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
//*--->>> @functions
//*==============================================================================

stock GetNearestFaction(playerid) {

    for(new i = 0; i < sizeof FactionInfo; i++) {

        if(IsPlayerInRangeOfPoint(playerid, 2.0, FactionInfo[i][factionEnter][0], FactionInfo[i][factionEnter][1], FactionInfo[i][factionEnter][2]))
            return i;
    }

    return INVALID_FACTION_ID;
}

stock ReturnFactionName(id) {

    new tmp_fmt[MAX_FACTION_NAME_LEN];
    format(tmp_fmt, sizeof tmp_fmt, "%s", FactionInfo[id][factionName]);
    return tmp_fmt;
}
