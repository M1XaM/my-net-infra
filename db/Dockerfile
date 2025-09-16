FROM postgres:13-alpine

USER root

# Install OpenSSL and create certificate directory
RUN apk add --no-cache openssl && \
    mkdir -p /var/lib/postgresql/certs

# Generate self-signed certificates (valid for 1 year)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /var/lib/postgresql/certs/server.key \
    -out /var/lib/postgresql/certs/server.crt \
    -subj "/CN=localhost"

# Set ownership and permissions
RUN chown -R postgres:postgres /var/lib/postgresql/certs && \
    chmod 600 /var/lib/postgresql/certs/server.key && \
    chmod 644 /var/lib/postgresql/certs/server.crt

# Switch to postgres user and copy configuration
USER postgres
COPY postgresql.conf /usr/local/share/postgresql/postgresql.conf.sample