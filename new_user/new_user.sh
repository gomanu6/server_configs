#!/bin/bash


# Add User to the system
# Create users Home Directory
# Chown Users Directory (Mountpoint) -- moved to after lv
# chmod users directory (Mountpoint) -- moved to after lv
# Enable user in Samba
# Samba Config (check config dir, user config, global config)
# Create LV part
# mount lv path
# Chown Users Directory (Mounted partition)
# chmod users directory (Mounted Partition)


. ./user_settings.config


day=$(date +%Y%m%d)
backup_stamp=$(date +%Y%m%d_%H%M%S)

# Log Directory
echo "[$(date +%Y%m%d_%H%M): add_new_user]: Checking if Log Directory exists."
if [ -d "${log_file_dir}" ]; then
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Log Directory exists."
else
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Log Directory doesnt exist."
    if mkdir -vp "${log_file_dir}"; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Log Directory Created."
    else
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Problem creating Log Directory"
    fi
fi


# Log File
echo "[$(date +%Y%m%d_%H%M): add_new_user]: Checking if Log file exists."
if [ -f "${log_file}" ]; then


    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Log file exists." | tee -a "${log_file}"
    

else
    echo "Log file doesnt exits. creating it"
    touch "${log_file}"
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Log file created" | tee -a "${log_file}"

fi




