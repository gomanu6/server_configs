#!/bin/bash



dir_create() {

    local n="[dir_create]: "
    local x="[dir_create]: "


    for folder in "$@"
    do
    
        if [ -n "${folder}" ]; then

            if [ ! -d "${folder}" ]; then
                echo "${n} ${folder}  doesn't exist, Creating it"

                if mkdir -p "${folder}" ; then
                    echo "$n Created Folder ${folder}"
                else
                    echo "$x Unable to Create ${folder}"
                fi
            else
                echo "$n ${folder} already exists"
            fi
        else
            echo "$x Please enter a valid Folder name"
        fi
    done

}
