#!/bin/bash



function create_group () {

    local groupname=$1
    

    echo "[create_group]: Checking if group ${groupname} exists."

    if grep -wi "${groupname}" /etc/group; then
        echo "[create_group]:  WARNING !! Group ${groupname} already exists."
    else
        if groupadd "${groupname}"; then
            echo "[create_group]: Group ${groupname} created successfully."
        else
            echo "[create_group]: WARNING !! Unable to create Group ${groupname}."
        fi
        echo "[create_group]:  WARNING !! Unable to create Group ${groupname}"
    fi



}
