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

//*     >> [ ITEM TYPES ] <<

#define MAX_INVENTORY_ITEMS     (35) //* Igrac ce moci posjedovati najvise 35 stvari u inventory-u

#define MAX_AMMO_QUANTITY       (90) //* Igrac ce moci shraniti 90 metaka u inventory za svaku pusku.

enum {

    INVENTORY_INVALID_ITEM_TYPE = -1,

    INVENTORY_ITEM_TYPE_DRUG = 1,
    INVENTORY_ITEM_TYPE_WEAPON,
    INVENTORY_ITEM_TYPE_FOOD,
    INVENTORY_ITEM_TYPE_TOOL,
    INVENTORY_ITEM_TYPE_MEDIC
}

//*     >> [ INVENTORY ITEMS ] <<
//* ID-evi krecu od 50 (zbog oruzja);

enum {

    INVALID_INVENTORY_ITEM = -1,

    INVENTORY_ITEM_BREAD = 50,
    INVENTORY_ITEM_JUICE,
    INVENTORY_ITEM_MEDKIT,
}

enum e_QUANTITY_DATA {

    itemID,
    maxQuantity
}

enum e_ITEM_TYPE_DATA {

    itemID,
    itemType
}

enum e_INVENTORY_INFO {

    PlayerID,
    ItemID,
    ItemQuantity,
    ItemType,
}

new InventoryInfo[MAX_PLAYERS][MAX_INVENTORY_ITEMS][e_INVENTORY_INFO];
new Iterator:iter_Items[MAX_PLAYERS]< MAX_INVENTORY_ITEMS >;

static inventory_ChosenItem[MAX_PLAYERS];

//* Odredjivanje maksimalne kolicine jednog itema u rancu, npr. 5 sokica mozete shraniti u inventar.

new const sz_quantityInfo[][e_QUANTITY_DATA] = {

    { INVENTORY_ITEM_BREAD,     10 },
    { INVENTORY_ITEM_JUICE,     5 },
    { INVENTORY_ITEM_MEDKIT,    1 }
};

new const sz_itemType[][e_ITEM_TYPE_DATA] = {

    { INVENTORY_ITEM_BREAD,     INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_JUICE,     INVENTORY_ITEM_TYPE_FOOD },
    { INVENTORY_ITEM_MEDKIT,    INVENTORY_ITEM_TYPE_MEDIC }

};

forward mysql_CheckPlayerInventory(playerid);
public mysql_CheckPlayerInventory(playerid) {

    new rows = cache_num_rows();

    if(!rows) return true;

    else {

        for(new i = 0; i < rows; i++) {

            cache_get_value_name_int(i, "PlayerID", InventoryInfo[playerid][i][PlayerID]);
            cache_get_value_name_int(i, "ItemID", InventoryInfo[playerid][i][ItemID]);
            cache_get_value_name_int(i, "ItemQuantity", InventoryInfo[playerid][i][ItemQuantity]);
            cache_get_value_name_int(i, "ItemType", InventoryInfo[playerid][i][ItemType]);

            Iter_Add(iter_Items[playerid], i);
        }
    }

    return (true);
}

forward mysql_AddInventoryItem(playerid, item, quantity);
public mysql_AddInventoryItem(playerid, item, quantity) {

    new rows = cache_num_rows();
    if(!rows) {

        new q[240];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `inventory` (`PlayerID`, `ItemID`, `ItemQuantity`, `ItemType`) \
                                        VALUES (%d, %d, %d, %d)",
                                        UserInfo[playerid][ID], item,
                                        quantity, sz_itemType[item-50][itemType]);
        mysql_tquery(SQL, q);

        new nextID = Iter_Free(iter_Items[playerid]);
        
        InventoryInfo[playerid][nextID][PlayerID] = UserInfo[playerid][ID];
        InventoryInfo[playerid][nextID][ItemID] = item;
        InventoryInfo[playerid][nextID][ItemQuantity] = quantity;
        InventoryInfo[playerid][nextID][ItemType] = sz_itemType[item-50][itemType];

        Iter_Add(iter_Items[playerid], nextID);

        printf("PlayerID - %d, ItemID - %d, ItemQuantity - %d, ItemType - %s", playerid, item, quantity, Inventory_ReturnItemName(item) );
        printf("Array ID - %d", nextID);

        SendClientMessage(playerid, 0xdaa520ff, "> Postavljen vam je item : %s, kolicina %d", Inventory_ReturnItemName(item), quantity);
    }

    else {

        new xQuantity, xItem;
        cache_get_value_name_int(0, "ItemQuantity", xQuantity);
        cache_get_value_name_int(0, "ItemID", xItem);

        foreach(new idx : iter_Items[playerid]) {

            if(InventoryInfo[playerid][idx][ItemID] == item) {

                if( ( xQuantity + quantity ) > sz_quantityInfo[ItemID][maxQuantity] ) 
                    InventoryInfo[playerid][idx][ItemQuantity] = sz_quantityInfo[xItem-50][maxQuantity];
                else
                    InventoryInfo[playerid][idx][ItemQuantity] += quantity;
            
                SendClientMessage(playerid, 0xdaa520ff, "> Postavljen vam je item : %s, kolicina %d", Inventory_ReturnItemName(item), quantity);

            }
        }
    }
    return (true);
}

