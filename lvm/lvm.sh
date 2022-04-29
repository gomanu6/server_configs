#! /bin/bash


function create_lvm_partition () {
    
    local username=$1

    # imported variables
    local vg_name="${volume_group_name}"


    # created variables
    local vg_path="/dev/${vg_name}/"
    local lv_name="${username}"
    local lv_path="/dev/${vg_name}/${lv_name}"
    local lv_size="${default_lvm_size}"
    local volume_label="${username}"
    local fstab_backups_dir="${config_backups_dir_fstab}"

    local new_user_data_dir="${base_home_dir}${username}" 

    
    if [ -d "${vg_path}" ]; then
        echo "[lvm]: Volume Group ${vg_name} exists"
    
        if lvcreate -v -L "${lv_size}" -n "${lv_name}" "${vg_name}"; then
            echo "[create_lvm]: created new LV '${lv_name}'"

            if mkfs.ext4 -v -L "${volume_label}" "${lv_path}"; then
                echo "[create_lvm]: Partioning new LV"
                             
            else
                echo "[create_lvm]: WARNING Problem Partioning new LV"
                exit 1
            fi


        else
            echo "[create_lvm]: WARNING Error creating new LV '${lv_name}'"
            exit 1
        fi

    else
        echo "[lvm]: WARNING !! Volume Group Does not Exist."
        exit 1

    fi
    

    if [ -d "${fstab_backups_dir}" ]; then
        echo "[create_lvm]: fstab Backup dir exists"
    else
        echo "[create_lvm]: fstab backups dir does not exist"

        if mkdir -vp "${fstab_backups_dir}"; then
            echo "[create_lvm]: created Backups dir for fstab"
        else
            echo "[create_lvm]: Unable to create backups dir for fstab"
        fi
    fi



    if cp -v "${fstab_file}" "${fstab_backups_dir}fstab.backup.${backup_stamp}"; then
            echo "[create_lvm]: Created Backup of fstab file"


        local UUID="$(sudo blkid -s UUID -o value ${lv_path})"

        local new_fstab_entry="UUID=${UUID}  ${new_user_data_dir}    ext4    defaults    0   0"

        echo "${new_fstab_entry}" | tee -a "${fstab_file}"

        if mount -v "${lv_path}" "${new_user_data_dir}"; then
            echo "[create_lvm]: LVM for User Directory has been mounted successfully"
            
            echo "[create_lvm]: Exiting to [create_user]"

        else
            echo "[create_lvm]: WARNING !! Unable to mount User LVM"
        fi



    else
        echo "[create_lvm]: WARNING!! Unable to create Backup of fstab file. Exiting"
        exit 1
    fi



}

