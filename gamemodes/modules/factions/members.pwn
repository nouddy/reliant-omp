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

enum E_FACTION_MEMBER_DATA {

    e_FACTION_ID:factionID,
    factionRank,
    factionJoinDate[256]
}

new FactionMember[MAX_PLAYERS][E_FACTION_MEMBER_DATA];

//*==============================================================================
//*--->>> @hooks
//*==============================================================================

forward mysql_LoadFactionMember(playerid);
public mysql_LoadFactionMember(playerid) {

    new rows = cache_num_rows();

    if(!rows) return (true);

    cache_get_value_name_int(0, "Faction", FactionMember[playerid][factionID]);
    cache_get_value_name_int(0, "Rank", FactionMember[playerid][factionRank]);
    cache_get_value_name(0, "JoinDate", FactionMember[playerid][factionJoinDate], 256);

    new xID = FactionMember[playerid][factionID];
    new xRank = FactionMember[playerid][factionRank];

    SetPlayerSkin(playerid, FactionInfo[xID][factionSkins][xRank - 1]);
    SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Vi ste clan organizacije %s", ReturnFactionName(xID));

    return (true);

}

hook OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle) {

    printf("ErrorID : %d | Error : %s | Query : %s", errorid, error, query);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerLoaded(playerid) {

    new q[128];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `faction_members` WHERE `Player` = '%d'", UserInfo[playerid][ID]);
    mysql_tquery(SQL, q, "mysql_LoadFactionMember", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:myfaction(playerid, params[], help) 
{
    
    if(FactionMember[playerid][factionID] == INVALD_FACTION_ID)
        return SendClientMessage(playerid, x_server, "(reliant): "c_white"");

    return 1;
}