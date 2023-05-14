#!/bin/bash


. ./backup_settings.config
. ./rsync_backup.sh


user=$1

source="${source_base}/${user}"

dest="${target_base}/${user}"


# check if source exists



echo "[backup_folder]: Starting Backup for ${user}"





