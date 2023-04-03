#!/bin/sh

log()
{
  while read -r line; do
    dt=$(date +"[%Y-%m-%d %H:%M:%S]")
    echo "${dt} ${line}"
  done
}

echo "***** Renewing Certificate *****" | log

if [ -z "${DNS_PROVIDER}" ]; then
  echo "No DNS provider (DNS_PROVIDER) specified!" | log
  exit 1
elif [ ! -f "/etc/dns-creds/${DNS_PROVIDER}.ini" ]; then
  echo "Provider ${DNS_PROVIDER} is not yet supported." | log
  exit 1
fi

if [ -z "${EMAIL}" ]; then
  echo "No Email address (EMAIL) specified!" | log
  exit 1
fi

if [ -z "${DOMAIN}" ]; then
  echo "No Domain name (DOMAIN) specified!" | log
  exit 1
fi

/opt/certbot/bin/certbot certonly \
  --agree-tos --non-interactive --test-cert \
  "--dns-${DNS_PROVIDER}" \
  "--dns-${DNS_PROVIDER}-credentials" "/etc/dns-creds/${DNS_PROVIDER}.ini" \
  "--dns-${DNS_PROVIDER}-propagation-seconds" 15 \
  -m "${EMAIL}" \
  -d "${DOMAIN},*.${DOMAIN}" \
  --preferred-challenges dns-01 2>&1 | log
echo