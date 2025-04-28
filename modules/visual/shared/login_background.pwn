//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new PlayerText:TxdLoginBackground[MAX_PLAYERS][6];


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
SHARED_CreateTextdrawLoginBackgroundBox(playerid) {

    TxdLoginBackground[playerid][0] = CreatePlayerTextDraw(playerid, 315.000000, 3.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid][0], TEXT_DRAW_FONT_0);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid][0], 1.158331, 49.900001);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid][0], 298.500000, 686.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid][0], false);


    TxdLoginBackground[playerid][1] = CreatePlayerTextDraw(playerid, -7.000000, -11.000000, "ld_dual:layer");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid][1], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid][1], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid][1], 296.000000, 302.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid][1], 1747094527);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid][1], 1296911666);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid][1], false);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid][1], false);

    TxdLoginBackground[playerid][2] = CreatePlayerTextDraw(playerid, 355.000000, -11.000000, "ld_dual:layer");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid][2], 296.000000, 302.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid][2], 1296911871);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid][2], false);

    TxdLoginBackground[playerid][3] = CreatePlayerTextDraw(playerid, 355.000000, 289.000000, "ld_dual:layer");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid][3], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid][3], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid][3], 296.000000, 302.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid][3], 1296911871);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid][3], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid][3], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid][3], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid][3], false);

    TxdLoginBackground[playerid][4] = CreatePlayerTextDraw(playerid, -8.000000, 289.000000, "ld_dual:layer");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid][4], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid][4], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid][4], 296.000000, 302.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid][4], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid][4], 1747094527);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid][4], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid][4], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid][4], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid][4], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid][4], false);

    TxdLoginBackground[playerid][5] = CreatePlayerTextDraw(playerid, 279.000000, 104.000000, "ld_dual:layer");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid][5], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid][5], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid][5], 296.000000, 302.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid][5], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid][5], 1296911871);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid][5], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid][5], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid][5], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid][5], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid][5], false);
    return 1;
}

SHARED_ShowTextdrawsLoginBackground(playerid) {

    for (new txd = 0; txd < 6; txd++) {
        PlayerTextDrawShow(playerid, TxdLoginBackground[playerid][txd]);
    }
    return 1;
}

SHARED_DestroyTextdrawsLoginBackground(playerid) {

    for (new txd = 0; txd < 6; txd++) {
    
        PlayerTextDrawDestroy(playerid, TxdLoginBackground[playerid][txd]);
        TxdLoginBackground[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}

SHARED_DestroyTextdrawLoginBoxBackground(playerid) {

    PlayerTextDrawDestroy(playerid, TxdLoginBackground[playerid][0]);
    return 1;
}

SHARED_DestroyTextdrawsLoginSpritesBackground(playerid) {

    for (new txd = 1; txd < 6; txd++) {
    
        PlayerTextDrawDestroy(playerid, TxdLoginBackground[playerid][txd]);
        TxdLoginBackground[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}