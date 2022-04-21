#!/bin/bash

. ./ascpl.config
. ./init/create_dir.sh
. ./init/create_file.sh
. ./init/create_group.sh
. ./init/create_system_user.sh

# Create directory for config
create_dir "${config_dir}" "Config"

# create directory for log File
create_dir "${log_dir}" "Log"

# Create log File
create_file "${init_log_file}" "Log"

# Create log File
create_file "${log_file}" "Log"

# create Samba Admins Group
create_group "${default_samba_admin_group}" | tee -a "${init_log_file}"

# create Samba users Group
create_group "${default_samba_users_group}" | tee -a "${init_log_file}"

# create SFTP Admin Group
create_group "${default_sftp_admin_group}" | tee -a "${init_log_file}"

# create SFTP users Group
create_group "${default_sftp_users_group}" | tee -a "${init_log_file}"


# create default user
create_system_user "${default_system_user}" "${default_system_user_password}" "${system_user_shell}" "${default_system_user_groups}"  | tee -a "${init_log_file}"


# create sftp user
create_system_user "${default_sftp_user}" "${default_sftp_user_password}" "${system_user_shell}" "${default_system_user_groups}"  | tee -a "${init_log_file}"


# add system user to samba admin group
if usermod -a -G "${default_samba_admin_group}" "${default_system_user}"; then
    echo "[ascpl_init]: Added ${default_system_user} to ${default_samba_admin_group}."  | tee -a "${init_log_file}"
else
    echo "[ascpl_init]: WARNING !! Unable to Add ${default_system_user} to ${default_samba_admin_group}."  | tee -a "${init_log_file}"
if


# create file for active users
create_file "${active_users}" "Active Users" | tee -a "${init_log_file}"


# SSH port
echo "Port ${default_ssh_port}" >> "${ssh_config_file}"
if systemctl restart sshd; then
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: Restarted SSH Service"  | tee -a "${init_log_file}"


# Set firewall rules
ufw reset
ufw default deny incoming
ufw default allow outgoing
ufw allow "${default_ssh_port}"
ufw allow samba
ufw enable

