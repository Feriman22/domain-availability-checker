#!/bin/bash
# This shell script can check the list to see which domains are registered and which are free.
# https://github.com/Feriman22/domain-availability-checker
# Donate me: https://paypal.me/BajzaFerenc
# Use any parameter to turn on silent mode

# List of domains
DOMAINS="
feriman.com \
github.com \
example.net \
randomstring2143532.org \
"

# Check domains one-by-one - Continue if the quick test found any recond (so the domain is 100% registered)
for domain in $DOMAINS; do
        # Nameservers check
        if dig +short NS "$domain" | grep -q .; then
                [ ! "$1" ] && echo "$domain is registered."
                continue
        fi

        # SOA check
        if dig +short SOA "$domain" | grep -q .; then
                [ ! "$1" ] && echo "$domain is registered."
                continue
        fi

        # NXDOMAIN check
        if dig "$domain" | grep -q "status: NXDOMAIN"; then
                [ ! "$1" ] && echo "$domain is NOT registered - Time!" || echo "$domain not registered" "Time!"
                continue
        fi

        # If unsure, then whois (fallback)
        [ "$whoisRanAtLeastOnce" ] && sleep 10
        if timeout 15 whois "$domain" 2>&1 | egrep -qi "No match|NOT FOUND|No entries"; then
                [ ! "$1" ] && echo "$domain is NOT registered - Time!" || echo "$domain not registered" "Time!"
        else
                [ ! "$1" ] && echo "$domain is registered."
        fi
        whoisRanAtLeastOnce="1"
done
