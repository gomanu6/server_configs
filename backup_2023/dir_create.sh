#!/bin/bash



dir_create() {

    local n="[$0]: "
    local folder=$1

    if [ -n "${folder}" ]; then

        if mkdir -vp "${folder}" ; then
            echo "$n Created Folder ${folder}"
            exit 0
        else
            echo "$n Unable to Create ${folder}"
            exit 1
    else
        echo "$n Please enter a valid Folder name"
    fi
    

}