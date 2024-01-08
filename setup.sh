#!/bin/bash

SUPER_ADMIN_KEY="$1"

CORTEX_URL=http://localhost:9001

ORG=buttercup
ORG_ADMIN="$ORG-admin"
ORG_ADMIN_PW=`openssl rand -base64 16`
ORG_INTEGRATION="$ORG-integration"

# Create Organization
curl -s -XPOST -H "Authorization: Bearer $SUPER_ADMIN_KEY" -H 'Content-Type: application/json' "$CORTEX_URL/api/organization" -d "{
  \"name\": \"$ORG\",
  \"description\": \"$ORG organization\",
  \"status\": \"Active\"
}"

# Create the orgadmin of the Organiszation
curl -s -XPOST -H "Authorization: Bearer $SUPER_ADMIN_KEY" -H 'Content-Type: application/json' "$CORTEX_URL/api/user" -d "{
  \"name\": \"$ORG org Admin\",
  \"roles\": [
    \"read\",
    \"analyze\",
    \"orgadmin\"
  ],
  \"organization\": \"$ORG\",
  \"login\": \"$ORG_ADMIN\"
}"

# Set the password of the orgadmin of the Organiszation
curl -s -XPOST -H "Authorization: Bearer $SUPER_ADMIN_KEY" -H 'Content-Type: application/json' "$CORTEX_URL/api/user/$ORG_ADMIN/password/set" -d "{
  \"password\": \"$ORG_ADMIN_PW\"
}"

# Get API key of the orgadmin of the Organiszation 
ORG_ADMIN_KEY=`curl -XPOST -H "Authorization: Bearer $SUPER_ADMIN_KEY" "$CORTEX_URL/api/user/$ORG_ADMIN/key/renew"`

# Create theHive integration user of the Organiszation 
curl -s -XPOST -H "Authorization: Bearer $ORG_ADMIN_KEY" -H 'Content-Type: application/json' "$CORTEX_URL/api/user" -d "{
  \"name\": \"$ORG Integration\",
  \"roles\": [
    \"read\",
    \"analyze\"
  ],
  \"organization\": \"$ORG\",
  \"login\": \"$ORG_INTEGRATION\"
}"

# Get theHive integration API key from the integration user of the Organiszation
ORG_INTEGRATION_KEY=`curl -XPOST -H "Authorization: Bearer $ORG_ADMIN_KEY" "$CORTEX_URL/api/user/$ORG_INTEGRATION/key/renew"`

# Populate the .env file used by docker-compose.yml
echo "CORTEX_KEY=$ORG_INTEGRATION_KEY" > .env
echo "job_directory=/tmp/job-directory" >> .env
echo "ORG=$ORG" >> .env

# Enable VirusTotal Scan Analyzer
# Get key From 1Password
# If you don't have 1password (or another vault)
# You can set this key in .env and retrieve it from there
VT_KEY=$(op read op://Splunk/virustotal.com/API)

curl -s -XPOST -H "Authorization: Bearer $ORG_ADMIN_KEY" -H 'Content-Type: application/json' \
"$CORTEX_URL/api/organization/analyzer/VirusTotal_Scan_3_1" \
-d "{
  \"name\": \"VirusTotal_Scan_3_1\",
  \"configuration\": {
    \"key\": \"$VT_KEY\"
  }
}"
echo ""
