#!/bin/sh
curl -s --max-time 10 "https://api.worldoftanks.eu/wgn/servers/info/?application_id=cabfb627502b1629384b83fe80846204" | jq -r '.data.wot[]' > /opt/data/WG/servers.json
