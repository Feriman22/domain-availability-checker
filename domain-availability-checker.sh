#!/bin/bash
# This shell script can check the list to see which domains are registered and which are free.
# https://github.com/Feriman22/domain-availability-checker
# Donate me: https://paypal.me/BajzaFerenc

# Create a list of domains
DOMAINS="
feriman.com \
github.com \
example.net \
randomstring2143532.org \
"

# Check domains one-by-one
for domain in $DOMAINS; do
        if whois $domain | egrep -q '^No match|^NOT FOUND|^Not fo|^Domain not found|AVAILABLE|^No Data Fou|has not been regi|No entri'; then
                echo "$domain is not registered."
        fi
done
