#!/bin/bash

function create_file () {


    local file_to_create=$1
    local filename=$1


    echo "[create_file]: Checking if ${filename} file exists."
    if [ -f "${file_to_create}" ]; then
        echo "[create_file]: ${filename} file exists" 
    else
        echo "[create_file]: ${filename} file does not exist. Creating it"

        if touch  "${file_to_create}"; then
            echo "[create_file]: ${filename} file has been created"
        else
            echo "[create_file]: WARNING !! Unable to create ${filename} file"
        fi
    fi


}