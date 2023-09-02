    #!/bin/bash


    . ./settings_backup.config
    . ./dir_exists.sh
    . ./dir_create.sh
    . ./dir_latest.sh
    . ./rsync_backup.sh

    n="[$0]: "
    user=$1

    todays_date=$(date +%F)

    source_folder="${source_base}/${user}/"

    dest="${target_base}/${user}/backups/backup_${todays_date}"
    echo "$n destination dir is --> ${dest}"
    deleted_files="${target_base}/${user}/deleted_files/deleted_${todays_date}/"

    log_dest="${target_base}/${user}/logs"
    
    link_dest=""
    link_dest_folder="${target_base}/${user}/backups/"

    # check if source exists
    if dir_exists "${source_folder}"; then
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
    last_backup=$(ls -t --group-directories-first "${link_dest_folder}" | head -n 1)
#    last_backup=$(dir_latest "${dest}")
    echo "Value of last_backup is: ${last_backup}"
    
    if [ -n "${last_backup}" ]; then
        echo "$n Previous backup exists"
        link_dest="--link-dest=${link_dest_folder}/${last_backup}"
        echo "$n link-dest has been set as ${last_backup}"
    else
        echo "$n No previous Backup"
    fi


    # Backup the Directory
    echo "$n Starting Backup for ${user}"

#    time -f "${time_format_options}" 

#    rsync_backup "${source_folder}" "${dest}" "${link_dest}" "${log_dest}" "${deleted_files}"
    
#    suffix="_deleted_on_${todays_date}"

#    rsync -hazvib --suffix="${suffix}" --backup-dir="${deleted_files}" --stats --delete-after "${link_dest}" "${source_folder}" "${dest}"

    echo "Value of link_dest is: ---> ${link_dest}"


    if [ -z "${link_dest}" ]; then
        rsync -hazvib --backup-dir="${deleted_files}" --stats --delete-after "${source_folder}" "${dest}"
    else
        rsync -hazvib --backup-dir="${deleted_files}" --stats --delete-after "${link_dest}" "${source_folder}" "${dest}"
    fi



#    rsync -hazvib "${link_dest}" "${source_folder}" "${dest}"