function add_new_user () {


    firstname=$1
    lastname=$2
    username=$3
    password=$4

    echo "-----------Running add_new_user for ${username}------------"
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Starting process to add ${username}"
    
    local users_dir="${users_base_dir}${username}"


    # Adding user to the system
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Adding ${username} to the system."
    if useradd --home "${users_dir}" --shell "${samba_users_shell}" -G "${samba_users_group}" "${username}"; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: successfully added ${username} to the system"


        if echo "$username:$password" | chpasswd; then
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: Password has been set for ${username}"
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: ${username} has been added to the system."
        fi


    else
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! There was an error in adding ${username} to the system .... aborting"
        exit 1
    fi


    # Creating Mountpoint
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Creating Mountpoint for ${username}"
    if [ ! -d "${users_dir}" ]; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Mount Point does not exist, creating mountpoint"

        if mkdir -vp "${users_dir}"; then
            echo   "[$(date +%Y%m%d_%H%M): add_new_user]: Mount point Created"
            
        else 
            echo   "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! Problem creating Mount Point ... aborting"
            exit 1
        fi

    else
        echo "[$(date +%Y%m%d_%H%M)add_new_user]: WARNING !! User Directory already exists. Please verify and rectify ... aborting"
        exit 1
    fi



    # # Changing Mountpoint Permissions
    # if chown -v "${username}:${samba_users_group}" "${users_dir}"; then
    #                 echo "[$(date +%Y%m%d_%H%M)add_new_user]: Mount Point ownership changed"

    #     if chmod -R -v 2755 "${users_dir}"; then
    #         echo "[$(date +%Y%m%d_%H%M)add_new_user]: Mount Point permissions changed to $(stat -c $'\nOwner Name: %U, \nOwner Group Name: %G, \nMount Point: %m, \nPermission: %A (%a), \nFile Type: %F' ${users_dir})"
                                
            
    #     else
    #         echo "[$(date +%Y%m%d_%H%M)add_new_user]: WARNING !! There was an error in changing the permissions for ${users_dir}."
    #         exit 1
    #     fi

    # else
    #     echo "[$(date +%Y%m%d_%H%M)add_new_user]: WARNING !! There was an error in setting the ownership for ${users_dir}"
    #     exit 1
    # fi



    # Enabling user in Samba

    echo "[$(date +%Y%m%d_%H%M): add_new_user]: adding Samba password for ${username}"
    if (echo "$password"; echo "$password") | smbpasswd -s -a "${username}"; then
        
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Enabling ${username} in samba"

        if smbpasswd -e "${username}"; then
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: The User can now login through Samba"

            

        else
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING [smbpasswd -e] Problem Enabling the user in Samba"
            # exit 1
        fi
    else 
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING [smbpasswd -a] Problem setting user password in Samba"
        # exit 1
    fi



    # Checking if Samba Users config directory exists
    if [ ! -d "${samba_users_config_dir}" ]; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Samba Config Directory does not exist .. Creating Samba Config Directory"

        if mkdir -vp "${samba_users_config_dir}"; then
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: Successfully Created Samba Config Directory"

        else
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING: Unable to create Samba users Config Directory"
        fi
        
    else
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Samba Backup Config Directory exists."
    fi


    # Creating Samba Config file for User
    
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Creating Samba Config file for ${username}"

    samba_user_config_file="${samba_users_config_dir}${username}.conf"

    tee -a "${samba_user_config_file}" > /dev/null << EOF
[${firstname^} ${lastname^}]
    Comment = Data Folder for ${firstname^} ${lastname^}
    path = ${users_dir}
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 3755
    force create mask = 3755


# This file has been created automatically by add_new_user
# $(date)
EOF
    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Samba Config file for ${username} has been created"

    # Adding entry to Global Samba Config File
    if [ -f "${samba_global_config_file}" ]; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Global Samba Config File exists."
    
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Backing up Global Samba Config File"
        
        if cp -v "${samba_global_config_file}" "${samba_config_backups}smb.conf.backup.${backup_stamp}"; then
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: Backup successful of Global Samba Config file"


            if echo "------------" >> "${samba_global_config_file}"; then
                if echo "# Samba Config File entry for ${firstname} ${lastname} (${username})" >> "${samba_global_config_file}"; then

                    if echo "include = ${samba_user_config_file}" >> "${samba_global_config_file}"; then

                        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Added link to Config file in smb.conf"


                        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Restarting Samba Service"
                        systemctl restart smbd.service

                    else
                        echo "[$(date +%Y%m%d_%H%M)add_new_user]: WARNING !! Unable to include link in smb.conf"
                        
                    fi
                
                else
                    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Unable to add comment in smb.conf"
                
                fi
            else

                echo "[$(date +%Y%m%d_%H%M): add_new_user]: Unable to add comment in smb.conf"

            fi

        else
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! Unable to Backup Global Samba Config file ... aborting"
            exit 1
        fi
    
        
    else
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! Global Samba Config file does not exist ... aborting"
        exit 1
    fi




    # Creating LV Partition
    lv_path="${vg_path}${username}"
    if [ -d "${vg_path}" ]; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Volume Group ${vg_name} exists"

        # read -rp "Enter Size of Logical Volume Partition : " lv_size
    
        if lvcreate -v -L "${default_lv_size}" -n "${username}" "${vg_name}"; then
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: created new LV '${username}'"

            if mkfs.ext4 -v -L "${username}" "${lv_path}"; then
                echo "[$(date +%Y%m%d_%H%M): add_new_user]: Partioning new LV"

                
                if cp -v "${fstab_file}" "${fstab_backups_dir}fstab.backup.${backup_stamp}"; then
                    echo "[$(date +%Y%m%d_%H%M): add_new_user]: Created Backup of fstab file"


                    local UUID="$(sudo blkid -s UUID -o value ${lv_path})"

                    local new_fstab_comment="# fstab entry for ${username}"
                    local new_fstab_entry="UUID=${UUID}  ${users_dir}    ext4    defaults    0   0"


                    echo "" | tee -a "${fstab_file}"
                    echo "${new_fstab_comment}" | tee -a "${fstab_file}"
                    echo "${new_fstab_entry}" | tee -a "${fstab_file}"

                    if mount -v "${lv_path}" "${users_dir}"; then
                        echo "[$(date +%Y%m%d_%H%M): add_new_user]: LVM for User Directory has been mounted successfully"
                        
                    else
                        echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! Unable to mount User LVM"
                    fi



                else
                    echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING!! Unable to create Backup of fstab file. ... ABORTING!!"
                    exit 1
                fi

              
            else
                echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING Problem Formatting new LV. ... ABORTING!!"
                exit 1
            fi


        else
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING Error creating new LV '${username}'..... ABORTING!!"
            exit 1
        fi

    else
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! Volume Group Does not Exist... ABORTING!!"
        exit 1

    fi



    # Changing Mountpoint Permissions
    if chown -R -v "${username}:${samba_users_group}" "${users_dir}"; then
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: Mount Point ownership changed"

        if chmod -R -v 3755 "${users_dir}"; then
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: Mount Point permissions changed to $(stat -c $'\nOwner Name: %U, \nOwner Group Name: %G, \nMount Point: %m, \nPermission: %A (%a), \nFile Type: %F' ${users_dir})"
                                
            
        else
            echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! There was an error in changing the permissions for ${users_dir}."
            # exit 1
        fi

    else
        echo "[$(date +%Y%m%d_%H%M): add_new_user]: WARNING !! There was an error in setting the ownership for ${users_dir}"
        # exit 1
    fi

    echo "[$(date +%Y%m%d_%H%M): add_new_user]: ${username} added successfully. \n End of add_new_user... bye ... bye"

}

read -rp "Enter First name : " first_name
read -rp "Enter Last Name : " last_name
read -rp "Enter Username : " user_name
read -rp "Enter password for ${user_name} : " -s user_pass

add_new_user "${first_name}" "${last_name}" "${user_name}" "${user_pass}" | tee -a "${log_file}"