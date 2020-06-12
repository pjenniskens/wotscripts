#!/bin/sh
curl -s --max-time 10 "https://api.worldoftanks.eu/wot/tanks/stats/?application_id=1266b28cbb37571a0b79d04fe6aa6136&account_id=510041062"  | jq -r '.data[]' > /opt/data/Pitr/vehicles.json

