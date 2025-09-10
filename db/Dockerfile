FROM postgres:13-alpine

USER root

# Create directory and copy certificates
RUN mkdir -p /var/lib/postgresql/certs
COPY certs/server.crt certs/server.key /var/lib/postgresql/certs/

# Set proper ownership and permissions
RUN chown -R postgres:postgres /var/lib/postgresql/certs && \
    chmod 600 /var/lib/postgresql/certs/server.key

# Even if docker-compose.yml configures Postgres to run with SSL, we
# still should have this config in place, and I don't really know why.
USER postgres
COPY postgresql.conf /usr/local/share/postgresql/postgresql.conf.sample