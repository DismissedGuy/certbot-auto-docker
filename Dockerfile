FROM python:3.11-alpine

RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash augeas-libs && \
    python3 -m venv /opt/certbot && \
    /opt/certbot/bin/pip install --disable-pip-version-check --no-cache-dir -U certbot certbot-dns-cloudflare

COPY src/crontab /var/spool/cron/crontabs/root
COPY src/renew.sh /renew.sh

RUN chmod +x /renew.sh

ENTRYPOINT ["crond", "-f"]
CMD ["-L", "/dev/stdout"]
