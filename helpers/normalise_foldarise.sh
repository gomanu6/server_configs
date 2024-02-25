#!/bin/bash



function normalise_foldarise() {


    for thefile in $(ls *.*); do


        filename=$(basename -- "${thefile}")

        extension="${filename##*.}"
        extension="${extension,,}"

        filename="${filename%.*}"
        filename="${filename,,}"
        
        foldername="${filename}-${extension}"

        if [ -d "${foldername}" ]; then
            echo "Folder exists"
            mv -v "${thefile}" "${foldername}"
        else
            mkdir -vp "${foldername}"
            mv -v "${thefile}" "${foldername}"
        fi

    done

}

normalise_foldarise