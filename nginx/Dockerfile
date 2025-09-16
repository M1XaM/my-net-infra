FROM nginx:stable-alpine

# Install openssl for generating self-signed certs
RUN apk add --no-cache openssl bash

# Create directories for certificates and config
RUN mkdir -p /etc/nginx/certs /etc/nginx/conf.d

# Generate self-signed certificate (valid for 1 year)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/certs/server.key \
    -out /etc/nginx/certs/server.crt \
    -subj "/CN=localhost"

# Copy Nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Expose ports
EXPOSE 80 443
