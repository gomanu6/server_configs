#!/bin/bash


function move_folder () {

    source=$1
    target=$2
    list=$3


    while IFS= read -r line; do

        mv "${source}${line}" "${target}"

    done < "${list}"


}



