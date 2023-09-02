#!/bin/bash



ls "${source_base}" | xargs -n1 -P4 -I% "${script_location}/backup_and_email.sh" "${user}" | tee -a "${log_dest}/rbackup_a_${todays_date}.log"
