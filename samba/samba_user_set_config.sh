#!/bin/bash


function samba_user_set_config () {


    local username=$1


    # imported variables
    local new_user_data_dir="${new_user_data_parent_dir}${username}"
    local smb_users_group="${smb_users_group}"
    local samba_global_config_file="${samba_global_config_file}"
    local smb_admins_group="${smb_admins_group}"
    local samba_users_config_dir="${samba_users_config_dir}"
    local samba_user_config_file="${samba_users_config_dir}${username}.conf"



    if [ ! -d "${samba_users_config_dir}" ]; then
        echo "[samba_user_set_config]: Samba Config Directory does not exist .. Creating Samba Config Directory"

        if mkdir -vp "${samba_users_config_dir}"; then
            echo "[samba_user_set_config]: Successfully Created Samba Config Directory"

        else
            echo "[samba_user_set_config]: WARNING: Unable to create Samba users Config Directory"
        fi
        
    else
        echo "[samba_user_set_config]: Samba Config Directory already exists."
    fi



    echo "[samba_user_set_config]: Creating Samba Config file for ${username}"

    if samba_user_config "${username}"; then
        echo "[samba_user_set_config]: Created User Config File for Samba"
    
        echo "[samba_user_set_config]: Adding Configuration file link in smb.conf"




    else
        echo "[samba_user_set_config]: WARNING !! uNABLE TO Create Samba Config File for user"
        exit 1

    fi


    if [ -f "${samba_global_config_file}" ]; then
        echo "[samba_user_set_config]: Samba Config File exists....Making a backup"

        if cp -v "${samba_global_config_file}" "${samba_global_config_file}.backup.$(date +%Y_%m_%d)"
            echo "[samba_user_set_config]: Backup successful of Global Samba Config file"
        
            if echo "include = ${samba_user_config_file}" >> "${samba_global_config_file}"; then

                echo "[samba_user_set_config]: Added link to Config file in smb.conf"


                echo "[samba_user_set_config]: Restarting Samba Service"
                systemctl restart smbd.service

            else
                echo "[samba_user_set_config]: WARNING !! Unable to include link in smb.conf"

            fi

                

            

        


        else
            echo "[samba_user_set_config]: WARNING !! Unable to Backup Global Samba Config file ... Aborting"
            exit 1
        fi



        
    
    
    else
        echo "[samba_user_set_config]: WARNING !! Global Samba Config file does not exist"
    fi






}