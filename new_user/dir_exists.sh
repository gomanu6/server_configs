#!/bin/bash


dir_exists() {

    local n="[dir_exists]: "
    local folder="$1"


    if [ -n "${folder}" ]; then


        echo "$n Checking if ${folder} exists"

        if [ -d "${folder}" ]; then
            echo "$n ${folder} exists"
        else
            echo "$n ${folder} does NOT exist"
        fi

    else
        echo "$n Please enter valid folder name"
    fi

}
