#!/bin/bash


file=$1
target=$2

source_path="/mnt/shares/sftp/old_ms2/All-Old/"
target_path_base="/mnt/shares/sftp/old_ms2/"



while IFS= read -r line; do

    mv "${source_path}$line" "${target_path_base}${target}"

done < "${file}"