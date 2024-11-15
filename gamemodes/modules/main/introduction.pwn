/*

 
*                  _       _                 _            _   _             
*                 (_)     | |               | |          | | (_)            
*                  _ _ __ | |_ _ __ ___   __| |_   _  ___| |_ _  ___  _ __  
*                 | | '_ \| __| '__/ _ \ / _` | | | |/ __| __| |/ _ \| '_ \ 
*                 | | | | | |_| | | (_) | (_| | |_| | (__| |_| | (_) | | | |
*                 |_|_| |_|\__|_|  \___/ \__,_|\__,_|\___|\__|_|\___/|_| |_|
*                                                                                           
*                  _________________________________________________________
*               
*                   @Author : Noddy
*                   Date : 13/11/2024
*                   
*                   TODO LIST:
*                   
*                   Everysing
*/

// 71+ -74+ -74+ 71+ -74+

//*==============================================================================
//*--->>> Beninging
//*==============================================================================

#include <ylessinc\YSI_Coding\y_hooks>

#define INTRODUCTION_INT            (15)
#define INTRODUCTION_INVALID_ITEM   (-1)

new g_tmpObjects[MAX_PLAYERS][5],
    g_tmpPickups[MAX_PLAYERS][5],
    bool:g_playerItems[MAX_PLAYERS][5],
    g_playerVehicle[MAX_PLAYERS],
    g_playerVW[MAX_PLAYERS],
    g_pumpObjs[MAX_PLAYERS][3],
    PlayerText3D:g_tmpLabels[MAX_PLAYERS][5],
    bool:g_vehRepaired[MAX_PLAYERS],
    bool:g_lockPicking[MAX_PLAYERS],
    bool:g_introductionRespawn[MAX_PLAYERS];

new PlayerText: Lockpick_UI[MAX_PLAYERS][14];

enum e_TMP_ITEM_DATA {

    itemID,
    itemName[32],
    itemModel,
    Float:itemPos[6]
}

new bool:g_lockPicked[MAX_PLAYERS],
    g_chosenPick[MAX_PLAYERS];

new IntroductionItems[5][e_TMP_ITEM_DATA] = {

    { 0, "Kanister Ulja", 19621, { 1400.396606, -3961.269531, 16.594469, 0.000000, 0.000000, 0.000000     } },
    { 1, "Kanister Goriva", 1650,  { 1388.172119, -3876.121093, 16.468694, 0.000000, 0.000000, 0.000000     } },
    { 2, "Serafciger", 18644, { 1462.076416, -3856.194335, 16.365949, 90.000000, 5.000000, -175.899963 } },
    { 3, "Akumulator", 2040,  { 1451.978393, -3880.465087, 16.355939, 0.000000, 0.000000, -66.199951   } },
    { 4, "Pumpa", 11744, { 1435.754028, -3864.039794, 16.212223, -179.899856, 0.000000, 0.000000  } }
};

forward Introduction_UpdateCutScene(playerid, scene);
public Introduction_UpdateCutScene(playerid, scene) {

    switch(scene) {

        case 1: {
            
            ClearChat(playerid);

            SendClientMessage(playerid, x_green, "introduction | "c_white"Potrebne djelove mozete naci u okolini!");
            SendClientMessage(playerid, x_green, "introduction | "c_white"Kada prikupite svih"c_green"5 "c_white"potrebnih djelova, imate mogucnost popravke auta.");

            InterpolateCameraPos(playerid, 1443.193847, -3958.828857, 19.194610, 1394.961547, -3954.646240, 17.907058, 2500);
            InterpolateCameraLookAt(playerid, 1438.393066, -3957.510498, 18.731822, 1398.149902, -3958.480712, 17.544187, 2500);

            SetTimerEx("Introduction_UpdateCutScene", 7500, false, "dd", playerid, 2);
        }

        case 2: {
            
            ClearChat(playerid);

            SendClientMessage(playerid, x_green, "introduction | "c_white"Pri uspjesnoj popravci auta imate punu mogucnost kako biste otisli na sigurno!");
            SendClientMessage(playerid, x_green, "introduction | "c_white"Sve sto je potrebno, je da pratite cestu do ovog mosta i nastavite dalje!");

            InterpolateCameraPos(playerid, 1490.694580, -3877.602783, 23.544942, 1325.874511, -3839.072021, 32.610057, 2500);
            InterpolateCameraLookAt(playerid, 1487.669677, -3873.775634, 22.448457, 1322.709594, -3835.354492, 31.531366, 2500);

            SetTimerEx("Introduction_UpdateCutScene", 7500, false, "dd", playerid, 3);
        }

        case 3: {

            TogglePlayerSpectating(playerid, false);
            TogglePlayerControllable(playerid, true);

            SpawnPlayer(playerid);
            Streamer_UpdateEx(playerid, 1479.8596,-3942.6516,17.2666, g_playerVW[playerid], INTRODUCTION_INT);
        }
    }

    return (true);
}

