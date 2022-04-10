#!/bin/bash

function samba_user_config () {

    local username=$1

    # imported variables
    local samba_user_config_file="${samba_users_config_dir}${username}.conf"
    local new_user_data_dir="${new_user_data_parent_dir}${username}"



    tee -a "${samba_user_config_file}" > /dev/null << EOF
[${username^}]
    Comment = Data for ${username^}
    path = ${new_user_data_dir}
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 2755
    force create mask = 2755


#This file has been created automatically by samba_user_set_config
$(date)
EOF

}