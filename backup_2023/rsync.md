### Rsync Backup

#### Backup Steps
- Backup directory (Rsync)
- Zip Directory
- Schedule

#### Rsync Options Major

- -z = compress
- -v = verbose
- -a = archive, = rlptgoD
    - -r = recursive, covered in -a
    - -l = copy symlinks as symlinks, covered in -a
    - -p = preserve Permissions, covered in -a
    - -t = preserve modification times, covered in -a
    - -g = preserve group, covered in -a
    - -o = preserve owner, covered in -a
    - -D = preserve device files, special files, covered in -a
- -h = human readable numbers
- -H = preserve Hard Links
- -n = dry run
- -i = itemize changes, output a change summary for all changes
- --link-dest=DIR = Dir for Hard Linking files from an existing Backup

- -b = make backups (suffix and backup-dir)
    - --suffix="_old"
    - --backup-dir="/path/"

- --chmod=CHMOD = change file/dir permissions
- --chown=USER:GROUP = simple username:groupname mapping


#### Rsync Other Options

- -q = supress non-error messages


- --delete = delete extraneous files from dest dirs
- --delete-after
- --delete-before = receiver deletes before transfer
- --delete-during
- --delete-delay
- --delete-excluded
- --delay-updatess = put all updated files in place at the end

- --exclude=PATTERN = excude files matching Pattrn
- --exclude-from=FILE = read exclude patterns from file
- --include=PATTERN = don't exclude files matching PATTERN
- --include-from=FILE = read include patters from FILE

- --partial = keep partially transferred files
- --partial-dir=DIR = put partially transfered files into dir

- --log-file=FILE = log to specified file
- --log-file-format=FMT = log updates using the specified format
- -A = preserve acl's, implies -p
- -X = preserve extended attributes
- -u = skip files that are newer on the receiver
- -c = skip based on checksum
- -E = preserve executability
- -x = one file system, dont cross filesystem boundaries
- -e = specify remote shell to use
- --preallocate = allocate destination files before writing
- --port=PORT = specifydouble-colon alternate port number
- --progress = show progress during transfer


##### Link Dest


##### cron
###### [Cron Troubleshooting](https://askubuntu.com/questions/222512/cron-info-no-mta-installed-discarding-output-error-in-the-syslog)