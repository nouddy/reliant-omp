/*
 
*                                _   _            _                _   
*                      __ _ _ __ | |_(_)       ___| |__   ___  __ _| |_ 
*                     / _` | '_ \| __| |_____ / __| '_ \ / _ \/ _` | __|
*                    | (_| | | | | |_| |_____| (__| | | |  __/ (_| | |_ 
*                     \__,_|_| |_|\__|_|      \___|_| |_|\___|\__,_|\__|
*                                                                       
*                  _________________________________________________________
*               
*                   @Author : Noddy
*                   Date : 7/11/2024
*                   
*                   TODO LIST:
*                   
*                   Do everything.

*/

#include <ylessinc\YSI_Coding\y_hooks>

//*==============================================================================
//*--->>> Begining
//*==============================================================================

#define ac_func%0(%1) \
        forward%0(%1); \
        public%0(%1) 

#define MAX_PLAYER_WEAPONS          (13)

enum e_ANTI_CHEAT_CODE {

    CHEAT_TYPE_JETPACK = 0,
    CHEAT_TYPE_SPECIAL_ACTION,
    CHEAT_TYPE_SPEED_HACK, // * 46
    CHEAT_TYPE_TELEPORT,
    CHEAT_TYPE_WEAPON_HACK
}

enum E_ANTI_CHEAT_DATA {

    WEAPON:acWeapon[MAX_PLAYER_WEAPONS],
    acAmmo[MAX_PLAYER_WEAPONS],

    acInt,
    acVW,

    Float:acPos[3],
    SPECIAL_ACTION:acSpecialAction
}

new AC_Info[MAX_PLAYERS][E_ANTI_CHEAT_DATA];

new const ac_CodeNames[][] = {

    "Jetpack Hack",
    "Special Action Hack",
    "Speed Hack",
    "Teleport Hack",
    "Weapon Hack"
};

ac_func ac_GivePlayerMoney(playerid, money) {

    UserInfo[playerid][Money] += money;
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, UserInfo[playerid][Money]);

    return (true);
}


//*==============================================================================
//*--->>> Functions
//*==============================================================================

forward OnCheatDetected(playerid, e_ANTI_CHEAT_CODE:code);
public OnCheatDetected(playerid, e_ANTI_CHEAT_CODE:code) {
    //* -->> DEBUG:

    SendClientMessageToAll(0xFF0055FF, "R E L I A N T | AC "c_white"%s mozda koristi {FF0056}#%d %s", code, ac_CodeNames[ code ]);
    return (true);
}


//*==============================================================================
//*--->>> Hooks
//*==============================================================================

hook OnPlayerConnect(playerid) {

    // * Unfinished, RAAAHHHHH

    for(new i = 0; i < MAX_PLAYER_WEAPONS; i++) {

        AC_Info[playerid][acWeapon][i] = UNKNOWN_WEAPON;
        AC_Info[playerid][acAmmo][i] = 0;
    }

    AC_Info[playerid][acInt] = 0;
    AC_Info[playerid][acVW] = 0;

    AC_Info[playerid][acPos][0] = 0.00;
    AC_Info[playerid][acPos][1] = 0.00;
    AC_Info[playerid][acPos][2] = 0.00;
    
    AC_Info[playerid][acSpecialAction] = SPECIAL_ACTION_NONE;

    SendClientCheck(playerid, 69, 0x00B7CE50, 0, 4);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*==============================================================================
//*--->>> Include
//*==============================================================================

#include "modules/anti-cheat/weapon-hack.pwn"

#if defined _ALS_GivePlayerMoney
    #undef GivePlayerMoney
#else
    #define _ALS_GivePlayerMoney
#endif
#define GivePlayerMoney ac_GivePlayerMoney