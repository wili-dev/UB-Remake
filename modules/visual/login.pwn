//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new PlayerText:TxdLoginLayoutFieldUser[MAX_PLAYERS][3];
new PlayerText:TxdLoginLayoutFieldPass[MAX_PLAYERS][3];
new PlayerText:TxdLoginTextFieldUser[MAX_PLAYERS];
new PlayerText:TxdLoginTextFieldPass[MAX_PLAYERS][2];
new PlayerText:TxdButtonLogin[MAX_PLAYERS][2];
new PlayerText:TxdButtonForgotPass[MAX_PLAYERS];


//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {

    if (!IsPlayerLogged(playerid)) {

        if (playertextid == TxdLoginTextFieldPass[playerid][0] || playertextid == TxdLoginTextFieldPass[playerid][1]) {
            return ShowPlayerDialogLogin(playerid);
        }
    }
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsLogin(playerid) {

    SHARED_CreateTextdrawLoginLogo(playerid);


    TxdLoginLayoutFieldUser[playerid][0] = CreatePlayerTextDraw(playerid, 314.000000, 193.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginLayoutFieldUser[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginLayoutFieldUser[playerid][0], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdLoginLayoutFieldUser[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLayoutFieldUser[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLayoutFieldUser[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLayoutFieldUser[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginLayoutFieldUser[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLayoutFieldUser[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLayoutFieldUser[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, TxdLoginLayoutFieldUser[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLayoutFieldUser[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLayoutFieldUser[playerid][0], false);

    TxdLoginLayoutFieldUser[playerid][1] = CreatePlayerTextDraw(playerid, 264.000000, 193.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginLayoutFieldUser[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginLayoutFieldUser[playerid][1], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdLoginLayoutFieldUser[playerid][1], 298.500000, 18.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLayoutFieldUser[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLayoutFieldUser[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLayoutFieldUser[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginLayoutFieldUser[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLayoutFieldUser[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLayoutFieldUser[playerid][1], 1747094527);
    PlayerTextDrawUseBox(playerid, TxdLoginLayoutFieldUser[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLayoutFieldUser[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLayoutFieldUser[playerid][1], false);

    TxdLoginLayoutFieldUser[playerid][2] = CreatePlayerTextDraw(playerid, 254.000000, 190.000000, "LD_OTB2:Ric4");
    PlayerTextDrawFont(playerid, TxdLoginLayoutFieldUser[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginLayoutFieldUser[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginLayoutFieldUser[playerid][2], 20.000000, 24.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLayoutFieldUser[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLayoutFieldUser[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLayoutFieldUser[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLayoutFieldUser[playerid][2], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLayoutFieldUser[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLayoutFieldUser[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginLayoutFieldUser[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLayoutFieldUser[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLayoutFieldUser[playerid][2], false);


    TxdLoginLayoutFieldPass[playerid][0] = CreatePlayerTextDraw(playerid, 314.000000, 222.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginLayoutFieldPass[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginLayoutFieldPass[playerid][0], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdLoginLayoutFieldPass[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLayoutFieldPass[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLayoutFieldPass[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLayoutFieldPass[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginLayoutFieldPass[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLayoutFieldPass[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLayoutFieldPass[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, TxdLoginLayoutFieldPass[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLayoutFieldPass[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLayoutFieldPass[playerid][0], false);

    TxdLoginLayoutFieldPass[playerid][1] = CreatePlayerTextDraw(playerid, 264.000000, 222.000000, "_");
    PlayerTextDrawFont(playerid, TxdLoginLayoutFieldPass[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdLoginLayoutFieldPass[playerid][1], 0.600000, 2.000003);
    PlayerTextDrawTextSize(playerid, TxdLoginLayoutFieldPass[playerid][1], 298.500000, 18.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLayoutFieldPass[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLayoutFieldPass[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLayoutFieldPass[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdLoginLayoutFieldPass[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLayoutFieldPass[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLayoutFieldPass[playerid][1], 1747094527);
    PlayerTextDrawUseBox(playerid, TxdLoginLayoutFieldPass[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLayoutFieldPass[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLayoutFieldPass[playerid][1], false);

    TxdLoginLayoutFieldPass[playerid][2] = CreatePlayerTextDraw(playerid, 256.000000, 224.000000, "HUD:radar_mafiacasino");
    PlayerTextDrawFont(playerid, TxdLoginLayoutFieldPass[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdLoginLayoutFieldPass[playerid][2], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdLoginLayoutFieldPass[playerid][2], 15.000000, 15.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginLayoutFieldPass[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, TxdLoginLayoutFieldPass[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginLayoutFieldPass[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginLayoutFieldPass[playerid][2], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginLayoutFieldPass[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, TxdLoginLayoutFieldPass[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, TxdLoginLayoutFieldPass[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, TxdLoginLayoutFieldPass[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginLayoutFieldPass[playerid][2], false);


    TxdLoginTextFieldUser[playerid] = CreatePlayerTextDraw(playerid, 280.000000, 195.000000, "Wili_Macena");
    PlayerTextDrawFont(playerid, TxdLoginTextFieldUser[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdLoginTextFieldUser[playerid], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdLoginTextFieldUser[playerid], 373.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginTextFieldUser[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginTextFieldUser[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginTextFieldUser[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginTextFieldUser[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginTextFieldUser[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginTextFieldUser[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdLoginTextFieldUser[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginTextFieldUser[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginTextFieldUser[playerid], false);

    TxdLoginTextFieldPass[playerid][0] = CreatePlayerTextDraw(playerid, 280.000000, 224.000000, "Digite sua senha");
    PlayerTextDrawFont(playerid, TxdLoginTextFieldPass[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdLoginTextFieldPass[playerid][0], 0.174998, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdLoginTextFieldPass[playerid][0], 373.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginTextFieldPass[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginTextFieldPass[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginTextFieldPass[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginTextFieldPass[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginTextFieldPass[playerid][0], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginTextFieldPass[playerid][0], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdLoginTextFieldPass[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginTextFieldPass[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginTextFieldPass[playerid][0], true);

    TxdLoginTextFieldPass[playerid][1] = CreatePlayerTextDraw(playerid, 280.000000, 224.000000, "]]]]]]]]]]]]");
    PlayerTextDrawFont(playerid, TxdLoginTextFieldPass[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdLoginTextFieldPass[playerid][1], 0.220831, 1.349995);
    PlayerTextDrawTextSize(playerid, TxdLoginTextFieldPass[playerid][1], 373.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdLoginTextFieldPass[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdLoginTextFieldPass[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdLoginTextFieldPass[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdLoginTextFieldPass[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdLoginTextFieldPass[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdLoginTextFieldPass[playerid][1], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdLoginTextFieldPass[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdLoginTextFieldPass[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdLoginTextFieldPass[playerid][1], true);


    TxdButtonLogin[playerid][0] = CreatePlayerTextDraw(playerid, 314.000000, 290.000000, "_");
    PlayerTextDrawFont(playerid, TxdButtonLogin[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdButtonLogin[playerid][0], 0.600000, 3.000000);
    PlayerTextDrawTextSize(playerid, TxdButtonLogin[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdButtonLogin[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdButtonLogin[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdButtonLogin[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdButtonLogin[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdButtonLogin[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdButtonLogin[playerid][0], 1747094527);
    PlayerTextDrawUseBox(playerid, TxdButtonLogin[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdButtonLogin[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdButtonLogin[playerid][0], false);

    TxdButtonLogin[playerid][1] = CreatePlayerTextDraw(playerid, 282.000000, 294.000000, "Fazer Login");
    PlayerTextDrawFont(playerid, TxdButtonLogin[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdButtonLogin[playerid][1], 0.349999, 1.899999);
    PlayerTextDrawTextSize(playerid, TxdButtonLogin[playerid][1], 348.000000, 16.000000);
    PlayerTextDrawSetOutline(playerid, TxdButtonLogin[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdButtonLogin[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdButtonLogin[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdButtonLogin[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdButtonLogin[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdButtonLogin[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, TxdButtonLogin[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdButtonLogin[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdButtonLogin[playerid][1], true);


    TxdButtonForgotPass[playerid] = CreatePlayerTextDraw(playerid, 278.000000, 349.000000, "Esqueci minha senha");
    PlayerTextDrawFont(playerid, TxdButtonForgotPass[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdButtonForgotPass[playerid], 0.162496, 1.199995);
    PlayerTextDrawTextSize(playerid, TxdButtonForgotPass[playerid], 353.500000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdButtonForgotPass[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdButtonForgotPass[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdButtonForgotPass[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdButtonForgotPass[playerid], 1296911871);
    PlayerTextDrawBackgroundColour(playerid, TxdButtonForgotPass[playerid], -1);
    PlayerTextDrawBoxColour(playerid, TxdButtonForgotPass[playerid], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdButtonForgotPass[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdButtonForgotPass[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdButtonForgotPass[playerid], true);
    return 1;
}

VSL_ShowTextdrawsLogin(playerid) {

    SHARED_ShowTextdrawLoginLogo(playerid);

    PlayerTextDrawShow(playerid, TxdLoginTextFieldUser[playerid]);
    PlayerTextDrawShow(playerid, TxdLoginTextFieldPass[playerid][0]);
    PlayerTextDrawShow(playerid, TxdButtonForgotPass[playerid]);

    for (new txd = 0; txd < 3; txd++) {

        PlayerTextDrawShow(playerid, TxdLoginLayoutFieldUser[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdLoginLayoutFieldPass[playerid][txd]);
    }

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawShow(playerid, TxdButtonLogin[playerid][txd]);
    }

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsLoginInputPass(playerid) {

    PlayerTextDrawHide(playerid, TxdLoginTextFieldUser[playerid]);
    PlayerTextDrawHide(playerid, TxdButtonForgotPass[playerid]);

    for (new txd = 0; txd < 3; txd++) {

        PlayerTextDrawHide(playerid, TxdLoginLayoutFieldUser[playerid][txd]);
        PlayerTextDrawHide(playerid, TxdLoginLayoutFieldPass[playerid][txd]);
    }

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawHide(playerid, TxdLoginTextFieldPass[playerid][txd]);
        PlayerTextDrawHide(playerid, TxdButtonLogin[playerid][txd]);
    }

    CancelSelectTextDraw(playerid);
    return 1;
}

VSL_DestroyTextdrawsLogin(playerid) {

    SHARED_DestroyTextdrawLoginBackground(playerid);
    SHARED_DestroyTextdrawLoginLogo(playerid);

    PlayerTextDrawDestroy(playerid, TxdLoginTextFieldUser[playerid]);
    PlayerTextDrawDestroy(playerid, TxdButtonForgotPass[playerid]);

    TxdLoginTextFieldUser[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    TxdButtonForgotPass[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 3; txd++) {

        PlayerTextDrawDestroy(playerid, TxdLoginLayoutFieldUser[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdLoginLayoutFieldPass[playerid][txd]);

        TxdLoginLayoutFieldUser[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdLoginLayoutFieldPass[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, TxdLoginTextFieldPass[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdButtonLogin[playerid][txd]);

        TxdLoginTextFieldPass[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdButtonLogin[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    CancelSelectTextDraw(playerid);
    return 1;
}