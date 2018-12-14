#!/bin/bash
echo -e "\e[32mStarting Pendrive Backup...\e[0m"

rsync -CauhP --stats --delete-after --exclude "N" --dry-run /media/nirantak/NirantakPD/ ~/Downloads/PD | grep "^del"
read -n1 -p "Do that? [y,n]: " doit

case $doit in
    y|Y) rsync -CauhP --stats --delete-after --exclude "N" /media/nirantak/NirantakPD/ ~/Downloads/PD ;;
    n|N) echo -e "\nDid not backup" ;;
    *) echo -e "\nInvalid Input" ;;
esac

echo -e "\e[32m*Backup Complete*\e[0m"