forward Introduction_InitializeForPlayer(playerid);
public Introduction_InitializeForPlayer(playerid) {

    g_playerVW[playerid] = ( MAX_PLAYERS - playerid ) + 1;

    SetSpawnInfo(playerid, NO_TEAM, UserInfo[playerid][Skin], 1479.8596,-3942.6516,17.2666, 246.04);
    SetPlayerInterior(playerid, INTRODUCTION_INT);
    SetPlayerVirtualWorld(playerid, g_playerVW[playerid]);
    
    SpawnPlayer(playerid);
    TogglePlayerSpectating(playerid, true);
    TogglePlayerControllable(playerid, false);

    InterpolateCameraPos(playerid, 1503.631591, -3952.656738, 21.798540, 1444.846313, -3958.577880, 20.432483, 2500);
    InterpolateCameraLookAt(playerid, 1499.137817, -3950.584716, 21.082351, 1440.213012, -3957.260009, 19.092388, 2500);

    Introduction_LoadData(playerid);

    ClearChat(playerid);
    
    SendClientMessage(playerid, x_green, "introduction | "c_white"Doslo je do nevolje u Hollow Ville-u!");
    SendClientMessage(playerid, x_green, "introduction | "c_white"Pronadji "c_green"5 "c_white"potrebnih djelova kako biste popravili vozilo!");

    SetTimerEx("Introduction_UpdateCutScene", 7500, false, "dd", playerid, 1);

    return (true);
}

forward Introduction_FixVehicle(playerid);
public Introduction_FixVehicle(playerid) {

    TogglePlayerControllable(playerid, true);

    new 
        VEHICLE_PANEL_STATUS:panels,
        VEHICLE_DOOR_STATUS:doors,
        VEHICLE_LIGHT_STATUS:lights,
        VEHICLE_TIRE_STATUS:tires;

    GetVehicleDamageStatus(g_playerVehicle[playerid], panels, doors, lights, tires);

    doors = VEHICLE_DOOR_STATUS_NONE;
    tires = VEHICLE_TYRE_STATUS_NONE;
    lights = VEHICLE_LIGHT_STATUS_NONE;
    panels = VEHICLE_PANEL_STATUS_NONE;

    UpdateVehicleDamageStatus(g_playerVehicle[playerid], panels, doors, lights, tires);
    SetVehicleHealth(g_playerVehicle[playerid], 1000.00);
    SendClientMessage(playerid, x_green, "introduction | "c_white"Uspjesno ste popravili vozilo, i spremni ste napustiti grad.");

    g_vehRepaired[playerid] = true;

    return (true);
}

//*==============================================================================
//*--->>> Functions
//*==============================================================================

