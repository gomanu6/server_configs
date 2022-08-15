#!/bin/bash


. ./dest_paths
. ./move.sh

src_base="/mnt/mounts/sftp/sftp_files/files/qbt_drive/qbt/completed/courses_unsorted"
file="/mnt/mounts/sftp/sftp_files/files/qbt_drive/qbt/completed/courses_unsorted/folders.txt"

declare -a folders_array

# for dir in ${src}/*; do


# done



while IFS= read -r directory; do
    
    folders_array+=(${directory})
    #echo "${src_base}/${directory}" 
    #echo "${directory}_dest"


    #move "${src_base}/${directory}" "${directory}_dest"

done < "${file}"






