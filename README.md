# server_configs
Configuration for the Samba Server

This will add a new user with relevant samba permissions


#### Prerequisites

- set timezone
- ssh
- samba
- acl
- git
- duck
- firewall
- fail2ban
    - enable sshd jail
- zip
    -9 = max compression level
    -r = recursive
    -v = verbose
    -q = quiet
- smartmontools

#### Init Tasks 
- set Timezone
    - timedatectl set-timezone Asia/Kolkata
- install pre-requisites
- set bash rc defaults
- duck dns
- startup log
- ssh port
- sftp setup
- create directories for system config
- create backups of ssh, samba and fstab config files
- default groups for sftp samba
- Partition and Format Backup Drive
- mount Backup drive and add entry in fstab file
- create directories for backups, daily and hourly
- Create Volume Group for Users Directory
- change value of IPT_MODULES entry for samba in ufw 
    - /etc/default/ufw
    - IPT_MODULES="nf_conntrack_ftp nf_nat_ftp nf_conntrack_irc nf_nat_irc"
    - IPT_MODULES="nf_conntrack_ftp nf_nat_ftp nf_conntrack_irc nf_nat_irc nf_conntrack_netbios_ns"
    - sudo ufw reload

    OR

    - echo 1 > /proc/sys/net/netfilter/nf_conntrack_helper


#### SSH Setup
- port
- set port in firewall
- ssh-keys


#### Samba Setup
- smb.conf
- Samba Users Directory
- Samba Users Group
- Samba Admin Group
- Check Samba Port in Firewall
- samba ports
    - 137/udp
    - 138/udp
    - 139/tcp
    - 445/tcp
    - 111/tcp

#### Firewall setup
- reset firewall
- deny incoming
- allow outgoing
- allow ssh
- allow samba
- log file /var/log/ufw.log
- tail -f /var/log/ufw.log to check if something is being blocked




#### User manipulation
- useradd
    - --home DIR = path to home dir
    - --shell /bin/shell = path to shell
    -c = comment
    -G = supplementary groups
    - --password $password = encrypted password, as returned by crypt(3)

- usermod
    -a = append user to supplementary group
    -G = supplementary groups
    -c = comment
    -d = new home directory
    -m = move contents of home dir to new home dir
    -s = name of new login shell
    -l = lock
    -u = unlock




#### LVM
- Volume Group
- lvm size
- mount point
- read an lvm partition in a new Linux system
    1. vgscan - scan for volume groups
    2. vgchange -ay {volume_group_name}
    3. lvs - scan for logical volumes
    4. create mountpoint
    5. mount
- vgextend vg_name /dev/sda2
- lvextend -L50G /dev/vg_name/lv_name
    50G = new size
    -L+50G = extend by 50G
- e2fsck -f /dev/vg_name/lv_name
- resize2fs /dev/vg_name/lv_name

#### Backup
- Backup directory
- Schedule
- options
    z = compress (only preferable for remote dirs)
    v = verbose
    a = archive, = rlptgoD
        r = recursive, covered in -a
        l = copy symlinks as symlinks, covered in -a
        p = preserve Permissions, covered in -a
        t = preserve modification times, covered in -a
        g = preserve group, covered in -a
        o = preserve owner, covered in -a
        D = preserve device files, special files, covered in -a
    A = preserve acl's
    X = preserve extended attributes
    E = preserve executability
    W = copy whole files (without delta transfer algo) - only compares time/size of file
    S = turns sequence of nulls into sparse blocks. Sparse files (i.e. files that are for instance holding a file system and that just take the space needed by their actual size)
    h = human readable numbers
    b = make backups (suffix and backup-dir)
        --suffix="_old"
        --backup-dir="/path/"
    ?H = preserve Hard Links
    A = preserve acl's, implies -p
    X = preserve extended attributes
    n = dry run
    c = checksum
    u = skip files that are newer on the receiver
    i = itemize changes, output a change summary for all changes
    --link-dest=DIR = Dir for Hard Linking files
    --log-file=DIR
#### [rsync output meaning](http://www.staroceans.org/e-book/understanding-the-output-of-rsync-itemize-changes.html)

##### Backup Commands

rsync_daily_backup $user $source $dest [$link_dest]

#### Initial Volume Group




#### Create System Users
- input username
- create mountpoint
- create user
- create lvm and mount lvm
- enable user in Samba
- update samba configuration
- set backup config and script




/mnt/shares/sftp/all/bkp/rbackups/accounts/backups/backup_2023-12-19/accounts/

while IFS= read -r user; do du -sh /mnt/shares/sftp/all/bkp/rbackups/${user}/backups/backup_2023-12-19/${user} >> /home/manu/user_sizes.txt; done < /etc/ascpl/users_to_backup


cat /sys/class/block/dm-1/dm/name

dmsetup info fedora-root -C -o blkdevname --noheadings