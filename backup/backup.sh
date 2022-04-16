#!/bin/bash

. ../settings.config

source_base="/mnt/test/"
dest_base="/mnt/backup/"
todays_date="$(date +%Y-%m-%d)"
users_file="${users_to_backup}"




# link_dest=""

while IFS= read -r user; do

    user_folder_to_backup=${user}

    source="${source_base}${user_folder_to_backup}/"
    dest="${dest_base}${user_folder_to_backup}/${todays_date}"


    for i in {-1..-7}; do

        date_to_check=$(date -d "${todays_date} ${i} days" +%Y-%m-%d)
        date_folder_to_check="${dest_base}${user_folder_to_backup}/${date_to_check}"

        if [ -d "${date_folder_to_check}" ]; then
            link_dest="${date_folder_to_check}"
            break
        fi

    done



    rsync -hazvib --suffix="_older" --link-dest=$link_dest $source $dest


        

    done < "${users_file}"



