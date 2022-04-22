#!/bin/bash

function backup_global_samba_config () {


    if [ -d "${samba_config_backups_dir}" ]; then
        echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: Backup Directory for Samba configs exits."

            
    else
        echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: Backup Directory for Samba configs does not exit."

        if mkdir -vp "${samba_config_backups_dir}"; then
            echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: Created Backup Directory for Samba Configs"
        else
            echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to create Backup Directory for Samba Configs"

        fi
    fi

   




    if [ -f "${samba_global_config_file}" ]; then
        echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: Samba Global Config file exists. Making a backup"

        if cp -v "${samba_global_config_file}" "${samba_config_backups_dir}${samba_global_config_file}.backup.${backup_stamp}"; then
            echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: Backup successful of Global Samba Config file"
                

        else
            echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to Backup Global Samba Config file ... Aborting"
                    
        fi
        

    else
        echo "[backup_global_samba_config: $(date +%Y%m%d_%H%M%S)]: WARNING !!Samba Global Config file does not exist"

    fi



}