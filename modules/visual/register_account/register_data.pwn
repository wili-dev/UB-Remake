//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new PlayerText:TxdScreenRegisterPlayerMenuBox[MAX_PLAYERS];
new PlayerText:TxdScreenRegisterPlayerBoxField[MAX_PLAYERS][5];
new PlayerText:TxdScreenRegisterPlayerTextField[MAX_PLAYERS][3];
new PlayerText:TxdScreenRegisterPlayerTextPassword[MAX_PLAYERS][2];
new PlayerText:TxdScreenRegisterPlayerTextPasswordConfirm[MAX_PLAYERS][2];
new PlayerText:TxdScreenRegisterPlayerButtonNext[MAX_PLAYERS][2];


//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
PlayerTextDrawClick:OnClickRegisterPlayerDateBirth(playerid, params) {

    VSL_HideTextdrawsRegisterInputField(playerid);
    ShowPlayerDialogRegisterBirthOfDate(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegisterPlayerGender(playerid, params) {

    VSL_HideTextdrawsRegisterInputField(playerid);
    ShowPlayerDialogRegisterGender(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegisterPlayerEmail(playerid, params) {

    VSL_HideTextdrawsRegisterInputField(playerid);
    ShowPlayerDialogRegisterEmail(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegisterPlayerPassword(playerid, params) {

    VSL_HideTextdrawsRegisterInputField(playerid);
    ShowPlayerDialogRegisterPassword(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegisterPlayerPassVerif(playerid, params) {

    VSL_HideTextdrawsRegisterInputField(playerid);
    ShowPlayerDialogRegisterPasswordConfirm(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegisterPlayerBtnNext(playerid, params) {

    new
        password[20 + 1],
        passwordConfirm[20 + 1];
    
    strcat(password, GetPlayerPasswordTemp(playerid)); 
    strcat(passwordConfirm, GetPlayerPasswordConfirmTemp(playerid));

    if (GetPlayerBirthDate(playerid) != '\0' && GetPlayerGender(playerid) != '\0' && strlen(GetPlayerEmail(playerid)) > 0 && !isnull(password) && !isnull(passwordConfirm)) {

        VSL_DestroyTextdrawsRegisterAccount(playerid);

        VSL_CreateTextdrawsRegisterPlayerVerification(playerid);
        VSL_TimerResendRegisterPlayerVerif(playerid, 60);
        VSL_ShowTextdrawsRegisterPlayerVerification(playerid);

        SendPlayerEmailRegisterAccount(playerid);
    }
    return 1;
}



//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsRegister(playerid) {

    TxdScreenRegisterPlayerMenuBox[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 3.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerMenuBox[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerMenuBox[playerid], 1.158331, 49.900001);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerMenuBox[playerid], 298.500000, 182.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerMenuBox[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerMenuBox[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerMenuBox[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerMenuBox[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerMenuBox[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerMenuBox[playerid], 168430335);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerMenuBox[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerMenuBox[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerMenuBox[playerid], false);

    TxdScreenRegisterPlayerBoxField[playerid][0] = CreatePlayerTextDraw(playerid, 318.000000, 174.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], 0.600000, 1.500002);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerBoxField[playerid][0], false);

    TxdScreenRegisterPlayerBoxField[playerid][1] = CreatePlayerTextDraw(playerid, 318.000000, 200.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], 0.600000, 1.500002);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerBoxField[playerid][1], false);

    TxdScreenRegisterPlayerBoxField[playerid][2] = CreatePlayerTextDraw(playerid, 318.000000, 233.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], 0.600000, 1.500002);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], -1);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerBoxField[playerid][2], false);

    TxdScreenRegisterPlayerBoxField[playerid][3] = CreatePlayerTextDraw(playerid, 318.000000, 259.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], 0.600000, 1.500002);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerBoxField[playerid][3], false);

    TxdScreenRegisterPlayerBoxField[playerid][4] = CreatePlayerTextDraw(playerid, 318.000000, 285.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], 0.600000, 1.500002);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerBoxField[playerid][4], false);

    TxdScreenRegisterPlayerTextField[playerid][0] = CreatePlayerTextDraw(playerid, 317.000000, 175.000000, "Data de Nascimento");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextField[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 8.000000, 70.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextField[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextField[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextField[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextField[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextField[playerid][0], true);

    TxdScreenRegisterPlayerTextField[playerid][1] = CreatePlayerTextDraw(playerid, 319.000000, 202.000000, "Genero");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextField[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 8.000000, 25.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextField[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextField[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextField[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextField[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextField[playerid][1], true);

    TxdScreenRegisterPlayerTextField[playerid][2] = CreatePlayerTextDraw(playerid, 318.000000, 235.000000, "Digite seu e-mail");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextField[playerid][2], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 8.000000, 58.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextField[playerid][2], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextField[playerid][2], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextField[playerid][2], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextField[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextField[playerid][2], true);


    TxdScreenRegisterPlayerTextPassword[playerid][0] = CreatePlayerTextDraw(playerid, 318.000000, 261.000000, "Digite sua senha");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 8.000000, 59.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0], true);

    TxdScreenRegisterPlayerTextPassword[playerid][1] = CreatePlayerTextDraw(playerid, 318.000000, 261.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 0.183319, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 8.000000, 59.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], true);

    TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0] = CreatePlayerTextDraw(playerid, 318.000000, 287.000000, "Confirme sua senha");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 8.000000, 70.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0], true);

    TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1] = CreatePlayerTextDraw(playerid, 318.000000, 287.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 0.183319, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 8.000000, 70.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], true);


    TxdScreenRegisterPlayerButtonNext[playerid][0] = CreatePlayerTextDraw(playerid, 318.000000, 365.000000, "_");
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], 0.600000, 1.450003);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], -1724724069);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], -1724724069); // 1724724199 // -1724723969
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], false);

    TxdScreenRegisterPlayerButtonNext[playerid][1] = CreatePlayerTextDraw(playerid, 300.000000, 365.000000, "Continuar"); // 
    PlayerTextDrawFont(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], 339.000000, 11.000000);
    PlayerTextDrawSetOutline(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], -101);
    PlayerTextDrawBackgroundColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], false);


    PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerDateBirth", TxdScreenRegisterPlayerTextField[playerid][0]);
    PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerGender", TxdScreenRegisterPlayerTextField[playerid][1]);
    PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerEmail", TxdScreenRegisterPlayerTextField[playerid][2]);

    for (new i = 0; i < 2; i++)
        PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerPassword", TxdScreenRegisterPlayerTextPassword[playerid][i], i);

    for (new i = 0; i < 2; i++)
        PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerPassVerif", TxdScreenRegisterPlayerTextPasswordConfirm[playerid][i], i);

    PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerBtnNext", TxdScreenRegisterPlayerButtonNext[playerid][1]);
    return 1;
}

