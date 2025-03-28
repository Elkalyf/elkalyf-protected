FROM ghcr.io/goauthentik/proxy:2025.2.2

# Install curl via apt (because this is Debian-based)
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean

# Install Traefik
RUN curl -sSL https://github.com/traefik/traefik/releases/download/v2.10.4/traefik_v2.10.4_linux_amd64.tar.gz \
    | tar -xz -C /usr/local/bin

# Add config files
COPY traefik.yml /etc/traefik/traefik.yml
COPY config.yml /etc/authentik/config.yml
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 80
EXPOSE 443

CMD ["/entrypoint.sh"]
