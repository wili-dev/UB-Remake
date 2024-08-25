//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new bool:tempPlayerTxdRegisterButtonEnable[MAX_PLAYERS];

new PlayerText:TxdRegisterLayoutFieldDateOfBirth[MAX_PLAYERS];
new PlayerText:TxdRegisterLayoutFieldGender[MAX_PLAYERS];
new PlayerText:TxdRegisterLayoutFieldEmail[MAX_PLAYERS];
new PlayerText:TxdRegisterLayoutFieldPassword[MAX_PLAYERS];
new PlayerText:TxdRegisterLayoutFieldPasswordConfirm[MAX_PLAYERS];

new PlayerText:TxdRegisterTextDateOfBirth[MAX_PLAYERS];
new PlayerText:TxdRegisterTextGender[MAX_PLAYERS];
new PlayerText:TxdRegisterTextEmail[MAX_PLAYERS];
new PlayerText:TxdRegisterTextPassword[MAX_PLAYERS][2];
new PlayerText:TxdRegisterTextPasswordConfirm[MAX_PLAYERS][2];

new PlayerText:TxdRegisterButtonRegister[MAX_PLAYERS][2];


//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    tempPlayerTxdRegisterButtonEnable[playerid] = false;
    return 1;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {

    if (!IsPlayerLogged(playerid)) {

        if (playertextid == TxdRegisterTextDateOfBirth[playerid]) {
            return ShowPlayerDialogRegisterBirthDate(playerid, 1);
        }

        if (playertextid == TxdRegisterTextGender[playerid]) {
            return ShowPlayerDialogRegisterGender(playerid);
        }

        if (playertextid == TxdRegisterTextEmail[playerid]) {
            return ShowPlayerDialogRegisterEmail(playerid);
        }

        if (playertextid == TxdRegisterTextPassword[playerid][0] || playertextid == TxdRegisterTextPassword[playerid][1]) {
            return ShowPlayerDialogRegisterPassword(playerid, 1);
        }

        if (playertextid == TxdRegisterTextPasswordConfirm[playerid][0] || playertextid == TxdRegisterTextPasswordConfirm[playerid][1]) {
            return ShowPlayerDialogRegisterPassword(playerid, 2);
        }

        if (playertextid == TxdRegisterButtonRegister[playerid][1]) {

            if (GetPlayerBirthDate(playerid) != '\0' && GetPlayerGender(playerid) != '\0' && strlen(GetPlayerEmail(playerid)) > 0
            && !isnull(tempPlayerPassword[playerid]) && !isnull(tempPlayerPasswordConfirm[playerid])) {

                VSL_DestroyTextdrawsRegisterData(playerid);

                VSL_CreateTextdrawsRegisterEmailCode(playerid);
                VSL_ShowTextdrawsRegisterEmailCode(playerid);

                createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "Enviamos um codigo para seu e-mail", _, 0x202020FF);
                // bcrypt_hash(playerid, "OnEncryptPasswordRegister", tempPlayerPassword[playerid], BCRYPT_COST);
            }
            return 1;
        }
    }
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsRegister(playerid) {

    SHARED_CreateTextdrawLoginLogo(playerid);


    TxdRegisterLayoutFieldDateOfBirth[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 202.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid], false);

    TxdRegisterLayoutFieldGender[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 231.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterLayoutFieldGender[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterLayoutFieldGender[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterLayoutFieldGender[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterLayoutFieldGender[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterLayoutFieldGender[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterLayoutFieldGender[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterLayoutFieldGender[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterLayoutFieldGender[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterLayoutFieldGender[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterLayoutFieldGender[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterLayoutFieldGender[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterLayoutFieldGender[playerid], false);

    TxdRegisterLayoutFieldEmail[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 270.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterLayoutFieldEmail[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterLayoutFieldEmail[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterLayoutFieldEmail[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterLayoutFieldEmail[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterLayoutFieldEmail[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterLayoutFieldEmail[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterLayoutFieldEmail[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterLayoutFieldEmail[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterLayoutFieldEmail[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterLayoutFieldEmail[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterLayoutFieldEmail[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterLayoutFieldEmail[playerid], false);

    TxdRegisterLayoutFieldPassword[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 299.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterLayoutFieldPassword[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterLayoutFieldPassword[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterLayoutFieldPassword[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterLayoutFieldPassword[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterLayoutFieldPassword[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterLayoutFieldPassword[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterLayoutFieldPassword[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterLayoutFieldPassword[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterLayoutFieldPassword[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterLayoutFieldPassword[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterLayoutFieldPassword[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterLayoutFieldPassword[playerid], false);

    TxdRegisterLayoutFieldPasswordConfirm[playerid] = CreatePlayerTextDraw(playerid, 314.000000, 328.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid], false);



    TxdRegisterTextDateOfBirth[playerid] = CreatePlayerTextDraw(playerid, 312.000000, 204.000000, "Data de Nascimento");
    PlayerTextDrawFont(playerid, TxdRegisterTextDateOfBirth[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextDateOfBirth[playerid], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextDateOfBirth[playerid], 12.000000, 120.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextDateOfBirth[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextDateOfBirth[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextDateOfBirth[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterTextDateOfBirth[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextDateOfBirth[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextDateOfBirth[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextDateOfBirth[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextDateOfBirth[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextDateOfBirth[playerid], true);

    TxdRegisterTextGender[playerid] = CreatePlayerTextDraw(playerid, 313.000000, 233.000000, "Genero");
    PlayerTextDrawFont(playerid, TxdRegisterTextGender[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextGender[playerid], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextGender[playerid], 12.000000, 122.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextGender[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextGender[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextGender[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterTextGender[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextGender[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextGender[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextGender[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextGender[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextGender[playerid], true);

    TxdRegisterTextEmail[playerid] = CreatePlayerTextDraw(playerid, 313.000000, 272.000000, "Digite seu e-mail");
    PlayerTextDrawFont(playerid, TxdRegisterTextEmail[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextEmail[playerid], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextEmail[playerid], 12.000000, 120.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextEmail[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextEmail[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextEmail[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterTextEmail[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextEmail[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextEmail[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextEmail[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextEmail[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextEmail[playerid], true);


    TxdRegisterTextPassword[playerid][0] = CreatePlayerTextDraw(playerid, 282.000000, 301.000000, "Digite sua senha");
    PlayerTextDrawFont(playerid, TxdRegisterTextPassword[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextPassword[playerid][0], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextPassword[playerid][0], 373.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextPassword[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextPassword[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextPassword[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterTextPassword[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextPassword[playerid][0], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextPassword[playerid][0], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextPassword[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextPassword[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextPassword[playerid][0], true);

    TxdRegisterTextPassword[playerid][1] = CreatePlayerTextDraw(playerid, 313.000000, 301.000000, "]]]]]]]]]]]]");
    PlayerTextDrawFont(playerid, TxdRegisterTextPassword[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextPassword[playerid][1], 0.219999, 1.249994);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextPassword[playerid][1], 14.000000, 122.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextPassword[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextPassword[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextPassword[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterTextPassword[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextPassword[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextPassword[playerid][1], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextPassword[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextPassword[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextPassword[playerid][1], true);

    TxdRegisterTextPasswordConfirm[playerid][0] = CreatePlayerTextDraw(playerid, 275.000000, 330.000000, "Confirme sua senha");
    PlayerTextDrawFont(playerid, TxdRegisterTextPasswordConfirm[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextPasswordConfirm[playerid][0], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextPasswordConfirm[playerid][0], 373.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextPasswordConfirm[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextPasswordConfirm[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextPasswordConfirm[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterTextPasswordConfirm[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextPasswordConfirm[playerid][0], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextPasswordConfirm[playerid][0], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextPasswordConfirm[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextPasswordConfirm[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextPasswordConfirm[playerid][0], true);

    TxdRegisterTextPasswordConfirm[playerid][1] = CreatePlayerTextDraw(playerid, 313.000000, 330.000000, "]]]]]]]]]]]]");
    PlayerTextDrawFont(playerid, TxdRegisterTextPasswordConfirm[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterTextPasswordConfirm[playerid][1], 0.219999, 1.249994);
    PlayerTextDrawTextSize(playerid, TxdRegisterTextPasswordConfirm[playerid][1], 14.000000, 122.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterTextPasswordConfirm[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterTextPasswordConfirm[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterTextPasswordConfirm[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterTextPasswordConfirm[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterTextPasswordConfirm[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdRegisterTextPasswordConfirm[playerid][1], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdRegisterTextPasswordConfirm[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterTextPasswordConfirm[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterTextPasswordConfirm[playerid][1], true);



    TxdRegisterButtonRegister[playerid][0] = CreatePlayerTextDraw(playerid, 314.000000, 375.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterButtonRegister[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterButtonRegister[playerid][0], 0.600000, 3.000000);
    PlayerTextDrawTextSize(playerid, TxdRegisterButtonRegister[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterButtonRegister[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterButtonRegister[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterButtonRegister[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterButtonRegister[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterButtonRegister[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterButtonRegister[playerid][0], 1296911871);
    PlayerTextDrawUseBox(playerid, TxdRegisterButtonRegister[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterButtonRegister[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterButtonRegister[playerid][0], false);

    TxdRegisterButtonRegister[playerid][1] = CreatePlayerTextDraw(playerid, 282.000000, 379.000000, "Continuar");
    PlayerTextDrawFont(playerid, TxdRegisterButtonRegister[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdRegisterButtonRegister[playerid][1], 0.349999, 1.899999);
    PlayerTextDrawTextSize(playerid, TxdRegisterButtonRegister[playerid][1], 348.000000, 16.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterButtonRegister[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterButtonRegister[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterButtonRegister[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterButtonRegister[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterButtonRegister[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterButtonRegister[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, TxdRegisterButtonRegister[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterButtonRegister[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterButtonRegister[playerid][1], false);
    return 1;
}

VSL_ShowTextdrawsRegister(playerid) {

    SHARED_ShowTextdrawLoginLogo(playerid);

    PlayerTextDrawShow(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterLayoutFieldGender[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterLayoutFieldEmail[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterLayoutFieldPassword[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterTextDateOfBirth[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterTextGender[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterTextEmail[playerid]);

    if (isnull(tempPlayerPassword[playerid]))
        PlayerTextDrawShow(playerid, TxdRegisterTextPassword[playerid][0]);
    else
        PlayerTextDrawShow(playerid, TxdRegisterTextPassword[playerid][1]);

    if (isnull(tempPlayerPasswordConfirm[playerid]))
        PlayerTextDrawShow(playerid, TxdRegisterTextPasswordConfirm[playerid][0]);
    else
        PlayerTextDrawShow(playerid, TxdRegisterTextPasswordConfirm[playerid][1]);

    if (GetPlayerBirthDate(playerid) == '\0' || GetPlayerGender(playerid) == '\0' || strlen(GetPlayerEmail(playerid)) == 0
    || isnull(tempPlayerPassword[playerid]) || isnull(tempPlayerPasswordConfirm[playerid])) {

        PlayerTextDrawBoxColour(playerid, TxdRegisterButtonRegister[playerid][0], 505290495);

        PlayerTextDrawColour(playerid, TxdRegisterButtonRegister[playerid][1], 1347440895);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterButtonRegister[playerid][1], false);
    }
    else {

        PlayerTextDrawBoxColour(playerid, TxdRegisterButtonRegister[playerid][0], 1747094527);

        PlayerTextDrawColour(playerid, TxdRegisterButtonRegister[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterButtonRegister[playerid][1], true);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, TxdRegisterButtonRegister[playerid][txd]);
    }

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsRegisterInputField(playerid) {

    PlayerTextDrawHide(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterLayoutFieldGender[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterLayoutFieldEmail[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterLayoutFieldPassword[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterTextDateOfBirth[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterTextGender[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterTextEmail[playerid]);

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawHide(playerid, TxdRegisterButtonRegister[playerid][txd]);

        PlayerTextDrawHide(playerid, TxdRegisterTextPassword[playerid][txd]);
        PlayerTextDrawHide(playerid, TxdRegisterTextPasswordConfirm[playerid][txd]);
    }

    CancelSelectTextDraw(playerid);
    return 1;
}

VSL_UpdateTextdrawRegisterBirthDate(playerid, const birth_date[]) {
    return PlayerTextDrawSetString(playerid, TxdRegisterTextDateOfBirth[playerid], birth_date);
}

VSL_UpdateTextdrawRegisterGender(playerid, const gender_id) {

    switch (gender_id) {

        case 0: PlayerTextDrawSetString(playerid, TxdRegisterTextGender[playerid], "Masculino");
        case 1: PlayerTextDrawSetString(playerid, TxdRegisterTextGender[playerid], "Feminino");
        case 2: PlayerTextDrawSetString(playerid, TxdRegisterTextGender[playerid], "Nao Binario");
    }
    return 1;
}

VSL_UpdateTextdrawRegisterEmail(playerid, const email[]) {
    return PlayerTextDrawSetString(playerid, TxdRegisterTextEmail[playerid], email);
}

VSL_UpdateTextdrawRegisterPassword(playerid, const password[]) {
    return PlayerTextDrawSetString(playerid, TxdRegisterTextPassword[playerid][1], GetFormatPasswordTextdraw(password));
}

VSL_UpdateTextdrawRegisterPasswordConfirm(playerid, const password[]) {
    return PlayerTextDrawSetString(playerid, TxdRegisterTextPasswordConfirm[playerid][1], GetFormatPasswordTextdraw(password));
}

VSL_DestroyTextdrawsRegisterData(playerid) {

    PlayerTextDrawDestroy(playerid, TxdRegisterLayoutFieldDateOfBirth[playerid]);
    TxdRegisterLayoutFieldDateOfBirth[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterLayoutFieldGender[playerid]);
    TxdRegisterLayoutFieldGender[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterLayoutFieldEmail[playerid]);
    TxdRegisterLayoutFieldEmail[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterLayoutFieldPassword[playerid]);
    TxdRegisterLayoutFieldPassword[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterLayoutFieldPasswordConfirm[playerid]);
    TxdRegisterLayoutFieldPasswordConfirm[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterTextDateOfBirth[playerid]);
    TxdRegisterTextDateOfBirth[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterTextGender[playerid]);
    TxdRegisterTextGender[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterTextEmail[playerid]);
    TxdRegisterTextEmail[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, TxdRegisterTextPassword[playerid][txd]);
        TxdRegisterTextPassword[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

        PlayerTextDrawDestroy(playerid, TxdRegisterTextPasswordConfirm[playerid][txd]);
        TxdRegisterTextPasswordConfirm[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

        PlayerTextDrawDestroy(playerid, TxdRegisterButtonRegister[playerid][txd]);
        TxdRegisterButtonRegister[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    return 1;
}