#!/bin/bash


# update system
# install dependencies

# create ascpl folders
#   logs
#   config backups
#   samba_user_configs




. ./ascpl.config


day=$(date +%Y%m%d)
backup_stamp=$(date +%Y%m%d_%H%M%S)


# Create Log Dir and File
if [ ! -d "${ascpl_log_dir}" ]; then

    if mkdir -vp "${ascpl_log_dir}"; then

        touch "${ascpl_init_log_file}"

    else
        echo "[init_ascpl]: WARNING! Problem creating Log Directory"

    fi

else
    echo "[init_ascpl]: Log Directory exists"


fi

apt update -y
apt upgrade -y

apt install "${dependencies}"




