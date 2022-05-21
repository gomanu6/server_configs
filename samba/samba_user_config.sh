#!/bin/bash

function samba_user_config () {

    local username=$1

    # imported variables
    local samba_user_config_file="${samba_users_config_dir}${username}.conf"
    local new_user_data_dir="${base_home_dir}${username}/"



    tee -a "${samba_user_config_file}" > /dev/null << EOF
[${username^}]
    Comment = Data Folder for ${username^}
    path = ${new_user_data_dir}
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 1755
    force create mask = 1755
    create mode = 1755
    force create mode = 1755


#This file has been created automatically by samba_user_config
$(date)
EOF

}