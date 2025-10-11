FROM postgres:13-alpine

USER root

RUN apk add --no-cache postgresql-client openssl
RUN mkdir -p /var/lib/postgresql/certs
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /var/lib/postgresql/certs/server.key \
    -out /var/lib/postgresql/certs/server.crt \
    -subj "/CN=localhost-standby"
RUN chown -R postgres:postgres /var/lib/postgresql/certs && \
    chmod 600 /var/lib/postgresql/certs/server.key

#COPY entrypoint.sh /usr/local/bin/
#RUN chmod +x /usr/local/bin/entrypoint.sh
#
#ENTRYPOINT ["entrypoint.sh"]
#CMD ["postgres"]