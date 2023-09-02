#!/bin/bash


 . ./settings_backup.config
 . ./dir_create.sh

todays_date=$(date +%F)
user="$1"

log_dest="${target_base}/${user}/logs"

dir_create "${log_dest}"

 ${script_location}/2backup_folder.sh ${user} | tee -a "${log_dest}/rbackup_a_${todays_date}.log"


