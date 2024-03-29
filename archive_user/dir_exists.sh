#!/bin/bash


dir_exists() {

    local n="[$0]: "
    local folder=$1


    if [ -n "${folder}"]; then


        echo "$n Checking if ${folder} exists"

        if [ -d "${folder}" ]; then
            echo "$n ${folder} exists"
            return true
        else
            echo "$n ${folder} does NOT exist"
            return false
        fi

    else
        echo "$n Please enter valid folder name"
        exit 1
    fi

}