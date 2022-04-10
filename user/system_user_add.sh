#!/bin/bash



function system_user_add () {

    local username=$1
    local password=$2

    # imported variables
    local new_user_data_dir="${new_user_data_parent_dir}${username}"
    local samba_group="${smb_users_group}"

    if useradd --home "${new_user_data_dir}" --shell /usr/sbin/nologin -G "${samba_group}" "${username}"; then
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