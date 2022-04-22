#!/bin/bash



function set_static_ip () {

    local ip_address="${static_ip}"
    local config_file="${static_ip_config_file}"
    local gateway="${gateway}"
    local nameserver1="${nameserver1}"
    local nameserver2="${nameserver2}"


    tee -a "${static_ip_config_file}" > /dev/null << EOF
network:
  version: 2
  renderer: networkd
  ethernets:
    enp2s0:
      dhcp: false
      addresses: [${static_ip}]
      gateway4: ${gateway}
      nameservers:
        addresses: [${nameserver1}, ${nameserver2}]

# This file has been created automatically by set_static_ip
# $(date)
EOF

  if netplan apply; then
      echo "[set_static_ip $(date +%Y%m%d_%H%M%S)]: IP Address has been set to ${ip_address}"
  else
      echo "[set_static_ip $(date +%Y%m%d_%H%M%S)]: WARNING !! IP Address has NOT been set."
  fi


    
}

