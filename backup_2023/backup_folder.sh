    #!/bin/bash


    . ./settings_backup.config
    . ./dir_exists.sh
    . ./dir_create.sh
    . ./rsync_backup.sh

    n="[$0]: "
    user=$1

    todays_date=$(date +%F)

    source_folder="${source_base}/${user}/"

    dest_base="${target_base}/${user}/backups"
    dest="${dest_base}/backup_${todays_date}"

    deleted_files="${target_base}/${user}/deleted_files/deleted_${todays_date}"

    log_dest="${target_base}/${user}/logs"
    log_file="${log_dest}/log_${todays_date}.log"

    link_dest=""
    link_dest_folder="${target_base}/${user}/backups"

    # check if source exists
    if dir_exists "${source_folder}"; then
        echo "$n Source Dir Exists"
    else
        echo "$n Source Directory does not exist. Nothing to Back Up."
        exit 1
    fi



    dir_create "${dest_base}" "${deleted_files}" "${log_dest}"

    touch ${log_file}

    last_backup=$(ls -t --group-directories-first "${dest_base}" | head -n 1)

    if [ -n "${last_backup}" ]; then
        echo "$n Previous backup exists"
        link_dest="--link-dest=${link_dest_folder}/${last_backup}"
        echo "$n link-dest has been set as ${last_backup}"
    else
        echo "$n No previous Backup"
    fi


    
    rsync_backup "${source_folder}" "${dest}" "${deleted_files}" "${link_dest}" "${user}" | tee -a "${log_file}"




