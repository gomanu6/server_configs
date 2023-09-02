#!/bin/bash



rsync_backup() {



    local n="[2rsync_backup]: "
    local backup_time=$(date +%T)

    local source_folder="$1"
    local dest="$2"
    local deleted_files="$3"
    local link_dest="$4"
    local user="$5"



    echo "$n Starting Backup for ${user}"
    echo "$n Value of link_dest is: ---> ${link_dest}"

    if [ -z "${link_dest}" ]; then
        rsync -hazvib --progress --chmod="${permissions_after_rsync}" --backup-dir="${deleted_files}" --suffix="_${backup_time}.deleted" --stats --delete-after "${source_folder}" "${dest}"
    
    else
        rsync -hazvib --progress --chmod="${permissions_after_rsync}" --backup-dir="${deleted_files}" --suffix="_${backup_time}.deleted" --stats --delete-after "${link_dest}" "${source_folder}" "${dest}"
    
    fi
}



# unused options

# --chown="${user}:${group_after_rsync}"

# Improve Efficiency
# [Concurrent file transfers](https://stackoverflow.com/questions/24058544/speed-up-rsync-with-simultaneous-concurrent-file-transfers)
# xargs is now the recommended tool to achieve parallel execution. 
# It's pre-installed almost everywhere. 
# For running multiple rsync tasks the command would be:

# ls /srv/mail | xargs -n1 -P4 -I% rsync -Pa % myserver.com:/srv/mail/

# This will list all folders in /srv/mail, pipe them to xargs, which will read them one-by-one and and run 4 rsync processes at a time. The % char replaces the input argument for each command call.