VSL_ShowTextdrawsRegisterAccount(playerid) {

    PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerMenuBox[playerid]);

    for (new txd = 0; txd < 5; txd++) {
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerBoxField[playerid][txd]);
    }

    for (new txd = 0; txd < 3; txd++) {
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerTextField[playerid][txd]);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerButtonNext[playerid][txd]);
    }

    new
        password[21],
        passwordConfirm[21];
    
    strcat(password, GetPlayerPasswordTemp(playerid)); 
    strcat(passwordConfirm, GetPlayerPasswordConfirmTemp(playerid));

    if (isnull(password))
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerTextPassword[playerid][0]);
    else
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1]);

    if (isnull(passwordConfirm))
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][0]);
    else
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1]);

    if (GetPlayerBirthDate(playerid) == '\0' || GetPlayerGender(playerid) == '\0' || strlen(GetPlayerEmail(playerid)) == 0 || isnull(password) || isnull(passwordConfirm)) {

        PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], -1724724069);

        PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], -101);
        PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], false);
    }
    else {

        PlayerTextDrawBoxColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][0], -1724723969);

        PlayerTextDrawColour(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, TxdScreenRegisterPlayerButtonNext[playerid][1], true);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, TxdScreenRegisterPlayerButtonNext[playerid][txd]);
    }

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsRegisterInputField(playerid) {

    for (new txd = 0; txd < 5; txd++) {
        PlayerTextDrawHide(playerid, TxdScreenRegisterPlayerBoxField[playerid][txd]);
    }

    for (new txd = 0; txd < 3; txd++) {
        PlayerTextDrawHide(playerid, TxdScreenRegisterPlayerTextField[playerid][txd]);
    }

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawHide(playerid, TxdScreenRegisterPlayerTextPassword[playerid][txd]);
        PlayerTextDrawHide(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][txd]);

        PlayerTextDrawHide(playerid, TxdScreenRegisterPlayerButtonNext[playerid][txd]);
    }

    CancelSelectTextDraw(playerid);
    return 1;
}

VSL_UpdateTextdrawRegisterBirthDate(playerid, const birth_date[]) {
    return PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextField[playerid][0], birth_date);
}

VSL_UpdateTextdrawRegisterGender(playerid, const gender_id) {

    switch (gender_id) {

        case 0: PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextField[playerid][1], "Masculino");
        case 1: PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextField[playerid][1], "Feminino");
        case 2: PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextField[playerid][1], "Nao Binario");
    }
    return 1;
}

VSL_UpdateTextdrawRegisterEmail(playerid, const email[]) {
    return PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextField[playerid][2], email);
}

VSL_UpdateTextdrawRegisterPassword(playerid, const password[]) {
    return PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextPassword[playerid][1], GetFormatPasswordTextdraw(password));
}

VSL_UpdateTextdrawRegisterPasswordConfirm(playerid, const password[]) {
    return PlayerTextDrawSetString(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][1], GetFormatPasswordTextdraw(password));
}

VSL_DestroyTextdrawsRegisterAccount(playerid) {

    PlayerTextDrawDestroy(playerid, TxdScreenRegisterPlayerMenuBox[playerid]);
    TxdScreenRegisterPlayerMenuBox[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 3; txd++) {

        PlayerTextDrawDestroy(playerid, TxdScreenRegisterPlayerTextField[playerid][txd]);
        TxdScreenRegisterPlayerTextField[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    for (new txd = 0; txd < 5; txd++) {

        PlayerTextDrawDestroy(playerid, TxdScreenRegisterPlayerBoxField[playerid][txd]);
        TxdScreenRegisterPlayerBoxField[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }


    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, TxdScreenRegisterPlayerTextPassword[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdScreenRegisterPlayerTextPasswordConfirm[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdScreenRegisterPlayerButtonNext[playerid][txd]);

        TxdScreenRegisterPlayerTextPassword[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdScreenRegisterPlayerTextPasswordConfirm[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdScreenRegisterPlayerButtonNext[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    CancelSelectTextDraw(playerid);
    return 1;
}