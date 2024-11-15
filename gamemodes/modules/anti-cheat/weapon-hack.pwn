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
*                   Date : 8/11/2024
*                   
*                   TODO LIST:
*                   
*                   Do everything.

*/

#include <ylessinc\YSI_Coding\y_hooks>

//*==============================================================================
//*--->>> Begining
//*==============================================================================

//*==============================================================================
//*--->>> Functions
//*==============================================================================

ac_func ac_GivePlayerWeapon(playerid, WEAPON:weaponid, ammo) {

    for(new i = 0; i < MAX_PLAYER_WEAPONS; i++) {

		if(AC_Info[playerid][acWeapon][i] == UNKNOWN_WEAPON) {

			AC_Info[playerid][acWeapon][i] = weaponid;
			AC_Info[playerid][acAmmo][i] = ammo;
			GivePlayerWeapon(playerid, weaponid, ammo);
			SetPlayerArmedWeapon(playerid, weaponid);

			break;
		}
	}

    return (true);
}

ac_func ac_SetPlayerAmmo(playerid, WEAPON:weaponid, ammo) {

    if(AC_Info[playerid][acWeapon][weaponid] == GetPlayerWeapon(playerid)) {

		AC_Info[playerid][acAmmo][weaponid] += ammo;
		SetPlayerAmmo(playerid, AC_Info[playerid][acWeapon][weaponid], AC_Info[playerid][acAmmo][weaponid]);
		SetPlayerArmedWeapon(playerid, weaponid);

	}

    return (true);
}

ac_func ac_GetPlayerAmmo(playerid) {

    for(new i = 0; i < MAX_PLAYER_WEAPONS; i++) {

		if(AC_Info[playerid][acWeapon][i] == GetPlayerWeapon(playerid)) {
			return AC_Info[playerid][acAmmo][i];
		}
	}

	return true;
}

ac_func ac_GetPlayerWeapon(playerid) {

    for(new i = 0; i < MAX_PLAYER_WEAPONS; i++) {

		if(AC_Info[playerid][acWeapon][i] == GetPlayerWeapon(playerid))
            return AC_Info[playerid][acAmmo][i];
	}

    return (true);
}

//*==============================================================================
//*--->>> Hooks
//*==============================================================================

hook OnPlayerUpdate(playerid) {

    new WEAPON:xWeapon = GetPlayerWeapon(playerid);
    if (xWeapon > WEAPON_FIST)
    {
        new bool:weaponFound = false;

        for (new i = 0; i < MAX_PLAYER_WEAPONS; i++)
        {
            if (AC_Info[playerid][acWeapon][i] == xWeapon)
            {
                weaponFound = true;
                break;
            }
        }

        if (!weaponFound)
        {
            OnCheatDetected(playerid, CHEAT_TYPE_WEAPON_HACK);
            ResetPlayerWeapons(playerid);
			return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

//*==============================================================================
//*--->>> @__ALS
//*==============================================================================

#if defined _ALS_GetPlayerAmmo
    #undef GetPlayerAmmo
#else
    #define _ALS_GetPlayerAmmo
#endif
#define GetPlayerAmmo ac_GetPlayerAmmo

#if defined _ALS_GivePlayerWeapon
    #undef GivePlayerWeapon
#else
    #define _ALS_GetPlayerAmmo
#endif
#define GivePlayerWeapon ac_GivePlayerWeapon


#if defined _ALS_SetPlayerAmmo
    #undef SetPlayerAmmo
#else
    #define _ALS_SetPlayerAmmo
#endif
#define SetPlayerAmmo ac_SetPlayerAmmo