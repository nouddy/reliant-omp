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

#define MAX_BUSINESS                        (300)
#define MAX_BUSINESS_NAME_LEN               (64)

#define WEAPON_ARMOUR               (WEAPON:100)

enum {

    BUSINESS_TYPE_MARKET,
    BUSINESS_TYPE_AMMUNATION,
    BUSINESS_TYPE_RESTAURANT,
    BUSINESS_TYPE_CAFE
}

enum e_BUSINESS_DATA {

    businessID,
    businessOwner,
    businessName[MAX_BUSINESS_NAME_LEN],
    businessLocked,
    businessMoney,
    businessVW,
    businessType,
    businessPrice,

    Float:businessEntrance[3],
    Float:businessExit[3],
    Float:businessInteract[3],

    businessProducts, //* Za svaki kupljeni item produtki se smanjivaju za 1.
}

enum e_INTERIOR_DATA {

    interiorID,
    Float:interiorPosition[3]
}

enum e_AMMUNATION_WEAPON_DATA {

    WEAPON:weaponID,
    weaponName[32],
    weaponAmmo,
    weaponPrice
}

new const sz_InteriorData[4][e_INTERIOR_DATA] = {

    { 10, { 6.08,-28.89,1003.54 } }, //* Market 24/7 Interior
    { 6,  { 316.50,-167.62,999.59 } }, //* Ammunation Interior
    { 9,  { 366.00,-9.43,1001.85 } }, //* Restaurant Interior
    { 11, { 501.95,-70.56,998.75 } } //* Cafe Bar Interior
};

new const sz_AmmunationData[][e_AMMUNATION_WEAPON_DATA] = {

    { "Colt-45", WEAPON_COLT45, 30, 120 },
    { "M4", WEAPON_M4, 60, 500 },
    { "Sniper Rifle", WEAPON_SNIPER, 12, 500 },
    { "Shotgun", WEAPON_SHOTGUN, 25, 350 },
    { "TEC-9", WEAPON_TEC9, 60, 320 },
    { "Desert Eagle", WEAPON_DEAGLE, 30, 250 },
    { "Armour", WEAPON_ARMOUR, 50, 500 }
};

new BusinessInfo[MAX_BUSINESS][e_BUSINESS_DATA],
    Iterator:iter_Business<MAX_BUSINESS>,
    Text3D:BusinessLabel[MAX_BUSINESS],
    Text3D:BusinessInteract[MAX_BUSINESS],
    BusinessPickup[MAX_BUSINESS];