stock Introduction_LoadData(playerid) {

    g_playerVehicle[playerid] = CreateVehicle(576,1431.8977,-3957.6873,17.0318,298.6303,64,1, 1500, false);

    for(new i = 0; i < sizeof IntroductionItems; i++) {

        g_tmpObjects[playerid][i] = CreatePlayerObject(playerid, IntroductionItems[i][itemModel], IntroductionItems[i][itemPos][0], IntroductionItems[i][itemPos][1], IntroductionItems[i][itemPos][2], IntroductionItems[i][itemPos][3], IntroductionItems[i][itemPos][4], IntroductionItems[i][itemPos][5]);
        g_tmpLabels[playerid][i] = CreatePlayer3DTextLabel(playerid, ""c_green"%s"c_white"\n[ N ]", -1, IntroductionItems[i][itemPos][0], IntroductionItems[i][itemPos][1], IntroductionItems[i][itemPos][2], 3.50, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, false, IntroductionItems[i][itemName]);
        g_tmpPickups[playerid][i] = CreatePlayerPickup(playerid, 19607, 1, IntroductionItems[i][itemPos][0], IntroductionItems[i][itemPos][1], ( IntroductionItems[i][itemPos][2]  - 1.75 ), g_playerVW[playerid]); 
    }
    
    g_pumpObjs[playerid][0] = CreatePlayerObject(playerid, 1654, 1435.741088, -3864.059570, 16.421901, 0.000000, -4.099998, 69.7999260, 0.00); //null_ptr
    g_pumpObjs[playerid][1] = CreatePlayerObject(playerid, 334, 1435.800903, -3863.999267, 16.612470, 0.000000, 180.000000, 90.000000, 0.00); // null_ptr 
    g_pumpObjs[playerid][2] = CreatePlayerObject(playerid, 334, 1435.800903, -3863.999267, 16.612470, 0.000000, 180.000000, 90.000000, 0.00); // null_ptr 
    
    SetPlayerObjectMaterial(playerid, g_pumpObjs[playerid][0], 0, 19962, "samproadsigns", "materialtext1", 0x00000000);
    SetPlayerObjectMaterial(playerid, g_tmpObjects[playerid][3], 0, 8399, "vgs_shops", "vgs_shpfrnt01_128", 0x00000000);
    SetPlayerObjectMaterial(playerid, g_tmpObjects[playerid][4], 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
    SetVehicleHealth(g_playerVehicle[playerid], 440.00);

    new 
        VEHICLE_PANEL_STATUS:panels,
        VEHICLE_DOOR_STATUS:doors,
        VEHICLE_LIGHT_STATUS:lights,
        VEHICLE_TIRE_STATUS:tires;

    GetVehicleDamageStatus(g_playerVehicle[playerid], panels, doors, lights, tires);

    doors = (VEHICLE_DOOR_STATUS_TRUNK_DAMAGED | VEHICLE_DOOR_STATUS_FRONT_LEFT_DAMAGED );
    tires = VEHICLE_TIRE_STATUS_FRONT_LEFT_POPPED;

    UpdateVehicleDamageStatus(g_playerVehicle[playerid], panels, doors, lights, tires);

    LinkVehicleToInterior(g_playerVehicle[playerid], INTRODUCTION_INT);
    SetVehicleVirtualWorld(g_playerVehicle[playerid], g_playerVW[playerid]);

    g_vehRepaired[playerid] = false;

    return (true);
}

stock Introduction_ReturnNearestItem(playerid) {

    for(new i = 0; i < sizeof IntroductionItems; i++) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, IntroductionItems[i][itemPos][0], IntroductionItems[i][itemPos][1], IntroductionItems[i][itemPos][2]))
            return i;
    }

    return INTRODUCTION_INVALID_ITEM;
}

