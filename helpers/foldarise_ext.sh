#!/bin/bash


function folderise_ext() {

    ext=$1

    for thefile in *.${ext}; do


        filename=$(basename -- "${thefile}")

        extension="${filename##*.}"
        extension="${extension,,}"

        filename="${filename%.*}"
                
        foldername="${filename}-${extension}"

        if [ -d "${foldername}" ]; then
            echo "Folder exists, moving the file"
            mv -v "${thefile}" "${foldername}"
        else
            mkdir -vp "${foldername}"
            mv -v "${thefile}" "${foldername}"
        fi

    done

}

folderise $1