#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init() {
    level thread onPlayerConnect();
}

onPlayerConnect() {
    for(;;) {
        level waittill("connected", player);

        if (!isDefined(player.message_shown) )
            player.message_shown = 0;

        player notifyonplayercommand("toggle_fps", "+actionslot 1");

        player thread watchFPSToggle();
        player thread onPlayerSpawned();
    }
}

onPlayerSpawned()
{
    self endon("disconnect");

    for(;;) {
        self waittill("spawned_player");
        if(!self.message_shown) {
            self.message_shown = 1;
            self iPrintlnBold("Press ^0[{+actionslot 1}] ^7to toggle low graphics");
        }
	
        self _SetActionSlot(1, ""); // workaround for night vision
    }
}

watchFPSToggle()
{
    self endon("disconnect");
    self.fpsBoostActive = false;

    self notifyOnPlayerCommand("toggle_fps", "+actionslot 1");

    for(;;)
    {
        self waittill("toggle_fps");

        if(!self.fpsBoostActive) {
            self setClientDvar("r_specular", "0");
            self setClientDvar("r_drawSun", "0");
            self setClientDvar("r_forceLod", "4");
            self setClientDvar("r_fullbright", "1");
            
            self iPrintlnBold("FPS Boost: ^0ON");
            self.fpsBoostActive = true;
        } else {
            self setClientDvar("r_specular", "1");
            self setClientDvar("r_drawSun", "1");
            self setClientDvar("r_forceLod", "none");
            self setClientDvar("r_fullbright", "0");
            
            self iPrintlnBold("FPS Boost: ^0OFF");
            self.fpsBoostActive = false;
        }
        
        // prevent button spam a little bit
        wait 0.5;
    }
}
