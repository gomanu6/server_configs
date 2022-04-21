#!/bin/bash



function create_group () {

    local groupname=$1
    

    echo "[create_group: $(date +%Y%m%d_%H%M%S)]: Checking if group ${groupname} exists."

    if grep -wi "${groupname}" /etc/group; then
        echo "[create_group: $(date +%Y%m%d_%H%M%S)]:  WARNING !! Group ${groupname} already exists."
    else
        if groupadd "${groupname}"; then
            echo "[create_group: $(date +%Y%m%d_%H%M%S)]: Group ${groupname} created successfully."
        else
            echo "[create_group: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to create Group ${groupname}."
        fi
        echo "[create_group: $(date +%Y%m%d_%H%M%S)]:  WARNING !! Unable to create Group ${groupname}"
    fi



}
