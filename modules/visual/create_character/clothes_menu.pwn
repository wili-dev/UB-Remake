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

static m_playerPageIdCurrent[MAX_PLAYERS];
static m_playerPageIdSkinSelected[MAX_PLAYERS];

static m_playerSkinIdSelected[MAX_PLAYERS];
static m_playerPreviewSkinSelected[MAX_PLAYERS char];


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
static PlayerText:m_screenLayout[MAX_PLAYERS][2];

static PlayerText:m_screenPreviewBox[MAX_PLAYERS][10];
static PlayerText:m_screenPreviewAreaClick[MAX_PLAYERS][10];
static PlayerText:m_screenPreviewSkin[MAX_PLAYERS][10];

static PlayerText:m_screenArrowBack[MAX_PLAYERS];
static PlayerText:m_screenArrowNext[MAX_PLAYERS];

static PlayerText:m_screenButtonClose[MAX_PLAYERS][2];


new allowed_clothes_ids[] = {
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
    11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
    21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
    31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
    51, 52, 53, 54, 55, 56, 57, 58, 59, 60,
    61, 62, 63, 64, 65, 66, 67, 68, 69, 70,
    71, 72, 73, 74, 75, 76, 77, 78, 79, 80,
    81, 82, 83, 84, 85, 86, 87, 88, 89, 90,
    91, 92, 93, 94, 95, 96, 97, 98, 99, 100,
    101, 102, 103, 104, 105, 106, 107, 108, 109, 110,
    111, 112, 113, 114, 115, 116, 117, 118, 119, 120,
    121, 122, 123, 124, 125, 126, 127, 128, 129, 130,
    131, 132, 133, 134, 135, 136, 137, 138, 139, 140,
    141, 142, 143, 144, 145, 146, 147, 148, 149, 150,
    151, 152, 153, 154, 155, 156, 157, 158, 159, 160,
    161, 162, 163, 164, 165, 166, 167, 168, 169, 170,
    171, 172, 173, 174, 175, 176, 177, 178, 179, 180,
    181, 182, 183, 184, 185, 186, 187, 188, 189, 190,
    191, 192, 193, 194, 195, 196, 197, 198, 199, 200,
    201, 202, 203, 204, 205, 206, 207, 208, 209, 210,
    211, 212, 213, 214, 215, 216, 217, 218, 219, 220,
    221, 222, 223, 224, 225, 226, 227, 228, 229, 230,
    231, 232, 233, 234, 235, 236, 237, 238, 239, 240,
    241, 242, 243, 244, 245, 246, 247, 248, 249, 250,
    251, 252, 253, 254, 255, 256, 257, 258, 259, 260,
    261, 262, 263, 264, 265, 266, 267, 268, 269, 270,
    271, 272, 273, 274, 275, 276, 277, 278, 279, 280,
    281, 282, 283, 284, 285, 286, 287, 288, 289, 290,
    291, 292, 293, 294, 295, 296, 297, 298, 299, 300
};



/*======================================================================================================================
                           _  _      ____      _ _ _                _    _         _  _   
                         _| || |_   / ___|__ _| | | |__   __ _  ___| | _( )___   _| || |_ 
                        |_  ..  _| | |   / _` | | | '_ \ / _` |/ __| |/ /// __| |_  ..  _|
                        |_      _| | |__| (_| | | | |_) | (_| | (__|   <  \__ \ |_      _|
                          |_||_|    \____\__,_|_|_|_.__/ \__,_|\___|_|\_\ |___/   |_||_|  

======================================================================================================================*/

