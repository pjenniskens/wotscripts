#!/bin/sh
wget -O /tmp/tanklist.json "https://api.worldoftanks.eu/wot/encyclopedia/vehicles/?application_id=58e3720d4d73695aa5fa10e15f9f1eab&fields=tank_id%2Cname%2Cshort_name%2Cnation%2Ctier%2Ctype%2Cis_premium"
echo "TankID, Name, Short, Nation, Premium, Tier, Type" > tanklist.csv
cat /tmp/tanklist.json | jq -r '.data[] | [ .tank_id, .name, .short_name, .nation, .is_premium, .tier, .type ] | @csv' >> tanklist.csv
