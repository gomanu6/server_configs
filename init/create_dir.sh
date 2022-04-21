#!/bin/bash


function create_dir () {

    local dir_to_create=$1
    local dir_type=$2



    echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: Checking if ${dir_type} directory exists." 
    if [ -d "${dir_to_create}" ]; then
        echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: ${dir_type} Directory exists" 
    else
        echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: ${dir_type} Directory does not exist. Creating it"

        if mkdir -vp  "${dir_to_create}"; then
            echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: ${dir_type} Directory has been created"
        else
            echo "[create_dir: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to create ${dir_type} directory"
        fi
    fi


}
