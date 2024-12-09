/*

*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

* About > Simple Gamemode for open.mp (GTA San Andreas Multiplayer)
* Author > Vostic & Nodi
* Down you have all versions used for this project.

* Merits
? open.mp > version v1.2.0.2670
? pBlueG for SA-MP-MySQL > version R41-4 (https://github.com/pBlueG/SA-MP-MySQL/releases/tag/R41-4)        
? Y-Less for YSI-Includes > version v5.10.0006 (https://github.com/pawn-lang/YSI-Includes/releases/tag/v5.10.0006)
? samp-incognito for Streamer > version v2.9.6 (https://github.com/samp-incognito/samp-streamer-plugin/releases)

*/

#define CGEN_MEMORY		(20000)


#include <open.mp>
#include <a_mysql>
#include <streamer>
#include <sscanf2>
#include <ylessinc\YSI_Coding\y_hooks>
#include <ylessinc\YSI_Coding\y_timers>
#include <ylessinc\YSI_Visual\y_commands>
#include <ylessinc\YSI_Data\y_foreach>
#include <ylessinc\YSI_Data\y_iterate>
#include <easyDialog>
#include <crashdetect>

//*		>> [ COLOURS ] <<

#define x_server		0x737be1FF
#define x_red           0xFF0000FF
#define x_orange        0xDAA520FF
#define x_white			0xffffffff
#define x_lblue			0x7DAEDFFF
#define x_green 		0x776444FF

#define c_server		"{737be1}"
#define c_red			"{ff0000}"
#define c_orange		"{daa520}"
#define c_white         "{ffffff}"
#define c_lblue			"{7DAEDF}"
#define c_green 		"{776444}"

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

stock bool:Weapon_IsValid(weaponid)
{
	return (weaponid >= 1 && weaponid <= 18 || weaponid >= 21 && weaponid <= 46);
}

main()
{
    print("-                                     -");
	print(" Version : v0.1 - Reliant");
	print(" Developer : Vostic & Nodi");
	print(" Credits : open.mp community, pBlueG, Y-Less, incognito..");
	print("-                                     -");
	print("> Gamemode Starting...");
	print(">> Reliant Gamemode Started");
    print("-                                     -");
}

public OnGameModeInit()
{
	//!Streamer za ucitavanje mapa

	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 550);
	Streamer_ToggleChunkStream(true);
	Streamer_SetChunkSize(STREAMER_TYPE_OBJECT, 250);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 975);
	Streamer_SetTickRate(25);

	DisableInteriorEnterExits();
	ManualVehicleEngineAndLights();
	
	LimitGlobalChatRadius(20.0);
	AllowInteriorWeapons(true);
	EnableVehicleFriendlyFire();
	EnableStuntBonusForAll(false);	

	SetGameModeText("(R) - Drustvo se skupilo");

	return 1;
}
public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{

	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnScriptCash(playerid, amount, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}


//*			>> [ Custom Includes ] << 

#include "utils/chat.pwn"

#include "modules/db_config.pwn"
#include "modules/db_functions.pwn"

//*			>> [ ACCOUNT ] <<

#include "modules/main/account.pwn"
#include "modules/main/introduction.pwn"

//*			>> [ STAFF ] <<

#include "modules/staff/functions.pwn"
#include "modules/staff/staff.pwn"

#include "modules/anti-cheat/_core.pwn"

//*			>> [ VEHICLE ] <<

#include "modules/vehicle/functions.pwn"
#include "modules/vehicle/lockpick.pwn"
#include "modules/vehicle/main.pwn"

//*			>> [ MISC ] <<

#include "modules/misc/public_places.pwn"

//*			>> [ INVENTORY ] <<

#include "modules/inventory/main.pwn"
#include "modules/inventory/functions.pwn"

//*			>> [ REAL ESTATE ] <<

// #include "modules/real_estate/functions.pwn" -> Ne koristi se trenutno.
#include "modules/real_estate/main.pwn"
#include "modules/real_estate/player_data.pwn"

// * 		>> [ FACTIONS ] <<

#include "modules/factions/_core.pwn"

//*			>> [ MAPS - INTERIORS ] <<

#include "maps/hospital-interior.pwn"

//*			>> [ MAPS - EXTERIORS ] <<

#include "maps/bank-exterior.pwn"
#include "maps/chernobyl.pwn"

YCMD:cls(playerid, params[], help) 
{
	for(new j = 0; j < 120; j++)
		SendClientMessage(playerid, -1, "");
	return 1;
}