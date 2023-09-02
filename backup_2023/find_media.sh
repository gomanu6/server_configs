#!/bin/bash

. ./settings_backup.config

user="$1"

find "${source_base}/${user}" -type f (-name "*.mkv" -o -name "*.avi" -o -name "*.mp4" -o -name "*.mp3")

