#!/bin/bash

. ./ascpl.config

function create_system_user () {


    local username=$1
    local password=$2
    local user_shell=$3
    local append_groups=$4

    if [ -z "$4" ]; then
        append_groups=""
    else
        echo "[rsync_backup]: $4 groups to be appended."
        append_groups="-G $4"
        echo "[rsync_backup]: groups to be appended parameter has been set."
    fi


    local user_home_dir="${base_home_dir}${username}"




    echo "[create_system_user]: Checking if ${username} already exists"
    if grep -Ewi  "${username}" /etc/passwd > /dev/null; then
        echo "[create_user]: WARNING !! ${username} already exists. please suggest a unique username"
        read -rp "Enter username to create : " input_username
        
        if [ -z "${input_username}" ]; then
            echo "[]: WARNING !! username field is blank. Please enter a username."
        else
            username="${input_username}"
        
    else
        read -rp "[create_user]: Enter a username. Default is ${suggested_username}" answer
        name="${answer,,}"
        username="${name:=$suggested_username}"
    fi





    if useradd --home "${user_home_dir}" --shell "${user_shell}" "${append_groups}" "${username}"; then







}