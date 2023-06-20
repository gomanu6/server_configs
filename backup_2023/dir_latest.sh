#!/bin/bash





dir_latest() {

    local parent_dir=$1

    local latest_sub_dir=$(ls -t --group-directories-first "${parent_dir}" | head -n 1)
    
    if [ -n "${latest_sub_dir}" ]; then
        echo "$n The latest Directory in ${parent_dir} is ${latest_sub_dir}"
        return "${latest_sub_dir}"
    else
        echo "$n No Sub-Directories"
        return ""
    fi

}