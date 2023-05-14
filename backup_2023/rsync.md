### Rsync Backup

#### Backup Steps
- Backup directory (Rsync)
- Zip Directory
- Schedule

#### Rsync Options

- z = compress
- v = verbose
- a = archive, = rlptgoD
    - r = recursive, covered in -a
    - l = copy symlinks as symlinks, covered in -a
    - p = preserve Permissions, covered in -a
    - t = preserve modification times, covered in -a
    - g = preserve group, covered in -a
    - o = preserve owner, covered in -a
    - D = preserve device files, special files, covered in -a
- h = human readable numbers
- b = make backups (suffix and backup-dir)
    - --suffix="_old"
    - --backup-dir="/path/"
- H = preserve Hard Links
- A = preserve acl's, implies -p
- X = preserve extended attributes
- n = dry run
- c = checksum
- u = skip files that are newer on the receiver
- i = itemize changes, output a change summary for all changes
    - --link-dest=DIR = Dir for Hard Linking files
    - --log-file=DIR

##### Link Dest
