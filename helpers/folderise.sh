#!/bin/bash



function folderise() {


    for thefile in $(ls -f *.*); do


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

folderise