//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new PlayerText:TxdLoginLogo[MAX_PLAYERS][4];


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
SHARED_CreateTextdrawLoginLogo(playerid) {

    TxdLoginLogo[playerid][0] = CreatePlayerTextDraw(playerid, 337.000000, 106.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][0], 22.500000, 22.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][0], 125);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, TxdLoginLogo[playerid][0], 642);
    PlayerTextDrawSetPreviewRot(playerid, TxdLoginLogo[playerid][0], -16.000000, -9.000000, -11.000000, 1.000000);
    PlayerTextDrawSetPreviewVehicleColours(playerid, TxdLoginLogo[playerid][0], 1, 1);

    TxdLoginLogo[playerid][1] = CreatePlayerTextDraw(playerid, 271.000000, 110.000000, "Umbrella");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][1], 0.374998, 3.799993);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][1], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][1], 1);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][1], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][1], false);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][1], false);

    TxdLoginLogo[playerid][3] = CreatePlayerTextDraw(playerid, 314.000000, 145.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][3], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][3], 0.600000, 0.899999);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][3], 298.500000, 672.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][3], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][3], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][3], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][3], 1747094527);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][3], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][3], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][3], false);

    TxdLoginLogo[playerid][2] = CreatePlayerTextDraw(playerid, 290.000000, 134.000000, "Roleplay");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][2], TEXT_DRAW_FONT_0);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][2], 0.420825, 1.699995);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][2], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][2], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][2], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][2], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][2], false);
    return 1;
}

SHARED_ShowTextdrawLoginLogo(playerid) {

    for (new txd = 0; txd < 4; txd++) {
        PlayerTextDrawShow(playerid, TxdLoginLogo[playerid][txd]);
    }
    return 1;
}

SHARED_DestroyTextdrawLoginLogo(playerid) {

    for (new txd = 0; txd < 4; txd++) {
    
        PlayerTextDrawDestroy(playerid, TxdLoginLogo[playerid][txd]);
        TxdLoginLogo[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}