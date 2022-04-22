#!/bin/bash



function check_if_user_exists () {

    local username=$1


    echo "[check_if_user_exists]: Checking if ${username} already exists."

    if id -u "${username}" > /dev/null 2>&1; then
        echo "[check_if_user_exists]: WARNING !! ${username} already exists, please suggest a unique username."
        exit 1        
    else
        echo "[check_if_user_exists]: ${username} does not exist in the system."
        exit 0
    fi


}