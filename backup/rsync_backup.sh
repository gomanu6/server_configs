#!/bin/bash


function rsync_backup () {
    local user=$1
    local source=$2
    local dest=$3
    
    local todays_date="$(date +%Y%m%d)"
    
    
    if [ -z "$4" ]; then
        link_dest=""
    else
        echo "[rsync_backup]: --link-dest parameter has been received."
        link_dest="--link-dest=$4/"
        echo "[rsync_backup]: --link-dest parameter has been set."
    fi
    
    if [ -d "${dest}" ]; then
        echo "[rsync_backup]: Destination directory for ${user} for ${todays_date} exists"
    else
        echo "[rsync_backup]: No backup directory found for ${user}. Creating directory for ${todays_date}"
        if mkdir -vp "${dest}"; then
            echo "[rsync_backup]: Created backup directory for ${user}"
        fi
    fi

    echo
    echo
    echo "[rsync_backup]: ********** Starting Backup for ${user} **************"
    if rsync -hazvib --suffix="_older" --stats ${link_dest} ${source} ${dest}; then
        echo "[rsync_backup]: ************* Backup for ${user} on ${todays_date} finished ****************"
        echo "--------------------XXXXXXXXXXXX---------------"
        echo
    else
        echo "[rsync_backup]: WARNING!! Backup for ${user} for ${todays_date} failed."
        exit 1
    fi


}

