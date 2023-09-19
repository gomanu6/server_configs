#!/bin/bash


file_exists() {

    local n="[file_exists]: "
    local file="$1"


    if [ -n "${file}" ]; then


        echo "$n Checking if ${file} exists"

        if [ -f "${file}" ]; then
            echo "$n ${file} exists"
            exit 0
        else
            echo "$n ${file} does NOT exist"
            exit 1
        fi

    else
        echo "$n Please enter valid file name"
        exit 2
    fi

}