forward mysql_LoadPlayerInventory(playerid);
public mysql_LoadPlayerInventory(playerid) {

    new rows = cache_num_rows();

    if(!rows) return (true);

    else {

        new _dialogStr[1945];
        new stringicc[256];

        for(new i = 0; i < rows; i++) {
    
            new xItem, xQuantity;

            cache_get_value_name_int(i, "ItemID", xItem);
            cache_get_value_name_int(i, "ItemQuantity", xQuantity);

            format(stringicc, sizeof stringicc, "%s -> Kolicina : %d\n", Inventory_ReturnItemName(xItem), xQuantity);
            strcat(_dialogStr, stringicc);
        }

        Dialog_Show(playerid, "inventoryDialog", DIALOG_STYLE_LIST, "{ff006f}Inventory:", _dialogStr, "Ok", "");
    }

    return (true);
}

hook OnPlayerLoaded(playerid) {

    new q[124];
    mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d LIMIT 35", UserInfo[playerid][ID]);
    mysql_tquery(MySQL:SQL, q, "mysql_CheckPlayerInventory", "d", playerid);

    inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

    return (true);
}

//* test command

YCMD:giveitem(playerid, params[], help) 
{
    
    if(help) {

        SendClientMessage(playerid, 0xdaa520ff, "> 50. Bread  |  51. Juice  | 52. Medkit");
    }
    new item, quantity;
    if(sscanf(params, "dd", item, quantity)) return SendClientMessage(playerid, 0xdaa520ff, "> /giveitem [ItemID] [Kolicina].");

    new q[120];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d", UserInfo[playerid][ID], item);
    mysql_tquery(MySQL:SQL, q, "mysql_AddInventoryItem", "ddd", playerid, item, quantity);

    return (true);
}

YCMD:inv(playerid, params[], help) {

    new q[246];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", UserInfo[playerid][ID]);
    mysql_tquery(SQL, q, "mysql_LoadPlayerInventory", "d", playerid);

    return (true);
}

Dialog:inventoryDialog(const playerid, response, listitem, string: inputtext[]) {
    
    if (!response) {
        
        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

        return true;
    }

    inventory_ChosenItem[playerid] = Iter_Index(iter_Items[playerid], listitem);

    Dialog_Show(playerid, "inventoryItemOption", DIALOG_STYLE_LIST, "{ff006f}INVENTORY", "Iskoristi\nBaci\nDaj Igracu", "Odaberi", "Odustani");

    return true;
}

