#!/bin/bash


function samba_user_enable () {

    local username=$1
    local password=$2

    if (echo "$password"; echo "$password") | smbpasswd -s -a "$username"; then

        if smbpasswd -e "$username"; then
            echo "[samba_user_enable]: The User can now login through Samba"

            

        else
            echo "[samba_user_enable]: WARNING [smbpasswd -e] Problem Enabling the user in Samba"
            exit 1
        fi
    else 
        echo "[samba_user_enable]: WARNING [smbpasswd -a] Problem setting user password in Samba"
        exit 1
    fi



}