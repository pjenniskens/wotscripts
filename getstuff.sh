#!/bin/sh
for clan in `cat /home/centos/bin/clan_ids | cut -f1 -d','`;
    do
        exit=5;
	attempt=25; 
        while [[ $exit -gt 0 && $attempt -gt 0 ]]; do
        sleep 0.3;
            curl -s --max-time 10 "https://api.worldoftanks.eu/wot/clans/info/?application_id=1266b28cbb37571a0b79d04fe6aa6136&clan_id=${clan}" | jq -r '.data[].members[] | "\(.account_id),\(.account_name),\(.role_i18n)"' > /home/centos/bin/accountlist_${clan}.csv;
            exit=$?;
	    let "attempt--"
            echo exit = $exit, attempt = $attempt;
        done;
    done;
    for account_id in `cat /home/centos/bin/accountlist_* | cut -f1 -d','`;
    do
        USER=`grep ${account_id} /home/centos/bin/accountlist_* | cut -f2 -d','`;
        echo ${USER};
        exit=5;
	attempt=25; 
        while [[ $exit -gt 0 && $attempt -gt 0 ]]; do
        sleep 0.3;
            curl -s --max-time 10 "https://api.worldoftanks.eu/wot/tanks/stats/?application_id=1266b28cbb37571a0b79d04fe6aa6136&account_id=$account_id" | jq '[.data[][] | {all: .all,tank_id,mark_of_mastery,max_xp,account_id,max_frags} ]' > /opt/data/reddit/vehicles_${USER};
            exit=$?;
	    let "attempt--"
            echo exit = $exit, attempt = $attempt;
        done;
        exit=5;
	attempt=25; 
        while [[ $exit -gt 0 && $attempt -gt 0 ]]; do
        sleep 0.3;
            curl -s --max-time 10 "https://api.worldoftanks.eu/wot/tanks/achievements/?application_id=1266b28cbb37571a0b79d04fe6aa6136&account_id=$account_id" | jq '[.data[][] | {achievements: .achievements,account_id,tank_id} ] ' > /opt/data/reddit/achievements_${USER};
            exit=$?;
	    let "attempt--"
            echo exit = $exit, attempt = $attempt;
        done;
    done

