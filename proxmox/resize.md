[Resize Disks - Proxmox](https://pve.proxmox.com/wiki/Resize_disks)

1. Resizing guest disk
Using GUI in Proxmox
Select your VM from the list > Hardware > Hard Disk > Disk Action > Resize

2. Enlarge the partition(s) in the virtual disk

Online for Linux Guests
Here we will enlarge a LVM PV partition, but the procedure is the same for every kind of partitions. 
Note that the partition you want to enlarge should be at the end of the disk. 
If you want to enlarge a partition which is anywhere on the disk, use the offline method.

Check that the kernel has detected the change of the hard drive size
dmesg | grep vda

Resize the partition 3 (LVM PV) to occupy the whole remaining space of the hard drive
parted /dev/vda
(parted) print
Warning: Not all of the space available to /dev/vda appears to be used, you can fix the GPT to use all of the space (an extra 268435456 blocks) or continue with the current setting? 
Fix/Ignore? F 

(parted) resizepart 3 100%
(parted) quit


3. Enlarge the filesystem(s) in the partitions on the virtual disk

Online for Linux guests with LVM

pvresize /dev/vda3

lvresize --extents +100%FREE --resizefs /dev/ubuntu-vg/ubuntu-lv
