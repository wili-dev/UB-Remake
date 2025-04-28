//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new Float:tempPlayerPosBoxMoveLoginSplash[MAX_PLAYERS];
new Float:tempPlayerSizeBoxMoveLoginSplash[MAX_PLAYERS];
new Timer:tempPlayerTimerLoginSplash[MAX_PLAYERS];

new PlayerText:TxdLoginSplashLogo[MAX_PLAYERS][3];
new PlayerText:TxdLoginSplashBoxMove[MAX_PLAYERS];


//=-=-=-=-=-=-=-=-=-=-=[Timer's]=-=-=-=-=-=-=-=-=-=-=//
timer OnTimerDelayLoadingSplash[3000](playerid) {

    PlayerTextDrawShow(playerid, TxdLoginSplashBoxMove[playerid]);

    for (new txd = 1; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, TxdLoginSplashLogo[playerid][txd]);
    }

    tempPlayerTimerLoginSplash[playerid] = repeat OnTimerLoginSplashBoxMove(playerid);
}

timer OnTimerLoginSplashBoxMove[100](playerid) {

    if (tempPlayerPosBoxMoveLoginSplash[playerid] >= 366) {

        YSI_StopTimerSafely(tempPlayerTimerLoginSplash[playerid]);

        PlayerTextDrawShow(playerid, TxdLoginSplashLogo[playerid][0]);
        PlayerTextDrawShow(playerid, TxdLoginSplashLogo[playerid][2]);

        defer OnTimerLoginSplashLoadAccount(playerid);
    }
    else {
        tempPlayerPosBoxMoveLoginSplash[playerid] += 0.8;
		tempPlayerSizeBoxMoveLoginSplash[playerid] += 2.0;
	}

    PlayerTextDrawSetPos(playerid, TxdLoginSplashBoxMove[playerid], tempPlayerPosBoxMoveLoginSplash[playerid], 177.0);
	PlayerTextDrawTextSize(playerid, TxdLoginSplashBoxMove[playerid], 298.500000, 96.0 - tempPlayerSizeBoxMoveLoginSplash[playerid]); // Fix
    PlayerTextDrawShow(playerid, TxdLoginSplashBoxMove[playerid]);
}

timer OnTimerLoginSplashLoadAccount[2000](playerid) {

    VSL_DestroyTextdrawsLoginSplash(playerid);
    CheckPlayerLogin(playerid);
}

