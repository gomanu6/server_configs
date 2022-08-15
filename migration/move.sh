#!/bin/bash




function move () {

    local src_directory=$1
    local dst_directory=$2

    echo "checking validity of source directory"
    if [ -d "${src_directory}" ]; then
        echo "Source is a valid directory"
        
        echo "checking if Destination exists"
        if [ -d "${dst_directory}" ]; then
            echo "Destination exists"

            echo "Moving recursively"

            for dir in ${src_directory}/*; do

                echo
                echo "------------------------------"
                echo "---- Copying ${dir} ------"
                if cp -r "${dir}" "${dst_directory}"; then
                    echo
                    echo "---- Finished Copying ${dir} ------"
                    echo "------------------------------------"
                    exit 0
                else
                    echo "[WARNING]---- Problem Copying ${dir} ------"
                    echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
                    exit 1
                fi
            done
            

        else
            echo "Destination does not exis ... exiting"
            exit 1
        fi




    else 
        echo "Source is not a valid Directory ... exiting"
        exit 1
    fi



}








