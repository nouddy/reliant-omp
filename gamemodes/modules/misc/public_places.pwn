/*

*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

*   @Author : Noddy
*   @Date : 7.12.2024

*/

#include <ylessinc\YSI_Coding\y_hooks>

//2306.38,-15.23,26.74 - employment centre interior
//

hook OnGameModeInit() {

    //*             >> [ LABELS 'n PICKUPS ] <<

    Create3DTextLabel(""c_lblue"(( MEDICAL DEPARTMENT ))\n"c_white"Za ulaz pritisni "c_lblue"'F'", -1, 1172.4216,-1323.4316,15.4032, 4.50, 0);
    Create3DTextLabel(""c_lblue"(( MEDICAL DEPARTMENT ))\n"c_white"Za ulaz pritisni "c_lblue"'F'", -1, 1172.4216,-1323.4316,15.4032, 4.50, 0);
    Create3DTextLabel(""c_lblue"(( CITY HALL ))\n"c_white"Za ulaz pritisni "c_lblue"'F'", -1, 1481.2469,-1771.3928,18.7958, 4.50, 0);
    Create3DTextLabel(""c_lblue"(( EMPLOYMENT CENTRE ))\n"c_white"Za ulaz pritisni "c_lblue"'F'", -1, 1308.5962,-1468.2781,10.0469, 4.50, 0);

    CreatePickup(19134, 1, 1172.4216,-1323.4316,15.4032);
    CreatePickup(19134, 1, 1481.2469,-1771.3928,18.7958);
    CreatePickup(19134, 1, 1308.5962,-1468.2781,10.0469);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_SECONDARY_ATTACK)) {

        //*         >> [ CITY HALL ] <<

        if(IsPlayerInRangeOfPoint(playerid, 3.00, 1481.2469,-1771.3928,18.7958) && GetPlayerInterior(playerid) == 0) {

            SetPlayerPos(playerid, 386.52,173.63,1008.38);
            SetPlayerInterior(playerid, 3);
            SetCameraBehindPlayer(playerid);
        }

        else if(IsPlayerInRangeOfPoint(playerid,  3.00, 386.52,173.63,1008.38) && GetPlayerInterior(playerid) == 3) {

            SetPlayerPos(playerid, 1481.2469,-1771.3928,18.7958);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }

        //*         >> [ HOSPITAL ] <<

        if(IsPlayerInRangeOfPoint(playerid, 3.00, 1172.4216,-1323.4316,15.4032) && GetPlayerInterior(playerid) == 0) {

            SetPlayerPos(playerid, 1402.6790,-26.2581,1000.8640);
            SetPlayerInterior(playerid, 1);
            SetCameraBehindPlayer(playerid);
        }

        else if(IsPlayerInRangeOfPoint(playerid,  3.00, 1402.6790,-26.2581,1000.8640) && GetPlayerInterior(playerid) == 1) {

            SetPlayerPos(playerid, 1172.4216,-1323.4316,15.4032);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}