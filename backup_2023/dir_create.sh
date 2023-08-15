#!/bin/bash



dir_create() {

    local n="[$0]: "


    for folder in "$@"
    do
    
        if [ -n "${folder}" ]; then

            if [ ! -d "${folder}" ]; then
                echo "${n} ${folder}  doesn't exist, Creating it"

                if mkdir -p "${folder}" ; then
                    echo "${n} Created Folder ${folder}"
                else
                    echo "${n} Unable to Create ${folder}"
                fi
            else
                echo "${n} ${folder} already exists"
            fi
        else
            echo "${n} Please enter a valid Folder name"
        fi
    done

}