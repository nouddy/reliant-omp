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

enum e_PLAYER_PROPERTY {

    PlayerID,
    BusinessID,
    HouseID,
    ApartmentID
}

new PlayerProperty[MAX_PLAYERS][e_PLAYER_PROPERTY];

forward mysql_LoadPlayerProperty(playerid);
public mysql_LoadPlayerProperty(playerid) {

    new rows = cache_num_rows();

    if(!rows) {

        PlayerProperty[playerid][PlayerID] = GetPlayerSQLID(playerid);
        PlayerProperty[playerid][BusinessID] = -1;
        PlayerProperty[playerid][HouseID] = -1;
        PlayerProperty[playerid][ApartmentID] = -1;
    
        new q[248];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `player_property` (`PlayerID`, `BusinessID`, `HouseID`, `ApartmentID`) \
                                        VALUES ('%d', '%d', '%d', '%d')", 
                                        GetPlayerSQLID(playerid), PlayerProperty[playerid][BusinessID],
                                        PlayerProperty[playerid][HouseID], PlayerProperty[playerid][ApartmentID]);
        mysql_tquery(SQL, q);
    }

    else {

        cache_get_value_name_int(0, "PlayerID", PlayerProperty[playerid][PlayerID]);
        cache_get_value_name_int(0, "BusinessID", PlayerProperty[playerid][BusinessID]);
        cache_get_value_name_int(0, "HouseID", PlayerProperty[playerid][HouseID]);
        cache_get_value_name_int(0, "ApartmentID", PlayerProperty[playerid][ApartmentID]);
    
    }

    return (true);
}

hook OnPlayerLoaded(playerid) {

    new q[128];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `player_property` WHERE `PlayerID` = '%d'", GetPlayerSQLID(playerid));
    mysql_tquery(SQL, q, "mysql_LoadPlayerProperty", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}
