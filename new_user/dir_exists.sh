#!/bin/bash


dir_exists() {

    local n="[dir_exists]: "
    local folder="$1"


    if [ -n "${folder}" ]; then


        echo "$n Checking if ${folder} exists"

        if [ -d "${folder}" ]; then
            echo "$n ${folder} exists"
            exit 0
        else
            echo "$n ${folder} does NOT exist"
            exit 1
        fi

    else
        echo "$n Please enter valid folder name"
        exit 2
    fi

}
