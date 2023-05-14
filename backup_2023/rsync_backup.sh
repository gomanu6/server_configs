#!/bin/bash




rsync_backup() {

    local n="[$0]: "
    local user_dir=$1
    local link_dest=$2
    local backup_date=$(date)

    local partial_dir="${}"
    local log_file="${}"

    rsync -hazvib --suffix="_older" --stats --delete-after ${link_dest} ${source} ${dest}

}


