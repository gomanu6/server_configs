#!/bin/bash


. ./settings_backup.config
. ./dir_create.sh

todays_date=$(date +%F)
user="$1"

log_dest="${target_base}/${user}/logs"

dir_create "${log_dest}"

echo >> ${script_log}
echo "[backup_and_email]: $(date) -> Starting backup for ${user}" >> ${script_log}

time ${script_location}/2backup_folder.sh ${user} | tee -a "${log_dest}/rbackup_a_${todays_date}.log"

echo "[backup_and_email]: $(date) -> Ending backup for ${user}" >> ${script_log}
echo >> ${script_log}


# for user in "$@"
# do

#     log_dest="${target_base}/${user}/logs"

#     dir_create "${log_dest}"

#     time ${script_location}/2backup_folder.sh ${user} | tee -a "${log_dest}/rbackup_a_${todays_date}.log"

# done