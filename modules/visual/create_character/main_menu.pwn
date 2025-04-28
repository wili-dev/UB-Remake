/*======================================================================================================================
                          _  _    __     __         _       _     _      _         _  _   
                        _| || |_  \ \   / /_ _ _ __(_) __ _| |__ | | ___( )___   _| || |_ 
                       |_  ..  _|  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \// __| |_  ..  _|
                       |_      _|   \ V / (_| | |  | | (_| | |_) | |  __/ \__ \ |_      _|
                         |_||_|      \_/ \__,_|_|  |_|\__,_|_.__/|_|\___| |___/   |_||_|  

======================================================================================================================*/

static PlayerText:m_screenLayout[MAX_PLAYERS];

static PlayerText:m_screenTextName[MAX_PLAYERS];
static PlayerText:m_screenTextNickname[MAX_PLAYERS];

static PlayerText:m_screenMenuOptions[MAX_PLAYERS][6];

static PlayerText:m_screenButtonCreateCharacter[MAX_PLAYERS][2];


/*======================================================================================================================
                           _  _      ____      _ _ _                _    _         _  _   
                         _| || |_   / ___|__ _| | | |__   __ _  ___| | _( )___   _| || |_ 
                        |_  ..  _| | |   / _` | | | '_ \ / _` |/ __| |/ /// __| |_  ..  _|
                        |_      _| | |__| (_| | | | |_) | (_| | (__|   <  \__ \ |_      _|
                          |_||_|    \____\__,_|_|_|_.__/ \__,_|\___|_|\_\ |___/   |_||_|  

======================================================================================================================*/

PlayerTextDrawClick:OnClickOptionsMainMenu(playerid, index) {

    if (index < 2)
        VSL_HideTextdrawsCreateCharacterMainMenu(playerid);

    switch (index) {
        
        case 0: VSL_ShowTextdrawsCreateCharacterAboutMenu(playerid);
        case 1: {

            VSL_CreateTextdrawsCreateCharacterClothes(playerid);
            VSL_ShowTextdrawsCreateCharacterClothes(playerid);
        }
    }
    return 1;
}

PlayerTextDrawClick:OnClickCreateCharacter(playerid, index) {

    bcrypt_hash(playerid, "OnEncryptPasswordRegister", GetPlayerPasswordTemp(playerid), BCRYPT_COST);

    VSL_DestroyTextdrawsCreateCharacterMainMenu(playerid);

    SetSpawnInfo(playerid, NO_TEAM, VSL_GetSkinIdCreateCharacterClothes(playerid), 1484.3187, -1711.7432, 14.0469, 66.8716);
    TogglePlayerSpectating(playerid, false);
    return 1;
}


/*======================================================================================================================
                        _  _     _____                 _   _             _         _  _   
                      _| || |_  |  ___|   _ _ __   ___| |_(_) ___  _ __ ( )___   _| || |_ 
                     |_  ..  _| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \|// __| |_  ..  _|
                     |_      _| |  _|| |_| | | | | (__| |_| | (_) | | | | \__ \ |_      _|
                       |_||_|   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_| |___/   |_||_|  

======================================================================================================================*/

