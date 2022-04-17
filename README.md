# server_configs
Configuration for the Samba Server

This will add a new user with relevant samba permissions


#### Prerequisites

- ssh
- samba
- git
- firewall
- fail2ban
    - enable sshd jail
- set timezone
- zip
    -9 = max compression level
    -r = recursive
    -v = verbose
    -q = quiet

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


#### LVM

- lvm size
- mount point


#### Backup
- Backup directory
- Schedule
- options
    z = compress
    v = verbose
    a = archive, = rlptgoD
        r = recursive, covered in -a
        l = copy symlinks as symlinks, covered in -a
        p = preserve Permissions, covered in -a
        t = preserve modification times, covered in -a
        g = preserve group, covered in -a
        o = preserve owner, covered in -a
        D = preserve device files, special files, covered in -a
    h = human readable numbers
    b = make backups (suffix and backup-dir)
        --suffix="_old"
        --backup-dir="/path/"
    ?H = preserve Hard Links
    A = preserve acl's, implies -p
    X = preserve extended attributes
    n = dry run
    c = checksum
    i = itemize changes, output a change summary for all changes
    --link-dest=DIR = Dir for Hard Linking files
    --log-file=DIR

##### Backup Commands

rsync_daily_backup $user $source $dest [$link_dest]

