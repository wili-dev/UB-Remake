//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new PlayerText:TxdLoginBackground[MAX_PLAYERS];


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
SHARED_CreateTextdrawLoginBackground(playerid) {

    TxdLoginBackground[playerid] = CreatePlayerTextDraw(playerid, 316.000000, 1.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginBackground[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginBackground[playerid], 0.558332, 50.299980);
    PlayerTextDrawTextSize(playerid, TxdLoginBackground[playerid], 298.500000, 680.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginBackground[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginBackground[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginBackground[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginBackground[playerid], 1747094527);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginBackground[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginBackground[playerid], 255);
    PlayerTextDrawUseBox(playerid, TxdLoginBackground[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginBackground[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginBackground[playerid], false);
    return 1;
}

SHARED_ShowTextdrawLoginBackground(playerid) {

    PlayerTextDrawShow(playerid, TxdLoginBackground[playerid]);
    return 1;
}

SHARED_DestroyTextdrawLoginBackground(playerid) {

    PlayerTextDrawDestroy(playerid, TxdLoginBackground[playerid]);
    TxdLoginBackground[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    return 1;
}