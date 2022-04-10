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

    local new_user_data_dir="${new_user_data_parent_dir}${username}" 

    


    if [ -d "${vg_path}" ]; then
        echo "[lvm]: Volume Group ${vg_name} exists"
    
        if [ lvcreate -v -L "${lv_size}" -n "${lv_name}" "${vg_name}" ]; then
            echo "[create_lvm]: created new LV '${lv_name}'"

            if [ mkfs.ext4 -v -L "${volume_label}" "${lv_path}" ]; then
                echo "[create_lvm]: Partioning new LV"

                
                UUID="$(sudo blkid -s UUID -o value ${lv_path})"

                local new_fstab_entry="UUID=${UUID}  ${new_user_data_dir}    ext4    defaults    0   0"

                echo "${new_fstab_entry}" | tee -a "${fstab_file}"

                mount -v -L "${lv_path}" "${new_user_data_dir}"
                


            else
                echo "[create_lvm]: WARNING Problem Partioning new LV"
                exit 1
            fi


        else
            echo "[create_lvm]: WARNING Error creating new LV '${lv_name}'"
            exit 1
        fi

    else

    fi
    

        




}

