    #!/bin/bash


    . ./settings_backup.config
    . ./dir_exists.sh
    . ./dir_create.sh
    . ./dir_latest.sh
    . ./2rsync_backup.sh

    n="[backup_folder]:--"
    x="[backup_folder]:-EXIT-ERROR- "
    user=$1

    todays_date=$(date +%F)

    source_folder="${source_base}/${user}/"
    dest="${target_base}/${user}/backups/backup_${todays_date}"
    deleted_files="${target_base}/${user}/deleted_files/deleted_${todays_date}/"
    log_dest="${target_base}/${user}/logs"
    
    link_dest=""
    link_dest_folder="${target_base}/${user}/backups/"

    echo
    echo "-----------xxxxx----- Start of Backup Job for ${user} on $(date)  -----------xxxxx-----"



    dir_create "${log_dest}"
    
    # check if source exists
    if dir_exists "${source_folder}"; then
        echo "${n} Source Dir Exists"
    else
        echo "${x} Source Directory does not exist. Nothing to Back Up."
        exit 1
    fi


    # check if dest exists
    if dir_exists "${target_base}/${user}/backups/"; then
        echo "${n} ${target_base}/${user}/backups Exists"
    else
        echo "${n} Destination Backup Directory does not exist."
        if dir_create "${target_base}/${user}/backups/"; then
            echo "${n} Created Destination Backup Directory"
        else
            echo "${x} Unable to create Destination Backup Directory"
            exit 1
        fi       
    fi

    dir_create "${deleted_files}" "${log_dest}"


    # Check if backup Folder contains previous backups
    last_backup=$(ls -t --group-directories-first "${link_dest_folder}" | head -n 1)
#    last_backup=$(dir_latest "${dest}")
    echo "Value of last_backup is: ${last_backup}"
    
    if [ -n "${last_backup}" ]; then
        echo "${n} Previous backup exists"
        link_dest="--link-dest=${link_dest_folder}${last_backup}"
        echo "${n} link-dest has been set as ${last_backup}"
    else
        echo "${n} No previous Backup"
    fi


    # Backup the Directory

    rsync_backup "${source_folder}" "${dest}" "${deleted_files}" "${link_dest}" "${user}" 

    echo
    echo "-----------xxxxx----- END of Backup Job for ${user} on $(date)  -----------xxxxx-----"
    
    echo