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

timer timer_KickPlayer[1000](playerid) 
{
    Kick(playerid);

    return (true);
}

stock Delayed_Kick(playerid, const reason[], target) {

    SendClientMessageToAll(x_server, "STAFF | "c_white" %s je kickovao igraca %s, razlog : "c_server"%s", ReturnPlayerName(playerid), ReturnPlayerName(target), reason);
    SendClientMessage(target, x_server, "STAFF | "c_white"%s vas je kickovao sa servera, razlog : "c_server"%s", ReturnPlayerName(playerid) ,reason);

    defer timer_KickPlayer(target);

    return (true);
}

stock Staff_SendMessage(admin, const message[]) {

    foreach(new i : Player) {

        if(UserInfo[i][Staff] >= 1) {

            SendClientMessage(i, -1, ""c_server"S T A F F | "c_white"%s %s : %s", Staff_ReturnRank(admin), ReturnPlayerName(admin), message);
        }
    }

    return (true);
}

stock Staff_ReturnRank(playerid) {

    new string[32];

    switch(UserInfo[playerid][Staff]) {

        case 1: { string = "Supporter"; }
        case 2: { string = "Trial Admin"; }
        case 3: { string = "Admin"; }
        case 4: { string = "Head Admin"; }
        default: { string = "[Undefined]:"; }
    }

    return string;
}