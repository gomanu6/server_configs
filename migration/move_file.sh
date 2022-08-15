#!/bin/bash




function move_file () {

    local directory=$1

    for dir in ${directory}/*; do

        echo
        echo "${dir}"
        if cp -r "${dir}" "${dest}"; then
            echo
            echo "---- Finished Copying ${dir} ------"
            exit 0
        else
            echo "[WARNING]---- Problem Copying ${dir} ------"
            exit 1
        fi
    done


}








