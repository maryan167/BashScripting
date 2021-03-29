#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--user)
    USERNAME="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--override)
    OVERRIDE=YES
    shift # past argument
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters



if [[ ! -d /backup  ]]
then
    sudo mkdir /backup
    sudo chmod 400 /backup
fi

if [[ ! -f /backup/${USERNAME}_configs.zip ]]
then
    files_list=$(find /home/$USERNAME/ -not -path "/home/$USERNAME/.local/share/Trash*" -type f -name '*.conf*')
    sudo zip /backup/${USERNAME}_configs $files_list
    sudo chown $USERNAME /backup/${USERNAME}_configs.zip
    sudo chgrp $USERNAME /backup/${USERNAME}_configs.zip
    sudo chmod 400 /backup/${USERNAME}_configs.zip
else
    files_list=()
    read -r -d'\n' -a files_list < <(unzip -Z1 /backup/${USERNAME}_configs.zip && printf '\0')
    
    for file in ${files_list[@]}; do
        if [ ! -f /$file ]
        then
            sudo -u $USERNAME unzip -j "/backup/${USERNAME}_configs.zip" "$file" -d $(dirname "/$file")
        fi
    done

    files_list=$(find /home/$USERNAME/ -not -path "/home/$USERNAME/.local/share/Trash*" -type f -name '*.conf*')
    sudo zip /backup/${USERNAME}_configs $files_list
    sudo chown $USERNAME /backup/${USERNAME}_configs.zip
    sudo chgrp $USERNAME /backup/${USERNAME}_configs.zip
    sudo chmod 400 /backup/${USERNAME}_configs.zip
fi




