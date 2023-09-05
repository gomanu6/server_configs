#!/bin/bash

. ./settings_backup.config

ls "${source_base}" | xargs -n1 -P4 -I% ${script_location}/backup_and_email.sh %