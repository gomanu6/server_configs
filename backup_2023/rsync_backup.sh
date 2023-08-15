#!/bin/bash



rsync_backup() {






    local n="[$0]: "

    local todays_date=$(date +%F)
    local source_folder="$1"
    local dest="$2"
    local backup_dir="$3"
    local link_dest="$4"
    local user="$5"
    # local log_file="$4"
    


    
    echo "$n <<<<<<<< Starting Backup for ${user} on ${todays_date} >>>>>>>>>>"
    
    echo "$n Value of link_dest is: ---> ${link_dest}"

    if [ -z "${link_dest}" ]; then
        rsync -hazvib --backup-dir="${backup_dir}" --stats --delete-after "${source_folder}" "${dest}"
    else
        rsync -hazvib --backup-dir="${backup_dir}" --stats --delete-after "${link_dest}" "${source_folder}" "${dest}"
    fi
}


