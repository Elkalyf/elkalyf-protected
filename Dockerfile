FROM alpine:latest

RUN apk add --no-cache \
    bash \
    curl \
    su-exec \
    ca-certificates

# Install Traefik
ENV TRAEFIK_VERSION=v2.10.4
RUN curl -sSL https://github.com/traefik/traefik/releases/download/${TRAEFIK_VERSION}/traefik_${TRAEFIK_VERSION}_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin

# Install Authentik Outpost
ENV OUTPOST_VERSION=2025.2.2
RUN curl -sSL https://goauthentik.io/docker/proxy-${OUTPOST_VERSION}.tar.gz \
    | tar -xz -C /usr/local/bin

# Copy config files
COPY traefik.yml /etc/traefik/traefik.yml
COPY config.yml /etc/authentik/config.yml
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443

CMD ["/entrypoint.sh"]

