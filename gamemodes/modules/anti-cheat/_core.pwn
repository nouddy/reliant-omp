/*

*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

*   @Author : Noddy
*   @Date : 7.13.2024

*/

#include <ylessinc\YSI_Coding\y_hooks>

//* AntiCheat types, da li igrac ima godmode, teleport hack itd...

enum {

    CHEAT_TYPE_MONEY = 1,
    CHEAT_TYPE_HEALTH,
    CHEAT_TYPE_ARMOUR,
    CHEAT_TYPE_SKIN_CHANGER,
    CHEAT_TYPE_MAP_TELEPORT
}

new Float:clickedPos[MAX_PLAYERS][3];

forward AntiCheat_OnPlayerClickMap(playerid, Float:positionX, Float:positionY, Float:positionZ);

timer ac_Kick[1500](playerid) 
{
    Kick(playerid);

    return (true);
}


hook OnPlayerConnect(playerid) {

    // Slanje provjere igracu za memorisjku adresu -> Ne znam da li ce biti funkcionalno jer sam samo preko cheat engina nasao adresu za novac.
    // Vidjet cemo dalje kako sta

    clickedPos[playerid][0] = clickedPos[playerid][1] = clickedPos[playerid][2] = 0.00; // Resetovanje na 0.00 za svaki slucaj.

    SendClientCheck(playerid, CHEAT_TYPE_MONEY, 0x00B7CE50, 0, 4);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ) {

    // Cuvanje kliknutih koordinata u igracevu promljenjivu

    clickedPos[playerid][0] = fX;
    clickedPos[playerid][1] = fY;
    clickedPos[playerid][2] = fZ;

    // Pozivanje lokalne funkcija / "custom" callbacka da se ne bi pravio timer bez razloga.

    CallLocalFunction("AntiCheat_OnPlayerClickMap", "dfff", playerid, clickedPos[playerid][0], clickedPos[playerid][1], clickedPos[playerid][2]);

    return (true);
}

hook OnClientCheckResponse(playerid, actionid, memaddr, retndata) {
    
    if(actionid == CHEAT_TYPE_MONEY) {

        if(retndata > 100 || retndata < 0) {

            SendClientMessage(playerid, 0xff006fff, "(anticheat): "c_white"Money hack detected!");
            SendClientMessageToAll(0xff006fff, "(anticheat): "c_white"Igrac %s je kickovan zbog moguceg : {ff006f}%d | MONEY HACK", ReturnPlayerName(playerid), CHEAT_TYPE_MONEY);

            defer ac_Kick(playerid);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

public AntiCheat_OnPlayerClickMap(playerid, Float:positionX, Float:positionY, Float:positionZ) {

    if(IsPlayerAdmin(playerid)) return true;

    // Ukoliko su trenutacne koordinate igraca jednake kliknutim koordinatama na mapi, moguc cheat, kick!!!

    new Float:pPos[3];
    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    if(clickedPos[playerid][0] == pPos[0] && clickedPos[playerid][1] == pPos[1] && clickedPos[playerid][2] == pPos[2] ) {

        SendClientMessage(playerid, 0xff006fff, "(anticheat): "c_white"Teleport hack detected!");
        SendClientMessageToAll(0xff006fff, "(anticheat): "c_white"Igrac %s je kickovan zbog moguceg : {ff006f}%d | TELEPORT HACK", ReturnPlayerName(playerid), CHEAT_TYPE_MAP_TELEPORT);

        defer ac_Kick(playerid);
    }

    return (true);
}