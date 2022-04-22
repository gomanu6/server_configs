#!/bin/bash

. ./move_folder.sh


base_path="/mnt/shares/sftp/old_ms2/"
old_src="All-Old/"
active_source="as/ActiveServer/"
accounts_path="common_accounts/"
old_users_path="old_user_folders/"
archive_users_path="user_archives/"
photos_archives="photos_archives/"
photos_old="photos_old/"

move_folders "${base_path}${old_src}" "${base_path}${accounts_path}" ./common_accounts.txt

move_folder "${base_path}${old_src}" "${base_path}${old_users_path}" ./old_user_folders.txt
move_folder "${base_path}${old_src}" "${base_path}${archive_users_path}" ./user_archives.txt
move_folder "${base_path}${old_src}" "${base_path}${photos_archives}" ./photos_archive.txt
move_folder "${base_path}${old_src}" "${base_path}${photos_old}" ./photos_old.txt

move_folder "${base_path}${active_source}" "${base_path}${photos_old}" ./as_old_users.txt


