#!/bin/bash



function create_mountpoint () {

    local username=$1

    # imported variables
    local new_user_data_dir="${base_home_dir}${username}" 
    local samba_group="${default_samba_users_group}"


    if [ ! -d "${new_user_data_dir}" ]; then
        echo "[mountpoint]: Mount Point does not exist, creating mountpoint"

        if mkdir -vp "${new_user_data_dir}"; then
            echo   "[mountpoint]: Mount point Created"

            if chown -v "${username}:${samba_group}" "${new_user_data_dir}"; then
                echo "[mountpoint]: Mount Point ownership changed"

                if chmod -R -v 1755 "${new_user_data_dir}"; then
                    echo "[mountpoint]: Mount Point permissions changed to $(stat -c $'\nOwner Name: %U, \nOwner Group Name: %G, \nMount Point: %m, \nPermission: %A (%a), \nFile Type: %F' ${new_user_data_dir})"
                                        

                    echo "[mountpoint]: Returning Control to create_user"
                    


                else
                    echo "[mountpoint]: WARNING !! There was an error in changing the permissions for the Mount Point."
                    exit 1
                fi

            else
                echo "[mountpoint]: WARNING !! There was an error in setting the ownership for the Mount Point"
                exit 1
            fi

        else 
            echo   "[mountpoint]: WARNING !! Problem creating Mount Point"
            exit 1
        fi


    else
        echo "[mountpoint]: WARNING !! User Directory already exists, aborting"
        exit 1
    fi


}
