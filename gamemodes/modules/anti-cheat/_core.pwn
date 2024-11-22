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
    SendClientCheck(playerid, 5, 0, 0, 2);
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


    return Y_HOOKS_CONTINUE_RETURN_1;
}

 
static const __NORMAL_ADDRESS[] =
{
    0x00749B93,0x1C5040F0,0x00000000,0x1C2F50E0,
    0x14CA8648,0x0177F800,0x00000000,0x0053408E,
    0x1C2F50E0,0x00734B90,0x00000000,0x00000016,
    0x14CA8648,0x04A9F01D,0x00000016,0x0515F9D0,
    0x14CA8648,0x14CA8648,0x0177F81C,0x04AAFFB7,
    0x00000016,0x000000BF,0x15F4F4C8,0x00000016,
    0x14CA8648,0x0177FA4C,0x04A1929C,0x00000016,
    0x05128190,0x00000001,0x0177F964,0x00000016,
    0x000000BF,0x00000048,0x00000048,0x00000040,
    0x0177F964,0x0080E700,0x0F9FDE80,0x00000004,
    0x00000986,0x00000000,0x00000052,0x0000BAF6,
    0x00000050,0x00000000,0x017A0970,0x00000002,
    0x00000000,0x00000050,0x00000052,0x00C4D958,
    0x00000010,0x0A29B5EC,0x00000004,0x00000000,
    0x00805769,0x017A20F4,0x00C9BC50,0x00000052,
    0x0178657C,0x007EF657,0x017A0970,0x0178657C,
    0x00000000,0x00000052,0x3F78196A,0x006C6293,
    0x006C62AD,0x00000052,0x00000052,0x006C62B5,
    0x15618FC4,0x00A95094,0x0000021C,0x00C4E4F8,
    0xC1F7AF37,0x3FF1A19A,0x00000000,0x3F25F734,
    0x412A20CD,0x00000000,0x00000000,0x3DCCCCCD,
    0x3F77A3AF,0xBD719680,0xBE7C6F8F,0x3F7FBE2A,
    0x3E7BF804,0xBC740004,0x3F781984,0xC1A9166B,
    0x3DB65369,0xBF64AA43,0x0177F97C,0x0177FA4C,
    0x0177FA94,0x0177FA94,0x04A1FB11,0x05128190,
    0x0177FA4C,0x00000001,0x0177FAA8,0x04AE0E7B,
    0x00000000,0x04A3AEE0,0x0177FA90,0x000000BF,
    0x00000016,0x04A3AE99,0x05164F42,0x05164F40,
    0x00000000,0x00000060,0x00000060,0x0000005C,
    0x05167F50,0x69953400,0x05DE6000,0x0177F9A4,
    0x0F9F1080,0x6995344D,0x3E7BF7C6,0x0F9FB430,
    0x00000000,0x00000000,0x00000000,0x00000780,
    0x00000438,0x0FBDB750,0x00000000,0x00000000
};
 
hook OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
    switch(actionid)
    {
        case 5:
        {
            if(memaddr < 0x400000 || memaddr > 0x856E00)
            {
                // lose adrese - kikuj
                synced_SendClientMessage(playerid, 0xFFFFFFFF, "Cit detektovan hook.");
                Kick(playerid);
            }
            addressCheck(playerid, retndata);
        }
    }
    return 1;
}
 
synced_SendClientMessage(playerid, colorcode, const msg[])
{
    return SendClientMessage(playerid, colorcode, msg);
}
 
static addressCheck(playerid, response)
{
    new moded_client;
    for(new i; i < sizeof __NORMAL_ADDRESS; i++)
    {
        if(response + __NORMAL_ADDRESS[i] > 0x856E00)
        {
            moded_client++;
        }
    }
    if(moded_client > 10)
    {
        synced_SendClientMessage(playerid, 0xFFFFFFFF, "Cit detektovan - Modded Client.");
        // Kick(playerid);
        return 1;
    }
    return 0;
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