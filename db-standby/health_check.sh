#!/bin/bash

PRIMARY_HOST=${PRIMARY_HOST:-primary}
PRIMARY_PORT=${PRIMARY_PORT:-5432}
REPLICATION_USER=${REPLICATION_USER:-repl_user}
POSTGRES_DB=${POSTGRES_DB:-postgres}
CHECK_INTERVAL=${CHECK_INTERVAL:-10}

echo "Starting health check for primary: $PRIMARY_HOST:$PRIMARY_PORT"

while true; do
    # Check if primary is reachable
    if ! pg_isready -h "$PRIMARY_HOST" -p "$PRIMARY_PORT" -U "$REPLICATION_USER" -d "$POSTGRES_DB" >/dev/null 2>&1; then
        echo "$(date): Primary database is unreachable. Promoting standby..."
        
        # Check if we're still in recovery mode
        if gosu postgres psql -t -c "SELECT pg_is_in_recovery();" | grep -q "t"; then
            echo "Promoting standby to primary..."
            gosu postgres pg_ctl promote -D "$PGDATA"
            
            # Verify promotion was successful
            sleep 5
            if gosu postgres psql -t -c "SELECT pg_is_in_recovery();" | grep -q "f"; then
                echo "Promotion successful. This node is now primary."
                break
            else
                echo "Promotion failed. Retrying..."
            fi
        else
            echo "This node is already primary."
            break
        fi
    fi
    
    sleep $CHECK_INTERVAL
done