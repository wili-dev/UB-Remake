/*======================================================================================================================
                              _  _     ___            _           _      _         _  _   
                            _| || |_  |_ _|_ __   ___| |_   _  __| | ___( )___   _| || |_ 
                           |_  ..  _|  | || '_ \ / __| | | | |/ _` |/ _ \// __| |_  ..  _|
                           |_      _|  | || | | | (__| | |_| | (_| |  __/ \__ \ |_      _|
                             |_||_|   |___|_| |_|\___|_|\__,_|\__,_|\___| |___/   |_||_|  

======================================================================================================================*/

#include <YSI_Coding\y_hooks>


/*======================================================================================================================
                          _  _    __     __         _       _     _      _         _  _   
                        _| || |_  \ \   / /_ _ _ __(_) __ _| |__ | | ___( )___   _| || |_ 
                       |_  ..  _|  \ \ / / _` | '__| |/ _` | '_ \| |/ _ \// __| |_  ..  _|
                       |_      _|   \ V / (_| | |  | | (_| | |_) | |  __/ \__ \ |_      _|
                         |_||_|      \_/ \__,_|_|  |_|\__,_|_.__/|_|\___| |___/   |_||_|  

======================================================================================================================*/

static m_playerModeIndexSelected[MAX_PLAYERS char];

static PlayerText:m_screenLayout[MAX_PLAYERS][2];

static PlayerText:m_screenMenuOptions[MAX_PLAYERS][4];
static PlayerText:m_screenMenuOptionIcon[MAX_PLAYERS];
static PlayerText:m_screenMenuOptionBox[MAX_PLAYERS];

static PlayerText:m_screenModeName[MAX_PLAYERS];
static PlayerText:m_screenModeDescription[MAX_PLAYERS];
static PlayerText:m_screenModeStats[MAX_PLAYERS];

static PlayerText:m_screenButtonNext[MAX_PLAYERS][2];


/*======================================================================================================================
                           _  _      ____      _ _ _                _    _         _  _   
                         _| || |_   / ___|__ _| | | |__   __ _  ___| | _( )___   _| || |_ 
                        |_  ..  _| | |   / _` | | | '_ \ / _` |/ __| |/ /// __| |_  ..  _|
                        |_      _| | |__| (_| | | | |_) | (_| | (__|   <  \__ \ |_      _|
                          |_||_|    \____\__,_|_|_|_.__/ \__,_|\___|_|\_\ |___/   |_||_|  

======================================================================================================================*/

hook OnPlayerConnect(playerid) {

    m_playerModeIndexSelected{playerid} = 255;
    return 1;
}


PlayerTextDrawClick:OnClickModeOptions(playerid, index) {

    VSL_ShowTextdrawsIconMenuRegisterCharacterModes(playerid, index);
    VSL_ShowTextdrawsModeRegisterCharacterModes(playerid, index);
    return 1;
}

PlayerTextDrawClick:OnClickModeButtonNext(playerid, params) {

    // new
    //     E_CHARACTER_MODES:character_mode;
    
    if (m_playerModeIndexSelected[playerid] == 255)
        return 1;

    // switch (m_playerModeIndexSelected[playerid]) {

    //     case 0: character_mode = MODE_NOTHING_TO_LOSE;
    //     case 1: character_mode = MODE_FAMILY_NEST;
    //     case 2: character_mode = MODE_SIMPLY_ME;
    //     case 3: character_mode = MODE_ELDERLY_PEOPLE;
    // }

    PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][0], -1724724069);
    PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][1], -101);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][1], false);

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenButtonNext[playerid][txd]);
    }

    CancelSelectTextDraw(playerid);

    m_playerActorId = CreateActor(1, 206.6420, -228.6146, 1.7954, 192.8569);
    
    SetActorVirtualWorld(m_playerActorId, playerid + 1);
    SetPlayerVirtualWorld(playerid, playerid + 1);

    SetDynamicObjectMaterial(CreateDynamicObject(3095, 205.92958, -227.70790, 1.90500, 90.00000, 0.00000, 0.00000, playerid + 1, 0, playerid), 0, 19800, "LSACarPark1", "Black", 0xFFFFFFFF);
    SetDynamicObjectMaterial(CreateDynamicObject(3095, 205.92461, -231.02800, 0.24000, 0.00000, 0.00000, 0.00000, playerid + 1, 0, playerid), 0, 19800, "LSACarPark1", "Black", 0xFFFFFFFF);

    SetPlayerCameraPos(playerid, 207.064682, -231.382614, 2.647306);
    SetPlayerCameraLookAt(playerid, 206.207565, -226.539779, 1.746010);

    inline OnDestroyScreen() {

        VSL_DestroyTextdrawsRegisterCharacterModes(playerid);
        SHARED_DestroyTextdrawsLoginSpritesBackground(playerid);
    }

    Timer_CreateCallback(using inline OnDestroyScreen, 2000, 1);

    inline OnCreateScreen() {

        SHARED_DestroyTextdrawLoginBoxBackground(playerid);

        InterpolateCameraPos(playerid, 207.064682, -231.382614, 2.647306, 206.985504, -230.935119, 2.564025, 3000, CAMERA_MOVE);
        InterpolateCameraLookAt(playerid, 206.207565, -226.539779, 1.746010, 206.128387, -226.092285, 1.662729, 3000, CAMERA_MOVE);
    }

    Timer_CreateCallback(using inline OnCreateScreen, 4000, 1);

    inline OnShowAboutMenu() {

        SetPlayerCharacterSelected(playerid, 0);

        VSL_CreateTextdrawsCreateCharacterMainMenu(playerid);

        VSL_CreateTextdrawsCreateCharacterAboutMenu(playerid);
        VSL_ShowTextdrawsCreateCharacterAboutMenu(playerid, false);
    }

    Timer_CreateCallback(using inline OnShowAboutMenu, 6000, 1);
    return 1;
}


