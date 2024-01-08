### Migration


#### Create PV 

pvcreate 
    -v = verbose
    -q = quiet
    -t = test
    -f = --force
    -y = --yes
    -u = --uuid string



sudo pvcreate /dev/md0

pvdisplay
pvscan
pvs


#### Create VG


vgcreate
    -v = verbose
    -f = --force
    -q = quiet
    -t = test
    -y = --yes
    -A = autobackup of metadata after change
    -p = --maxphysicalvolumes Number

vgcreate [option] vg_name PV

vgcreate <vg_name> /dev/sdb /dev/sdc

sudo vgcreate users /dev/md0

#### Create LVM





Mount LVM
Add entries to fstab files




