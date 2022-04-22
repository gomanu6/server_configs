#!/bin/bash



function system_user_add () {

    local username=$1
    local password=$2

    # imported variables
    local new_user_data_dir="${base_home_dir}${username}"
    local samba_group="${default_samba_users_group}"
    local samba_user_shell="${samba_user_shell}"

    if useradd --home "${base_home_dir}" --shell "${samba_user_shell}" -G "${samba_group}" "${username}"; then
        echo "[system_user_add]: successfully added ${username} to the system"

        if echo "$username:$password" | chpasswd; then
            echo "[system_user_add]: Password has been set for ${username}"
            echo "[system_user_add]: User has been added to the system. Returning control to [create_user]"
        fi


    else
        echo "[system_user_add]: WARNING !! There was an error in adding ${username} to the system"
        exit 1
    fi








}