/*======================================================================================================================
                        _  _     _____                 _   _             _         _  _   
                      _| || |_  |  ___|   _ _ __   ___| |_(_) ___  _ __ ( )___   _| || |_ 
                     |_  ..  _| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \|// __| |_  ..  _|
                     |_      _| |  _|| |_| | | | | (__| |_| | (_) | | | | \__ \ |_      _|
                       |_||_|   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_| |___/   |_||_|  

======================================================================================================================*/

VSL_CreateTextdrawsRegisterCharacterModes(playerid) {

    m_screenLayout[playerid][0] = CreatePlayerTextDraw(playerid, 203.000000, 57.000000, "Voce deve escolher um modo para iniciar seu personagem.~n~Os modos lhe ajudaram a dar sentido a historia e nao poderao ser troca");
    PlayerTextDrawFont(playerid, m_screenLayout[playerid][0], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenLayout[playerid][0], 0.220833, 1.449998);
    PlayerTextDrawTextSize(playerid, m_screenLayout[playerid][0], 660.500000, 147.000000);
    PlayerTextDrawSetOutline(playerid, m_screenLayout[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, m_screenLayout[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayout[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayout[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayout[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayout[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, m_screenLayout[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayout[playerid][0], false);

    m_screenLayout[playerid][1] = CreatePlayerTextDraw(playerid, 507.000000, 136.000000, "_");
    PlayerTextDrawFont(playerid, m_screenLayout[playerid][1], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayout[playerid][1], 0.600000, 23.400024);
    PlayerTextDrawTextSize(playerid, m_screenLayout[playerid][1], 299.500000, 264.000000);
    PlayerTextDrawSetOutline(playerid, m_screenLayout[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, m_screenLayout[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenLayout[playerid][1], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayout[playerid][1], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayout[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayout[playerid][1], 0x0A0A0AFF);
    PlayerTextDrawUseBox(playerid, m_screenLayout[playerid][1], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayout[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayout[playerid][1], false);



    m_screenMenuOptionBox[playerid] = CreatePlayerTextDraw(playerid, 110.000000, 176.000000, "_");
    PlayerTextDrawFont(playerid, m_screenMenuOptionBox[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenMenuOptionBox[playerid], 0.600000, 1.550009);
    PlayerTextDrawTextSize(playerid, m_screenMenuOptionBox[playerid], 299.500000, 100.000000);
    PlayerTextDrawSetOutline(playerid, m_screenMenuOptionBox[playerid], 1);
    PlayerTextDrawSetShadow(playerid, m_screenMenuOptionBox[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenMenuOptionBox[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenMenuOptionBox[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptionBox[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenMenuOptionBox[playerid], -1724723969);
    PlayerTextDrawUseBox(playerid, m_screenMenuOptionBox[playerid], true);
    PlayerTextDrawSetProportional(playerid, m_screenMenuOptionBox[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptionBox[playerid], false);

    m_screenMenuOptionIcon[playerid] = CreatePlayerTextDraw(playerid, 60.000000, 172.000000, "ld_tatt:11dice2");
    PlayerTextDrawFont(playerid, m_screenMenuOptionIcon[playerid], TEXT_DRAW_FONT_SPRITE);
    PlayerTextDrawLetterSize(playerid, m_screenMenuOptionIcon[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, m_screenMenuOptionIcon[playerid], 22.000000, 22.000000);
    PlayerTextDrawSetOutline(playerid, m_screenMenuOptionIcon[playerid], 1);
    PlayerTextDrawSetShadow(playerid, m_screenMenuOptionIcon[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenMenuOptionIcon[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenMenuOptionIcon[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptionIcon[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenMenuOptionIcon[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenMenuOptionIcon[playerid], true);
    PlayerTextDrawSetProportional(playerid, m_screenMenuOptionIcon[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptionIcon[playerid], false);



    m_screenMenuOptions[playerid][0] = CreatePlayerTextDraw(playerid, 86.000000, 177.000000, "Nada a Perder");
    PlayerTextDrawFont(playerid, m_screenMenuOptions[playerid][0], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenMenuOptions[playerid][0], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenMenuOptions[playerid][0], 136.000000, 10.000000);
    PlayerTextDrawSetOutline(playerid, m_screenMenuOptions[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, m_screenMenuOptions[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenMenuOptions[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenMenuOptions[playerid][0], -1); // 1296911871
    PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptions[playerid][0], -1);
    PlayerTextDrawBoxColour(playerid, m_screenMenuOptions[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, m_screenMenuOptions[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, m_screenMenuOptions[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][0], true);

    m_screenMenuOptions[playerid][1] = CreatePlayerTextDraw(playerid, 86.000000, 206.000000, "Ninho familiar");
    PlayerTextDrawFont(playerid, m_screenMenuOptions[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenMenuOptions[playerid][1], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenMenuOptions[playerid][1], 134.000000, 10.000000);
    PlayerTextDrawSetOutline(playerid, m_screenMenuOptions[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, m_screenMenuOptions[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenMenuOptions[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenMenuOptions[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptions[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, m_screenMenuOptions[playerid][1], 1296911666);
    PlayerTextDrawUseBox(playerid, m_screenMenuOptions[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenMenuOptions[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][1], true);

    m_screenMenuOptions[playerid][2] = CreatePlayerTextDraw(playerid, 86.000000, 235.000000, "Simplesmente Eu");
    PlayerTextDrawFont(playerid, m_screenMenuOptions[playerid][2], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenMenuOptions[playerid][2], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenMenuOptions[playerid][2], 145.000000, 10.000000);
    PlayerTextDrawSetOutline(playerid, m_screenMenuOptions[playerid][2], 0);
    PlayerTextDrawSetShadow(playerid, m_screenMenuOptions[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, m_screenMenuOptions[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenMenuOptions[playerid][2], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptions[playerid][2], 255);
    PlayerTextDrawBoxColour(playerid, m_screenMenuOptions[playerid][2], 50);
    PlayerTextDrawUseBox(playerid, m_screenMenuOptions[playerid][2], false);
    PlayerTextDrawSetProportional(playerid, m_screenMenuOptions[playerid][2], true);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][2], true);

    m_screenMenuOptions[playerid][3] = CreatePlayerTextDraw(playerid, 86.000000, 264.000000, "Terceira Idade");
    PlayerTextDrawFont(playerid, m_screenMenuOptions[playerid][3], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenMenuOptions[playerid][3], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenMenuOptions[playerid][3], 136.500000, 10.000000);
    PlayerTextDrawSetOutline(playerid, m_screenMenuOptions[playerid][3], 0);
    PlayerTextDrawSetShadow(playerid, m_screenMenuOptions[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, m_screenMenuOptions[playerid][3], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenMenuOptions[playerid][3], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenMenuOptions[playerid][3], 255);
    PlayerTextDrawBoxColour(playerid, m_screenMenuOptions[playerid][3], 50);
    PlayerTextDrawUseBox(playerid, m_screenMenuOptions[playerid][3], false);
    PlayerTextDrawSetProportional(playerid, m_screenMenuOptions[playerid][3], true);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][3], true);



    m_screenModeName[playerid] = CreatePlayerTextDraw(playerid, 402.000000, 171.000000, "Nada a Perder");
    PlayerTextDrawFont(playerid, m_screenModeName[playerid], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenModeName[playerid], 0.245829, 1.700000);
    PlayerTextDrawTextSize(playerid, m_screenModeName[playerid], 486.500000, 17.500000);
    PlayerTextDrawSetOutline(playerid, m_screenModeName[playerid], 0);
    PlayerTextDrawSetShadow(playerid, m_screenModeName[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenModeName[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenModeName[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenModeName[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenModeName[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenModeName[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenModeName[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenModeName[playerid], false);

    m_screenModeDescription[playerid] = CreatePlayerTextDraw(playerid, 402.000000, 197.000000, "_");
    PlayerTextDrawFont(playerid, m_screenModeDescription[playerid], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenModeDescription[playerid], 0.204162, 1.250000);
    PlayerTextDrawTextSize(playerid, m_screenModeDescription[playerid], 560.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, m_screenModeDescription[playerid], 0);
    PlayerTextDrawSetShadow(playerid, m_screenModeDescription[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenModeDescription[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenModeDescription[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenModeDescription[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenModeDescription[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenModeDescription[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenModeDescription[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenModeDescription[playerid], false);

    m_screenModeStats[playerid] = CreatePlayerTextDraw(playerid, 402.000000, 239.000000, "_");
    PlayerTextDrawFont(playerid, m_screenModeStats[playerid], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenModeStats[playerid], 0.204162, 1.250000);
    PlayerTextDrawTextSize(playerid, m_screenModeStats[playerid], 560.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, m_screenModeStats[playerid], 0);
    PlayerTextDrawSetShadow(playerid, m_screenModeStats[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenModeStats[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenModeStats[playerid], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenModeStats[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenModeStats[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenModeStats[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenModeStats[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenModeStats[playerid], false);



    m_screenButtonNext[playerid][0] = CreatePlayerTextDraw(playerid, 512.000000, 320.000000, "_");
    PlayerTextDrawFont(playerid, m_screenButtonNext[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenButtonNext[playerid][0], 0.600000, 1.150009);
    PlayerTextDrawTextSize(playerid, m_screenButtonNext[playerid][0], 299.500000, 62.000000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonNext[playerid][0], true);
    PlayerTextDrawSetShadow(playerid, m_screenButtonNext[playerid][0], false);
    PlayerTextDrawAlignment(playerid, m_screenButtonNext[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonNext[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][0], -1724723969);
    PlayerTextDrawUseBox(playerid, m_screenButtonNext[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenButtonNext[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][0], false);

    m_screenButtonNext[playerid][1] = CreatePlayerTextDraw(playerid, 495.000000, 319.000000, "Continuar");
    PlayerTextDrawFont(playerid, m_screenButtonNext[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenButtonNext[playerid][1], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenButtonNext[playerid][1], 529.000000, 10.000000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonNext[playerid][1], false);
    PlayerTextDrawSetShadow(playerid, m_screenButtonNext[playerid][1], false);
    PlayerTextDrawAlignment(playerid, m_screenButtonNext[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonNext[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, m_screenButtonNext[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenButtonNext[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][1], true);


    for (new i = 0; i < 4; i++) {
        PlayerTextDrawSetClick(playerid, "OnClickModeOptions", m_screenMenuOptions[playerid][i], i);
    }

    PlayerTextDrawSetClick(playerid, "OnClickModeButtonNext", m_screenButtonNext[playerid][1]);
    return 1;
}

VSL_ShowTextdrawsRegisterCharacterModes(playerid) {

    PlayerTextDrawShow(playerid, m_screenLayout[playerid][0]);

    for (new txd = 0; txd < 4; txd++) {
        PlayerTextDrawShow(playerid, m_screenMenuOptions[playerid][txd]);
    }

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_DestroyTextdrawsRegisterCharacterModes(playerid) {

    PlayerTextDrawDestroy(playerid, m_screenMenuOptionIcon[playerid]);
    m_screenMenuOptionIcon[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, m_screenMenuOptionBox[playerid]);
    m_screenMenuOptionBox[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, m_screenModeName[playerid]);
    m_screenModeName[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, m_screenModeDescription[playerid]);
    m_screenModeDescription[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, m_screenModeStats[playerid]);
    m_screenModeStats[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, m_screenLayout[playerid][txd]);
        m_screenLayout[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

        PlayerTextDrawDestroy(playerid, m_screenButtonNext[playerid][txd]);
        m_screenButtonNext[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    for (new txd = 0; txd < 4; txd++) {

        PlayerTextDrawDestroy(playerid, m_screenMenuOptions[playerid][txd]);
        m_screenMenuOptions[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    CancelSelectTextDraw(playerid);
    return 1;
}


VSL_ShowTextdrawsIconMenuRegisterCharacterModes(playerid, index) {

    new
        Float:pos_x,
        Float:pos_y
    ;

    switch (index) {

        case 0: PlayerTextDrawSetString(playerid, m_screenMenuOptionIcon[playerid], "ld_tatt:11dice2");
        case 1: PlayerTextDrawSetString(playerid, m_screenMenuOptionIcon[playerid], "ld_tatt:7mary");
        case 2: PlayerTextDrawSetString(playerid, m_screenMenuOptionIcon[playerid], "ld_tatt:6clown");
        case 3: PlayerTextDrawSetString(playerid, m_screenMenuOptionIcon[playerid], "ld_tatt:12angel");
    }

    PlayerTextDrawGetPos(playerid, m_screenMenuOptions[playerid][index], pos_x, pos_y);

    PlayerTextDrawSetPos(playerid, m_screenMenuOptionBox[playerid], 110.0, pos_y - 1.0);
    PlayerTextDrawSetPos(playerid, m_screenMenuOptionIcon[playerid], 60.0, pos_y - 5.0);

    PlayerTextDrawShow(playerid, m_screenMenuOptionBox[playerid]);
    PlayerTextDrawShow(playerid, m_screenMenuOptionIcon[playerid]);
    return 1;
}

VSL_ShowTextdrawsModeRegisterCharacterModes(playerid, index) {

    PlayerTextDrawShow(playerid, m_screenLayout[playerid][1]);

    if (m_playerModeIndexSelected{playerid} != 255) {

        PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][m_playerModeIndexSelected{playerid}], true);
        PlayerTextDrawShow(playerid, m_screenMenuOptions[playerid][m_playerModeIndexSelected{playerid}]);
    }

    PlayerTextDrawColour(playerid, m_screenMenuOptions[playerid][index], -1);
    PlayerTextDrawSetSelectable(playerid, m_screenMenuOptions[playerid][index], false);
    PlayerTextDrawShow(playerid, m_screenMenuOptions[playerid][index]);

    PlayerTextDrawSetString(playerid, m_screenModeName[playerid], VSL_GetNameModeRegisterCharacterModes(index));
    PlayerTextDrawShow(playerid, m_screenModeName[playerid]);

    PlayerTextDrawSetString(playerid, m_screenModeDescription[playerid], VSL_GetDescModeRegisterCharacterModes(index));
    PlayerTextDrawShow(playerid, m_screenModeDescription[playerid]);

    if (!IsPlayerTextDrawVisible(playerid, m_screenButtonNext[playerid][0])) {

        for (new txd = 0; txd < 2; txd++) {
            PlayerTextDrawShow(playerid, m_screenButtonNext[playerid][txd]);
        }
    }

    m_playerModeIndexSelected{playerid} = index;
    return 1;
}

VSL_GetNameModeRegisterCharacterModes(index) {

    new
        mode_name[16];

    switch (index) {

        case 0: strcat(mode_name, "Nada a Perder");
        case 1: strcat(mode_name, "Ninho Familiar");
        case 2: strcat(mode_name, "Simplesmente Eu");
        case 3: strcat(mode_name, "Terceira Idade");

        default: strcat(mode_name, "null");
    }
    return mode_name;
}

VSL_GetDescModeRegisterCharacterModes(index) {

    new
        mode_desc[240];

    switch (index) {

        case 0: strcat(mode_desc, "Voce meteu o louco e veio la do fim do mundo para a cidade grande. O que voce tem e R$200 reais no bolso e um sonho!~n~ ~n~");
        case 1: strcat(mode_desc, "Voce ainda mora com seus pais, entao e melhor se comportar ou podera ser expulso. Pelo menos eles te deram um veiculo usado que so faz barulho para voce ir a faculdade.~n~ ~n~");
        case 2: strcat(mode_desc, "Voce alugou seu proprio cantinho e tem um emprego de meio periodo desde a epoca de escola. Sua fiel lambreta te acompanha, e lenta, mas raramenta te deixa na mao.~n~ ~n~");
        case 3: strcat(mode_desc, "Voce ja esta no final da vida e se aposentou, sem muitas obrigacoes. Tem um dinheiro guardado, mas gasta horrores com remedios. Se apegou demais ao seu veiculo para pensar em trocar por um novo.~n~ ~n~");

        default: strcat(mode_desc, "null");
    }
    
    if (!isnull(mode_desc)) {
        strcat(mode_desc, VSL_GetStatsModeRegisterCharacterModes(index));
    }
    return mode_desc;
}

VSL_GetStatsModeRegisterCharacterModes(index) {

    new
        mode_stats[30];

    switch (index) {

        case 0: strcat(mode_stats, "LEVEL 1~n~EXP: NORMAL");
        case 1: strcat(mode_stats, "LEVEL 4~n~EXP: -20% EM PAYDAY");
        case 2: strcat(mode_stats, "LEVEL 2~n~EXP: -15% EM PAYDAY");
        case 3: strcat(mode_stats, "LEVEL 10~n~EXP: NENHUM");

        default: strcat(mode_stats, "null");
    }
    return mode_stats;
}