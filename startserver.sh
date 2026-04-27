#!/bin/sh

# krummy iw4x server startup file

name=$(uname -n) # each container has an assigned hostname corresponding to what kind of server it's running

case "$name" in
    iw46v6tdm) GamePort=47768 && ServerFilename=tdm.cfg && HomePath=/mnt/homepaths/6v6tdm ;;
    iw46v6snd) GamePort=47769 && ServerFilename=snd.cfg && HomePath=/mnt/homepaths/6v6snd ;;
    iw48pgg)   GamePort=47770 && ServerFilename=gg.cfg  && HomePath=/mnt/homepaths/8pgg   ;;
    iw4gtnw)   GamePort=47771 && ServerFilename=gtnw.cfg && HomePath=/mnt/homepaths/gtnw  ;;
    *) printf '%s\n' 'unknown hostname, where am i?' ; exit 1 ;;
esac

# Offline/Private LAN Party Mode
# 0 Disable (Send heartbeats to online serverlist)
# 1 Enable (Add to the Local serverlist. Unlisted from Public)
LANMode=0

# Enable logging
LogFile=2

# make sure this server's homepath exists
mkdir -p "$HomePath" ||
    { printf '%s\n' "failed to create homepath $HomePath, cannot continue" ; exit 1 ; }

# move to the directory that has MW2 files
cd /mnt ||
    { printf '%s\n' 'failed to move to /mnt, cannot continue' ; exit 1 ; }

# my script for updating/installing at: https://github.com/kkrruumm/iw4x-updoot
if [ -f iw4x-updoot.sh ]; then
    ./iw4x-updoot.sh ||
        { printf '%s\n' 'failed to run iw4x-updoot.sh or it returned 1, not continuing.' ; exit 1 ; }
else
    printf '%s\n' 'iw4x-updoot.sh not found, not continuing.'
    exit 1
fi

type wine > /dev/null ||
    { printf '%s\n' 'wine not found in PATH, is it installed?' ; exit 1 ; }

wine iw4x.exe -dedicated -stdout +set fs_homepath "$HomePath" +set fs_game "$ModFolderName" +set sv_lanonly "$LANMode" +set net_port "$GamePort" +exec "$ServerFilename" +set logfile "$LogFile" +set party_enable "0" +map_rotate
