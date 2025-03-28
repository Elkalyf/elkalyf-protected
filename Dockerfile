FROM alpine:3.19

RUN apk add --no-cache curl bash su-exec ca-certificates nodejs npm

# Install Traefik
ENV TRAEFIK_VERSION=v2.10.4
RUN curl -sSL https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin

# Install Authentik Outpost
ENV OUTPOST_VERSION=2025.2.2
RUN curl -sSL https://github.com/goauthentik/authentik/releases/download/${OUTPOST_VERSION}/proxy-linux-amd64 -o /usr/local/bin/authentik-proxy && \
    chmod +x /usr/local/bin/authentik-proxy

# Copy configs and test app
COPY traefik.yml /etc/traefik/traefik.yml
COPY config.yml /etc/authentik/config.yml
COPY entrypoint.sh /entrypoint.sh
COPY server.js /server.js

RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443
EXPOSE 3000

CMD ["/entrypoint.sh"]