stock Introduction_PickupItem(playerid, idx) {

    for(new i = 0; i < sizeof IntroductionItems; i++) {

        if(idx == IntroductionItems[idx][itemID])
        {   
            if(g_playerItems[playerid][idx]) continue;

            if(IntroductionItems[idx][itemID] == 4) {

                DestroyPlayerObject(playerid, g_pumpObjs[playerid][0]);
                DestroyPlayerObject(playerid, g_pumpObjs[playerid][1]);
                DestroyPlayerObject(playerid, g_pumpObjs[playerid][2]);
            }

            DestroyPlayerObject(playerid, g_tmpObjects[playerid][idx]);
            DestroyPlayerPickup(playerid, g_tmpPickups[playerid][idx]);
            DeletePlayer3DTextLabel(playerid, g_tmpLabels[playerid][idx]);
            SendClientMessage(playerid, x_green, "hollow-ville | "c_white"Pokupili ste "c_green"%s "c_white"sa poda", IntroductionItems[idx][itemName]);
            g_playerItems[playerid][idx] = true;
            return Y_HOOKS_CONTINUE_RETURN_1;
        }
    }

    return (true);
}

stock Introduction_ReturnPlayerItems(playerid) {

    new count = 0;

    for(new i = 0; i < sizeof IntroductionItems; i++) {

        if(g_playerItems[playerid][i])
            count++;
    }

    return count;
}

//*==============================================================================
//*--->>> Hooks
//*==============================================================================

