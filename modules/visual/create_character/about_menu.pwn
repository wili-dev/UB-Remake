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

static m_playerCountCreateOptions[MAX_PLAYERS char];
static bool:m_playerShowButtonNextInShowTextdraws[MAX_PLAYERS];

static PlayerText:m_screenLayout[MAX_PLAYERS][2];

static PlayerText:m_screenMenuOptions[MAX_PLAYERS][7];
static PlayerText:m_screenMenuOptionsText[MAX_PLAYERS][7];

static PlayerText:m_screenButtonNext[MAX_PLAYERS][2];


/*======================================================================================================================
                           _  _      ____      _ _ _                _    _         _  _   
                         _| || |_   / ___|__ _| | | |__   __ _  ___| | _( )___   _| || |_ 
                        |_  ..  _| | |   / _` | | | '_ \ / _` |/ __| |/ /// __| |_  ..  _|
                        |_      _| | |__| (_| | | | |_) | (_| | (__|   <  \__ \ |_      _|
                          |_||_|    \____\__,_|_|_|_.__/ \__,_|\___|_|\_\ |___/   |_||_|  

======================================================================================================================*/

hook OnPlayerConnect(playerid) {

    m_playerShowButtonNextInShowTextdraws[playerid] = false;
    return 1;
}


/*====================================================================================================================*/
PlayerTextDrawClick:OnClickOptionsAboutMenu(playerid, index) {

    switch (index) {

        case 0: ShowPlayerDialogCreateCharacterAboutName(playerid);
        case 1: ShowPlayerDialogCreateCharacterAboutNickname(playerid);
        case 2: ShowPlayerDialogCreateCharacterAboutDateBirth(playerid);
        case 3: ShowPlayerDialogCreateCharacterAboutGender(playerid);
        case 4: ShowPlayerDialogCreateCharacterAboutNationality(playerid);
        case 5: {

            if (strlen(Data_GetPlayerCharacterNationalityCustom(playerid)) > 0) {
                ShowPlayerDialogCreateCharacterAboutPlaceBirthCustom(playerid);
            }
            else if (Data_GetPlayerCharacterNationality(playerid)) {
                ShowPlayerDialogCreateCharacterAboutPlaceBirth(playerid);
            }
            else
                createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "E necessario informar a nacionalidade antes.", true, 0x202020FF);
        }
        case 6: ShowPlayerDialogCreateCharacterAboutEthnicity(playerid);
    }
    return 1;
}

PlayerTextDrawClick:OnClickOptionsAboutButtonNext(playerid, params) {

    Dialog_Hide(playerid);

    if (m_playerShowButtonNextInShowTextdraws[playerid]) {

        VSL_HideTextdrawsCreateCharacterAboutMenu(playerid);
        VSL_ShowTextdrawsCreateCharacterMainMenu(playerid);
    }
    else {

        CancelSelectTextDraw(playerid);

        VSL_EnaleTextdrawsCreateCharacterAboutButtonNext(playerid, false);

        inline OnCreateMainMenu() {

            VSL_HideTextdrawsCreateCharacterAboutMenu(playerid);

            PlayerTextDrawSetPos(playerid, m_screenButtonNext[playerid][0], 533.000000, 362.000000);
            PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][0], -1724723969);

            PlayerTextDrawSetString(playerid, m_screenButtonNext[playerid][1], "Fechar");
            PlayerTextDrawTextSize(playerid, m_screenButtonNext[playerid][1], 541.500000, 8.000000);
            PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][1], -1);
            PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][1], true);

            VSL_ShowTextdrawsCreateCharacterMainMenu(playerid);
        }

        Timer_CreateCallback(using inline OnCreateMainMenu, 2000, 1);
    }
    return 1;
}


/*======================================================================================================================
                        _  _     _____                 _   _             _         _  _   
                      _| || |_  |  ___|   _ _ __   ___| |_(_) ___  _ __ ( )___   _| || |_ 
                     |_  ..  _| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \|// __| |_  ..  _|
                     |_      _| |  _|| |_| | | | | (__| |_| | (_) | | | | \__ \ |_      _|
                       |_||_|   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_| |___/   |_||_|  

======================================================================================================================*/

