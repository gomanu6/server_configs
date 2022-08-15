#!/bin/bash

. ./folder_paths.txt

src_base="/mnt/mounts/sftp/sftp_files/files/qbt_drive/qbt/completed/courses_unsorted"

file="/mnt/mounts/sftp/sftp_files/files/qbt_drive/qbt/completed/courses_unsorted/folders.txt"


while IFS= read -r folder; do

    echo "${folder}"
    src="${src_base}/${folder}"
    dest="${folder}_dest"

    echo "${src}"
    echo "${dest}"

    for dir in ${src}/*; do
        echo
        echo "--------- Copying -------"
        echo "Line-----"
        echo "${dir}"
        echo "----New Line----"
        # cp -r "${dir}" "${dest}"
        echo "${dest}"
        echo "##### Completed Copying ${dir} ######"
    done
   


done < "${file}"
