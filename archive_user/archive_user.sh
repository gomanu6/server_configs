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
backup_time=$(date +%Y%m%d_%H%M%S)

user="$1"
source="${source_base}/${user}"
target_folder="${target_folder}/${user}_${day}"

target_archive="${target_archive}/${user}_${day}"


# check if source exists
if dir_exists "${source}"; then
    echo "$0 Source Dir Exists"
else
    echo "$0 Source Directory does not exist. Nothing to Back Up."
    exit 1
fi

# check if target exists
if dir_exists "${target_folder}"; then
    echo "$0 target Dir Exists. Will not copy over target dir"
    exit 1
else
    echo "$0 Target Directory does not exist. Will create target dir"
    if mkdir -p "${target_folder}"; then
        echo "$0 target directory created"
    else
        echo "$0 unable to create target dir"
        exit 1
    fi
fi


if cp -Rp "${source}" "${target_folder}"; then
    echo "$0 copied folder successdully"
else
    echo "$0 unable to copy folder"
fi



if zip -r "${target_archive}.zip" "${source}"; then
    echo "$0 zip archive created successfully"
else
    echo "$0 unable to create zip archive"
fi









