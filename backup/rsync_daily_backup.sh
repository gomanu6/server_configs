#!/bin/bash


function rsync_daily_backup () {
    local user=$1
    local source=$2
    local dest=$3
    
    local todays_date="$(date +%Y-%m-%d)"
    
    
    if [ -z "$3" ]; then
        link_dest=""
    else
        echo "[rsync_daily_backup]: Setting the --link-dest parameter."
        link_dest="--link-dest=$3/"
        echo "[rsync_daily_backup]: --link-dest parameter has been set."
    fi
    
    if [ -d "${dest}" ]; then
        echo "[rsync_daily_backup]: Destination directory for ${user} for ${todays_date} exists"
    else
        echo "[rsync_daily_backup]: No backup directory found for ${user}. Creating directory for ${todays_date}"
        if mkdir -vp "${dest}"; then
            echo "[rsync_daily_backup]: Created backup directory for ${user}"
        fi
    fi

    echo
    echo "[rsync_daily_backup]: ********** Starting Backup for ${user} **************"
    if rsync -hazvib --suffix="_older" ${link_dest} ${source} ${dest}; then
        echo "[rsync_daily_backup]: ************* Backup for ${user} on ${todays_date} finished ****************"
        echo "--------------------XXXXXXXXXXXX---------------"
        echo
    else
        echo "[rsync_daily_backup]: WARNING!! Backup for ${user} for ${todays_date} failed."
        exit 1
    fi


}

