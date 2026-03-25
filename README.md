# krummy iw4x server configs
this repo contains the configs / serverside scripts for my "krummy servers" for iw4x

# info
for anyone coming across this-

in general, i run iw4x servers against *alpine linux* using the wine provided in their repositories

the `etc/init.d/iw4x` script is an openrc service script for alpine containers to automatically start the servers as the correct user

the container solution i am using for each server is incus, and there is a single stripped copy of mw2/iw4x on the host server that is passed into all of these containers

on the note of bot warfare, the `z_svr_bots.iwd` and `scriptdata` file/directory need to be placed in `userraw` directly to prevent the server from being tagged as modded

# fpsboost.gsc

while some may consider an fps boost script some form of cheating / visual advantage, fullbright nets my thinkpad t480 +~70fps, and is the only reason the game is playable on that system

all of these servers end the game on nuke, so it's not exactly an "anti-nuke toggle" here.