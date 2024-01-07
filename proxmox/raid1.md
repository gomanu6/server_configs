


[Raid 1 mdadm](https://www.digitalocean.com/community/tutorials/how-to-create-raid-arrays-with-mdadm-on-ubuntu-22-04)

Creating the Array
sudo mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sda /dev/sdb


madam
    -A = Assemble a pre-existing array
    -B = Build a legacy array without superblocks
    -C = Create new array, --create
    -v = verbose, --verbose
    -n = Raid devices, --raid-devices=
    -N = Name of the array


sudo mdadm -v -C /dev/md0 --level=mirror -n 2 -N "USER_RAID" /dev/sda /dev/sdb