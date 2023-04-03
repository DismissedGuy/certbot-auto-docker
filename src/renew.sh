#!/bin/bash

log()
{
  while read -r line; do
    dt=$(date +"[%Y-%m-%d %H:%M:%S]")
    echo "${dt} ${line}"
  done
}


echo "***** Renewing Certificate *****" | log


## Verification
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


## Arguments building
certbot_args=(
  "--agree-tos" "--non-interactive"
  "--preferred-challenges" "dns-01"
  
  "--dns-${DNS_PROVIDER}"
  "--dns-${DNS_PROVIDER}-credentials" "/etc/dns-creds/${DNS_PROVIDER}.ini"
  
  "-m" "${EMAIL}"
  "-d" "${DOMAIN},*.${DOMAIN}"
)
if [ ! -z "${STAGING}" ] && [ "${STAGING,,}" != "false" ]; then
  echo "** Using Staging environment **" | log
  certbot_args+=("--test-cert")
fi

echo "** Running with options: ${certbot_args[*]}"

## Actual renewal
/opt/certbot/bin/certbot certonly ${certbot_args[*]} 2>&1 | log
echo
