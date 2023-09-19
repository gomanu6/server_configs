#!/bin/bash


file_exists() {

    local n="[file_exists]: "
    local file="$1"


    if [ -n "${file}" ]; then

        echo "$n Checking if ${file} exists"

        if [ -f "${file}" ]; then
            echo "$n ${file} exists"
        else
            echo "$n ${file} does NOT exist"
            
        fi

    else
        echo "$n Please enter valid file name"
    fi

}