forward mysql_LoadBusinessData();
public mysql_LoadBusinessData() {

    new rows = cache_num_rows();

    if(!rows) return print("DATABASE: There is no business in database.");

    else {

        for(new i = 0; i < rows; i++) {

            cache_get_value_name_int(i, "BusinessID", BusinessInfo[i][businessID]);
            cache_get_value_name_int(i, "BusinessOwner", BusinessInfo[i][businessOwner]);
            cache_get_value_name(i, "BusinessName", BusinessInfo[i][businessName], MAX_BUSINESS_NAME_LEN);
            cache_get_value_name_int(i, "BusinessLocked", BusinessInfo[i][businessLocked]);
            cache_get_value_name_int(i, "BusinessMoney", BusinessInfo[i][businessMoney]);
            cache_get_value_name_int(i, "BusinessVW", BusinessInfo[i][businessVW]);
            cache_get_value_name_int(i, "BusinessType", BusinessInfo[i][businessType]);
            cache_get_value_name_int(i, "BusinessPrice", BusinessInfo[i][businessPrice]);

            cache_get_value_name_float(i, "BusinessEntrance_X", BusinessInfo[i][businessEntrance][0]);
            cache_get_value_name_float(i, "BusinessEntrance_Y", BusinessInfo[i][businessEntrance][1]);
            cache_get_value_name_float(i, "BusinessEntrance_Z", BusinessInfo[i][businessEntrance][2]);

            cache_get_value_name_float(i, "BusinessExit_X", BusinessInfo[i][businessExit][0]);
            cache_get_value_name_float(i, "BusinessExit_Y", BusinessInfo[i][businessExit][1]);
            cache_get_value_name_float(i, "BusinessExit_Z", BusinessInfo[i][businessExit][2]);

            cache_get_value_name_float(i, "BusinessInteract_X", BusinessInfo[i][businessInteract][0]);
            cache_get_value_name_float(i, "BusinessInteract_Y", BusinessInfo[i][businessInteract][1]);
            cache_get_value_name_float(i, "BusinessInteract_Z", BusinessInfo[i][businessInteract][2]);

            cache_get_value_name_int(i, "BusinessProducts", BusinessInfo[i][businessProducts]);

            new stringicc[264];

            if(BusinessInfo[i][businessOwner] > -1) 
                 format(stringicc, sizeof stringicc, "{ff006f}(( %s {ff006f} [%d] ))\n{ffffff}Za ulaz pritisnite {ff006f}'F'",  BusinessInfo[i][businessName], BusinessInfo[i][businessID]);
            else
                format(stringicc, sizeof stringicc, "{ff006f}(( %s {ff006f} [%d] ))\n{ffffff}Cijena firme : {ff006f}%d\n{ffffff}Za kupovinu : {ff006f}/buybusiness",  BusinessInfo[i][businessName], BusinessInfo[i][businessID], BusinessInfo[i][businessPrice]);

            BusinessLabel[i] = CreateDynamic3DTextLabel(stringicc, 0xFFFFFFFF, BusinessInfo[i][businessEntrance][0], BusinessInfo[i][businessEntrance][1], BusinessInfo[i][businessEntrance][2], 4.50, INVALID_PLAYER_ID);
            BusinessPickup[i] = CreateDynamicPickup(19132, 1,BusinessInfo[i][businessEntrance][0], BusinessInfo[i][businessEntrance][1], BusinessInfo[i][businessEntrance][2]);
            BusinessInteract[i] = CreateDynamic3DTextLabel("{ffffff}Za kupovinu kucajte : \n{ff006f}>> {ffffff}/buy {ff006f}<<", 0xFFFFFFFF, BusinessInfo[i][businessEntrance][0], BusinessInfo[i][businessEntrance][1], BusinessInfo[i][businessEntrance][2], 4.50, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[i][businessVW], sz_InteriorData[ BusinessInfo[i][businessType] - 1 ][interiorID]);
        
            Iter_Add(iter_Business, i);
        } 
    }

    return (true);
}

forward mysql_CreateBusiness(id);
public mysql_CreateBusiness(id) {

    BusinessInfo[id][businessID] = cache_insert_id();

    new stringicc[264];
    format(stringicc, sizeof stringicc, "{ff006f}(( %s {ff006f} [%d] ))\n{ffffff}Cijena firme : {ff006f}%d\n{ffffff}Za kupovinu : {ff006f}/buybusiness",  BusinessInfo[id][businessName], BusinessInfo[id][businessID], BusinessInfo[id][businessPrice]);

    BusinessLabel[id] = CreateDynamic3DTextLabel(stringicc, 0xFFFFFFFF, BusinessInfo[id][businessEntrance][0], BusinessInfo[id][businessEntrance][1], BusinessInfo[id][businessEntrance][2], 4.50, INVALID_PLAYER_ID);
    BusinessPickup[id] = CreateDynamicPickup(19132, 1,BusinessInfo[id][businessEntrance][0], BusinessInfo[id][businessEntrance][1], BusinessInfo[id][businessEntrance][2]);
    BusinessInteract[id] = CreateDynamic3DTextLabel("{ffffff}Za kupovinu kucajte : \n{ff006f}>> {ffffff}/buy {ff006f}<<", 0xFFFFFFFF, BusinessInfo[id][businessEntrance][0], BusinessInfo[id][businessEntrance][1], BusinessInfo[id][businessEntrance][2], 4.50, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, BusinessInfo[id][businessVW], sz_InteriorData[ BusinessInfo[id][businessType] - 1 ][interiorID]);

    Iter_Add(iter_Business, id);

    return (true);
}

