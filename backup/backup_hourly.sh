#!/bin/bash

. ../ascpl.config
. ./rsync_backup.sh


users_file="${active_users}"
log_file_base="${log_files_base_hourly}"


echo "[backup]: Reading users file for users to Backup"

while IFS= read -r user; do

    user_folder_name=${user}
    
    backup_date="${todays_date}"
    backup_time=$(date +%H)

    source="${source_base}${user_folder_name}/"
    
    log_file_base_user="${log_file_base}${user_folder_name}/${backup_date}/"
    log_file="${log_file_base_user}${backup_date}_${backup_time}.txt"

    user_dest="${dest_base_hourly}${user_folder_name}/${backup_date}/"
    dest="${user_dest}${backup_time}"


    echo "[backup_daily]: Checking if Backup Log Directory exists."
    if [ -d "${log_file_base_user}" ]; then
        echo "[backup_daily]: Backup Log Directory exists."

        echo "[backup_daily]: Creating log file for the current backup operation."
        if touch "${log_file}"; then
            echo "[backup_daily]: Log File created"
        else
            echo "[backup_daily]: WARNING!! Trouble creating Log file"
        fi

    else
        echo "[backup_daily]: Backup Log Directory does not exist. Creating it .."
        
        if mkdir -vp "${log_file_base_user}"; then
            echo "[backup_daily]: Log Directory created"

            echo "[backup_daily]: Creating log file for the current backup operation."
            if touch "${log_file}"; then
                echo "[backup_daily]: Log File created"
            else
                echo "[backup_daily]: WARNING!! Trouble creating Log file"
            fi

        else
            echo "[backup_daily]: WARNING !! Trouble creating Log Directory"

        fi

    fi




    echo
    echo "-----${user}------------${todays_date}-----" | tee -a "${log_file}"
    echo "[backup_daily]: Checking if ${user} folder exists."
    if [ -d ${source} ]; then
        echo "[backup_daily]: ${user} folder exists." | tee -a "${log_file}"

        echo "[backup_daily]: Checking if ${user}'s backup destination exists." | tee -a "${log_file}"
        if [ -d ${user_dest} ]; then
            echo "[backup_daily]: Backup destination for ${user} exists." | tee -a "${log_file}"

            echo "[backup_daily]: Checking previous Backup's for ${user}...." | tee -a "${log_file}"

            for i in {-1..-12}; do 

                echo "[backup]: Checking last backup directory for ${user}" | tee -a "${log_file}"
                
                time_to_check=$(date -d "${i} hours" +%H)
                time_folder_to_check="${user_dest}${time_to_check}"

                if [ -d "${time_folder_to_check}" ]; then
                    link_dest="${time_folder_to_check}"
                    echo "[backup]: Found backup directory for ${user} at ${time_folder_to_check} Hours. --link-dest parameter has been set" | tee -a "${log_file}"
                    break
                fi

            done

            rsync_backup "${user}" "${source}" "${dest}" "${link_dest}" | tee -a "${log_file}"

        else
            echo "[backup]: WARNING !! Backup destination for ${user} does not exist." | tee -a "${log_file}"

            echo "[backup]: Creating Backup destination for ${user}." | tee -a "${log_file}"
            
            if mkdir -vp ${user_dest}; then
                echo "[backup]: Backup Destination for ${user} has been created." | tee -a "${log_file}"

                if mkdir -vp ${dest}; then

                    echo "[backup]: Backup Directory for ${user} created for ${backup_date}" | tee -a "${log_file}"

                    echo "[backup]: Starting Backup. --link-dest parameter has not been set." | tee -a "${log_file}"

                    rsync_backup "${user}" "${source}" "${dest}" | tee -a "${log_file}"


                else
                    echo "[backup]: WARNING !! Problem creating Backup Directory for ${user} for ${backup_date}" | tee -a "${log_file}"
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



