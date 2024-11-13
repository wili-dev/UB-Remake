//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new Float:tempPlayerPosBoxMoveLoginSplash[MAX_PLAYERS];
new Timer:tempPlayerTimerLoginSplash[MAX_PLAYERS];

new PlayerText:TxdLoginSplashLogo[MAX_PLAYERS][3];
new PlayerText:TxdLoginSplashBoxMove[MAX_PLAYERS];


//=-=-=-=-=-=-=-=-=-=-=[Timer's]=-=-=-=-=-=-=-=-=-=-=//
timer OnTimerDelayLoadingSplash[1500](playerid) {

    for (new txd = 1; txd < 3; txd++) {
        PlayerTextDrawShow(playerid, TxdLoginSplashLogo[playerid][txd]);
    }

    tempPlayerTimerLoginSplash[playerid] = repeat OnTimerLoginSplashBoxMove(playerid);
}

timer OnTimerLoginSplashBoxMove[100](playerid) {
    
    VSL_CreateTextdrawBoxMoveLoginSplash(playerid, tempPlayerPosBoxMoveLoginSplash[playerid]);
    VSL_UpdateTextdrawLogoLoginSplash(playerid, tempPlayerPosBoxMoveLoginSplash[playerid]);

    if (tempPlayerPosBoxMoveLoginSplash[playerid] >= 451) {

        YSI_StopTimerSafely(tempPlayerTimerLoginSplash[playerid]);
        PlayerTextDrawShow(playerid, TxdLoginSplashLogo[playerid][0]);

        defer OnTimerLoginSplashLoadAccount(playerid);
    }
    else
        tempPlayerPosBoxMoveLoginSplash[playerid] += 5.0;
}

timer OnTimerLoginSplashLoadAccount[1500](playerid) {

    VSL_DestroyTextdrawsLoginSplash(playerid);
    CheckPlayerLogin(playerid);
}

//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    YSI_StopTimerSafely(tempPlayerTimerLoginSplash[playerid]);

    TxdLoginSplashBoxMove[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {

    YSI_StopTimerSafely(tempPlayerTimerLoginSplash[playerid]);
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsLoginSplash(playerid) {

    SHARED_CreateTextdrawLoginBackground(playerid);

    TxdLoginSplashLogo[playerid][0] = CreatePlayerTextDraw(playerid, 339.000000, 153.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, TxdLoginSplashLogo[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawLetterSize(playerid, TxdLoginSplashLogo[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginSplashLogo[playerid][0], 45.000000, 39.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginSplashLogo[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginSplashLogo[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginSplashLogo[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginSplashLogo[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashLogo[playerid][0], 125);
    PlayerTextDrawBoxColour(playerid, TxdLoginSplashLogo[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginSplashLogo[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginSplashLogo[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginSplashLogo[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, TxdLoginSplashLogo[playerid][0], 642);
    PlayerTextDrawSetPreviewRot(playerid, TxdLoginSplashLogo[playerid][0], -16.000000, -9.000000, -11.000000, 1.000000);
    PlayerTextDrawSetPreviewVehicleColours(playerid, TxdLoginSplashLogo[playerid][0], 1, 1);

    TxdLoginSplashLogo[playerid][1] = CreatePlayerTextDraw(playerid, 255.000000, 160.000000, "Umbrella");
    PlayerTextDrawFont(playerid, TxdLoginSplashLogo[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdLoginSplashLogo[playerid][1], 0.508331, 5.749999);
    PlayerTextDrawTextSize(playerid, TxdLoginSplashLogo[playerid][1], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginSplashLogo[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginSplashLogo[playerid][1], 1);
    PlayerTextDrawAlignment(playerid, TxdLoginSplashLogo[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginSplashLogo[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashLogo[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginSplashLogo[playerid][1], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdLoginSplashLogo[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginSplashLogo[playerid][1], false);
    PlayerTextDrawSetSelectable(playerid, TxdLoginSplashLogo[playerid][1], false);

    TxdLoginSplashLogo[playerid][2] = CreatePlayerTextDraw(playerid, 281.000000, 193.000000, "_"); // Roleplay
    PlayerTextDrawFont(playerid, TxdLoginSplashLogo[playerid][2], TEXT_DRAW_FONT_0);
    PlayerTextDrawLetterSize(playerid, TxdLoginSplashLogo[playerid][2], 0.558323, 2.549993);
    PlayerTextDrawTextSize(playerid, TxdLoginSplashLogo[playerid][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginSplashLogo[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginSplashLogo[playerid][2], 4);
    PlayerTextDrawAlignment(playerid, TxdLoginSplashLogo[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginSplashLogo[playerid][2], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashLogo[playerid][2], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginSplashLogo[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginSplashLogo[playerid][2], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginSplashLogo[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginSplashLogo[playerid][2], false);
    return 1;
}

VSL_ShowTextdrawsLoginSplash(playerid) {

    tempPlayerPosBoxMoveLoginSplash[playerid] = 311.0;

    SHARED_ShowTextdrawLoginBackground(playerid);

    VSL_CreateTextdrawBoxMoveLoginSplash(playerid, 311.0);

    defer OnTimerDelayLoadingSplash(playerid);
    return 1;
}

VSL_CreateTextdrawBoxMoveLoginSplash(playerid, Float:pos_x) {

    if (TxdLoginSplashBoxMove[playerid] != PlayerText:INVALID_PLAYER_TEXT_DRAW)
        PlayerTextDrawDestroy(playerid, TxdLoginSplashBoxMove[playerid]);    

    TxdLoginSplashBoxMove[playerid] = CreatePlayerTextDraw(playerid, pos_x, 154.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginSplashBoxMove[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginSplashBoxMove[playerid], 0.600000, 7.549992);
    PlayerTextDrawTextSize(playerid, TxdLoginSplashBoxMove[playerid], 298.500000, 136.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginSplashBoxMove[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginSplashBoxMove[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginSplashBoxMove[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginSplashBoxMove[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashBoxMove[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginSplashBoxMove[playerid], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginSplashBoxMove[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginSplashBoxMove[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginSplashBoxMove[playerid], false);

    PlayerTextDrawShow(playerid, TxdLoginSplashBoxMove[playerid]);
    return 1;
}

VSL_UpdateTextdrawLogoLoginSplash(playerid, Float:size) {

    switch (size) {

        case 341.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "R");
        case 356.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Ro");
        case 361.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Rol");
        case 366.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Role");
        case 371.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Rolep");
        case 376.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Rolepl");
        case 381.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Rolepla");
        case 386.0: PlayerTextDrawSetString(playerid, TxdLoginSplashLogo[playerid][2], "Roleplay");
    }

    PlayerTextDrawShow(playerid, TxdLoginSplashLogo[playerid][2]);
    return 1;
}

VSL_DestroyTextdrawsLoginSplash(playerid) {

    PlayerTextDrawDestroy(playerid, TxdLoginSplashBoxMove[playerid]);
    TxdLoginSplashBoxMove[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 3; txd++) {
        PlayerTextDrawDestroy(playerid, TxdLoginSplashLogo[playerid][txd]);
        TxdLoginSplashLogo[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}