hook OnGameModeInit() {

    mysql_tquery(SQL, "SELECT * FROM `business`", "mysql_LoadBusinessData");

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnGameModeExit() {

    foreach(new i : iter_Business) {

        if(IsValidDynamicPickup(BusinessPickup[i]))
            DestroyDynamicPickup(BusinessPickup[i]);
    
        if(IsValidDynamic3DTextLabel(BusinessLabel[i]))
            DestroyDynamic3DTextLabel(BusinessLabel[i]);
        
        if(IsValidDynamic3DTextLabel(BusinessInteract[i]))
            DestroyDynamic3DTextLabel(BusinessInteract[i]);
    
        Iter_Remove(iter_Business, i);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:createbusiness(playerid, params[], help) {

    if(!IsPlayerAdmin(playerid)) 
        return SendClientMessage(playerid, x_server, "(reliant): "c_white"Samo RCON admini imaju pristup ovoj komandi!");

    new type, price, name[MAX_BUSINESS_NAME_LEN];

    if(sscanf(params, "dds[64]", type, price, name)) return SendClientMessage(playerid, 0x442861FF, "(realEstate): "c_white"/createbusiness [Tip] [Cijena] [Ime]");

    if(price < 0) return SendClientMessage(playerid, 0x442861FF, "(realEstate): "c_white"Cijena firme ne moze biti manja od 0");
    if(type < BUSINESS_TYPE_MARKET || type > BUSINESS_TYPE_CAFE) return SendClientMessage(playerid, 0x442861FF, "(realEstate): "c_white"Tip firme ne moze biti manji od 1 a veci od 4");

    new tmp_name[MAX_BUSINESS_NAME_LEN];
    strmid(tmp_name, name, 0, sizeof name, MAX_BUSINESS_NAME_LEN);

    new xID = Iter_Free(iter_Business), Float:pPos[3];

    GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);

    BusinessInfo[xID][businessOwner] = -1;
    BusinessInfo[xID][businessName] = tmp_name;
    BusinessInfo[xID][businessLocked] = 1;
    BusinessInfo[xID][businessMoney] = 0;
    BusinessInfo[xID][businessType] = type;
    BusinessInfo[xID][businessPrice] = price;

    BusinessInfo[xID][businessEntrance][0] = pPos[0];
    BusinessInfo[xID][businessEntrance][1] = pPos[1];
    BusinessInfo[xID][businessEntrance][2] = pPos[2];

    BusinessInfo[xID][businessExit][0] = sz_InteriorData[ type - 1 ][interiorPosition][0];
    BusinessInfo[xID][businessExit][1] = sz_InteriorData[ type - 1 ][interiorPosition][1];
    BusinessInfo[xID][businessExit][2] = sz_InteriorData[ type - 1 ][interiorPosition][2];
    BusinessInfo[xID][businessVW] = xID;

    BusinessInfo[xID][businessInteract][0] = pPos[0];
    BusinessInfo[xID][businessInteract][1] = pPos[1];
    BusinessInfo[xID][businessInteract][2] = pPos[2];

    BusinessInfo[xID][businessProducts] = 0;

    new q[1024];
    mysql_format(SQL, q, sizeof q, "INSERT INTO `business` (`BusinessOwner`, `BusinessName`, `BusinessLocked`, `BusinessMoney`, `BusinessVW`, `BusinessType`, `BusinessPrice`, \
                                    `BusinessEntrance_X`, `BusinessEntrance_Y`, `BusinessEntrance_Z`, `BusinessExit_X`, `BusinessExit_Y`, `BusinessExit_Z`, \
                                    `BusinessInteract_X`, `BusinessInteract_Y`, `BusinessInteract_Z`, `BusinessProducts`) \
                                    VALUES ('-1', '%e', '1', '0', '%d', '%d', '%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '0')",
                                    tmp_name, type, price, xID, pPos[0], pPos[1], pPos[2], BusinessInfo[xID][businessExit][0], BusinessInfo[xID][businessExit][1], BusinessInfo[xID][businessExit][2],
                                    pPos[0], pPos[1], pPos[2]);
    mysql_tquery(SQL, q, "mysql_CreateBusiness", "d", xID);
    return (true);
}