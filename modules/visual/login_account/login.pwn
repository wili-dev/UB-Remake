/*======================================================================================================================
                          _  _    __     __         _       _     _      _         _  _   
                        _| || |_  \ \   / /_ _ _ __(_) __ _| |__ | | ___( )___   _| || |_ 
                       |_  ..  _|  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \// __| |_  ..  _|
                       |_      _|   \ V / (_| | |  | | (_| | |_) | |  __/ \__ \ |_      _|
                         |_||_|      \_/ \__,_|_|  |_|\__,_|_.__/|_|\___| |___/   |_||_|  

======================================================================================================================*/

static PlayerText:m_screenLayoutBoxMenu[MAX_PLAYERS];

static PlayerText:m_screenLayoutLogo[MAX_PLAYERS][3];

static PlayerText:m_screenLayoutFieldUser[MAX_PLAYERS][3];
static PlayerText:m_screenLayoutFieldPass[MAX_PLAYERS][3];

static PlayerText:m_screenTextFieldUser[MAX_PLAYERS];
static PlayerText:m_screenTextFieldPass[MAX_PLAYERS][2];

static PlayerText:m_screenButtonForgotPass[MAX_PLAYERS];

static PlayerText:m_screenButtonLogin[MAX_PLAYERS][2];



/*======================================================================================================================
                           _  _      ____      _ _ _                _    _         _  _   
                         _| || |_   / ___|__ _| | | |__   __ _  ___| | _( )___   _| || |_ 
                        |_  ..  _| | |   / _` | | | '_ \ / _` |/ __| |/ /// __| |_  ..  _|
                        |_      _| | |__| (_| | | | |_) | (_| | (__|   <  \__ \ |_      _|
                          |_||_|    \____\__,_|_|_|_.__/ \__,_|\___|_|\_\ |___/   |_||_|  

======================================================================================================================*/

