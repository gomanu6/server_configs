#!/bin/bash


. ./dest_paths.txt
. ./move.sh

src_base="/mnt/mounts/sftp/sftp_files/files/qbt_drive/qbt/completed/courses_unsorted"


while IFS= read -r directory; do
    
    echo "${src_base}/${directory}" 
    echo "${directory}_dest"


    #move "${src_base}/${directory}" "${directory}_dest"

done