Dialog:inventoryItemOption(const playerid, response, listitem, string: inputtext[]) {
    if (!response) {

        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

        return true;
    }

    switch(listitem) {

        case 0: {

            new tmp_id = inventory_ChosenItem[playerid];

            if(InventoryInfo[playerid][tmp_id][ItemType] == INVENTORY_ITEM_TYPE_FOOD) {

                if(InventoryInfo[playerid][tmp_id][ItemQuantity] == 1) {

                    new Float:Health;
                    GetPlayerHealth(playerid, Health);
                    
                    if(Health == 100.00) 
                        return SendClientMessage(playerid, 0xff006fFF, "(inventory): "c_white"Ne mozete iskoristiti ovaj item, health vam je pun.");

                    else if( ( Health + 25.00 )  > 100.00)
                        SetPlayerHealth(playerid, 100.00);
                    
                    else {

                        SetPlayerHealth(playerid, ( Health + 25.00 ) );
                        SendClientMessage(playerid, 0xff006fFF, "(inventory): "c_white"%s vam je regenerirao helth za 25.00 vise.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]));
                    }

                    InventoryInfo[playerid][tmp_id][ItemQuantity]--;

                    new q[128];
                    mysql_format(SQL, q, sizeof q, "DELETE FROM `inventory` WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                                    InventoryInfo[playerid][tmp_id][ItemID], UserInfo[playerid][ID]);
                    mysql_tquery(SQL, q);

                    Iter_Remove(iter_Items[playerid], tmp_id);

                    InventoryInfo[playerid][tmp_id][ItemID] = INVALID_INVENTORY_ITEM; 
                    InventoryInfo[playerid][tmp_id][ItemQuantity] = 0;
                    InventoryInfo[playerid][tmp_id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

                    new qw[246];
                    mysql_format(SQL, qw, sizeof qw, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", UserInfo[playerid][ID]);
                    mysql_tquery(SQL, qw, "mysql_LoadPlayerInventory", "d", playerid);

                    inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

                    return (true);
                }

                new Float:xHealth;
                GetPlayerHealth(playerid, xHealth);
                
                if( ( xHealth + 25.00 ) > 100.00)
                    SetPlayerHealth(playerid, 100.00);
                
                else {

                    SetPlayerHealth(playerid, ( xHealth + 25.00 ) );
                    SendClientMessage(playerid, 0xff006fFF, "(inventory): "c_white"%s vam je regenerirao helth za 25.00 vise.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]));
                }

                InventoryInfo[playerid][tmp_id][ItemQuantity]--;

                new q[128];
                mysql_format(SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                                InventoryInfo[playerid][tmp_id][ItemQuantity], InventoryInfo[playerid][tmp_id][ItemID], UserInfo[playerid][ID]);
                mysql_tquery(SQL, q);
            }

            else if(InventoryInfo[playerid][tmp_id][ItemType] == INVENTORY_ITEM_TYPE_WEAPON) 
                Dialog_Show(playerid, "inventoryTakeGun", DIALOG_STYLE_INPUT, "{ff006f}TakeGun", "Unesite zeljenu kolicinu metaka za %s\n Trenutna kolicina : {ff006f}%d/%d", "Unesi", "Odustani", 
                                      Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]),
                                      InventoryInfo[playerid][tmp_id][ItemQuantity], MAX_AMMO_QUANTITY
                );
        }

        case 1: {

            new tmp_id = inventory_ChosenItem[playerid];

            new q[246];

            SendClientMessage(playerid, 0xff006fFF, "(inventory): "c_white"Uspjesno si bacio %s.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]));

            mysql_format(MySQL:SQL, q, sizeof(q), "DELETE FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d", UserInfo[playerid][ID], InventoryInfo[playerid][tmp_id][ItemID]);
            mysql_tquery(SQL, q); 

            InventoryInfo[playerid][tmp_id][ItemID] = INVALID_INVENTORY_ITEM; 
            InventoryInfo[playerid][tmp_id][ItemQuantity] = 0;
            InventoryInfo[playerid][tmp_id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

            Iter_Remove(iter_Items[playerid], tmp_id);

            new qw[246];
            mysql_format(SQL, qw, sizeof qw, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", UserInfo[playerid][ID]);
            mysql_tquery(SQL, qw, "mysql_LoadPlayerInventory", "d", playerid);

            inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

        }

        //* Nemerem dalje imam sizofreniju
    }

    return true;
}

Dialog:inventoryTakeGun(const playerid, response, listitem, string: inputtext[]) {
    if (!response) { 

        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;

        return true;
    }

    new tmp_id = inventory_ChosenItem[playerid], ammo;

    if(sscanf(inputtext, "d", ammo)) return  Dialog_Show(playerid, "inventoryTakeGun", DIALOG_STYLE_INPUT, "{ff006f}Takegun", "Unesite zeljenu kolicinu metaka za %s\n Trenutna kolicina : {ff006f}%d/%d", "Unesi", "Odustani", 
                                                                    Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]),
                                                                    InventoryInfo[playerid][tmp_id][ItemQuantity], MAX_AMMO_QUANTITY
                                            );

    if(ammo < 0 || ammo > InventoryInfo[playerid][tmp_id][ItemQuantity]) return Dialog_Show(playerid, "inventoryTakeGun", DIALOG_STYLE_INPUT, "{ff006f}TakeGun", "Unesite zeljenu kolicinu metaka za %s\n Trenutna kolicina : {ff006f}%d/%d", "Unesi", "Odustani", 
                                                                                                        Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]),
                                                                                                        InventoryInfo[playerid][tmp_id][ItemQuantity], MAX_AMMO_QUANTITY
                                                                                );

    if(InventoryInfo[playerid][tmp_id][ItemQuantity] == ammo) {

        GivePlayerWeapon(playerid, WEAPON:InventoryInfo[playerid][tmp_id][ItemID], ammo);
        SendClientMessage(playerid, 0xff006fFF, "(inventory): "c_white"Uzeli ste %s sa %d municije.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]), ammo);

        new q[128];
        mysql_format(SQL, q, sizeof q, "DELETE FROM `inventory` WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                        InventoryInfo[playerid][tmp_id][ItemID], UserInfo[playerid][ID]);
        mysql_tquery(SQL, q);

        Iter_Remove(iter_Items[playerid], tmp_id);

        InventoryInfo[playerid][tmp_id][ItemID] = INVALID_INVENTORY_ITEM; 
        InventoryInfo[playerid][tmp_id][ItemQuantity] = 0;
        InventoryInfo[playerid][tmp_id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

        new qw[246];
        mysql_format(SQL, qw, sizeof qw, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", UserInfo[playerid][ID]);
        mysql_tquery(SQL, qw, "mysql_LoadPlayerInventory", "d", playerid);

        inventory_ChosenItem[playerid] = INVALID_INVENTORY_ITEM;
        return (true);
    }

    InventoryInfo[playerid][tmp_id][ItemQuantity]-= ammo;

    GivePlayerWeapon(playerid, WEAPON:InventoryInfo[playerid][tmp_id][ItemID], ammo);
    SendClientMessage(playerid, x_server, "(0xff006fFF): "c_white"Uzeli ste %s sa %d municije.", Inventory_ReturnItemName(InventoryInfo[playerid][tmp_id][ItemID]), ammo);

    new q[240];

    mysql_format(SQL, q, sizeof q, "UPDATE `inventory` SET `ItemQuantity` = '%d' WHERE `ItemID` = '%d' AND `PlayerID` = '%d'", 
                                    InventoryInfo[playerid][tmp_id][ItemQuantity], InventoryInfo[playerid][tmp_id][ItemID],
                                    UserInfo[playerid][ID]);
    mysql_tquery(SQL, q);

    return true;
}

YCMD:invname(playerid, params[], help) {

    new id;
    if(sscanf(params, "d", id)) return true;
    
    SendClientMessage(playerid, x_server, "%s", Inventory_ReturnItemName(id));
    
    return (true);
}

/*

    mysql_format(MySQL:SQL, q, sizeof(q), "DELETE FROM `inventory` WHERE `PlayerID` = %d AND `ItemID` = %d", UserInfo[playerid][ID], InventoryInfo[playerid][id][ItemID]);
    mysql_tquery(SQL, q); 

    InventoryInfo[playerid][id][ItemID] = INVALID_INVENTORY_ITEM; 
    InventoryInfo[playerid][id][ItemQuantity] = 0;
    InventoryInfo[playerid][id][ItemType] = INVENTORY_INVALID_ITEM_TYPE;

    Iter_Remove(iter_Items[playerid], id);

    printf("* Removed item from inventory array at index '%d'", id);

    SendClientMessage(playerid, 0x00FF00FF, "Bacio si item - DEBUG.");

    new qw[246];
    mysql_format(SQL, qw, sizeof qw, "SELECT * FROM `inventory` WHERE `PlayerID` = %d", UserInfo[playerid][ID]);
    mysql_tquery(SQL, qw, "mysql_LoadPlayerInventory", "d", playerid);

*/