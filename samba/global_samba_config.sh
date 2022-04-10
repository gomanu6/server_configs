#!/bin/bash


. ./global_samba_settings.config




echo "[global_samba_config]: Creating Global Samba Config file"
    tee -a "$samba_config_file" > /dev/null << EOF
[global]
    workgroup = $workgroup
    netbios name = $netbios_name
    server string = $server_string
    log file = $samba_log_file
    max log size = $max_log_size
    logging = $logging
    panic action = $panic_action

# ====== AUTHENTICATION =======
    server role = $standalone_server
    obey pam restrictions = yes
    unix password sync = yes
    passwd program = /usr/bin/passwd %u
    passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
    pam password change = yes
    map to guest = bad user
    
# ===== MISC =======
    usershare allow guests = yes

    name resolve order = bcast host

# ======= SHARES ======

EOF