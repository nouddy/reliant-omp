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
*   @Credits : !moosy A.K.A Sil Va (TextDraw)

*/

#include <ylessinc\YSI_Coding\y_hooks>

new PlayerText:g_NotifyTD[MAX_PLAYERS][12],
    bool:g_NotifyShown[MAX_PLAYERS];

stock Notify_SendNotification(playerid, const notification[], const header[], modelid) {

    if(g_NotifyShown[playerid]) return (true);

    for(new i = 0; i < sizeof g_NotifyTD[]; i++) {

        if(g_NotifyTD[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

        PlayerTextDrawDestroy(playerid, g_NotifyTD[playerid][i]);
        PlayerTextDrawHide(playerid, g_NotifyTD[playerid][i]);

        g_NotifyTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
    }

    g_NotifyTD[playerid][0] = CreatePlayerTextDraw(playerid, 253.000, 352.451, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][0], 124.000, 56.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][0], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][0], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][0], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][0], false);

    g_NotifyTD[playerid][1] = CreatePlayerTextDraw(playerid, 248.133, 350.363, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][1], 10.000, 12.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][1], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][1], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][1], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][1], false);

    g_NotifyTD[playerid][2] = CreatePlayerTextDraw(playerid, 248.133, 398.366, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][2], 10.000, 12.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][2], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][2], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][2], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][2], false);

    g_NotifyTD[playerid][3] = CreatePlayerTextDraw(playerid, 371.600, 398.366, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][3], 10.000, 12.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][3], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][3], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][3], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][3], false);

    g_NotifyTD[playerid][4] = CreatePlayerTextDraw(playerid, 371.600, 350.448, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][4], 10.000, 12.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][4], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][4], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][4], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][4], false);

    g_NotifyTD[playerid][5] = CreatePlayerTextDraw(playerid, 249.966, 357.174, "LD_SPAC:white");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][5], 129.940, 46.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][5], 320149759);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][5], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][5], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][5], false);

    g_NotifyTD[playerid][6] = CreatePlayerTextDraw(playerid, 249.999, 349.962, "_");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][6], 35.000, 38.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][6], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][6], 121);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][6], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][6], 0);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][6], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][6], false);
    PlayerTextDrawSetPreviewModel(playerid, g_NotifyTD[playerid][6], 2729);
    PlayerTextDrawSetPreviewRot(playerid, g_NotifyTD[playerid][6], 0.000, 0.000, 23.000, 1.000);
    PlayerTextDrawSetPreviewVehicleColours(playerid, g_NotifyTD[playerid][6], 0, 0);

    g_NotifyTD[playerid][7] = CreatePlayerTextDraw(playerid, 249.333, 352.866, "_");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][7], 35.000, 31.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][7], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][7], -1);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][7], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][7], 0);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][7], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][7], false);
    PlayerTextDrawSetPreviewModel(playerid, g_NotifyTD[playerid][7], model);
    PlayerTextDrawSetPreviewRot(playerid, g_NotifyTD[playerid][7], 0.000, 0.000, 23.000, 1.000);
    PlayerTextDrawSetPreviewVehicleColours(playerid, g_NotifyTD[playerid][7], 0, 0);

    g_NotifyTD[playerid][8] = CreatePlayerTextDraw(playerid, 260.666, 385.637, "ld_beat:chit");
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][8], 13.000, 14.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][8], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][8], -242);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][8], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][8], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][8], false);

    g_NotifyTD[playerid][9] = CreatePlayerTextDraw(playerid, 265.000, 388.000, "?");
    PlayerTextDrawLetterSize(playerid, g_NotifyTD[playerid][9], 0.210, 0.899);
    PlayerTextDrawTextSize(playerid, g_NotifyTD[playerid][9], 0.000, 77.000);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][9], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][9], -1);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][9], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][9], 150);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][9], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][9], true);

    g_NotifyTD[playerid][10] = CreatePlayerTextDraw(playerid, 312.333, 348.948, header);
    PlayerTextDrawLetterSize(playerid, g_NotifyTD[playerid][10], 0.149, 0.774);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][10], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][10], -1);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][10], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][10], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][10], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][10], true);

    g_NotifyTD[playerid][11] = CreatePlayerTextDraw(playerid, 324.333, 363.785, notification);
    PlayerTextDrawLetterSize(playerid, g_NotifyTD[playerid][11], 0.147, 0.858);
    PlayerTextDrawAlignment(playerid, g_NotifyTD[playerid][11], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, g_NotifyTD[playerid][11], -1);
    PlayerTextDrawSetShadow(playerid, g_NotifyTD[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, g_NotifyTD[playerid][11], 0);
    PlayerTextDrawBackgroundColour(playerid, g_NotifyTD[playerid][11], 255);
    PlayerTextDrawFont(playerid, g_NotifyTD[playerid][11], TEXT_DRAW_FONT_1);
    PlayerTextDrawSetProportional(playerid, g_NotifyTD[playerid][11], true);

    for(new i = 0; i < sizeof g_NotifyTD[]; i++) {

        PlayerTextDrawShow(playerid, g_NotifyTD[playerid][i]);
    }
    
    SetTimerEx("notify_DestroyInterface", 5000, false, "d", playerid);

    return (true);
}

forward notify_DestroyInterface(playerid);
public notify_DestroyInterface(playerid) {

    if(g_NotifyShown[playerid])

        for(new i = 0; i < sizeof g_NotifyTD[]; i++) {

            if(g_NotifyTD[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid, g_NotifyTD[playerid][i]);
            PlayerTextDrawHide(playerid, g_NotifyTD[playerid][i]);

            g_NotifyTD[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
            g_NotifyShown[playerid] = false;
        }

    }

    return (true);
}

YCMD:notifyme(playerid, params[], help) 
{
    Notify_SendNotification(playerid, "Kuca poso poso kuca~n~\
                                       Sta znam nista ne znam", "Header1", 1247);

    return 1;
}