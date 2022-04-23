#!/bin/bash


# . ../user/check_if_user_exists.sh


function create_system_user () {


    local username=$1
    local password=$2
    local user_shell=$3
    # local append_groups=$4

    # if [ -z "$4" ]; then
    #     append_groups=""
    # else
    #     echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: $4 groups to be appended."
    #     append_groups="-G $4"
    #     echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: groups to be appended parameter has been set."
    # fi



    # while :
    # do

    #     if [ -z "${input_username}" ]; then
    #         echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: WARNING !! Input Username is blank"

    #     else
    #         echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: The entered username is ${input_username}"

    #         if id -u "${input_username}" > /dev/null 2>&1; then
    #             echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: WARNING !! ${input_username} already exists, please suggest a unique username."
    #             # exit 1        
    #         else
    #             echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: ${input_username} does not exist in the system."
    #             username="${input_username}"
    #             #echo "Creating ${username}"
    #             break
    #             # exit 0
    #         fi


    #     fi

    # done


            if id -u "${username}" > /dev/null 2>&1; then
                echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: WARNING !! ${username} already exists, please suggest a unique username."
                # exit 1        
            else
                echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: ${username} does not exist in the system."
                username="${username}"
                #echo "Creating ${username}"
                #break
                # exit 0
            fi




    local user_home_dir="${base_home_dir}${username}"
    
    if useradd --home "${user_home_dir}" --shell "${user_shell}" "${username}"; then
        echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: successfully added ${username} to the system"

        if echo "$username:$password" | chpasswd; then
            echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: Password has been set for ${username}"
            # echo "[create_system_user]: User has been added to the system. Returning control to [create_user]"
        fi


    else
        echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: WARNING !! There was an error in adding ${username} to the system"
        exit 1
    fi



        






}