PlayerTextDrawClick:OnClickTextFieldPassLogin(playerid, params) {

    VSL_HideTextdrawsLoginInputPass(playerid);

    ShowPlayerDialogLogin(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickButtonScreenLogin(playerid, params) {

    new
        password[20 + 1];
    
    GetPVarString(playerid, "temp_password_login", password);

    bcrypt_verify(playerid, "BcryptCheckPasswordLogin", password, GetPlayerPassword(playerid));
    return 1;
}




/*======================================================================================================================
                        _  _     _____                 _   _             _         _  _   
                      _| || |_  |  ___|   _ _ __   ___| |_(_) ___  _ __ ( )___   _| || |_ 
                     |_  ..  _| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \|// __| |_  ..  _|
                     |_      _| |  _|| |_| | | | | (__| |_| | (_) | | | | \__ \ |_      _|
                       |_||_|   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_| |___/   |_||_|  

======================================================================================================================*/

VSL_CreateTextdrawsLogin(playerid) {

    m_screenLayoutBoxMenu[playerid] = CreatePlayerTextDraw(playerid, 318.0, 3.0, "_");
    PlayerTextDrawFont(playerid, m_screenLayoutBoxMenu[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutBoxMenu[playerid], 1.158331, 49.9);
    PlayerTextDrawTextSize(playerid, m_screenLayoutBoxMenu[playerid], 298.5, 182.5);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutBoxMenu[playerid], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutBoxMenu[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutBoxMenu[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayoutBoxMenu[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutBoxMenu[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutBoxMenu[playerid], 168430335);
    PlayerTextDrawUseBox(playerid, m_screenLayoutBoxMenu[playerid], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutBoxMenu[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutBoxMenu[playerid], false);


    m_screenLayoutLogo[playerid][0] = CreatePlayerTextDraw(playerid, 334.0, 98.0, "Preview_Model");
    PlayerTextDrawFont(playerid, m_screenLayoutLogo[playerid][0], TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutLogo[playerid][0], 0.6, 2.0);
    PlayerTextDrawTextSize(playerid, m_screenLayoutLogo[playerid][0], 27.5, 35.5);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutLogo[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutLogo[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutLogo[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayoutLogo[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutLogo[playerid][0], -1724724224);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutLogo[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, m_screenLayoutLogo[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutLogo[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutLogo[playerid][0], false);
    PlayerTextDrawSetPreviewModel(playerid, m_screenLayoutLogo[playerid][0], 642);
    PlayerTextDrawSetPreviewRot(playerid, m_screenLayoutLogo[playerid][0], -10.0, -9.0, 0.0, 1.0);
    PlayerTextDrawSetPreviewVehicleColours(playerid, m_screenLayoutLogo[playerid][0], 16, 1);

    m_screenLayoutLogo[playerid][1] = CreatePlayerTextDraw(playerid, 285.0, 108.0, "Umbrella");
    PlayerTextDrawFont(playerid, m_screenLayoutLogo[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutLogo[playerid][1], 0.312489, 2.849992);
    PlayerTextDrawTextSize(playerid, m_screenLayoutLogo[playerid][1], 605.5, 17.0);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutLogo[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutLogo[playerid][1], 1);
    PlayerTextDrawAlignment(playerid, m_screenLayoutLogo[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayoutLogo[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutLogo[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutLogo[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, m_screenLayoutLogo[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutLogo[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutLogo[playerid][1], false);

    m_screenLayoutLogo[playerid][2] = CreatePlayerTextDraw(playerid, 311.0, 126.0, "Roleplay");
    PlayerTextDrawFont(playerid, m_screenLayoutLogo[playerid][2], TEXT_DRAW_FONT_0);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutLogo[playerid][2], 0.304161, 1.399996);
    PlayerTextDrawTextSize(playerid, m_screenLayoutLogo[playerid][2], 613.5, 12.0);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutLogo[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutLogo[playerid][2], 1);
    PlayerTextDrawAlignment(playerid, m_screenLayoutLogo[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayoutLogo[playerid][2], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutLogo[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutLogo[playerid][2], 255);
    PlayerTextDrawUseBox(playerid, m_screenLayoutLogo[playerid][2], false);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutLogo[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutLogo[playerid][2], false);


    m_screenLayoutFieldUser[playerid][0] = CreatePlayerTextDraw(playerid, 318.0, 174.0, "_");
    PlayerTextDrawFont(playerid, m_screenLayoutFieldUser[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutFieldUser[playerid][0], 0.6, 1.5);
    PlayerTextDrawTextSize(playerid, m_screenLayoutFieldUser[playerid][0], 298.5, 116.5);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutFieldUser[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutFieldUser[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutFieldUser[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayoutFieldUser[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutFieldUser[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutFieldUser[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, m_screenLayoutFieldUser[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutFieldUser[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutFieldUser[playerid][0], false);

    m_screenLayoutFieldUser[playerid][1] = CreatePlayerTextDraw(playerid, 268.0, 174.0, "_");
    PlayerTextDrawFont(playerid, m_screenLayoutFieldUser[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutFieldUser[playerid][1], 0.6, 1.5);
    PlayerTextDrawTextSize(playerid, m_screenLayoutFieldUser[playerid][1], 298.5, 16.5);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutFieldUser[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutFieldUser[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutFieldUser[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayoutFieldUser[playerid][1], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutFieldUser[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutFieldUser[playerid][1], 228);
    PlayerTextDrawUseBox(playerid, m_screenLayoutFieldUser[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutFieldUser[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutFieldUser[playerid][1], false);

    m_screenLayoutFieldUser[playerid][2] = CreatePlayerTextDraw(playerid, 259.0, 169.0, "LD_OTB2:Ric4");
    PlayerTextDrawFont(playerid, m_screenLayoutFieldUser[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutFieldUser[playerid][2], 0.6, 2.0);
    PlayerTextDrawTextSize(playerid, m_screenLayoutFieldUser[playerid][2], 18.0, 24.0);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutFieldUser[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutFieldUser[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutFieldUser[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayoutFieldUser[playerid][2], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutFieldUser[playerid][2], -1);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutFieldUser[playerid][2], 255);
    PlayerTextDrawUseBox(playerid, m_screenLayoutFieldUser[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutFieldUser[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutFieldUser[playerid][2], false);


    m_screenLayoutFieldPass[playerid][0] = CreatePlayerTextDraw(playerid, 318.0, 204.0, "_");
    PlayerTextDrawFont(playerid, m_screenLayoutFieldPass[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutFieldPass[playerid][0], 0.6, 1.5);
    PlayerTextDrawTextSize(playerid, m_screenLayoutFieldPass[playerid][0], 298.5, 116.5);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutFieldPass[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutFieldPass[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutFieldPass[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayoutFieldPass[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutFieldPass[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutFieldPass[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, m_screenLayoutFieldPass[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutFieldPass[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutFieldPass[playerid][0], false);

    m_screenLayoutFieldPass[playerid][1] = CreatePlayerTextDraw(playerid, 268.0, 204.0, "_");
    PlayerTextDrawFont(playerid, m_screenLayoutFieldPass[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutFieldPass[playerid][1], 0.6, 1.5);
    PlayerTextDrawTextSize(playerid, m_screenLayoutFieldPass[playerid][1], 298.5, 16.5);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutFieldPass[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutFieldPass[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutFieldPass[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayoutFieldPass[playerid][1], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutFieldPass[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutFieldPass[playerid][1], 228);
    PlayerTextDrawUseBox(playerid, m_screenLayoutFieldPass[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutFieldPass[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutFieldPass[playerid][1], false);

    m_screenLayoutFieldPass[playerid][2] = CreatePlayerTextDraw(playerid, 260.0, 203.0, "HUD:radar_mafiacasino");
    PlayerTextDrawFont(playerid, m_screenLayoutFieldPass[playerid][2], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, m_screenLayoutFieldPass[playerid][2], 0.6, 2.0);
    PlayerTextDrawTextSize(playerid, m_screenLayoutFieldPass[playerid][2], 15.0, 15.0);
    PlayerTextDrawSetOutline(playerid, m_screenLayoutFieldPass[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayoutFieldPass[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayoutFieldPass[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayoutFieldPass[playerid][2], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayoutFieldPass[playerid][2], -1);
    PlayerTextDrawBoxColour(playerid, m_screenLayoutFieldPass[playerid][2], 255);
    PlayerTextDrawUseBox(playerid, m_screenLayoutFieldPass[playerid][2], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayoutFieldPass[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayoutFieldPass[playerid][2], false);


    m_screenTextFieldUser[playerid] = CreatePlayerTextDraw(playerid, 326.0, 176.0, "Wili_Macena");
    PlayerTextDrawFont(playerid, m_screenTextFieldUser[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenTextFieldUser[playerid], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, m_screenTextFieldUser[playerid], 605.5, 17.0);
    PlayerTextDrawSetOutline(playerid, m_screenTextFieldUser[playerid], 0);
    PlayerTextDrawSetShadow(playerid, m_screenTextFieldUser[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenTextFieldUser[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenTextFieldUser[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, m_screenTextFieldUser[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenTextFieldUser[playerid], 255);
    PlayerTextDrawUseBox(playerid, m_screenTextFieldUser[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenTextFieldUser[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenTextFieldUser[playerid], false);


    m_screenTextFieldPass[playerid][0] = CreatePlayerTextDraw(playerid, 329.0, 206.0, "Digite sua senha");
    PlayerTextDrawFont(playerid, m_screenTextFieldPass[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenTextFieldPass[playerid][0], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, m_screenTextFieldPass[playerid][0], 11.0, 88.0);
    PlayerTextDrawSetOutline(playerid, m_screenTextFieldPass[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, m_screenTextFieldPass[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenTextFieldPass[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenTextFieldPass[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, m_screenTextFieldPass[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenTextFieldPass[playerid][0], 255);
    PlayerTextDrawUseBox(playerid, m_screenTextFieldPass[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, m_screenTextFieldPass[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenTextFieldPass[playerid][0], true);

    m_screenTextFieldPass[playerid][1] = CreatePlayerTextDraw(playerid, 329.0, 206.0, "]]]]]");
    PlayerTextDrawFont(playerid, m_screenTextFieldPass[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenTextFieldPass[playerid][1], 0.183319, 0.999997);
    PlayerTextDrawTextSize(playerid, m_screenTextFieldPass[playerid][1], 11.0, 88.0);
    PlayerTextDrawSetOutline(playerid, m_screenTextFieldPass[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, m_screenTextFieldPass[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenTextFieldPass[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenTextFieldPass[playerid][1], 255);
    PlayerTextDrawBackgroundColour(playerid, m_screenTextFieldPass[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, m_screenTextFieldPass[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, m_screenTextFieldPass[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenTextFieldPass[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenTextFieldPass[playerid][1], true);


    m_screenButtonLogin[playerid][0] = CreatePlayerTextDraw(playerid, 318.0, 275.0, "_");
    PlayerTextDrawFont(playerid, m_screenButtonLogin[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenButtonLogin[playerid][0], 0.6, 1.450003);
    PlayerTextDrawTextSize(playerid, m_screenButtonLogin[playerid][0], 298.5, 116.5);
    PlayerTextDrawSetOutline(playerid, m_screenButtonLogin[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, m_screenButtonLogin[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonLogin[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenButtonLogin[playerid][0], -1724724069);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonLogin[playerid][0], -1);
    PlayerTextDrawBoxColour(playerid, m_screenButtonLogin[playerid][0], -1724724069);
    PlayerTextDrawUseBox(playerid, m_screenButtonLogin[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenButtonLogin[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonLogin[playerid][0], false);

    m_screenButtonLogin[playerid][1] = CreatePlayerTextDraw(playerid, 300.0, 275.0, "Fazer Login");
    PlayerTextDrawFont(playerid, m_screenButtonLogin[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenButtonLogin[playerid][1], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenButtonLogin[playerid][1], 338.5, 11.0);
    PlayerTextDrawSetOutline(playerid, m_screenButtonLogin[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, m_screenButtonLogin[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonLogin[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenButtonLogin[playerid][1], -101);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonLogin[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, m_screenButtonLogin[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, m_screenButtonLogin[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenButtonLogin[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonLogin[playerid][1], false);


    m_screenButtonForgotPass[playerid] = CreatePlayerTextDraw(playerid, 293.0, 348.0, ". Recuperar minha senha");
    PlayerTextDrawFont(playerid, m_screenButtonForgotPass[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenButtonForgotPass[playerid], 0.170828, 1.049996);
    PlayerTextDrawTextSize(playerid, m_screenButtonForgotPass[playerid], 10.0, 70.0);
    PlayerTextDrawSetOutline(playerid, m_screenButtonForgotPass[playerid], 0);
    PlayerTextDrawSetShadow(playerid, m_screenButtonForgotPass[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonForgotPass[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenButtonForgotPass[playerid], -1061109505);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonForgotPass[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenButtonForgotPass[playerid], 255);
    PlayerTextDrawUseBox(playerid, m_screenButtonForgotPass[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenButtonForgotPass[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonForgotPass[playerid], true);



    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawSetClick(playerid, "OnClickTextFieldPassLogin", m_screenTextFieldPass[playerid][txd], txd);
    }

    PlayerTextDrawSetClick(playerid, "OnClickButtonScreenLogin", m_screenButtonLogin[playerid][1]);
    return 1;
}

VSL_ShowTextdrawsLogin(playerid) {

    new
        password[20 + 1];

    PlayerTextDrawShow(playerid, m_screenLayoutBoxMenu[playerid]);

    for (new txd = 0; txd < 3; txd++) {

        // PlayerTextDrawShow(playerid, m_screenLayoutLogo[playerid][txd]);
        PlayerTextDrawShow(playerid, m_screenLayoutFieldUser[playerid][txd]);
        PlayerTextDrawShow(playerid, m_screenLayoutFieldPass[playerid][txd]);
    }

    PlayerTextDrawShow(playerid, m_screenTextFieldUser[playerid]);

    PlayerTextDrawShow(playerid, m_screenButtonForgotPass[playerid]);
    
    GetPVarString(playerid, "temp_password_login", password);

    if (isnull(password))
       PlayerTextDrawShow(playerid, m_screenTextFieldPass[playerid][0]);
    else
        PlayerTextDrawShow(playerid, m_screenTextFieldPass[playerid][1]);

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenButtonLogin[playerid][txd]);
    }

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsLoginInputPass(playerid) {

    for (new txd = 0; txd < 3; txd++) {

        PlayerTextDrawHide(playerid, m_screenLayoutFieldUser[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenLayoutFieldPass[playerid][txd]);
    }

    PlayerTextDrawHide(playerid, m_screenTextFieldUser[playerid]);

    PlayerTextDrawHide(playerid, m_screenButtonForgotPass[playerid]);

    for (new txd = 0; txd < 2; txd++) {
    
        PlayerTextDrawHide(playerid, m_screenTextFieldPass[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenButtonLogin[playerid][txd]);
    }
    return 1;
}

VSL_DestroyTextdrawsLogin(playerid) {

    PlayerTextDrawDestroy(playerid, m_screenLayoutBoxMenu[playerid]);
    m_screenLayoutBoxMenu[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 3; txd++) {

        PlayerTextDrawDestroy(playerid, m_screenLayoutLogo[playerid][txd]);
        m_screenLayoutLogo[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

        PlayerTextDrawDestroy(playerid, m_screenLayoutFieldUser[playerid][txd]);
        m_screenLayoutFieldUser[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

        PlayerTextDrawDestroy(playerid, m_screenLayoutFieldPass[playerid][txd]);
        m_screenLayoutFieldPass[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    PlayerTextDrawDestroy(playerid, m_screenTextFieldUser[playerid]);
    m_screenTextFieldUser[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;


    PlayerTextDrawDestroy(playerid, m_screenButtonForgotPass[playerid]);
    m_screenButtonForgotPass[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 2; txd++) {
        
        PlayerTextDrawDestroy(playerid, m_screenTextFieldPass[playerid][txd]);
        m_screenTextFieldPass[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

        PlayerTextDrawDestroy(playerid, m_screenButtonLogin[playerid][txd]);
        m_screenButtonLogin[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    CancelSelectTextDraw(playerid);
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_UpdateTextdrawLayoutFieldPassLogin(playerid) {

    new
        password[20 + 1];

    GetPVarString(playerid, "temp_password_login", password);

    if (isnull(password)) {

       PlayerTextDrawHide(playerid, m_screenTextFieldPass[playerid][1]);
       PlayerTextDrawShow(playerid, m_screenTextFieldPass[playerid][0]);
    }
    else {

        PlayerTextDrawHide(playerid, m_screenTextFieldPass[playerid][0]);
        PlayerTextDrawShow(playerid, m_screenTextFieldPass[playerid][1]);
    }
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_SetStrTextFieldPassScreenLogin(playerid, const password[]) {
    return PlayerTextDrawSetString(playerid, m_screenTextFieldPass[playerid][1], GetFormatPasswordTextdraw(password));
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_EnableButtonLoginScreenLogin(playerid, bool:toggle) {

    if (toggle) {

        PlayerTextDrawBoxColour(playerid, m_screenButtonLogin[playerid][0], -1724723969);

        PlayerTextDrawColour(playerid, m_screenButtonLogin[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, m_screenButtonLogin[playerid][1], true);
    }
    else {

        PlayerTextDrawBoxColour(playerid, m_screenButtonLogin[playerid][0], -1724724069);

        PlayerTextDrawColour(playerid, m_screenButtonLogin[playerid][1], -101);
        PlayerTextDrawSetSelectable(playerid, m_screenButtonLogin[playerid][1], false);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenButtonLogin[playerid][txd]);
    }
    return 1;
}