#!/bin/bash

# check if source folder exists
# check if destination folder exists
# copy source folder to target
# change folder permissions
# Unmount users partition
# edit fstab entry ?
# 

. ./settings_archive_user.config

day=$(date +%Y%m%d)
backup_stamp=$(date +%Y%m%d_%H%M%S)

user="$1"
source_folder="${source_base}/${user}"
target_folder="${target_base}/${user}"






