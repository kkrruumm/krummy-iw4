/***************************************************
 *                    FPS Boost                    *
 ***************************************************
 * Some people haz sandpz, plz fix                 *
 *                                                 *
 * LAST EDIT: 17.06.2017                           *
 * CHANGES: Fixed messageloop                      *
 * BY: Dizzy                                       *
 ***************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;


init()
{
	level thread onPlayerConnect();
}

onPlayerConnect()
{
	for(;;)
	{
		level waittill( "connected", player );		
		
		if( !isDefined( player.message_shown) )
			player.message_shown = 0;
		
		if( !isDefined( player.cur_bright ) )
			player.cur_bright = 0;
		
		player thread watchButton();
		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");

	for(;;)
	{
		self waittill("spawned_player");
		
		if( !self.message_shown ) {
			self.message_shown = 1;
			self iPrintlnBold( "^0Press ^7[{+actionslot 1}] ^0to toggle ^7low graphics" );
		}
		
		// Workaround for nightvision, this is very importanto!
		self _SetActionSlot( 1, "" );
	}
}

watchButton()
{
	self endon("disconnect");
	
	self notifyOnPlayerCommand( "fpsboost", "+actionslot 1" );
	
	for(;;) {
		self waittill( "fpsboost" );
		
		self.cur_bright = !self.cur_bright;
		self setClientDvar( "r_fullbright", self.cur_bright );
		
		if( self.cur_bright )
			self iPrintlnBold( "^0High FPS ^7On" );
		else 
			self iPrintlnBold( "^0High FPS ^7Off" );
	}
	
}
