#!/bin/bash



rsync_backup() {



    # while getopts "s:d:k:b:l:" flag;
    # do
    #     case "${flag}" in
    #         s) source=${OPTARG};;
    #         d) dest=${OPTARG};;
    #         k) link_dest=${OPTARG};;
    #         b) backup_dir=${OPTARG};;
    #         l) log_dest=${OPTARG};;
    #     esac
    # done


    local n="[$0]: "


    local source_folder="$1"
    local dest="$2"
    local link_dest="$3"
    local log_file="$4"
    local backup_dir="$5"
    
    local backup_date=$(date +%F)
    local suffix="deleted_on_${backup_date}"

    local partial_dir="${}"

    rsync -hazvib --suffix="${suffix}" --backup-dir="${backup_dir}" --stats --delete-after "${link_dest}" "${source_folder}" "${dest}"

}


