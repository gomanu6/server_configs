#!/bin/bash

. ../settings.config
. ./rsync_daily_backup.sh


users_file="${users_to_backup}"


echo "[backup]: Reading users file for users to Backup"

while IFS= read -r user; do

    user_folder_name=${user}

    source="${source_base}${user_folder_name}/"
    user_dest="${dest_base_daily}${user_folder_name}/"
    log_file_base="${log_files_base_daily}"
    log_file_base_user="${log_file_base}${user_folder_name}/"
    log_file="${log_file_base_user}${todays_date}.txt"
    dest="${user_dest}${todays_date}"

    echo
    echo "-----${user}------------${todays_date}-----"
    echo "[backup_daily]: Checking if ${user} folder exists." | tee -a "${log_file}"
    if [ -d ${source} ]; then
        echo "[backup_daily]: ${user} folder exists." | tee -a "${log_file}"

        echo "[backup_daily]: Checking if ${user}'s backup destination exists." | tee -a "${log_file}"
        if [ -d ${user_dest} ]; then
            echo "[backup_daily]: Backup destination for ${user} exists." | tee -a "${log_file}"

            echo "[backup_daily]: Checking previous Backup's for ${user}...." | tee -a "${log_file}"

            for i in {-1..-15}; do 

                echo "[backup]: Checking last backup directory for ${user}" | tee -a "${log_file}"
                
                date_to_check=$(date -d "${todays_date} ${i} days" +%Y-%m-%d)
                date_folder_to_check="${user_dest}${date_to_check}"

                if [ -d "${date_folder_to_check}" ]; then
                    link_dest="${date_folder_to_check}"
                    echo "[backup]: Found backup directory for ${user} dated ${date_folder_to_check}. --link-dest parameter has been set" | tee -a "${log_file}"
                    break
                fi

            done

            rsync_daily_backup "${user}" "${source}" "${dest}" "${link_dest}" | tee -a "${log_file}"

        else
            echo "[backup]: WARNING !! Backup destination for ${user} does not exist." | tee -a "${log_file}"

            echo "[backup]: Creating Backup destination for ${user}." | tee -a "${log_file}"
            
            if mkdir -vp ${user_dest}; then
                echo "[backup]: Backup Destination for ${user} has been created." | tee -a "${log_file}"

                if mkdir -vp ${dest}; then

                    echo "[backup]: Backup Directory for ${user} created for ${todays_date}" | tee -a "${log_file}"

                    echo "[backup]: Starting Backup. --link-dest parameter has not been set." | tee -a "${log_file}"

                    rsync_daily_backup "${user}" "${source}" "${dest}" | tee -a "${log_file}"


                else
                    echo "[backup]: WARNING !! Problem creating Backup Directory for ${user} for ${todays_date}" | tee -a "${log_file}"
                    exit 1

                fi


            else
                echo "[backup]: WARNING !! Problem creating Backup Destination for ${user}." | tee -a "${log_file}"
                exit 1
            fi


        fi


    else
        echo "[backup]: WARNING !! ${user} folder does NOT exist. Nothing to Backup" | tee -a "${log_file}"
        

    fi

     

    done < "${users_file}"



