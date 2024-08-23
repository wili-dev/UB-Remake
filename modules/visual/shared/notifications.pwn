// OneLineStartY = 418.0
// TwoLineStartY = 411.0

// DownIsOne = DownIsOne.y + 39.0
// DownIsTwo = DownIsTwo.y + 32.0

//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Define's]=-=-=-=-=-=-=-=-=-=//
#define TXD_NOTIFY_ALINE_POSY_START   (418.0)
#define TXD_NOTIFY_TWOLINE_POSY_START (411.0)

#define TXD_NOTIFY_MARGIN_LINE_IS_ONE (32.0)
#define TXD_NOTIFY_MARGIN_LINE_IS_TWO (39.0)

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
enum e_player_txd_notifications_data {

    bool:e_player_txd_created,
    e_player_txd_notify_index
}

new txdPlayerNotificationData[MAX_PLAYERS][MAX_PLAYER_NOTIFICATIONS][e_player_txd_notifications_data];

new PlayerText:TxdSpriteNotifications[MAX_PLAYERS][MAX_PLAYER_NOTIFICATIONS];
new PlayerText:TxdBoxNotifications[MAX_PLAYERS][MAX_PLAYER_NOTIFICATIONS];
new PlayerText:TxdTextNotifications[MAX_PLAYERS][MAX_PLAYER_NOTIFICATIONS];


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
Float:VSL_GetPosYTextdrawPlayerNotify(playerid, index, bool:notify_twoline = false) {

    new
        Float:pos_x,
        Float:pos_y;

    if (index == 0)
        return notify_twoline ? TXD_NOTIFY_TWOLINE_POSY_START : TXD_NOTIFY_ALINE_POSY_START;
    
    // Redundancy
    if (TxdBoxNotifications[playerid][index - 1] == PlayerText:INVALID_PLAYER_TEXT_DRAW)
        return (TXD_NOTIFY_ALINE_POSY_START - TXD_NOTIFY_MARGIN_LINE_IS_ONE) * 5;

    PlayerTextDrawGetPos(playerid, TxdBoxNotifications[playerid][index - 1], pos_x, pos_y);

    return notify_twoline ? pos_y - TXD_NOTIFY_MARGIN_LINE_IS_TWO : pos_y - TXD_NOTIFY_MARGIN_LINE_IS_ONE;
}

