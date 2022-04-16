#!/bin/bash

source_base="/mnt/test/"
dest_base="/mnt/backup/"
todays_date="$(date +%Y-%m-%d)"

user_folder_to_backup=$1

source="${source_base}${user_folder_to_backup}/"
dest="${dest_base}${user_folder_to_backup}/${todays_date}"


link_dest=""


for i in {-1..-7}; do

    date_to_check=$(date -d "${todays_date} $i days" +%Y-%m-%d)
    date_folder_to_check="${dest_base}${date_to_check}"

    if [ -d "${date_folder_to_check}" ]; then
        link_dest="${date_folder_to_check}"
        break
    fi

done









rsync -hazbiv --suffix="_older" --link-dest=$link_dest $source $dest