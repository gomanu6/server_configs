#!/bin/bash

. ../settings.config
. ./rsync_daily_backup.sh


users_file="${users_to_backup}"




echo "[backup]: Reading users file for users to Backup"

while IFS= read -r user; do

    user_folder_to_backup=${user}

    source="${source_base}${user_folder_to_backup}/"
    user_dest="${dest_base_daily}${user_folder_to_backup}/"

    dest="${user_dest}${todays_date}"

    echo
    echo "----------------${user}--------------------"
    echo "[backup]: Checking if ${user} folder exists."
    if [ -d ${source} ]; then
        echo "[backup]: ${user} folder exists."

        echo "[backup]: Checking if ${user}'s backup destination exists."
        if [ -d ${user_dest} ]; then
            echo "[backup]: Backup destination for ${user} exists."

            echo "[backup]: Checking previous Backup's for ${user}...."

            for i in {-1..-15}; do

                echo "[backup]: Checking last backup directory for ${user}"
                
                date_to_check=$(date -d "${todays_date} ${i} days" +%Y-%m-%d)
                date_folder_to_check="${user_dest}${date_to_check}"

                if [ -d "${date_folder_to_check}" ]; then
                    link_dest="${date_folder_to_check}"
                    echo "[backup]: Found backup directory for ${user} dated ${date_folder_to_check}. --link-dest parameter has been set"
                    break
                fi

            done

            rsync_daily_backup "${user}" "${source}" "${dest}" "${link_dest}"

        else
            echo "[backup]: WARNING !! Backup destination for ${user} does not exist."

            echo "[backup]: Creating Backup destination for ${user}."
            
            if mkdir -vp ${user_dest}; then
                echo "[backup]: Backup Destination for ${user} has been created."

                if mkdir -vp ${dest}; then

                    echo "[backup]: Backup Directory for ${user} created for ${todays_date}"

                    echo "[backup]: Starting Backup. --link-dest parameter has not been set."

                    rsync_daily_backup "${user}" "${source}" "${dest}"


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
        echo "[backup]: WARNING !! ${user} folder does NOT exist. Nothing to Backup"
        

    fi

     

    done < "${users_file}"



