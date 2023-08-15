#!/bin/bash



# unmount drive
# extend
# e2fsck
# resize 2 fs
# re-mount

user="$1"
vg_base="/dev/users"
lv="${vg_base}/${user}"
add_space="3G"

if umount -f "${lv}"; then
    echo "$0: Successfully unmounted drive"
else
    if umount -l "${lv}"; then
        echo "$0: Successfully unmounted drive"
    else
        echo "$0: Unable to unmount drive"
        exit 1
    fi
fi

if lvextend -L+"${add_space}" "${lv}"; then
    echo "$0: Added ${add_space} of Space"
else
    echo "$0: Unable to add space"
    exit 1
fi

if e2fsck -f "${lv}"; then
    echo "$0: e2fsck success"
else
    echo "$0: ERROR e2fsck unable to complete"
    exit 1
fi

if resize2fs "${lv}"; then
    echo "$0: resize2fs Success"
else
    echo "$0: ERROR resize2fs"
    exit 1
fi

if mount -v "${lv}"; then
    echo "$0: Remounted ${lv}"
else
    echo "$0: Unable to re mount ${lv}"
    exit 1
fi


exit 0
