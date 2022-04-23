#!/bin/bash

. ./ascpl.config
. ./init/create_dir.sh
. ./init/create_file.sh
. ./init/create_group.sh
. ./init/create_system_user.sh
. ./network/set_static_ip.sh
. ./samba/backup_global_samba_config.sh
. ./samba/custom_global_samba_config.sh
. ./samba/samba_user_enable.sh


# Create log File
create_file "${init_log_file}" "Log"

echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: Beginning Init tasks" | tee -a "${init_log_file}"
# Create directory for config
create_dir "${config_dir}" "Config" | tee -a "${init_log_file}"

# create directory for log File
create_dir "${log_dir}" "Log" | tee -a "${init_log_file}"


# Create log File
create_file "${log_file}" "Log" | tee -a "${init_log_file}"

# create Samba Admins Group
create_group "${default_samba_admin_group}" | tee -a "${init_log_file}"

# create Samba users Group
create_group "${default_samba_users_group}" | tee -a "${init_log_file}"

# create SFTP Admin Group
create_group "${default_sftp_admin_group}" | tee -a "${init_log_file}"

# create SFTP users Group
create_group "${default_sftp_users_group}" | tee -a "${init_log_file}"

# create samba user config directory
create_dir "${samba_users_config_dir}" "Samba Users Config"

# create samba config backup directory
create_dir "${samba_config_backups_dir}" "Samba Config Backups"

# create file for active users
create_file "${active_users}" "Active Users" | tee -a "${init_log_file}"


# create default user
create_system_user "${default_system_user}" "${default_system_user_password}" "${system_user_shell}" | tee -a "${init_log_file}"



# create sftp user
create_system_user "${default_sftp_user}" "${default_sftp_user_password}" "${system_user_shell}"  | tee -a "${init_log_file}"

# add sftp user to sftp admins group
if usermod -aG "${default_sftp_admin_group}" "${default_sftp_user}"; then
    echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]: successfully added ${username} to ${default_samba_admin_group}"
else
    echo "[create_system_user: $(date +%Y%m%d_%H%M%S)]:WARNING !! Unable to add ${username} to ${default_samba_admin_group}"

fi


# add system user to samba admin group
if usermod -a -G "${default_samba_admin_group}" "${default_system_user}"; then
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: Added ${default_system_user} to ${default_samba_admin_group}."  | tee -a "${init_log_file}"
else
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to Add ${default_system_user} to ${default_samba_admin_group}."  | tee -a "${init_log_file}"
if



# Set Static IP
if set_static_ip; then
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: Static IP has been set"
else
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to set Static IP."
fi



# SSH port
cp -v "${ssh_config_file}" "${ssh_config_file}.backup.${backup_stamp}"
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



# backup Global samba config file
backup_global_samba_config | tee -a "${init_log_file}"



# Create Custom Global Samba Config
if custom_global_samba_config; then
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: Custom Config for Samba Successfully created"  | tee -a "${init_log_file}"
else
    echo "[ascpl_init: $(date +%Y%m%d_%H%M%S)]: WARNING !! Unable to create Custom Config for Samba." | tee -a "${init_log_file}"

fi


# enable default system user for samba
samba_user_enable "${default_system_user}" "${default_system_user_password}"  | tee -a "${init_log_file}"

# restart Samba



exit 0