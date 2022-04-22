# server_configs
Configuration for the Samba Server

This will add a new user with relevant samba permissions


#### Prerequisites

- ssh
- samba
- git
- duck
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

#### Firewall setup
- reset firewall
- deny incoming
- allow outgoing
- allow ssh
- allow samba




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

- lvm size
- mount point
- read an lvm partition in a new Linux system
    1. vgscan - scan for volume groups
    2. vgchange -ay {volume_group_name}
    3. lvs - scan for logical volumes
    4. create mountpoint
    5. mount

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

