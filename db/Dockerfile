FROM postgres:13-alpine

USER root

RUN apk add --no-cache openssl
RUN mkdir -p /var/lib/postgresql/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /var/lib/postgresql/certs/server.key \
    -out /var/lib/postgresql/certs/server.crt \
    -subj "/CN=localhost"
RUN chown -R postgres:postgres /var/lib/postgresql/certs && \
    chmod 600 /var/lib/postgresql/certs/server.key && \
    chmod 644 /var/lib/postgresql/certs/server.crt

USER postgres

COPY postgresql.conf /usr/local/share/postgresql/postgresql.conf.sample
COPY init-repl-user.sql /docker-entrypoint-initdb.d/init-repl-user.sql
COPY pg_hba.conf /usr/local/share/postgresql/pg_hba.conf.sample