VSL_CreateTextdrawPlayerNotify(playerid, notify_index, const sprite[], const text[], bool:notify_twoline = false, boxColor = 255) {

    new
        index,
        Float:pos_y;
    
    if ((index = VSL_GetTextdrawPlayerNotifyEmptyIndex(playerid)) == -1) {
        index = 0;
    }

    pos_y = VSL_GetPosYTextdrawPlayerNotify(playerid, index, notify_twoline);

    txdPlayerNotificationData[playerid][index][e_player_txd_created] = true;
    txdPlayerNotificationData[playerid][index][e_player_txd_notify_index] = notify_index;

    TxdBoxNotifications[playerid][index] = CreatePlayerTextDraw(playerid, 553.000000, pos_y, "_");
    PlayerTextDrawFont(playerid, TxdBoxNotifications[playerid][index], TEXT_DRAW_FONT_0);
    PlayerTextDrawLetterSize(playerid, TxdBoxNotifications[playerid][index], 0.554166, notify_twoline ? 3.348998 : 2.598999);
    PlayerTextDrawTextSize(playerid, TxdBoxNotifications[playerid][index], 298.500000, 165.000000);
    PlayerTextDrawSetOutline(playerid, TxdBoxNotifications[playerid][index], 1);
    PlayerTextDrawSetShadow(playerid, TxdBoxNotifications[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdBoxNotifications[playerid][index], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdBoxNotifications[playerid][index], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdBoxNotifications[playerid][index], 255);
    PlayerTextDrawBoxColour(playerid, TxdBoxNotifications[playerid][index], boxColor);
    PlayerTextDrawUseBox(playerid, TxdBoxNotifications[playerid][index], true);
    PlayerTextDrawSetProportional(playerid, TxdBoxNotifications[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdBoxNotifications[playerid][index], false);

    TxdSpriteNotifications[playerid][index] = CreatePlayerTextDraw(playerid, 476.000000, pos_y + 4.0, sprite);
    PlayerTextDrawFont(playerid, TxdSpriteNotifications[playerid][index], TEXT_DRAW_FONT_SPRITE_DRAW);
    PlayerTextDrawLetterSize(playerid, TxdSpriteNotifications[playerid][index], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdSpriteNotifications[playerid][index], 14.000000, 14.000000);
    PlayerTextDrawSetOutline(playerid, TxdSpriteNotifications[playerid][index], 1);
    PlayerTextDrawSetShadow(playerid, TxdSpriteNotifications[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdSpriteNotifications[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdSpriteNotifications[playerid][index], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdSpriteNotifications[playerid][index], 255);
    PlayerTextDrawBoxColour(playerid, TxdSpriteNotifications[playerid][index], 50);
    PlayerTextDrawUseBox(playerid, TxdSpriteNotifications[playerid][index], true);
    PlayerTextDrawSetProportional(playerid, TxdSpriteNotifications[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdSpriteNotifications[playerid][index], false);

    TxdTextNotifications[playerid][index] = CreatePlayerTextDraw(playerid, 495.000000, pos_y + 5.0, text);
    PlayerTextDrawFont(playerid, TxdTextNotifications[playerid][index], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdTextNotifications[playerid][index], 0.170000, 1.299993);
    PlayerTextDrawTextSize(playerid, TxdTextNotifications[playerid][index], 637.000000, 12.000000);
    PlayerTextDrawSetOutline(playerid, TxdTextNotifications[playerid][index], 0);
    PlayerTextDrawSetShadow(playerid, TxdTextNotifications[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdTextNotifications[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdTextNotifications[playerid][index], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdTextNotifications[playerid][index], -1);
    PlayerTextDrawBoxColour(playerid, TxdTextNotifications[playerid][index], -1523963342);
    PlayerTextDrawUseBox(playerid, TxdTextNotifications[playerid][index], false);
    PlayerTextDrawSetProportional(playerid, TxdTextNotifications[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdTextNotifications[playerid][index], false);


    PlayerTextDrawShow(playerid, TxdSpriteNotifications[playerid][index]);
    PlayerTextDrawShow(playerid, TxdBoxNotifications[playerid][index]);
    PlayerTextDrawShow(playerid, TxdTextNotifications[playerid][index]);
    return index;
}

VSL_SetOrderTextdrawPlayerNotify(playerid) {

    new
        index = 0,
        notify_id,
        notify_sprite[40],
        notify_text[100],
        notify_boxColor,
        Float:size_x,
        Float:size_y;

    for (new i = 0; i < MAX_PLAYER_NOTIFICATIONS; i++) {

        if (txdPlayerNotificationData[playerid][i][e_player_txd_created] && i != index) {

            PlayerTextDrawGetString(playerid, TxdSpriteNotifications[playerid][i], notify_sprite);
            PlayerTextDrawGetString(playerid, TxdTextNotifications[playerid][i], notify_text);
            PlayerTextDrawGetLetterSize(playerid, TxdBoxNotifications[playerid][i], size_x, size_y);
            notify_boxColor = PlayerTextDrawGetBoxColour(playerid, TxdBoxNotifications[playerid][i]);

            notify_id = VSL_CreateTextdrawPlayerNotify(playerid, txdPlayerNotificationData[playerid][i][e_player_txd_notify_index], notify_sprite, notify_text, size_y > 2.6 ? true : false, notify_boxColor);
            setPlayerNotificationDataId(playerid, txdPlayerNotificationData[playerid][i][e_player_txd_notify_index], notify_id);

            VSL_DestroyTextdrawPlayerNotifyId(playerid, i);

            index ++;
        }
    }
    return 1;
}

VSL_GetTextdrawPlayerNotifyEmptyIndex(playerid) {

    for (new i = 0; i < MAX_PLAYER_NOTIFICATIONS; i++) {

        if (!txdPlayerNotificationData[playerid][i][e_player_txd_created])
            return i;
    }
    return -1;
}

VSL_DestroyTextdrawPlayerNotifyId(playerid, index) {

    PlayerTextDrawDestroy(playerid, TxdSpriteNotifications[playerid][index]);
    PlayerTextDrawDestroy(playerid, TxdBoxNotifications[playerid][index]);
    PlayerTextDrawDestroy(playerid, TxdTextNotifications[playerid][index]);

    TxdSpriteNotifications[playerid][index] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    TxdBoxNotifications[playerid][index] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    TxdTextNotifications[playerid][index] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    txdPlayerNotificationData[playerid][index][e_player_txd_created] = false;
    txdPlayerNotificationData[playerid][index][e_player_txd_notify_index] = -1;
    return 1;
}