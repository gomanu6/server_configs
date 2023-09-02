#!/bin/bash



rsync_backup() {



    local n="[2rsync_backup]: "


    local source_folder="$1"
    local dest="$2"
    local deleted_files="$3"
    local link_dest="$4"
    local user="$5"



    echo "$n Starting Backup for ${user}"
    echo "$n Value of link_dest is: ---> ${link_dest}"

    if [ -z "${link_dest}" ]; then
        rsync -hazvib --backup-dir="${deleted_files}" --stats --delete-after "${source_folder}" "${dest}"
    
    else
        rsync -hazvib --backup-dir="${deleted_files}" --stats --delete-after "${link_dest}" "${source_folder}" "${dest}"
    
    fi
}