hook OnPlayerConnect(playerid) {

    m_playerSkinIdSelected[playerid] = -1;
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
PlayerTextDrawClick:OnClickPreviewSkin(playerid, index) {

    if (m_playerSkinIdSelected[playerid] == -1) {

        VSL_EnableButtonCloseCreateCharacterClothes(playerid, true);
        VSL_MarkPreviewCreateCharacterClothes(playerid, index);
    }
    else {

        if (m_playerPageIdCurrent[playerid] == m_playerPageIdSkinSelected[playerid])
            VSL_MarkPreviewCreateCharacterClothes(playerid, index, m_playerPreviewSkinSelected{playerid});
        else
            VSL_MarkPreviewCreateCharacterClothes(playerid, index);
    }

    m_playerSkinIdSelected[playerid] = allowed_clothes_ids[(m_playerPageIdCurrent[playerid] * 10) + index];
    m_playerPreviewSkinSelected{playerid} = index;
    m_playerPageIdSkinSelected[playerid] = m_playerPageIdCurrent[playerid];

    SetActorSkin(m_playerActorId, m_playerSkinIdSelected[playerid]);
    return 1;
}

PlayerTextDrawClick:OnClickArrowBack(playerid, index) {

    m_playerPageIdCurrent[playerid] --;

    VSL_CheckPageCreateCharacterClothes(playerid);
    VSL_ShowPreviewCreateCharacterClothes(playerid);

    if (m_playerPageIdCurrent[playerid] == 0)
        PlayerTextDrawHide(playerid, m_screenArrowBack[playerid]);

    PlayerTextDrawShow(playerid, m_screenArrowNext[playerid]);
    return 1;
}

PlayerTextDrawClick:OnClickArrowNext(playerid, index) {

    m_playerPageIdCurrent[playerid] ++;

    VSL_CheckPageCreateCharacterClothes(playerid);
    VSL_ShowPreviewCreateCharacterClothes(playerid);

    PlayerTextDrawShow(playerid, m_screenArrowBack[playerid]);

    if ((m_playerPageIdCurrent[playerid] * 10) + 10 >= sizeof(allowed_clothes_ids))
        PlayerTextDrawHide(playerid, m_screenArrowNext[playerid]);

    return 1;
}

PlayerTextDrawClick:OnClickButtonMenu(playerid, index) {

    if (m_playerSkinIdSelected[playerid] == -1)
        return 1;

    VSL_HideTextdrawsCreateCharacterClothes(playerid);

    VSL_ShowTextdrawsCreateCharacterMainMenu(playerid);
    return 1;
}


/*======================================================================================================================
                        _  _     _____                 _   _             _         _  _   
                      _| || |_  |  ___|   _ _ __   ___| |_(_) ___  _ __ ( )___   _| || |_ 
                     |_  ..  _| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \|// __| |_  ..  _|
                     |_      _| |  _|| |_| | | | | (__| |_| | (_) | | | | \__ \ |_      _|
                       |_||_|   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_| |___/   |_||_|  

======================================================================================================================*/

VSL_CreateTextdrawsCreateCharacterClothes(playerid) {

    m_screenLayout[playerid][0] = CreatePlayerTextDraw(playerid, 530.000000, 136.000000, "_");
    PlayerTextDrawFont(playerid, m_screenLayout[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenLayout[playerid][0], 0.600000, 29.449932);
    PlayerTextDrawTextSize(playerid, m_screenLayout[playerid][0], 299.500000, 219.500000);
    PlayerTextDrawSetOutline(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetShadow(playerid, m_screenLayout[playerid][0], false);
    PlayerTextDrawAlignment(playerid, m_screenLayout[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenLayout[playerid][0], 168430335);
    PlayerTextDrawBackgroundColour(playerid, m_screenLayout[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenLayout[playerid][0], 168430335);
    PlayerTextDrawUseBox(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenLayout[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenLayout[playerid][0], false);

    m_screenLayout[playerid][1] = CreatePlayerTextDraw(playerid, 438.000000, 151.000000, "Escolha sua roupa");
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



    m_screenArrowBack[playerid] = CreatePlayerTextDraw(playerid, 454.000000, 380.000000, "ld_beat:left");
    PlayerTextDrawFont(playerid, m_screenArrowBack[playerid], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, m_screenArrowBack[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, m_screenArrowBack[playerid], 12.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, m_screenArrowBack[playerid], 1);
    PlayerTextDrawSetShadow(playerid, m_screenArrowBack[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenArrowBack[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenArrowBack[playerid], -1061109505);
    PlayerTextDrawBackgroundColour(playerid, m_screenArrowBack[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenArrowBack[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenArrowBack[playerid], true);
    PlayerTextDrawSetProportional(playerid, m_screenArrowBack[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenArrowBack[playerid], true);

    m_screenArrowNext[playerid] = CreatePlayerTextDraw(playerid, 595.000000, 380.000000, "ld_beat:right");
    PlayerTextDrawFont(playerid, m_screenArrowNext[playerid], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, m_screenArrowNext[playerid], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, m_screenArrowNext[playerid], 12.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, m_screenArrowNext[playerid], 1);
    PlayerTextDrawSetShadow(playerid, m_screenArrowNext[playerid], 0);
    PlayerTextDrawAlignment(playerid, m_screenArrowNext[playerid], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenArrowNext[playerid], -1061109505);
    PlayerTextDrawBackgroundColour(playerid, m_screenArrowNext[playerid], 255);
    PlayerTextDrawBoxColour(playerid, m_screenArrowNext[playerid], 50);
    PlayerTextDrawUseBox(playerid, m_screenArrowNext[playerid], false);
    PlayerTextDrawSetProportional(playerid, m_screenArrowNext[playerid], true);
    PlayerTextDrawSetSelectable(playerid, m_screenArrowNext[playerid], true);



    m_screenButtonClose[playerid][0] = CreatePlayerTextDraw(playerid, 529.000000, 383.000000, "_");
    PlayerTextDrawFont(playerid, m_screenButtonClose[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, m_screenButtonClose[playerid][0], 0.600000, 0.600009);
    PlayerTextDrawTextSize(playerid, m_screenButtonClose[playerid][0], 299.500000, 53.500000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonClose[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, m_screenButtonClose[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonClose[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, m_screenButtonClose[playerid][0], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonClose[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, m_screenButtonClose[playerid][0], -1724724069);
    PlayerTextDrawUseBox(playerid, m_screenButtonClose[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, m_screenButtonClose[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonClose[playerid][0], false);

    m_screenButtonClose[playerid][1] = CreatePlayerTextDraw(playerid, 519.000000, 381.000000, "Fechar");
    PlayerTextDrawFont(playerid, m_screenButtonClose[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, m_screenButtonClose[playerid][1], 0.162487, 0.999993);
    PlayerTextDrawTextSize(playerid, m_screenButtonClose[playerid][1], 541.500000, 8.000000);
    PlayerTextDrawSetOutline(playerid, m_screenButtonClose[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, m_screenButtonClose[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, m_screenButtonClose[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, m_screenButtonClose[playerid][1], -101);
    PlayerTextDrawBackgroundColour(playerid, m_screenButtonClose[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, m_screenButtonClose[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, m_screenButtonClose[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, m_screenButtonClose[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, m_screenButtonClose[playerid][1], false);



    PlayerTextDrawSetClick(playerid, "OnClickArrowBack", m_screenArrowBack[playerid]);
    PlayerTextDrawSetClick(playerid, "OnClickArrowNext", m_screenArrowNext[playerid]);

    PlayerTextDrawSetClick(playerid, "OnClickButtonMenu", m_screenButtonClose[playerid][1]);


    m_playerPageIdCurrent[playerid] = 0;

    VSL_CreatePreviewCreateCharacterClothes(playerid);
    return 1;
}

VSL_CreatePreviewCreateCharacterClothes(playerid) {

    const
        Float:const_previewBox_posX = 443.0,
        Float:const_previewAreaClick_posX = 423.5,
        Float:const_previewSkin_posX = 397.0,

        Float:const_previewBox_posY = 183.0,
        Float:const_previewSkin_posY = 180.0
    ;

    new
        Float:previewBox_posX,
        Float:previewAreaClick_posX,
        Float:previewSkin_posX,

        Float:previewBox_posY,
        Float:previewSkin_posY
    ;


    for (new txd = 0, count = 0; txd < 10; txd++, count++) {

        if (txd == 5)
            count = 0;

        if (txd < 5) {

            previewBox_posX = const_previewBox_posX + (43.0 * count);
            previewAreaClick_posX = const_previewAreaClick_posX + (43.0 * count);
            previewSkin_posX = const_previewSkin_posX + (43.0 * count);

            previewBox_posY = const_previewBox_posY;
            previewSkin_posY = const_previewSkin_posY;
        }
        else {

            previewBox_posX = const_previewBox_posX + (43.0 * count);
            previewAreaClick_posX = const_previewAreaClick_posX + (43.0 * count);
            previewSkin_posX = const_previewSkin_posX + (43.0 * count);

            previewBox_posY = const_previewBox_posY + 94.0;
            previewSkin_posY = const_previewSkin_posY + 94.0;
        }


        m_screenPreviewBox[playerid][txd] = CreatePlayerTextDraw(playerid, previewBox_posX, previewBox_posY, "_");
        PlayerTextDrawFont(playerid, m_screenPreviewBox[playerid][txd], TEXT_DRAW_FONT_1);
        PlayerTextDrawLetterSize(playerid, m_screenPreviewBox[playerid][txd], 0.600000, 9.099998);
        PlayerTextDrawTextSize(playerid, m_screenPreviewBox[playerid][txd], 298.500000, 34.000000);
        PlayerTextDrawSetOutline(playerid, m_screenPreviewBox[playerid][txd], true);
        PlayerTextDrawSetShadow(playerid, m_screenPreviewBox[playerid][txd], false);
        PlayerTextDrawAlignment(playerid, m_screenPreviewBox[playerid][txd], TEXT_DRAW_ALIGN_CENTER);
        PlayerTextDrawColour(playerid, m_screenPreviewBox[playerid][txd], -1);
        PlayerTextDrawBackgroundColour(playerid, m_screenPreviewBox[playerid][txd], 255);
        PlayerTextDrawBoxColour(playerid, m_screenPreviewBox[playerid][txd], -1061109505);
        PlayerTextDrawUseBox(playerid, m_screenPreviewBox[playerid][txd], true);
        PlayerTextDrawSetProportional(playerid, m_screenPreviewBox[playerid][txd], true);
        PlayerTextDrawSetSelectable(playerid, m_screenPreviewBox[playerid][txd], false);

        m_screenPreviewAreaClick[playerid][txd] = CreatePlayerTextDraw(playerid, previewAreaClick_posX, previewSkin_posY, "ld_dual:white");
        PlayerTextDrawFont(playerid, m_screenPreviewAreaClick[playerid][txd], TEXT_DRAW_FONT_SPRITE);
        PlayerTextDrawLetterSize(playerid, m_screenPreviewAreaClick[playerid][txd], 0.600000, 2.000000);
        PlayerTextDrawTextSize(playerid, m_screenPreviewAreaClick[playerid][txd], 39.099998, 88.000000);
        PlayerTextDrawSetOutline(playerid, m_screenPreviewAreaClick[playerid][txd], true);
        PlayerTextDrawSetShadow(playerid, m_screenPreviewAreaClick[playerid][txd], false);
        PlayerTextDrawAlignment(playerid, m_screenPreviewAreaClick[playerid][txd], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, m_screenPreviewAreaClick[playerid][txd], 84215295);
        PlayerTextDrawBackgroundColour(playerid, m_screenPreviewAreaClick[playerid][txd], 255);
        PlayerTextDrawBoxColour(playerid, m_screenPreviewAreaClick[playerid][txd], 50);
        PlayerTextDrawUseBox(playerid, m_screenPreviewAreaClick[playerid][txd], true);
        PlayerTextDrawSetProportional(playerid, m_screenPreviewAreaClick[playerid][txd], true);
        PlayerTextDrawSetSelectable(playerid, m_screenPreviewAreaClick[playerid][txd], true);

        m_screenPreviewSkin[playerid][txd] = CreatePlayerTextDraw(playerid, previewSkin_posX, previewSkin_posY, "Preview_Model");
        PlayerTextDrawFont(playerid, m_screenPreviewSkin[playerid][txd], TEXT_DRAW_FONT_MODEL_PREVIEW);
        PlayerTextDrawLetterSize(playerid, m_screenPreviewSkin[playerid][txd], 0.600000, 2.000000);
        PlayerTextDrawTextSize(playerid, m_screenPreviewSkin[playerid][txd], 90.000000, 90.000000);
        PlayerTextDrawSetOutline(playerid, m_screenPreviewSkin[playerid][txd], false);
        PlayerTextDrawSetShadow(playerid, m_screenPreviewSkin[playerid][txd], false);
        PlayerTextDrawAlignment(playerid, m_screenPreviewSkin[playerid][txd], TEXT_DRAW_ALIGN_LEFT);
        PlayerTextDrawColour(playerid, m_screenPreviewSkin[playerid][txd], -1);
        PlayerTextDrawBackgroundColour(playerid, m_screenPreviewSkin[playerid][txd], 0);
        PlayerTextDrawBoxColour(playerid, m_screenPreviewSkin[playerid][txd], 255);
        PlayerTextDrawUseBox(playerid, m_screenPreviewSkin[playerid][txd], false);
        PlayerTextDrawSetProportional(playerid, m_screenPreviewSkin[playerid][txd], true);
        PlayerTextDrawSetSelectable(playerid, m_screenPreviewSkin[playerid][txd], false);
        PlayerTextDrawSetPreviewModel(playerid, m_screenPreviewSkin[playerid][txd], 1);
        PlayerTextDrawSetPreviewRot(playerid, m_screenPreviewSkin[playerid][txd], -10.000000, 0.000000, 0.000000, 1.000000);
        PlayerTextDrawSetPreviewVehicleColours(playerid, m_screenPreviewSkin[playerid][txd], 1, 1);


        PlayerTextDrawSetClick(playerid, "OnClickPreviewSkin", m_screenPreviewAreaClick[playerid][txd], txd);
    }
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_ShowTextdrawsCreateCharacterClothes(playerid) {

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenLayout[playerid][txd]);
    }

    VSL_EnableButtonCloseCreateCharacterClothes(playerid, m_playerSkinIdSelected[playerid] == -1 ? false : true);

    VSL_ShowPreviewCreateCharacterClothes(playerid);
    VSL_CheckPageCreateCharacterClothes(playerid);

    if (m_playerPageIdCurrent[playerid] > 0)
        PlayerTextDrawShow(playerid, m_screenArrowBack[playerid]);

    if ((m_playerPageIdCurrent[playerid] * 10) + 10 <= sizeof(allowed_clothes_ids))
        PlayerTextDrawShow(playerid, m_screenArrowNext[playerid]);

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_ShowPreviewCreateCharacterClothes(playerid) {

    new
        count = 0;

    for (new i = 10 * m_playerPageIdCurrent[playerid]; i < sizeof(allowed_clothes_ids); i++, count++) {

        if (count >= 10)
            break;

        if (!IsPlayerTextDrawVisible(playerid, m_screenPreviewBox[playerid][count])) {

            PlayerTextDrawShow(playerid, m_screenPreviewBox[playerid][count]);
            PlayerTextDrawShow(playerid, m_screenPreviewAreaClick[playerid][count]);
        }

        PlayerTextDrawSetPreviewModel(playerid, m_screenPreviewSkin[playerid][count], allowed_clothes_ids[i]);
        PlayerTextDrawShow(playerid, m_screenPreviewSkin[playerid][count]);
    }

    if (count < 10) {

        for (new txd = count; txd < 10; txd++) {

            PlayerTextDrawHide(playerid, m_screenPreviewBox[playerid][txd]);
            PlayerTextDrawHide(playerid, m_screenPreviewAreaClick[playerid][txd]);
            PlayerTextDrawHide(playerid, m_screenPreviewSkin[playerid][txd]);
        }
    }
    return 1;
}

VSL_HideTextdrawsCreateCharacterClothes(playerid) {

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawHide(playerid, m_screenLayout[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenButtonClose[playerid][txd]);
    }

    for (new txd = 0; txd < 10; txd++) {

        PlayerTextDrawHide(playerid, m_screenPreviewBox[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenPreviewAreaClick[playerid][txd]);
        PlayerTextDrawHide(playerid, m_screenPreviewSkin[playerid][txd]);
    }

    PlayerTextDrawHide(playerid, m_screenArrowBack[playerid]);
    PlayerTextDrawHide(playerid, m_screenArrowNext[playerid]);

    CancelSelectTextDraw(playerid);
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_EnableButtonCloseCreateCharacterClothes(playerid, bool:toggle) {

    if (toggle) {

        PlayerTextDrawBoxColour(playerid, m_screenButtonClose[playerid][0], -1724723969);

        PlayerTextDrawColour(playerid, m_screenButtonClose[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, m_screenButtonClose[playerid][1], true);
    }
    else {

        PlayerTextDrawBoxColour(playerid, m_screenButtonClose[playerid][0], -1724724069);
        PlayerTextDrawColour(playerid, m_screenButtonClose[playerid][1], -101);

        PlayerTextDrawSetSelectable(playerid, m_screenButtonClose[playerid][1], false);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, m_screenButtonClose[playerid][txd]);
    }
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_CheckPageCreateCharacterClothes(playerid) {

    if (m_playerSkinIdSelected[playerid] == -1)
        return 1;

    if (m_playerPageIdSkinSelected[playerid] == m_playerPageIdCurrent[playerid]) {
        VSL_MarkPreviewCreateCharacterClothes(playerid, m_playerPreviewSkinSelected{playerid});
    }
    else if (!PlayerTextDrawIsSelectable(playerid, m_screenPreviewAreaClick[playerid][m_playerPreviewSkinSelected{playerid}])) {

        VSL_MarkPreviewCreateCharacterClothes(playerid, _, m_playerPreviewSkinSelected{playerid});
    }
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_MarkPreviewCreateCharacterClothes(playerid, index_new = -1, index_old = -1) {

    if (index_new != -1) {

        PlayerTextDrawBoxColour(playerid, m_screenPreviewBox[playerid][index_new], -1724723969);
        PlayerTextDrawColour(playerid, m_screenPreviewAreaClick[playerid][index_new], -1724723969);
        PlayerTextDrawSetSelectable(playerid, m_screenPreviewAreaClick[playerid][index_new], false);

        PlayerTextDrawShow(playerid, m_screenPreviewBox[playerid][index_new]);
        PlayerTextDrawShow(playerid, m_screenPreviewAreaClick[playerid][index_new]);
    }

    if (index_old != -1) {
    
        PlayerTextDrawBoxColour(playerid, m_screenPreviewBox[playerid][index_old], -1061109505);
        PlayerTextDrawColour(playerid, m_screenPreviewAreaClick[playerid][index_old], 84215295);
        PlayerTextDrawSetSelectable(playerid, m_screenPreviewAreaClick[playerid][index_old], true);

        PlayerTextDrawShow(playerid, m_screenPreviewBox[playerid][index_old]);
        PlayerTextDrawShow(playerid, m_screenPreviewAreaClick[playerid][index_old]);
    }
    return 1;
}


/*- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
VSL_GetSkinIdCreateCharacterClothes(playerid) {
    return m_playerSkinIdSelected[playerid];
}