#!/bin/bash

. ./settings.config
. ./user/system_user_add.sh
. ./mount/create_mountpoint.sh
. ./samba/samba_user_enable.sh
. ./samba/samba_user_set_config.sh
. ./samba/samba_user_config.sh



if [ "$(id -u)" -eq 0 ]; then
    echo "[create_user]: Root user detected"
    read -rp "Enter First Name : " first_name
    read -rp "Enter Last Name : " last_name
    
    first_name_lower="${first_name,,}"
    last_name_lower="${last_name,,}"

    suggested_username="${first_name_lower}_${last_name_lower}"

    if grep -Ewi  "${suggested_username}" /etc/passwd > /dev/null; then
        echo "[create_user]: WARNING !! The suggested Username ${suggested_username} already exists. please suggest a unique username"
        read -rp "Enter username to create : " input_username
        username="${input_username}"
    else
        read -rp "[create_user]: Enter a username. Default is ${suggested_username}" answer
        name="${answer,,}"
        username="${name:=$suggested_username}"
    fi


    # echo "${first_name}" | awk '{print tolower($0)}'
    # echo "${last_name}" | awk '{print tolower($0)}'


    read -rp "Enter password for ${username} : " -s password

    if system_user_add "${username}" "${password}"; then
        echo "[create_user]: ${username} added to the system"

        if create_mountpoint "${username}"; then
            echo "[create_user]: Mount Point Created"

            if samba_user_enable "${username}" "${password}"; then
                echo "[create_user]: ${username} enabled in Samba"


                if samba_user_set_config "${username}"; then
                    echo "[create_user]: ${username} Samba Config has been set"


                    if create_lvm_partition "${username}"; then
                        echo "[create_user]: LV created"
                    else
                        echo "[create_user]: WARNING!! Problem creating LV"
                    fi


                else
                    echo "[create_user]: WARNING !! Samba Config for ${username} has not been set"

                fi


            else
                echo "[create_user]: WARNING !! Problem enabling user in Samba"
            fi



        else
            echo "[create_user]: WARNING !! Error during Mount Point Creation"
        fi
    else
        echo "[create_user]: WARNING !! There was an error in adding ${username} to the system"
    fi



else
    echo "[create_user]: WARNING !! Only Root may make further changes, exiting"
    exit 1
fi
