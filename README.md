# Certbot-Auto Docker
Automatically generate wildcard certificates using certbot and keep them renewed!

## Features
- Easy to use / configure
- Set-and-forget: certificates will be kept up-to-date automatically
- Super low on resources, especially when idle

## Supported DNS providers
- [Cloudflare](https://cloudflare.com)

Adding support for other providers is quite simple, so open an issue if you'd like to see more!

## Installation
1. Clone this repository
2. Modify `docker-compose.yml` for your configuration.
    1. You must set a domain name, your DNS provider and a contact email (for Let's Encrypt)
    2. After you have verified that everything works, unset the STAGING variable to generate a certificate from the production environment.
3. Modify your DNS provider's config file in `dns-creds/` for authentication.
    1. This is usually an API key, account credentials or something similar.
4. Run it using `docker-compose up -d` and you're good to go! Generated certificates will be put in the `letsencrypt/` directory.

## Disclaimer
I am not affiliated with Certbot or Let's Encrypt, but I am a huge fan! :-)

If you like what they're doing, please consider donating to [Let's Encrypt](https://letsencrypt.org/donate/) or the [EFF](https://supporters.eff.org/donate/support-work-on-certbot).
