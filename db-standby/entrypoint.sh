#!/bin/sh
set -e

# If the data directory is empty, perform a base backup.
if [ ! -s "$PGDATA/PG_VERSION" ]; then
    echo "Data directory is empty. Initializing standby from primary..."

    # Wait for the primary to be available
    until pg_isready -h "$PRIMARY_HOST" -p "$PRIMARY_PORT" -U "$REPLICATION_USER" -d "$POSTGRES_DB"; do
        echo "Waiting for primary database at $PRIMARY_HOST:$PRIMARY_PORT..."
        sleep 2
    done
    echo "Primary is ready."

    # Perform the base backup
    echo "Running pg_basebackup..."
    export PGPASSWORD="$REPLICATION_PASSWORD"
    pg_basebackup -h "$PRIMARY_HOST" -p "$PRIMARY_PORT" -D "$PGDATA" \
                  -U "$REPLICATION_USER" -vP -R -X stream

    # Set correct permissions
    chown -R postgres:postgres "$PGDATA"
    chmod 0700 "$PGDATA"

    echo "Base backup complete. Standby is ready."
fi

# Check if we should promote to primary
check_promotion() {
    if [ -f "/tmp/promote_trigger" ]; then
        echo "Promotion trigger file found. Promoting standby to primary..."
        gosu postgres pg_ctl promote -D "$PGDATA"
        rm -f /tmp/promote_trigger
        return 0
    fi
    
    # Check if primary is reachable
    if ! pg_isready -h "$PRIMARY_HOST" -p "$PRIMARY_PORT" -U "$REPLICATION_USER" -d "$POSTGRES_DB" >/dev/null 2>&1; then
        echo "Primary database is unreachable. Attempting promotion..."
        gosu postgres pg_ctl promote -D "$PGDATA"
        return 0
    fi
    
    return 1
}

# Start PostgreSQL server
echo "Starting PostgreSQL server..."
gosu postgres postgres &

# Store the PID
POSTGRES_PID=$!

# Wait for PostgreSQL to start
sleep 5

# Monitor for promotion conditions in background
(
    while true; do
        if check_promotion; then
            echo "Promotion completed. Monitoring stopped."
            break
        fi
        sleep 10
    done
) &

# Wait for the PostgreSQL process
wait $POSTGRES_PID