hook OnPlayerConnect(playerid) {

    g_vehRepaired[playerid] = false;
    g_lockPicked[playerid] = false;
    g_lockPicking[playerid] = false;
    g_chosenPick[playerid] = -1;
    g_introductionRespawn[playerid] = false;

    if(IsValidVehicle(g_playerVehicle[playerid]))
        DestroyVehicle(g_playerVehicle[playerid]);

    for(new i = 0; i < sizeof IntroductionItems; i++) 
    {
        if(IsValidPlayerObject(playerid, g_tmpObjects[playerid][i])) 
            DestroyPlayerObject(playerid, g_tmpObjects[playerid][i]);

        if(IsValidPlayerPickup(playerid,  g_tmpPickups[playerid][i]))
            DestroyPlayerPickup(playerid, g_tmpPickups[playerid][i]);

        if(IsValidPlayer3DTextLabel(playerid, g_tmpLabels[playerid][i]))
            DeletePlayer3DTextLabel(playerid, g_tmpLabels[playerid][i]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDisconnect(playerid, reason) {

    if(IsValidVehicle(g_playerVehicle[playerid]))
        DestroyVehicle(g_playerVehicle[playerid]);

    for(new i = 0; i < sizeof IntroductionItems; i++) 
    {

        if(IsValidPlayerObject(playerid, g_tmpObjects[playerid][i])) 
            DestroyPlayerObject(playerid, g_tmpObjects[playerid][i]);

        if(IsValidPlayerPickup(playerid,  g_tmpPickups[playerid][i]))
            DestroyPlayerPickup(playerid, g_tmpPickups[playerid][i]);

        if(IsValidPlayer3DTextLabel(playerid, g_tmpLabels[playerid][i]))
            DeletePlayer3DTextLabel(playerid, g_tmpLabels[playerid][i]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {
        new idx = Introduction_ReturnNearestItem(playerid);
        if(idx != INTRODUCTION_INVALID_ITEM) 
            Introduction_PickupItem(playerid, idx);

        new Float:cPos[3];
        GetVehiclePos(g_playerVehicle[playerid], cPos[0], cPos[1], cPos[2]);

        if(IsPlayerInRangeOfPoint(playerid, 3.50, cPos[0], cPos[1], cPos[2]) && !g_vehRepaired[playerid]) {
            
            if(Introduction_ReturnPlayerItems(playerid) < 5)
                return SendClientMessage(playerid, x_green, "introduction | "c_white"Nemate dovoljno resursa za popravku vozila "c_green"%d/5", Introduction_ReturnPlayerItems(playerid));

            GameTextForPlayer(playerid, "~b~POPRAVKA ~w~VOZILA U TOKU", 6500, 3);
            SetTimerEx("Introduction_FixVehicle", 6500, false, "d", playerid);
            TogglePlayerControllable(playerid, false);
        }

        if(g_chosenPick[playerid] != -1 && !g_lockPicked[playerid]) {

            new tmp_idx = ( g_chosenPick[playerid] + 8 );
            new Float:tdPos[2];
            PlayerTextDrawGetTextSize(playerid, Lockpick_UI[playerid][tmp_idx], tdPos[0], tdPos[1]);

            if(tdPos[1] < 0) 
                tdPos[1] += -1.0;
            else
                tdPos[1] += 1.0;
            
            PlayerTextDrawTextSize(playerid,  Lockpick_UI[playerid][tmp_idx], tdPos[0], tdPos[1]);
            PlayerTextDrawShow(playerid, Lockpick_UI[playerid][tmp_idx]);

            if( floatabs( tdPos[1] ) >= 74.0) {

                g_chosenPick[playerid]++;

                if(g_chosenPick[playerid] > 5) {

                    SendClientMessage(playerid, x_green, "introduction | "c_white"Uspjesno ste pokrenuli vozilo, odvezite se odavde!");
                    g_lockPicked[playerid] = true;      
                    g_chosenPick[playerid] = -1;

                    SetPlayerCheckpoint(playerid, 1251.0521,-3773.1060,14.8340, 3.50);
                    Lockpick_ShowInterface(playerid, false);

                    new veh = GetPlayerVehicleID(playerid),
                    bool:engine,
                    bool:lights,
                    bool:alarm,
                    bool:doors,
                    bool:bonnet,
                    bool:boot,
                    bool:objective;

                    if(IsVehicleBicycle(GetVehicleModel(veh)))
                        return true;
                            
                    GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);
                    SetVehicleParamsEx(veh, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);

                    return Y_HOOKS_BREAK_RETURN_1;
                }
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {

    if(vehicleid == g_playerVehicle[playerid]) {

        if(g_vehRepaired[playerid] == false) 
            return ClearAnimations(playerid);
    }


    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterCheckpoint(playerid) {

    if(g_lockPicked[playerid]) {

        if(IsPlayerInRangeOfPoint(playerid, 3.50, 1251.0521,-3773.1060,14.8340)) {

            SetPlayerPos(playerid, 167.1225, -160.3572,6.7786);
            SetPlayerFacingAngle(playerid, 91.7);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);

            SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"%s, dobrodosli na server.", ReturnPlayerName(playerid));
            SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Vas account je uspjesno kreiran i sacuvan u "c_server"databazu.");
            SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Ukoliko vam zatreba pomoc, obratite se staff teamu putem "c_server"/askq");

            GivePlayerMoney(playerid, UserInfo[playerid][Money]);

            UserInfo[playerid][Introduction] = 1;

            new q[128];
            mysql_format(SQL, q, sizeof q, "UPDATE `users` SET `Introduction` = '%d' WHERE `ID` = '%d'", UserInfo[playerid][Introduction], UserInfo[playerid][ID]);
            mysql_tquery(SQL, q);

            CallLocalFunction("OnPlayerLoaded", "d", playerid);

            return Y_HOOKS_BREAK_RETURN_1;
        }
    }

    return (true);
}

YCMD:lockpick(playerid, params[], help) {

    if(!g_lockPicking[playerid]) {

        if(g_chosenPick[playerid] != -1)
            return (true);

        g_lockPicking[playerid] = true;

        Lockpick_ShowInterface(playerid, true);
        g_chosenPick[playerid] = 0;
        SendClientMessage(playerid, x_server, "locpick | "c_white"Pritiskajte tipku 'N' kako biste nastavili sa obijanjem brave za paljenje!");
    }

    return (true);
}

hook OnPlayerDeath(playerid, killerid, reason) {

    if(UserInfo[playerid][Introduction] == 0) 
        g_introductionRespawn[playerid] = true;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid) {

    if(g_introductionRespawn[playerid]) {

        SetPlayerPos(playerid, 1479.8596,-3942.6516,17.2666);
        SetPlayerInterior(playerid, INTRODUCTION_INT);
        SetPlayerVirtualWorld(playerid, g_playerVW[playerid]);

        return Y_HOOKS_BREAK_RETURN_1;
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}