#!/bin/bash


function create_dir () {

    local dir_to_create=$1
    local dir_type=$2



    echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: Checking if ${2} directory exists." 
    if [ -d "${dir_to_create}" ]; then
        echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: ${2} Directory exists" 
    else
        echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: ${2} Directory does not exist. Creating it"

        if mkdir -vp  "${dir_to_create}"; then
            echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: ${2} Directory has been created"
        else
            echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to create ${2} directory"
        fi
    fi


}
