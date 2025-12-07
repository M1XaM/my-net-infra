FROM nginx:stable-alpine

RUN apk add --no-cache openssl bash

RUN mkdir -p /etc/nginx/certs /etc/nginx/conf.d

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/server.key \
    -out /etc/nginx/certs/server.crt \
    -subj "/CN=localhost"

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443