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