//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerDisconnect(playerid, reason) {

    YSI_StopTimerSafely(tempPlayerTimerLoginSplash[playerid]);
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsLoginSplash(playerid) {

	TxdLoginSplashLogo[playerid][0] = CreatePlayerTextDraw(playerid, 340.000000, 175.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TxdLoginSplashLogo[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
	PlayerTextDrawLetterSize(playerid, TxdLoginSplashLogo[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TxdLoginSplashLogo[playerid][0], 35.750000, 46.150001);
	PlayerTextDrawSetOutline(playerid, TxdLoginSplashLogo[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TxdLoginSplashLogo[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, TxdLoginSplashLogo[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TxdLoginSplashLogo[playerid][0], -1724723969);
	PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashLogo[playerid][0], -1724724224);
	PlayerTextDrawBoxColour(playerid, TxdLoginSplashLogo[playerid][0], 255);
	PlayerTextDrawUseBox(playerid, TxdLoginSplashLogo[playerid][0], false);
	PlayerTextDrawSetProportional(playerid, TxdLoginSplashLogo[playerid][0], true);
	PlayerTextDrawSetSelectable(playerid, TxdLoginSplashLogo[playerid][0], false);
	PlayerTextDrawSetPreviewModel(playerid, TxdLoginSplashLogo[playerid][0], 642);
	PlayerTextDrawSetPreviewRot(playerid, TxdLoginSplashLogo[playerid][0], -10.000000, -9.000000, 0.000000, 1.000000);
	PlayerTextDrawSetPreviewVehicleColours(playerid, TxdLoginSplashLogo[playerid][0], 16, 1);

	TxdLoginSplashLogo[playerid][1] = CreatePlayerTextDraw(playerid, 276.000000, 188.000000, "Umbrella");
	PlayerTextDrawFont(playerid, TxdLoginSplashLogo[playerid][1], TEXT_DRAW_FONT_2);
	PlayerTextDrawLetterSize(playerid, TxdLoginSplashLogo[playerid][1], 0.406235, 3.704988);
	PlayerTextDrawTextSize(playerid, TxdLoginSplashLogo[playerid][1], 605.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TxdLoginSplashLogo[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TxdLoginSplashLogo[playerid][1], 1);
	PlayerTextDrawAlignment(playerid, TxdLoginSplashLogo[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TxdLoginSplashLogo[playerid][1], -245);
	PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashLogo[playerid][1], -1);
	PlayerTextDrawBoxColour(playerid, TxdLoginSplashLogo[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, TxdLoginSplashLogo[playerid][1], false);
	PlayerTextDrawSetProportional(playerid, TxdLoginSplashLogo[playerid][1], true);
	PlayerTextDrawSetSelectable(playerid, TxdLoginSplashLogo[playerid][1], false);

	TxdLoginSplashLogo[playerid][2] = CreatePlayerTextDraw(playerid, 304.000000, 210.000000, "Roleplay");
	PlayerTextDrawFont(playerid, TxdLoginSplashLogo[playerid][2], TEXT_DRAW_FONT_0);
	PlayerTextDrawLetterSize(playerid, TxdLoginSplashLogo[playerid][2], 0.395408, 1.819995);
	PlayerTextDrawTextSize(playerid, TxdLoginSplashLogo[playerid][2], 613.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, TxdLoginSplashLogo[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TxdLoginSplashLogo[playerid][2], 1);
	PlayerTextDrawAlignment(playerid, TxdLoginSplashLogo[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TxdLoginSplashLogo[playerid][2], -1724723969);
	PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashLogo[playerid][2], 255);
	PlayerTextDrawBoxColour(playerid, TxdLoginSplashLogo[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, TxdLoginSplashLogo[playerid][2], false);
	PlayerTextDrawSetProportional(playerid, TxdLoginSplashLogo[playerid][2], true);
	PlayerTextDrawSetSelectable(playerid, TxdLoginSplashLogo[playerid][2], false);

	TxdLoginSplashBoxMove[playerid] = CreatePlayerTextDraw(playerid, 324.0, 177.000000, "_");
	PlayerTextDrawFont(playerid, TxdLoginSplashBoxMove[playerid], TEXT_DRAW_FONT_1);
	PlayerTextDrawLetterSize(playerid, TxdLoginSplashBoxMove[playerid], 0.600000, 6.949985);
	PlayerTextDrawTextSize(playerid, TxdLoginSplashBoxMove[playerid], 298.500000, 96.000000);
	PlayerTextDrawSetOutline(playerid, TxdLoginSplashBoxMove[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TxdLoginSplashBoxMove[playerid], 0);
	PlayerTextDrawAlignment(playerid, TxdLoginSplashBoxMove[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TxdLoginSplashBoxMove[playerid], -1);
	PlayerTextDrawBackgroundColour(playerid, TxdLoginSplashBoxMove[playerid], 255);
	PlayerTextDrawBoxColour(playerid, TxdLoginSplashBoxMove[playerid], 255);
	PlayerTextDrawUseBox(playerid, TxdLoginSplashBoxMove[playerid], true);
	PlayerTextDrawSetProportional(playerid, TxdLoginSplashBoxMove[playerid], true);
	PlayerTextDrawSetSelectable(playerid, TxdLoginSplashBoxMove[playerid], false);
    return 1;
}

VSL_ShowTextdrawsLoginSplash(playerid) {

    tempPlayerPosBoxMoveLoginSplash[playerid] = 324.0;
	tempPlayerSizeBoxMoveLoginSplash[playerid] = 0.0;

    defer OnTimerDelayLoadingSplash(playerid);
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