//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new PlayerText:TxdLoginLogo[MAX_PLAYERS][3];


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
SHARED_CreateTextdrawsLoginLogo(playerid) {

    TxdLoginLogo[playerid][0] = CreatePlayerTextDraw(playerid, 334.000000, 98.000000, "Preview_Model");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][0], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][0], 27.500000, 35.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][0], -1724724224);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, TxdLoginLogo[playerid][0], 642);
    PlayerTextDrawSetPreviewRot(playerid, TxdLoginLogo[playerid][0], -10.000000, -9.000000, 0.000000, 1.000000);
    PlayerTextDrawSetPreviewVehicleColours(playerid, TxdLoginLogo[playerid][0], 16, 1);

    TxdLoginLogo[playerid][1] = CreatePlayerTextDraw(playerid, 285.000000, 108.000000, "Umbrella");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][1], 0.312489, 2.849992);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][1], 605.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][1], 1);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][1], false);

    TxdLoginLogo[playerid][2] = CreatePlayerTextDraw(playerid, 311.000000, 126.000000, "Roleplay");
    PlayerTextDrawFont(playerid, TxdLoginLogo[playerid][2], TEXT_DRAW_FONT_0);
    PlayerTextDrawLetterSize(playerid, TxdLoginLogo[playerid][2], 0.304161, 1.399996);
    PlayerTextDrawTextSize(playerid, TxdLoginLogo[playerid][2], 613.500000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLogo[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginLogo[playerid][2], 1);
    PlayerTextDrawAlignment(playerid, TxdLoginLogo[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLogo[playerid][2], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLogo[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLogo[playerid][2], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginLogo[playerid][2], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginLogo[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLogo[playerid][2], false);
    return 1;
}

SHARED_ShowTextdrawsLoginLogo(playerid) {

    for (new txd = 0; txd < 3; txd++) {
        PlayerTextDrawShow(playerid, TxdLoginLogo[playerid][txd]);
    }
    return 1;
}

SHARED_DestroyTextdrawsLoginLogo(playerid) {

    for (new txd = 0; txd < 3; txd++) {
    
        PlayerTextDrawDestroy(playerid, TxdLoginLogo[playerid][txd]);
        TxdLoginLogo[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}