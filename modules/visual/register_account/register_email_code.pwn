//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new bool:tempPlayerTxdRegisterEmailCodeButtonEnable[MAX_PLAYERS];

new PlayerText:TxdRegisterCodeLayoutFieldEmail[MAX_PLAYERS];
new PlayerText:TxdRegisterCodeLayoutFieldCode[MAX_PLAYERS];

new PlayerText:TxdRegisterCodeTextEmail[MAX_PLAYERS];
new PlayerText:TxdRegisterCodeTextCode[MAX_PLAYERS];

new PlayerText:TxdRegisterCodeButtonRegister[MAX_PLAYERS][2];
new PlayerText:TxdRegisterCodeButtonResendCode[MAX_PLAYERS];

//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    tempPlayerTxdRegisterEmailCodeButtonEnable[playerid] = false;
    return 1;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {

    if (!IsPlayerLogged(playerid)) {

        if (playertextid == TxdRegisterCodeTextCode[playerid]) {

            VSL_HideTextdrawsRegisterEmailCode(playerid);
            ShowPlayerDialogRegisterEmailCode(playerid);
        }
        else if (playertextid == TxdRegisterCodeButtonRegister[playerid][1]) {

            SHARED_DestroyTextdrawLoginLogo(playerid);
            VSL_DestroyTextdrawsRegisterEmailCode(playerid);

            VSL_CreateTextdrawsCharacterModes(playerid);
            VSL_ShowTextdrawsModeCharacterModes(playerid);
        }
    }
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsRegisterEmailCode(playerid) {

    TxdRegisterCodeLayoutFieldEmail[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 193.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeLayoutFieldEmail[playerid], false);

    TxdRegisterCodeLayoutFieldCode[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 222.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterCodeLayoutFieldCode[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeLayoutFieldCode[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeLayoutFieldCode[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeLayoutFieldCode[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeLayoutFieldCode[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeLayoutFieldCode[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterCodeLayoutFieldCode[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeLayoutFieldCode[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeLayoutFieldCode[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeLayoutFieldCode[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeLayoutFieldCode[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeLayoutFieldCode[playerid], false);



    TxdRegisterCodeTextEmail[playerid] = CreatePlayerTextDraw(playerid, 270.000000, 195.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterCodeTextEmail[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeTextEmail[playerid], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeTextEmail[playerid], 373.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeTextEmail[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeTextEmail[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeTextEmail[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterCodeTextEmail[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeTextEmail[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeTextEmail[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeTextEmail[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeTextEmail[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeTextEmail[playerid], false);



    TxdRegisterCodeTextCode[playerid] = CreatePlayerTextDraw(playerid, 267.000000, 224.000000, "Codigo de verificacao");
    PlayerTextDrawFont(playerid, TxdRegisterCodeTextCode[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeTextCode[playerid], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeTextCode[playerid], 395.500000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeTextCode[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeTextCode[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeTextCode[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterCodeTextCode[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeTextCode[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeTextCode[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeTextCode[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeTextCode[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeTextCode[playerid], true);



    TxdRegisterCodeButtonRegister[playerid][0] = CreatePlayerTextDraw(playerid, 314.000000, 290.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterCodeButtonRegister[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeButtonRegister[playerid][0], 0.600000, 3.000000);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeButtonRegister[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeButtonRegister[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeButtonRegister[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeButtonRegister[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterCodeButtonRegister[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeButtonRegister[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeButtonRegister[playerid][0], 1747094527);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeButtonRegister[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeButtonRegister[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeButtonRegister[playerid][0], false);

    TxdRegisterCodeButtonRegister[playerid][1] = CreatePlayerTextDraw(playerid, 279.000000, 294.000000, "Criar conta");
    PlayerTextDrawFont(playerid, TxdRegisterCodeButtonRegister[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeButtonRegister[playerid][1], 0.349999, 1.899999);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeButtonRegister[playerid][1], 351.500000, 16.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeButtonRegister[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeButtonRegister[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeButtonRegister[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterCodeButtonRegister[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeButtonRegister[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeButtonRegister[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeButtonRegister[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeButtonRegister[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeButtonRegister[playerid][1], true);



    TxdRegisterCodeButtonResendCode[playerid] = CreatePlayerTextDraw(playerid, 316.000000, 342.000000, "Reenviar Codigo");
    PlayerTextDrawFont(playerid, TxdRegisterCodeButtonResendCode[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterCodeButtonResendCode[playerid], 0.162496, 1.199995);
    PlayerTextDrawTextSize(playerid, TxdRegisterCodeButtonResendCode[playerid], 11.000000, 60.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterCodeButtonResendCode[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterCodeButtonResendCode[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterCodeButtonResendCode[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterCodeButtonResendCode[playerid], -1061109505);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterCodeButtonResendCode[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterCodeButtonResendCode[playerid], 1296911666);
    PlayerTextDrawUseBox(playerid, TxdRegisterCodeButtonResendCode[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterCodeButtonResendCode[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeButtonResendCode[playerid], true);
    return 1;
}

VSL_ShowTextdrawsRegisterEmailCode(playerid) {

    PlayerTextDrawShow(playerid, TxdRegisterCodeLayoutFieldEmail[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterCodeLayoutFieldCode[playerid]);

    PlayerTextDrawSetString(playerid, TxdRegisterCodeTextEmail[playerid], GetPlayerEmail(playerid));
    PlayerTextDrawShow(playerid, TxdRegisterCodeTextEmail[playerid]);

    PlayerTextDrawShow(playerid, TxdRegisterCodeTextCode[playerid]);


    if (tempPlayerTxdRegisterEmailCodeButtonEnable[playerid]) {

        PlayerTextDrawBoxColour(playerid, TxdRegisterCodeButtonRegister[playerid][0], 1747094527);

        PlayerTextDrawColour(playerid, TxdRegisterCodeButtonRegister[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeButtonRegister[playerid][1], true);
    }
    else {

        PlayerTextDrawBoxColour(playerid, TxdRegisterCodeButtonRegister[playerid][0], 505290495);

        PlayerTextDrawColour(playerid, TxdRegisterCodeButtonRegister[playerid][1], 1347440895);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterCodeButtonRegister[playerid][1], false);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, TxdRegisterCodeButtonRegister[playerid][txd]);
    }
    return 1;
}

VSL_HideTextdrawsRegisterEmailCode(playerid) {

    PlayerTextDrawHide(playerid, TxdRegisterCodeLayoutFieldEmail[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterCodeLayoutFieldCode[playerid]);

    PlayerTextDrawSetString(playerid, TxdRegisterCodeTextEmail[playerid], GetPlayerEmail(playerid));
    PlayerTextDrawHide(playerid, TxdRegisterCodeTextEmail[playerid]);

    PlayerTextDrawHide(playerid, TxdRegisterCodeTextCode[playerid]);

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawHide(playerid, TxdRegisterCodeButtonRegister[playerid][txd]);
    }

    PlayerTextDrawHide(playerid, TxdRegisterCodeButtonResendCode[playerid]);
    return 1;
}

VSL_DestroyTextdrawsRegisterEmailCode(playerid) {

    PlayerTextDrawDestroy(playerid, TxdRegisterCodeLayoutFieldEmail[playerid]);
    TxdRegisterCodeLayoutFieldEmail[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterCodeLayoutFieldCode[playerid]);
    TxdRegisterCodeLayoutFieldCode[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterCodeTextEmail[playerid]);
    TxdRegisterCodeTextEmail[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterCodeTextCode[playerid]);
    TxdRegisterCodeTextCode[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, TxdRegisterCodeButtonRegister[playerid][txd]);
        TxdRegisterCodeButtonRegister[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    PlayerTextDrawDestroy(playerid, TxdRegisterCodeButtonResendCode[playerid]);
    TxdRegisterCodeButtonResendCode[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    CancelSelectTextDraw(playerid);
    return 1;
}

VSL_UpdateTextdrawRegisterEmailCode(playerid, const input_code[]) {

    tempPlayerTxdRegisterEmailCodeButtonEnable[playerid] = strlen(input_code) > 0 ? true : false;

    PlayerTextDrawSetString(playerid, TxdRegisterCodeTextCode[playerid], input_code);
    return 1;
}