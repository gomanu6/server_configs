#!/bin/bash

base_path="/mnt/shares/sftp/old_ms2/"
old_src="All-Old/"
active_source="as/ActiveServer/"
users_active="users_active/"
accounts_path="common_accounts/"
old_users_path="old_user_folders/"
archive_users_path="user_archives/"
photos_archives="photos_archives/"
photos_old="photos_old/"

function move_folder () {

    source=$1
    target=$2
    list=$3


    while IFS= read -r line; do

        mv "${source}${line}" "${target}"

    done < "${list}"


}


move_folder "${base_path}${active_source}" "${base_path}${users_active}" ./as_active_users.txt
move_folder "${base_path}${active_source}" "${base_path}${old_users_path}" ./as_to_old_users.txt
move_folder "${base_path}${active_source}" "${base_path}${photos_old}" ./as_to_photos_old.txt
move_folder "${base_path}${active_source}" "${base_path}${archive_users_path}" ./as_to_user_archives.txt



