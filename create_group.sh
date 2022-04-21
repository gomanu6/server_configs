#!/bin/bash



function create_group () {

    local groupname=$1
    

    echo "[create_group]: Checking if group ${groupname} exists and creating it"

    if getent group "${groupname}" || groupadd "${groupname}"; then
        echo "[create_group]:  Group for ${ groupname} Created"
    else
        echo "[create_group]:  WARNING !! Unable to create Group ${groupname}"
    fi



}