VSL_CreateTextdrawsCreateCharacterMainMenu(playerid) {

    m_screenLayout[playerid] = CreatePlayerTextDraw(playerid, 109.000000, 86.000000, "_");
    PlayerTextDrawFont(playerid, m_screenLayout[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenLayout[playerid], 0.600000, 35.999938);
    PlayerTextDrawTextSize(playerid, m_screenLayout[playerid], 299.500000, 133.500000);
    PlayerTextDrawSetOutline(playerid, m_screenLayout[playerid], true);
    PlayerTextDrawSetShadow(playerid, m_screenLayout[playerid], false);
    PlayerTextDrawAlignment(playerid, m_screenLayout[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayout[playerid], 255);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayout[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayout[playerid], 0x0A0A0AFF);
    PlayerTextDrawUseBox(playerid, m_screenLayout[playerid], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayout[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayout[playerid], false);


    m_screenTextName[playerid] = CreatePlayerTextDraw(playerid, 108.000000, 133.000000, ". . .");
    PlayerTextDrawFont(playerid, m_screenTextName[playerid], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenTextName[playerid], 0.283324, 2.199995);
    PlayerTextDrawTextSize(playerid, m_screenTextName[playerid], 146.000000, 357.000000);
    PlayerTextDrawSetOutline(playerid, m_screenTextName[playerid], true);
    PlayerTextDrawSetShadow(playerid, m_screenTextName[playerid], false);
    PlayerTextDrawAlignment(playerid, m_screenTextName[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenTextName[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenTextName[playerid], 336860415);
    PlayerTextDrawBoxColour(playerid, m_screenTextName[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenTextName[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenTextName[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenTextName[playerid], false);

    m_screenTextNickname[playerid] = CreatePlayerTextDraw(playerid, 108.000000, 151.000000, "_");
    PlayerTextDrawFont(playerid, m_screenTextNickname[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenTextNickname[playerid], 0.149990, 1.249994);
    PlayerTextDrawTextSize(playerid, m_screenTextNickname[playerid], 146.000000, 357.000000);
    PlayerTextDrawSetOutline(playerid, m_screenTextNickname[playerid], false);
    PlayerTextDrawSetShadow(playerid, m_screenTextNickname[playerid], false);
    PlayerTextDrawAlignment(playerid, m_screenTextNickname[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenTextNickname[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenTextNickname[playerid], -1);
    PlayerTextDrawBoxColour(playerid, m_screenTextNickname[playerid], 255);
    PlayerTextDrawUseBox(playerid, m_screenTextNickname[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenTextNickname[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenTextNickname[playerid], false);


    m_screenButtonCreateCharacter[playerid][0] = CreatePlayerTextDraw(playerid, 109.000000, 402.000000, "_");
    PlayerTextDrawFont(playerid, m_screenButtonCreateCharacter[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenButtonCreateCharacter[playerid][0], 0.600000, 0.900008);
    PlayerTextDrawTextSize(playerid, m_screenButtonCreateCharacter[playerid][0], 299.500000, 133.000000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonCreateCharacter[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, m_screenButtonCreateCharacter[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonCreateCharacter[playerid][0], TEXT_DRAW_ALIGN_CENTRE);
    PlayerTextDrawColour(playerid, m_screenButtonCreateCharacter[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonCreateCharacter[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenButtonCreateCharacter[playerid][0], -1724723969);
    PlayerTextDrawUseBox(playerid, m_screenButtonCreateCharacter[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenButtonCreateCharacter[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonCreateCharacter[playerid][0], false);

    m_screenButtonCreateCharacter[playerid][1] = CreatePlayerTextDraw(playerid, 82.000000, 401.000000, "Criar personagem");
    PlayerTextDrawFont(playerid, m_screenButtonCreateCharacter[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenButtonCreateCharacter[playerid][1], 0.162487, 0.999993);
    PlayerTextDrawTextSize(playerid, m_screenButtonCreateCharacter[playerid][1], 131.000000, 9.000000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonCreateCharacter[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, m_screenButtonCreateCharacter[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonCreateCharacter[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenButtonCreateCharacter[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonCreateCharacter[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, m_screenButtonCreateCharacter[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, m_screenButtonCreateCharacter[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenButtonCreateCharacter[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonCreateCharacter[playerid][1], true);

    VSL_CreateOptionInCreateCharacterMainMenu(playerid);


    PlayerTextDrawSetClick(playerid, "OnClickCreateCharacter", m_screenButtonCreateCharacter[playerid][1]);
    return 1;
}

VSL_CreateOptionInCreateCharacterMainMenu(playerid) {

    new
        Float:txd_pos_y = 206.0,

        txd_text[][] = { "Sobre", "Roupas", "Cabelos", "Acessorios", "Atributos", "Dublagem" },
        Float:txd_text_size[] = { 121.0, 109.0, 111.0, 122.500, 119.0, 117.500 }
    ;

    for (new txd = 0; txd < 6; txd++) {

        m_screenMenuOptions[playerid][txd] = CreatePlayerTextDraw(playerid, 86.000000, txd_pos_y, txd_text[txd]);
        PlayerTextDrawFont(playerid, m_screenMenuOptions[playerid][txd], TEXT_DRAW_FONT_3);
        PlayerTextDrawLetterSize(playerid, m_screenMenuOptions[playerid][txd], 0.195828, 1.199998);
        PlayerTextDrawTextSize(playerid, m_screenMenuOptions[playerid][txd], txd_text_size[txd], 10.000000);
        PlayerTextDrawSetOutline(playerid, m_screenMenuOptions[playerid][txd], false);
        PlayerTextDrawSetShadow(playerid, m_screenMenuOptions[playerid][txd], false);
        PlayerTextDrawAlignment(playerid, m_screenMenuOptions[playerid][txd], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, m_screenMenuOptions[playerid][txd], -1);
        PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptions[playerid][txd], -1);
        PlayerTextDrawBoxColour(playerid, m_screenMenuOptions[playerid][txd], 50);
        PlayerTextDrawUseBox(playerid, m_screenMenuOptions[playerid][txd], false);
        PlayerTextDrawSetProportional(playerid, m_screenMenuOptions[playerid][txd], true);
        PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][txd], true);

        txd_pos_y = txd_pos_y + 30.0;

        PlayerTextDrawSetClick(playerid, "OnClickOptionsMainMenu", m_screenMenuOptions[playerid][txd], txd);
    }
    return 1;
}

VSL_ShowTextdrawsCreateCharacterMainMenu(playerid) {

    PlayerTextDrawShow(playerid, m_screenLayout[playerid]);
    PlayerTextDrawShow(playerid, m_screenTextName[playerid]);
    PlayerTextDrawShow(playerid, m_screenTextNickname[playerid]);

    for (new txd = 0; txd < 6; txd++) {
        PlayerTextDrawShow(playerid, m_screenMenuOptions[playerid][txd]);
    }

    if (VSL_GetSkinIdCreateCharacterClothes(playerid) != -1) {

        for (new txd = 0; txd < 2; txd++) {
            PlayerTextDrawShow(playerid, m_screenButtonCreateCharacter[playerid][txd]);
        }
    }

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsCreateCharacterMainMenu(playerid) {

    PlayerTextDrawHide(playerid, m_screenLayout[playerid]);
    PlayerTextDrawHide(playerid, m_screenTextName[playerid]);
    PlayerTextDrawHide(playerid, m_screenTextNickname[playerid]);

    for (new txd = 0; txd < 6; txd++) {
        PlayerTextDrawHide(playerid, m_screenMenuOptions[playerid][txd]);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawHide(playerid, m_screenButtonCreateCharacter[playerid][txd]);
    }
    return 1;
}

VSL_DestroyTextdrawsCreateCharacterMainMenu(playerid) {

    PlayerTextDrawDestroy(playerid, m_screenLayout[playerid]);
    m_screenLayout[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, m_screenTextName[playerid]);
    m_screenTextName[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, m_screenTextNickname[playerid]);
    m_screenTextNickname[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 6; txd++) {

        PlayerTextDrawDestroy(playerid, m_screenMenuOptions[playerid][txd]);
        m_screenMenuOptions[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, m_screenButtonCreateCharacter[playerid][txd]);
        m_screenButtonCreateCharacter[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    CancelSelectTextDraw(playerid);
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_SetStrTextdrawCreateCharacterMainMenuName(playerid, const name[]) {
    return PlayerTextDrawSetString(playerid, m_screenTextName[playerid], name);
}

VSL_SetStrTextdrawCreateCharacterMainMenuNickname(playerid, const nickname[]) {
    return PlayerTextDrawSetString(playerid, m_screenTextNickname[playerid], nickname);
}