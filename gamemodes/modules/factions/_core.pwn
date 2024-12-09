/*
*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

*   @Author : Noddy
*   @Date : 7.5.2024

*/

#include <ylessinc\YSI_Coding\y_hooks>

//*==============================================================================
//*--->>> @vars & misc
//*==============================================================================

//*     --> IDS <--

#define MAX_FACTION_MEMBERS         (20)
#define MAX_FACTIONS                (2)
#define MAX_FACTION_NAME_LEN        (64)

enum e_FACTION_ID {

    INVALID_FACTION_ID = -1,
    FACTION_POLICE = 0,
    FACTION_EC = 1
}

enum e_FACTION_TYPE {

    FACTION_TYPE_POLICE = 1,
    FACTION_TYPE_GANG = 2
}

enum E_FACTION_DATA {

    factionID,
    e_FACTION_TYPE:factionType,
    factionName[MAX_FACTION_NAME_LEN],

    Float:factionEnter[3],
    Float:factionExit[3],
    factionInt,

    factionSkins[3]
}

new FactionInfo[MAX_FACTIONS][E_FACTION_DATA] = {

    { FACTION_POLICE, FACTION_TYPE_POLICE, "Police Department", { 0.00, 0.00, 0.00 }, { 288.47,170.06,1007.17 }, 10, {284, 282, 281} },
    { FACTION_EC, FACTION_TYPE_GANG, "Escobar Cartel", {0.00, 0.00, 0.00}, { 322.11,1119.32,1083.88 }, 5, { 46, 47, 48 } }
    
};

new Text3D:factionLabel[MAX_FACTIONS],
    factionPickup[MAX_FACTIONS];

#include "modules/factions/members.pwn"

//*==============================================================================
//*--->>> @hooks
//*==============================================================================

hook OnGameModeInit() {

    for(new i = 0; i < sizeof FactionInfo; i++) {

        factionPickup[i] = CreatePickup(19133, 1, FactionInfo[i][factionEnter][0], FactionInfo[i][factionEnter][1], FactionInfo[i][factionEnter][2]);
        factionLabel[i] = Create3DTextLabel(""c_server"FACTION - "c_white"%s", 1, FactionInfo[i][factionEnter][0], FactionInfo[i][factionEnter][1], FactionInfo[i][factionEnter][2], 3.50, 0, false, FactionInfo[i][factionName]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_SECONDARY_ATTACK)) {

        new f = GetNearestFaction(playerid);

        if(e_FACTION_ID:f != INVALID_FACTION_ID) {

            if(IsPlayerInRangeOfPoint(playerid, 2.0, FactionInfo[f][factionEnter][0], FactionInfo[f][factionEnter][1], FactionInfo[f][factionEnter][2])) {

                SetPlayerPos(playerid, FactionInfo[f][factionExit][0], FactionInfo[f][factionExit][1], FactionInfo[f][factionExit][2]);
                SetPlayerInterior(playerid, FactionInfo[f][factionInt]);
            }
        }

        for(new i = 0; i < sizeof FactionInfo; i++) {

            if(IsPlayerInRangeOfPoint(playerid, 2.0, FactionInfo[i][factionExit][0], FactionInfo[i][factionExit][1], FactionInfo[i][factionExit][2])) {

                SetPlayerPos(playerid, FactionInfo[i][factionEnter][0], FactionInfo[i][factionEnter][1], FactionInfo[i][factionEnter][2]);
                SetPlayerInterior(playerid, 0);
                break;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}


//*==============================================================================
//*--->>> @staffcmds
//*==============================================================================

//*================================== [ DEBUG ] =================================
//*--->>> @hilfe bitte
//*==============================================================================


YCMD:ubacime(playerid, params[], help) 
{
    
    new e_FACTION_ID:faid;
    if(sscanf(params, "d", faid)) return (true);

    FactionMember[playerid][factionID] = faid;
    FactionMember[playerid][factionRank] = 1;

    new q[284];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `faction_members` (`Player`, `Faction`, `Rank`, `JoinDate`) VALUES ( '%d', '%d', '%d', NOW() )", UserInfo[playerid][ID], FactionMember[playerid][factionID], FactionMember[playerid][factionRank]);
    mysql_tquery(SQL, q);

    return 1;
}

#include "modules/factions/functions.pwn"