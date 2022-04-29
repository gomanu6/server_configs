#!/bin/bash


. ./system_user.config


backup_stamp=$(date +%Y%m%d_%H%M%S)


echo "[$(date +%Y%m%d_%H%M)system_user]: Starting process to add new Samba user."
if [ "$(id -u)" -eq 0 ]; then
    echo "[$(date +%Y%m%d_%H%M)system_user]: Root user detected"


    



    read -rp "Enter First Name : " first_name
    read -rp "Enter Last Name : " last_name

    first_name_lower="${first_name,,}"
    last_name_lower="${last_name,,}"

    suggested_username="${first_name_lower}_${last_name_lower}"



    # Getting unique Username
    while :
    do

        read -rp "[create_user]: Enter a username. Default is ${suggested_username}" answer
        name="${answer,,}"
        check_username="${name:=$suggested_username}"


        if [ -z "${check_username}" ]; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! Input Username is blank"
        else
            echo "[$(date +%Y%m%d_%H%M)system_user]: The entered username is ${check_username}"

            if id -u "${check_username}" > /dev/null 2>&1; then
                echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! ${check_username} already exists, please suggest a unique username."
                # exit 1        
            else
                echo "[$(date +%Y%m%d_%H%M)system_user]: ${check_username} does not exist in the system."
                username="${check_username}"
                #echo "Creating ${username}"
                break
                # exit 0
            fi


        fi

    done

    read -rp "Enter password for ${username} : " -s password


    users_dir="${users_base_dir}${username}"

    # Creating Mountpoint
    echo "[$(date +%Y%m%d_%H%M)system_user]: Creating Mountpoint for ${username}"
    if [ ! -d "${users_dir}" ]; then
        echo "[$(date +%Y%m%d_%H%M)system_user]: Mount Point does not exist, creating mountpoint"

        if mkdir -vp "${users_dir}"; then
            echo   "[$(date +%Y%m%d_%H%M)system_user]: Mount point Created"
            
        else 
            echo   "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! Problem creating Mount Point"
            exit 1
        fi

    else
        echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! User Directory already exists"
        
    fi


    # Changing Mountpoint Permissions
    if chown -v "${username}:${samba_users_group}" "${users_dir}"; then
                    echo "[$(date +%Y%m%d_%H%M)system_user]: Mount Point ownership changed"

        if chmod -R -v 2755 "${users_dir}"; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: Mount Point permissions changed to $(stat -c $'\nOwner Name: %U, \nOwner Group Name: %G, \nMount Point: %m, \nPermission: %A (%a), \nFile Type: %F' ${users_dir})"
                                
            
        else
            echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! There was an error in changing the permissions for ${users_dir}."
            exit 1
        fi

    else
        echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! There was an error in setting the ownership for ${users_dir}"
        exit 1
    fi


    # Adding user to the system
    if useradd --home "${users_dir}" --shell "${samba_users_shell}" -G "${samba_users_group}" "${username}"; then
        echo "[$(date +%Y%m%d_%H%M)system_user]: successfully added ${username} to the system"

        if echo "$username:$password" | chpasswd; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: Password has been set for ${username}"
            echo "[$(date +%Y%m%d_%H%M)system_user]: User has been added to the system. Returning control to [create_user]"
        fi


    else
        echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! There was an error in adding ${username} to the system"
        exit 1
    fi


    # Enabling user in Samba
    if (echo "$password"; echo "$password") | smbpasswd -s -a "${username}"; then

        if smbpasswd -e "${username}"; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: The User can now login through Samba"

            

        else
            echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING [smbpasswd -e] Problem Enabling the user in Samba"
            exit 1
        fi
    else 
        echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING [smbpasswd -a] Problem setting user password in Samba"
        exit 1
    fi



    # Checking if Samba Users config directory exists
    if [ ! -d "${samba_users_config_dir}" ]; then
        echo "[$(date +%Y%m%d_%H%M)system_user]: Samba Config Directory does not exist .. Creating Samba Config Directory"

        if mkdir -vp "${samba_users_config_dir}"; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: Successfully Created Samba Config Directory"

        else
            echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING: Unable to create Samba users Config Directory"
        fi
        
    else
        echo "[$(date +%Y%m%d_%H%M)system_user]: Samba Config Directory already exists."
    fi


    # Creating Samba Config file for User
    samba_user_config_file="${samba_users_config_dir}${username}.conf"

    tee -a "${samba_user_config_file}" > /dev/null << EOF
[${username^}]
    Comment = Data Folder for ${username^}
    path = ${users_dir}
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 2755
    force create mask = 2755


# This file has been created automatically by system_user
# $(date)
EOF

    # Adding entry to Global Samba Config File
    if [ -f "${samba_global_config_file}" ]; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: Samba Config File exists....Making a backup"
        
        
        if cp -v "${samba_global_config_file}" "${samba_config_backups}smb.conf.backup.${backup_stamp}"; then
            echo "[$(date +%Y%m%d_%H%M)system_user]: Backup successful of Global Samba Config file"


            if echo "include = ${samba_user_config_file}" >> "${samba_global_config_file}"; then

                echo "[$(date +%Y%m%d_%H%M)system_user]: Added link to Config file in smb.conf"


                echo "[$(date +%Y%m%d_%H%M)system_user]: Restarting Samba Service"
                systemctl restart smbd.service

            else
                echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! Unable to include link in smb.conf"
                
            fi

        else
            echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! Unable to Backup Global Samba Config file ... Aborting"
            exit 1
        fi
    
        
    else
        echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! Global Samba Config file does not exist ... aborting"
        exit 1
    fi


    lv_path="${vg_path}${username}"
    # Creating LV Partition
    if [ -d "${vg_path}" ]; then
        echo "[lvm]: Volume Group ${vg_name} exists"

        read -rp "Enter Size of Logical Volume Partition : " lv_size
    
        if lvcreate -v -L "${lv_size}" -n "${username}" "${vg_name}"; then
            echo "[create_lvm]: created new LV '${username}'"

            if mkfs.ext4 -v -L "${username}" "${lv_path}"; then
                echo "[create_lvm]: Partioning new LV"

                
                if cp -v "${fstab_file}" "${fstab_backups_dir}fstab.backup.${backup_stamp}"; then
                    echo "[create_lvm]: Created Backup of fstab file"


                    local UUID="$(sudo blkid -s UUID -o value ${lv_path})"

                    local new_fstab_entry="UUID=${UUID}  ${users_dir}    ext4    defaults    0   0"

                    echo "${new_fstab_entry}" | tee -a "${fstab_file}"

                    if mount -v "${lv_path}" "${users_dir}"; then
                        echo "[create_lvm]: LVM for User Directory has been mounted successfully"
                        
                    else
                        echo "[create_lvm]: WARNING !! Unable to mount User LVM"
                    fi



                else
                    echo "[create_lvm]: WARNING!! Unable to create Backup of fstab file. Exiting"
                    exit 1
                fi

              
            else
                echo "[create_lvm]: WARNING Problem Partioning new LV"
                exit 1
            fi


        else
            echo "[create_lvm]: WARNING Error creating new LV '${username}'"
            exit 1
        fi

    else
        echo "[lvm]: WARNING !! Volume Group Does not Exist."
        exit 1

    fi



































else
    echo "[$(date +%Y%m%d_%H%M)system_user]: WARNING !! Only Root may make further changes, exiting"
    exit 1
fi




