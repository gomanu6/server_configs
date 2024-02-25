#!/bin/bash


function normalise() {


    
    for thefile in $(ls *.*); do


        filename=$(basename -- "${thefile}")

        extension="${filename##*.}"
        extension="${extension,,}"

        filename="${filename%.*}"
        filename="${filename,,}"
        
        newfile="${filename}.${extension}"

        if [ -f "${newfile}" ]; then
            echo "File already exists"
        else
            mv -v "${thefile}" "${newfile}"
        fi

    done

}

normalise