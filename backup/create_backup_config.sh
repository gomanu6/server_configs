#!/bin/bash

todays_date=$(date +%F)

user=$1
link_dest=""

source_base="/mnt/shares/sftp/all/active/"
source="${source_base}${user}/"

dest_base="/mnt/shares/sftp/all/bkp/user_backups/daily/"
users_backup_dir="${dest_base}${user}/"
dest="${users_backup_dir}/${todays_date}/"

log_base="/mnt/shares/sftp/all/bkp/logs/${user}/"
log_file="${log_base}/${user}_${todays_date}.log"


if [ -d ${log_base} ]; then
    echo "Found ${user}'s log folder"
else
    echo "WARNING!! ${user}'s log folder does not exist .. attempting to create it"
    if mkdir -vp ${log_base}; then
        echo "${user}'s log folder has been created."
    else
        echo "WARNING!! Unable to create ${user}'s log folder"
    fi

fi


touch ${log_file}
echo | tee -a ${log_file}
echo "/---------BACKUP--->>--${user}--<<--------/" | tee -a ${log_file}
echo "Start Time: $(date)" | tee -a ${log_file}
echo "----------------${user}--------------------" | tee -a ${log_file}


if [ -d ${source} ]; then
    echo "Found ${user}'s source folder" | tee -a ${log_file}
else
    echo "WARNING!! ${user}'s source folder does not exist .. exiting" | tee -a ${log_file}
    exit 1
fi


if [ -d ${dest} ]; then
    echo "Found ${user}'s destination folder" | tee -a ${log_file}
else
    echo "WARNING!! ${user}'s destination folder does not exist .. attempting to create it" | tee -a ${log_file}
    if mkdir -vp ${dest}; then
        echo "${user}'s destination folder has been created." | tee -a ${log_file}
    else
        echo "WARNING!! Unable to create ${user}'s destination folder ... exiting" | tee -a ${log_file}
        exit 1
    fi

fi




echo "[bkp]: Checking if a previous backup for ${user} exists." | tee -a ${log_file}

for i in {-1..-15}; do
    
    date_to_check=$(date -d "${todays_date} ${i} days" +%F)
    date_folder_to_check="${users_backup_dir}${date_to_check}"
    echo "[bkp]: Checking last backup directory for ${user} on ${date_to_check}..." | tee -a ${log_file}

    if [ -d "${date_folder_to_check}" ]; then
        link_dest="${date_folder_to_check}"
        echo "[backup]: Found backup directory for ${user} dated ${date_folder_to_check}. --link-dest parameter has been set" | tee -a ${log_file}
        break
    fi

done


# rsync_daily_backup "${user}" "${source}" "${dest}" "${link_dest}"

echo "Starting Backup ....." | tee -a ${log_file}
rsync -uhazib --suffix="_older" --stats ${link_dest} ${source} ${dest} | tee -a ${log_file}

echo "Reached end of backup script ... bye!!"  | tee -a ${log_file}
echo "End Time: $(date)" | tee -a ${log_file}
echo "/------------END OF BACKUP------------/" | tee -a ${log_file}
echo | tee -a ${log_file}
exit 0
