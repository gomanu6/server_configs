#!/bin/bash


folder1=$1
folder2=$1

log_folder="/home/manu/diff/"
base_server_folder="/mnt/shares/sftp/old_ms2/All-Old/"
log_file="${folder1}_and_${folder2}"

diff -rq "${base_server_folder}${folder1}/" "${base_server_folder}${folder2}/" | tee -a  "${log_folder}${log_file}.log"


