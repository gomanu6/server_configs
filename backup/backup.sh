#!/bin/bash

. ../settings.config

source_base="/mnt/test/"
dest_base="/mnt/backup/"
todays_date="$(date +%Y-%m-%d)"
users_file="${users_to_backup}"


function rsync_backup () {
    local source=$1
    local dest=$2
    
    local todays_date="$(date +%Y-%m-%d)"
    
    
    if [ -z "$3" ]; then
        link_dest=""
    else
        echo "[rsync_backup]: Setting the --link-dest parameter."
        link_dest="--link-dest=$3/"
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

    echo "[rsync_backup]: Starting Backup for ${user}."
    if rsync -hazvib --suffix="_older" ${link_dest} ${source} ${dest}; then
        echo "[rsync_backup]: Backup for ${user} on ${todays_date} finished."
    else
        echo "[rsync_backup]: WARNING!! Backup for ${user} on ${todays_date} failed."
        exit 1
    fi


}



echo "[backup]: Reading users file for users to Backup"

while IFS= read -r user; do

    user_folder_to_backup=${user}

    source="${source_base}${user_folder_to_backup}/"
    user_dest="${dest_base}${user_folder_to_backup}/"

    dest="${user_dest}${todays_date}"

    echo "[backup]: Checking if ${user} folder exists."
    if [ -d ${source} ]; then
        echo "[backup]: ${user} folder exists."

        echo "[backup]: Checking if ${user}'s backup destination exists."
        if [ -d ${user_dest} ]; then
            echo "[backup]: Backup destination for ${user} exists."

            echo "[backup]: Checking previous Backup's for ${user}...."

            for i in {0..-15}; do

                echo "[backup]: Checking last backup directory for ${user}"
                
                date_to_check=$(date -d "${todays_date} ${i} days" +%Y-%m-%d)
                date_folder_to_check="${user_dest}${date_to_check}"

                if [ -d "${date_folder_to_check}" ]; then
                    link_dest="${date_folder_to_check}"
                    echo "[backup]: Found backup directory for ${user} dated ${date_folder_to_check}. --link-dest parameter has been set"
                    break
                fi

            done

            rsync_backup "${source}" "${dest}" "${link_dest}"

        else
            echo "[backup]: WARNING !! Backup destination for ${user} does not exist."

            echo "[backup]: Creating Backup destination for ${user}."
            
            if mkdir -vp ${user_dest}; then
                echo "[backup]: Backup Destination for ${user} has been created."

                if mkdir -vp ${dest}; then

                    echo "[backup]: Backup Directory for ${user} created for ${todays_date}"

                    echo "[backup]: Starting Backup. --link-dest parameter has not been set."

                    rsync_backup "${source}" "${dest}"


                else
                    echo "[backup]: WARNING !! Problem creating Backup Directory for ${user} for ${todays_date}"
                    exit 1

                fi


            else
                echo "[backup]: WARNING !! Problem creating Backup Destination for ${user}."
                exit 1
            fi


        fi


    else
        echo "[backup]: WARNING !! ${user} folder Does NOT exist. Nothing to Backup"
        exit 1

    fi

     

    done < "${users_file}"



