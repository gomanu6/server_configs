#!/bin/bash

. ./ascpl.config
. ./create_dir.sh
. ./create_file.sh
. ./create_system_user.sh
. ./create_group.sh

# Create directory for config
create_dir "${config_dir}" "Config"

# create directory for log File
create_dir "${log_dir}" "Log"

# Create log File
create_file "${log_file}" "Log"

# create Samba Admins Group
create_group "${default_samba_admin_group}"

# create Samba users Group
create_group "${default_samba_users_group}"

# create SFTP Admin Group
create_group "${default_sftp_admin_group}"

# create SFTP users Group
create_group "${default_sftp_users_group}"


# create default user
create_system_user "${default_system_user}" "${default_system_user_password}" "${system_user_shell}" "${default_system_user_groups}"


# create sftp user and sftp groups
create_system_user "${default_sftp_user}" "${default_sftp_user_password}" "${system_user_shell}" "${default_system_user_groups}"




create groups for samba and samba admin

set user as samba admin

cretae file for active users