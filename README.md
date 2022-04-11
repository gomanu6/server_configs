# server_configs
Configuration for the Samba Server

This will add a new user with relevant samba permissions


#### Prerequisites

- ssh
- samba
- git
- firewall
- set timezone
- zip

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
    v = verbose
    a = archive, = rlptgoD
        r = recursive, covered in -a
        l = copy symlinks as symlinks, covered in -a
        p = preserve Permissions, covered in -a
        t = preserve modification times, covered in -a
        g = preserve group, covered in -a
        o = preserve owner, covered in -a
        D = preserve device files, special files, covered in -a
    b = make backups (suffix and backup-dir)
    ?H = preserve Hard Links
    A = preserve acl's, implies -p
    X = preserve extended attributes
    n = dry run
    z = compress
    h = human readable numbers
    c = checksum
