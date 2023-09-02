#!/bin/bash


dir_exists() {

    local n="[dir_exists]: "
    local folder="$1"


    if [ -n "${folder}" ]; then


        echo "$n Checking if ${folder} exists"

        if [ -d "${folder}" ]; then
            echo "$n ${folder} exists"
            return 0
        else
            echo "$n ${folder} does NOT exist"
            return 1
        fi

    else
        echo "$n Please enter valid folder name"
        exit 1
    fi

}
