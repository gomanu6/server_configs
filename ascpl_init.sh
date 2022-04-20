#!/bin/bash

. ./ascpl.config
. ./create_dir.sh
. ./create_file.sh
. ./create_system_user.sh

# Create directory for config
create_dir "${config_dir}" "Config"


# create directory for log File
create_dir "${log_dir}" "Log"


# Create log File
create_file "${log_file}" "Log"




# create default user
create_system_user "${default_system_user}" "${}"

create sftp user and sftp groups

create groups for samba and samba admin

set user as samba admin

cretae file for active users