#!/bin/bash



function folderise_only() {


    for thefile in $(ls *.*); do


        filename=$(basename -- "${thefile}")

        extension="${filename##*.}"
        extension="${extension,,}"

        filename="${filename%.*}"
                
        foldername="${filename}-${extension}"

        if [ -d "${foldername}" ]; then
            echo "Folder exists"
            mv -v "${thefile}" "${foldername}"
        else
            mkdir "${foldername}"
            mv -v "${thefile}" "${foldername}"
        fi

    done

}

folderise_only