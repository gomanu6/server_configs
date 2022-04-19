#!/bin/bash


# Create directory for config

echo "[ascpl_init]: Checking if config directory exists."
if [ -d "${config_dir}" ]; then
    echo "[ascpl_init]: Config Directory exists" 
else
    echo "[ascpl_init]: Config Directory does not exist. Creating it"

    if mkdir -vp  "${config_dir}"; then
        echo "[ascpl_init]: Config Directory has been created"
    else
        echo "[ascpl_init]: WARNING !! Unable to create config directory"
    fi
fi


# create directory for log File
echo "[ascpl_init]: Checking if log directory exists."
if [ -d "${log_dir}" ]; then
    echo "[ascpl_init]: Log Directory exists" 
else
    echo "[ascpl_init]: Log Directory does not exist. Creating it"

    if mkdir -vp  "${log_dir}"; then
        echo "[ascpl_init]: Log Directory has been created"
    else
        echo "[ascpl_init]: WARNING !! Unable to create log directory"
    fi
fi


# Create log File
echo "[ascpl_init]: Checking if log file exists."
if [ -f "${log_file}" ]; then
    echo "[ascpl_init]: Log file exists" 
else
    echo "[ascpl_init]: Log file does not exist. Creating it"

    if touch  "${log_file}"; then
        echo "[ascpl_init]: Log file has been created"
    else
        echo "[ascpl_init]: WARNING !! Unable to create log file"
    fi
fi



# create default user


create sftp user and sftp groups

create groups for samba and samba admin

set user as samba admin

cretae file for active users