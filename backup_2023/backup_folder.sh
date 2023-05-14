#!/bin/bash


. ./backup_settings.config
. ./dir_exists.sh
. ./dir_create.sh
. ./dir_latest.sh
. ./rsync_backup.sh

n="[$0]: "
user=$1

todays_date=$(date +%F)

source="${source_base}/${user}"

dest="${target_base}/${user}/backups"

deleted_files="${target_base}/${user}/deleted_files"

log_dest="${target_base}/${user}/logs"

link_dest=""


# check if source exists
if dir_exists "${source}"; then
    echo "$n Source Dir Exists"
else
    echo "$n Source Directory does not exist. Nothing to Back Up."
    exit 1
fi

# check if target exists and create if it doesn't
# if dir_exists "${dest}"; then
#     echo "$n Target Dir Exists"


# else
#     echo "$n Target Directory does not exist."
#     if dir_create "${dest}"; then
#         echo "$n Created directory ${dest}"
#     else
#         echo "$n Unable to create Target Destination"
#         exit 1
#     fi
# fi

dir_create "${dest}" "${deleted_files}" "${log_dest}"


# Check if backup Folder contains previous backups
last_backup=$(dir_latest "${dest}")

if [ -n "${last_backup}" ]; then
    echo "$n Previous backup exists"
    link_dest="--link-dest ${last_backup}"
    echo "$n link-dest has been set as ${last_backup}"
else
    echo "$n No previous Backup"
fi


# Backup the Directory
echo "$n Starting Backup for ${user}"

time -f "${time_format_options}" rsync_backup -s "${user}" -d "${dest}" -k "${link_dest}" -l "${log_dest}"




