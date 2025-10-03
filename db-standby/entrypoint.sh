#!/bin/sh
set -e

# If the data directory is empty, perform a base backup.
# Otherwise, the standby is already initialized.
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

    # --- FIX: Set correct permissions ---
    chown -R postgres:postgres "$PGDATA"
    chmod 0700 "$PGDATA"
    # ------------------------------------

    echo "Base backup complete. Standby is ready."
fi

# Start PostgreSQL server as the postgres user
exec gosu postgres postgres