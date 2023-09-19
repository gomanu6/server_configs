#!/bin/bash


# Add User to the system
# Create users Home Directory
# Enable user in Samba
# Samba Config (check config dir, user config, global config)
# LV Partition exists
# mount lv path
# Chown Users Directory (Mounted partition)
# chmod users directory (Mounted Partition)


. ./user_settings.config
. ./active_users.config
. ./dir_create.sh
. ./dir_exists.sh
. ./file_exists.sh

day=$(date +%Y%m%d)
backup_stamp=$(date +%Y%m%d_%H%M)
n="[bulk_user]: "

# Log Directory
if dir_exists "${log_file_dir}"; then
    echo "${n} Log Dir Exists"
else
    echo "${n} Log Directory does not exist."
    dir_create "${log_file_dir}"
fi


# Log File
echo "${n} Checking if Log file exists."

if file_exists "${log_file}"; then
    echo "${n} Log file exists." | tee -a "${log_file}"
else
    echo "Log file doesnt exits. creating it"
    touch "${log_file}"
    echo "${n} Log file created" | tee -a "${log_file}"
fi


# Backup fstab File
if cp -v "${fstab_file}" "${fstab_backups_dir}fstab.backup.${backup_stamp}"; then
    echo "${n} Created Backup of fstab file"
else
    echo "${n} WARNING!! Unable to create Backup of fstab file. ...!!"
fi

