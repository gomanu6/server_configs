#!/bin/bash



function new_user_backup_config () {

    local username=$1
    local active_users="${active_users}"

    local dest_base_daily="${dest_base_daily}"
    local dest_base_daily_user="${dest_base_daily}${username}/"
    
    local dest_base_hourly="${dest_base_hourly}"
    local dest_base_hourly_user="${dest_base_hourly}${username}/"

    local log_files_base_daily="${log_files_base_daily}"
    local log_files_base_daily_user="${log_files_base_daily}${username}/"


    local log_files_base_hourly="${log_files_base_hourly}"
    local log_files_base_hourly_user="${log_files_base_hourly}${username}/"


    echo "[new_user_backup]: Adding an entry to active users"
    if echo "${username}" >> "${active_users}"; then
        echo "[new_user_backup]: ${username} has been added to active users"


        echo "[new_user_backup]: Creating Daily backup destination for ${username}"

        if [ -d "${dest_base_daily_user}" ]; then
            echo "[new_user_backup]: Daily backup destination for ${username} exists"

        else
            echo "[new_user_backup]: Daily backup destination for ${username} does not exist. Creating it now."

            if mkdir -vp "${dest_base_daily_user}"; then
                echo "[new_user_backup]: The Daily backup destination for ${username} has been created"
                
            else
                echo "[new_user_backup]: WARNING !! Unable to create the Daily backup destination for ${username}"

            fi

        fi



        if [ -d "${dest_base_hourly_user}" ]; then
            echo "[new_user_backup]: Hourly backup destination for ${username} exists"

        else
            echo "[new_user_backup]: Hourly backup destination for ${username} does not exist. Creating it now."

            if mkdir -vp "${dest_base_hourly_user}"; then
                echo "[new_user_backup]: The Hourly backup destination for ${username} has been created"
                
            else
                echo "[new_user_backup]: WARNING !! Unable to create the Hourly backup destination for ${username}"

            fi

        fi


        if [ -d "${log_files_base_daily_user}" ]; then
            echo "[new_user_backup]: Daily backup Log File destination for ${username} exists"

        else
            echo "[new_user_backup]: Daily backup Log File destination for ${username} does not exist. Creating it now."

            if mkdir -vp "${log_files_base_daily_user}"; then
                echo "[new_user_backup]: The Daily backup Log File destination for ${username} has been created"
                
            else
                echo "[new_user_backup]: WARNING !! Unable to create the Daily backup Log File destination for ${username}"

            fi

        fi

        if [ -d "${log_files_base_hourly_user}" ]; then
            echo "[new_user_backup]: Hourly backup Log File destination for ${username} exists"

        else
            echo "[new_user_backup]: Hourly backup Log File destination for ${username} does not exist. Creating it now."

            if mkdir -vp "${log_files_base_hourly_user}"; then
                echo "[new_user_backup]: The Hourly backup Log File destination for ${username} has been created"
                
            else
                echo "[new_user_backup]: WARNING !! Unable to create the Hourly backup Log File destination for ${username}"

            fi

        fi

    else
        echo "[new_user_backup]: WARNING !! Unable to add ${username} to active users"
    fi













}