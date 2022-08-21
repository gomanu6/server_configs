#!/bin/bash


# update system
# install dependencies

# create ascpl folders
#   logs
#   config backups
#   samba_user_configs




. ./ascpl.config
. ./create_dir.sh
. ./create_group.sh
. ./set_static_ip.sh

day=$(date +%Y%m%d)
day_time=$(date +%H%M%S)
backup_stamp=$(date +%Y%m%d_%H%M%S)


# Create Log Dir and File

create_dir "${ascpl_log_dir}" "Log"
touch "${ascpl_init_log_file}"


function ascpl_init () {


    apt update -y
    # apt upgrade -y
    echo "[ascpl_init]: Updated Repositories"

    if apt install "${dependencies}"; then
        echo "[ascpl_init]: Installed  ... ${dependencies}"

    else
        echo "[ascpl_init]: WARNING !!! Problem installing dependencies"

    fi



    create_dir "${ascpl_samba_users_config_dir}" "Samba Users Config"
    create_dir "${ascpl_config_backups_dir}" "Config Backups"
    create_dir "${ascpl_config_backups_samba_dir}" "Config Backups - Samba"
    create_dir "${ascpl_config_backups_fstab_dir}" "Config Backups - fstab"
    create_dir "${ascpl_config_backups_ssh_dir}" "Config Backups - ssh"
    create_dir "${ascpl_config_backups_ssh_dir}" "Config Backups - ssh"

    create_group "${default_samba_users_group}"
    create_group "${default_samba_admin_group}"

    set_static_ip

}

ascpl_init | tee -a "${ascpl_init_log_file}"

echo "Tasks Pending"
echo "SSH default port"
echo "configure fail2ban"
echo "Set Firewall Rules"




