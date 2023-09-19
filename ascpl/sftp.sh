#!/bin/bash


mkdir -p /mnt/shares/sftp/all

chown root:root /mnt/shares/sftp
chmod 755 /mnt/shares/sftp

chown manusftp:manusftp /mnt/shares/sftp/all


Match Group sftpusers
ForceCommand internal-sftp
PasswordAuthentication yes
ChrootDirectory /mnt/shares/sftp
PermitTunnel no
AllowAgentForwarding no
AllowTcpForwarding no
X11Forwarding no