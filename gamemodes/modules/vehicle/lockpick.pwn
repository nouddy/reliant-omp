/*

 
*                         _            _          _      _    
*                        | | ___   ___| | ___ __ (_) ___| | __
*                        | |/ _ \ / __| |/ / '_ \| |/ __| |/ /
*                        | | (_) | (__|   <| |_) | | (__|   < 
*                        |_|\___/ \___|_|\_\ .__/|_|\___|_|\_\
*                                          |_|                                                                                            
*                  _________________________________________________________
*               
*                   @Author : Noddy
*                   Date : 15/11/2024
*                   
*/


//*==============================================================================
//*--->>> Beninging
//*==============================================================================

#include <ylessinc\YSI_Coding\y_hooks>

stock Lockpick_ShowInterface(playerid, bool:show) {

    if(show) {

        for(new i = 0; i < sizeof Lockpick_UI[]; i++) {

            if(Lockpick_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid, Lockpick_UI[playerid][i]);
            Lockpick_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        }

        Lockpick_UI[playerid][0] = CreatePlayerTextDraw(playerid, 189.000, 145.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][0], 244.000, 151.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][0], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][0], 3355647);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][0], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][0], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][0], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][0], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][0], true);

        Lockpick_UI[playerid][1] = CreatePlayerTextDraw(playerid, 230.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][1], 21.000, 147.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][1], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][1], 1768516095);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][1], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][1], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][1], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][1], true);

        Lockpick_UI[playerid][2] = CreatePlayerTextDraw(playerid, 258.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][2], 21.000, 147.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][2], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][2], 1768516095);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][2], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][2], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][2], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][2], true);

        Lockpick_UI[playerid][3] = CreatePlayerTextDraw(playerid, 285.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][3], 21.000, 147.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][3], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][3], 1768516095);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][3], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][3], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][3], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][3], true);

        Lockpick_UI[playerid][4] = CreatePlayerTextDraw(playerid, 313.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][4], 21.000, 147.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][4], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][4], 1768516095);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][4], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][4], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][4], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][4], true);

        Lockpick_UI[playerid][5] = CreatePlayerTextDraw(playerid, 340.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][5], 21.000, 147.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][5], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][5], 1768516095);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][5], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][5], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][5], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][5], true);

        Lockpick_UI[playerid][6] = CreatePlayerTextDraw(playerid, 365.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][6], 21.000, 147.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][6], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][6], 1768516095);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][6], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][6], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][6], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][6], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][6], true);

        Lockpick_UI[playerid][7] = CreatePlayerTextDraw(playerid, 228.000, 221.95, "LD_SPAC:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][7], 160.000, -1.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][7], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][7], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][7], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][7], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][7], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][7], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][7], true);

        Lockpick_UI[playerid][8] = CreatePlayerTextDraw(playerid, 365.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][8], 21.000, 51.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][8], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][8], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][8], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][8], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][8], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][8], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][8], true);

        Lockpick_UI[playerid][9] = CreatePlayerTextDraw(playerid, 340.000, 294.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][9], 21.000, -27.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][9], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][9], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][9], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][9], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][9], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][9], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][9], true);

        Lockpick_UI[playerid][10] = CreatePlayerTextDraw(playerid, 313.000, 294.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][10], 21.000, -27.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][10], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][10], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][10], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][10], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][10], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][10], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][10], true);

        Lockpick_UI[playerid][11] = CreatePlayerTextDraw(playerid, 285.000, 147.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][11], 21.000, 24.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][11], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][11], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][11], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][11], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][11], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][11], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][11], true);

        Lockpick_UI[playerid][12] = CreatePlayerTextDraw(playerid, 258.000, 294.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][12], 21.000, -9.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][12], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][12], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][12], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][12], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][12], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][12], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][12], true);

        Lockpick_UI[playerid][13] = CreatePlayerTextDraw(playerid, 230.000, 294.000, "ld_spac:white");
        PlayerTextDrawTextSize(playerid, Lockpick_UI[playerid][13], 21.000, -39.000);
        PlayerTextDrawAlignment(playerid, Lockpick_UI[playerid][13], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, Lockpick_UI[playerid][13], -1);
        PlayerTextDrawSetShadow(playerid, Lockpick_UI[playerid][13], 0);
        PlayerTextDrawSetOutline(playerid, Lockpick_UI[playerid][13], 0);
        PlayerTextDrawBackgroundColour(playerid, Lockpick_UI[playerid][13], 255);
        PlayerTextDrawFont(playerid, Lockpick_UI[playerid][13], TEXT_DRAW_FONT_SPRITE_DRAW);
        PlayerTextDrawSetProportional(playerid, Lockpick_UI[playerid][13], true);

        for(new i = 0; i < sizeof Lockpick_UI[]; i++) {

            PlayerTextDrawShow(playerid, Lockpick_UI[playerid][i]);
        }
    }

    else {

        for(new i = 0; i < sizeof Lockpick_UI[]; i++) {

            if(Lockpick_UI[playerid][i] == INVALID_PLAYER_TEXT_DRAW) continue;

            PlayerTextDrawDestroy(playerid, Lockpick_UI[playerid][i]);
            Lockpick_UI[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
        }
    }

    return (true);
}

stock IsPlayerLockpicking(playerid) {

    if(!IsPlayerConnected(playerid))
        return 0;

    if(g_chosenPick[playerid] != -1)
        return 1;

    return 0;
}
