#!/bin/bash



function foldarise() {


    for thefile in $(ls *.*); do


        filename=$(basename -- "${thefile}")

        extension="${filename##*.}"
        extension="${extension,,}"

        filename="${filename%.*}"
        filename="${filename,,}"
        
        foldername="${filename}-${extension}"

        usr=$(stat --format="%U:%G"  ${thefile} | cut -d ":" -f1)
        grp=$(stat --format="%U:%G"  ${thefile} | cut -d ":" -f2)


        if [ -d "${foldername}" ]; then
            echo "Folder exists"
            mv -v "${thefile}" "${foldername}"
            chown "${usr}:${grp}" "${foldername}/${thefile}"
        else
            mkdir -vp "${foldername}"
            mv -v "${thefile}" "${foldername}"
            chown -R "${usr}:${grp}" "${foldername}"
        fi

    done

}

foldarise