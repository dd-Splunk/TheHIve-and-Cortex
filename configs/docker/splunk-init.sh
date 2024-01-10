#!/bin/ash

echo "Create $CORTEX_USER"

curl -k -u admin:$SPLUNK_PASSWORD --location 'https://splunk:8089/services/authentication/users' \
--header 'Content-Type: application/x-www-form-urlencoded' \
--data-urlencode "name=$CORTEX_USER" \
--data-urlencode "password=$CORTEX_PASSWORD" \
--data-urlencode "roles=cortex-role"

echo "$CORTEX_USER created"