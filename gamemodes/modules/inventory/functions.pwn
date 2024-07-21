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


stock Inventory_ReturnItemName(id) {

    new string[65];

    switch(id) {

        case 22..34: { 
            
            new wpn[32];
            GetWeaponName(WEAPON:id, wpn, sizeof wpn);
            format(string, sizeof string, "%s", wpn);
            return string;
        }
        
        case INVENTORY_ITEM_BREAD: { string = "Kruh"; }
        case INVENTORY_ITEM_JUICE: { string = "Sok"; }
        case INVENTORY_ITEM_MEDKIT: { string = "Prva pomoc"; }

        default: { string = "[Undefined]:"; }
    }

    return string;
}