VSL_CreateTextdrawsCreateCharacterAboutMenu(playerid) {

    m_playerCountCreateOptions{playerid} = 0;

    m_screenLayout[playerid][0] = CreatePlayerTextDraw(playerid, 530.000000, 136.000000, "_");
    PlayerTextDrawFont(playerid, m_screenLayout[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayout[playerid][0], 0.600000, 27.299964);
    PlayerTextDrawTextSize(playerid, m_screenLayout[playerid][0], 299.500000, 219.500000);
    PlayerTextDrawSetOutline(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetShadow(playerid, m_screenLayout[playerid][0], false);
    PlayerTextDrawAlignment(playerid, m_screenLayout[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayout[playerid][0], 255);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayout[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayout[playerid][0], 0x0A0A0AFF);
    PlayerTextDrawUseBox(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayout[playerid][0], false);

    m_screenLayout[playerid][1] = CreatePlayerTextDraw(playerid, 440.000000, 157.000000, "Sobre mim");
    PlayerTextDrawFont(playerid, m_screenLayout[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenLayout[playerid][1], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, m_screenLayout[playerid][1], 607.000000, 10.000000);
    PlayerTextDrawSetOutline(playerid, m_screenLayout[playerid][1], false);
    PlayerTextDrawSetShadow(playerid, m_screenLayout[playerid][1], false);
    PlayerTextDrawAlignment(playerid, m_screenLayout[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenLayout[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayout[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, m_screenLayout[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, m_screenLayout[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenLayout[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayout[playerid][1], false);


    m_screenButtonNext[playerid][0] = CreatePlayerTextDraw(playerid, 536.000000, 362.000000, "_");
    PlayerTextDrawFont(playerid, m_screenButtonNext[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, m_screenButtonNext[playerid][0], 0.600000, 0.600009);
    PlayerTextDrawTextSize(playerid, m_screenButtonNext[playerid][0], 299.500000, 53.500000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonNext[playerid][0], true);
    PlayerTextDrawSetShadow(playerid, m_screenButtonNext[playerid][0], false);
    PlayerTextDrawAlignment(playerid, m_screenButtonNext[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonNext[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][0], -1724723969);
    PlayerTextDrawUseBox(playerid, m_screenButtonNext[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenButtonNext[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][0], false);

    m_screenButtonNext[playerid][1] = CreatePlayerTextDraw(playerid, 523.000000, 360.000000, "Continuar");
    PlayerTextDrawFont(playerid, m_screenButtonNext[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenButtonNext[playerid][1], 0.162487, 0.999993);
    PlayerTextDrawTextSize(playerid, m_screenButtonNext[playerid][1], 550.000000, 8.000000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonNext[playerid][1], false);
    PlayerTextDrawSetShadow(playerid, m_screenButtonNext[playerid][1], false);
    PlayerTextDrawAlignment(playerid, m_screenButtonNext[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonNext[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, m_screenButtonNext[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenButtonNext[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][1], false);

    /*
        Fechar:
            TextSize: 541.500000, 8.000000

            Box: 533.000000, 362.000000
        
        Continuar:
            TextSize: 550.000000, 8.000000

            Box: 536.000000, 362.000000

    */


    new options[][] = {

        "Nome",
        "Apelido",
        "Data de nascimento",
        "Genero",
        "Nacionalidade",
        "Naturalidade",
        "Etnia"
    };

    new Float:optionsSize[] = {456.0, 460.0, 494.0, 460.0, 477.0, 475.0, 453.5};

    for (new i = 0; i < 7; i++) {

        VSL_CreateOptionInCreateCharacterAboutMenu(playerid, options[i], m_screenMenuOptions[playerid][i], m_screenMenuOptionsText[playerid][i], optionsSize[i]);

        PlayerTextDrawSetClick(playerid, "OnClickOptionsAboutMenu", m_screenMenuOptions[playerid][i], i);
    }

    PlayerTextDrawSetClick(playerid, "OnClickOptionsAboutButtonNext", m_screenButtonNext[playerid][1]);
    return 1;
}

VSL_CreateOptionInCreateCharacterAboutMenu(playerid, const text[], &PlayerText:txd_option, &PlayerText:txd_text, Float:txd_text_size) {

    txd_option = CreatePlayerTextDraw(playerid, 440.000000, 191.0 + (22 * m_playerCountCreateOptions{playerid}), text);
    PlayerTextDrawFont(playerid, txd_option, TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, txd_option, 0.166657, 1.099995);
    PlayerTextDrawTextSize(playerid, txd_option, txd_text_size, 8.000000);
    PlayerTextDrawSetOutline(playerid, txd_option, false);
    PlayerTextDrawSetShadow(playerid, txd_option, false);
    PlayerTextDrawAlignment(playerid, txd_option, TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, txd_option, -1061109505);
    PlayerTextDrawBackgroundColour(playerid, txd_option, -1);
    PlayerTextDrawBoxColour(playerid, txd_option, 50);
    PlayerTextDrawUseBox(playerid, txd_option, false);
    PlayerTextDrawSetProportional(playerid, txd_option, true);
    PlayerTextDrawSetSelectable(playerid, txd_option, true);

    txd_text = CreatePlayerTextDraw(playerid, 580.000000, 191.0 + (22 * m_playerCountCreateOptions{playerid}), ". . .");
    PlayerTextDrawFont(playerid, txd_text, TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, txd_text, 0.166657, 1.099995);
    PlayerTextDrawTextSize(playerid, txd_text, 146.000000, 357.000000);
    PlayerTextDrawSetOutline(playerid, txd_text, false);
    PlayerTextDrawSetShadow(playerid, txd_text, false);
    PlayerTextDrawAlignment(playerid, txd_text, TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, txd_text, -1061109505);
    PlayerTextDrawBackgroundColour(playerid, txd_text, -1);
    PlayerTextDrawBoxColour(playerid, txd_text, 50);
    PlayerTextDrawUseBox(playerid, txd_text, false);
    PlayerTextDrawSetProportional(playerid, txd_text, true);
    PlayerTextDrawSetSelectable(playerid, txd_text, false);


    m_playerCountCreateOptions{playerid} ++;
    return 1;
}

/*====================================================================================================================*/
VSL_ShowTextdrawsCreateCharacterAboutMenu(playerid, bool:show_button_next = true) {

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenLayout[playerid][txd]);
    }

    for (new txd = 0; txd < 7; txd++) {

        PlayerTextDrawShow(playerid, m_screenMenuOptions[playerid][txd]);
        PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][txd]);
    }

    if (show_button_next) {

        for (new txd = 0; txd < 2; txd++) {
            PlayerTextDrawShow(playerid, m_screenButtonNext[playerid][txd]);
        }
    }

    m_playerShowButtonNextInShowTextdraws[playerid] = show_button_next;

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsCreateCharacterAboutMenu(playerid) {

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawHide(playerid, m_screenLayout[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenButtonNext[playerid][txd]);
    }

    for (new txd = 0; txd < 7; txd++) {

        PlayerTextDrawHide(playerid, m_screenMenuOptions[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenMenuOptionsText[playerid][txd]);
    }
    return 1;
}

/*====================================================================================================================*/
VSL_EnaleTextdrawsCreateCharacterAboutButtonNext(playerid, bool:toggle) {

    if (toggle) {

        PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][0], -1724723969);

        PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][1], true);
    }
    else {

        PlayerTextDrawBoxColour(playerid, m_screenButtonNext[playerid][0], -1724724069); // -1724724199

        PlayerTextDrawColour(playerid, m_screenButtonNext[playerid][1], -101); // -226
        PlayerTextDrawSetSelectable(playerid, m_screenButtonNext[playerid][1], false);        
    }
    
    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenButtonNext[playerid][txd]);
    }
    return 1;
}

/*====================================================================================================================*/
VSL_SetStrTextdrawCreateCharacterAboutName(playerid, const name[]) {
    
    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][0], name);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][0], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][0]);
    return 1;
}

VSL_SetStrTextdrawCreateCharacterAboutNickname(playerid, const nickname[]) {
    
    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][1], nickname);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][1], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][1]);
    return 1;
}

VSL_SetStrTextdrawCreateCharacterAboutDateBirth(playerid, const date_birth[]) {
    
    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][2], date_birth);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][2], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][2]);
    return 1;
}

VSL_SetStrTextdrawCreateCharacterAboutGender(playerid, const gender[]) {

    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][3], gender);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][3], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][3]);
    return 1;
}

VSL_SetStrTextdrawCreateCharacterAboutNationality(playerid, const nationality[]) {

    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][4], nationality);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][4], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][4]);
    return 1;
}

VSL_SetStrTextdrawCreateCharacterAboutPlaceBirth(playerid, const place_birth[]) {

    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][5], place_birth);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][5], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][5]);
    return 1;
}

VSL_SetStrTextdrawCreateCharacterAboutEthnicity(playerid, const ethnicity[]) {

    PlayerTextDrawSetString(playerid, m_screenMenuOptionsText[playerid][6], ethnicity);
    PlayerTextDrawColour(playerid, m_screenMenuOptionsText[playerid][6], -1);

    PlayerTextDrawShow(playerid, m_screenMenuOptionsText[playerid][6]);
    return 1;
}