function import_user () {

    local firstname=$1
    local lastname=$2
    local username=$3
    local password="${1,,}#1234"
    local n="[import_user]: "

    echo "-----------Running import_user for ${username}-on $(date +%Y%m%d_%H%M)-----------"
    echo "${n} Starting process to add ${username}"
    
    local users_dir="${users_base_dir}${username}"


    # Adding user to the system
    echo "${n} Adding ${username} to the system."
    if useradd --home "${users_dir}" --shell "${samba_users_shell}" -G "${samba_users_group}" "${username}"; then
        echo "${n} successfully added ${username} to the system"


        if echo "$username:$password" | chpasswd; then
            echo "${n} Password has been set for ${username}"
            echo "${n} ${username} has been added to the system."
        fi


    else
        echo "${n} WARNING !! There was an error in adding ${username} to the system"
    fi


    # Creating Mountpoint
    echo "${n} Creating Mountpoint for ${username}"
    if [ ! -d "${users_dir}" ]; then
        echo "${n} Mount Point does not exist, creating mountpoint"

        if mkdir -vp "${users_dir}"; then
            echo   "${n} Mount point Created"
        else 
            echo   "${n} WARNING !! Problem creating Mount Point for ${username}"
        fi

    else
        echo "${n} WARNING !! User Directory for ${username} already exists. Please verify and rectify"
    fi



    # Enabling user in Samba

    echo "${n} adding Samba password for ${username}"
    if (echo "$password"; echo "$password") | smbpasswd -s -a "${username}"; then
        
        echo "${n} Enabling ${username} in samba"

        if smbpasswd -e "${username}"; then
            echo "${n} ${username} can now login through Samba"
        else
            echo "${n} WARNING [smbpasswd -e] Problem Enabling the ${username} in Samba"
        fi
    
    else 
        echo "${n} WARNING [smbpasswd -a] Problem setting ${username} password in Samba"
    fi



    # Checking if Samba Users config directory exists
    if [ ! -d "${samba_users_config_dir}" ]; then
        echo "${n} Samba Config Directory does not exist .. Creating Samba Config Directory"

        if mkdir -vp "${samba_users_config_dir}"; then
            echo "${n} Successfully Created Samba Config Directory"

        else
            echo "${n} WARNING: Unable to create Samba users Config Directory for ${username}"
        fi
        
    else
        echo "${n} Samba Backup Config Directory for ${username} exists."
    fi


    # Creating Samba Config file for User
    
    echo "${n} Creating Samba Config file for ${username}"

    samba_user_config_file="${samba_users_config_dir}${username}.conf"

    tee -a "${samba_user_config_file}" > /dev/null << EOF
[${firstname^} ${lastname^}]
    Comment = Data Folder for ${firstname^} ${lastname^}
    path = ${users_dir}
    browsable = yes
    guest ok = yes
    read only = no
    create mask = 2755
    force create mask = 2755
    create mode = 2755
    force create mode = 2755


# This file has been created automatically by import_user
# $(date)
EOF
    echo "${n} Samba Config file for ${username} has been created"

    # Adding entry to Global Samba Config File
    if [ -f "${samba_global_config_file}" ]; then
        echo "${n} Global Samba Config File exists."
    
        echo "${n} Backing up Global Samba Config File"
        
        if cp -v "${samba_global_config_file}" "${samba_config_backups}smb.conf.backup.${backup_stamp}"; then
            echo "${n} Backup successful of Global Samba Config file"


            if echo "------------" >> "${samba_global_config_file}"; then
                if echo "# Samba Config File entry for ${firstname} ${lastname} (${username}), created on ${day}" >> "${samba_global_config_file}"; then

                    if echo "include = ${samba_user_config_file}" >> "${samba_global_config_file}"; then
                        echo >> "${samba_global_config_file}"
                        echo "${n} Added link to Config file in smb.conf"
                        echo "${n} Restarting Samba Service"
                        systemctl restart smbd.service

                    else
                        echo "${n} WARNING !! Unable to include link in smb.conf for ${username}"
                    fi
                
                else
                    echo "${n} Unable to add comment in smb.conf for ${username}"
                fi
            
            else
                echo "${n} Unable to add comment in smb.conf for ${username}"
            fi

        else
            echo "${n} WARNING !! Unable to Backup Global Samba Config file"
        fi
    
    else
        echo "${n} WARNING !! Global Samba Config file does not exist"
    fi


    # Adding Entry in fstab file
    lv_path="${vg_path}${username}"
    local UUID="$(sudo blkid -s UUID -o value ${lv_path})"
    local new_fstab_comment="# fstab entry for ${username}, modified on ${day}"
    local new_fstab_entry="UUID=${UUID}  ${users_dir}    ext4    defaults    0   0"


    echo "" | tee -a "${fstab_file}"
    echo "${new_fstab_comment}" | tee -a "${fstab_file}"
    echo "${new_fstab_entry}" | tee -a "${fstab_file}"

    # Mounting the LV
    if mount -v "${lv_path}" "${users_dir}"; then
        echo "${n} LVM for User Directory has been mounted successfully"
    else
        echo "${n} WARNING !! Unable to mount User LVM"
    fi


    # Changing Mountpoint Permissions
    if chown -R -v "${username}:${samba_users_group}" "${users_dir}"; then
        echo "${n} Mount Point ownership changed"

        if chmod -R -v 2755 "${users_dir}"; then
            echo "${n} Mount Point permissions changed to $(stat -c $'\nOwner Name: %U, \nOwner Group Name: %G, \nMount Point: %m, \nPermission: %A (%a), \nFile Type: %F' ${users_dir})"
        else
            echo "${n} WARNING !! There was an error in changing the permissions for ${users_dir}."
            # exit 1
        fi

    else
        echo "${n} WARNING !! There was an error in setting the ownership for ${users_dir}"
        # exit 1
    fi

    echo "${n} ${username} added successfully. \n End of import_user... bye ... bye"

}

read -rp "Enter First name : " first_name
read -rp "Enter Last Name : " last_name
read -rp "Enter Username : " user_name
# read -rp "Enter password for ${user_name} : " -s user_pass

# import_user "${first_name}" "${last_name}" "${user_name}" "${user_pass}" | tee -a "${log_file}"
import_user "${first_name}" "${last_name}" "${user_name}" | tee -a "${log_file}"

