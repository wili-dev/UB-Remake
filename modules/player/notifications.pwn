//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Define's]=-=-=-=-=-=-=-=-=-=//
#define MAX_PLAYER_NOTIFICATIONS (5)

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new playerNotificationCount[MAX_PLAYERS char];

enum e_player_notification_data {

    bool:e_notification_created,
    e_notification_index,
    Timer:e_notification_timer
}

new gPlayerNotificationData[MAX_PLAYERS][MAX_PLAYER_NOTIFICATIONS][e_player_notification_data];

//=-=-=-=-=-=-=-=-=-=-=[Timer's]=-=-=-=-=-=-=-=-=-=-=//
timer TimerPlayerDestroyNotification[5000](playerid, index) {

    VSL_DestroyTextdrawPlayerNotifyId(playerid, gPlayerNotificationData[playerid][index][e_notification_index]);
    resetPlayerNotificationData(playerid, index);

    playerNotificationCount{playerid} --;

    if (playerNotificationCount{playerid} > 0) {
        VSL_SetOrderTextdrawPlayerNotify(playerid);
    }
}

//=-=-=-=-=-=-=-=-=-=-=[Callck's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    playerNotificationCount{playerid} = 0;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {

    if (playerNotificationCount{playerid} > 0) {

        for (new i = 0; i < MAX_PLAYER_NOTIFICATIONS; i++) {

            if (gPlayerNotificationData[playerid][i][e_notification_created])
                resetPlayerNotificationData(playerid, i);
        }
    }
    return 1;
}

//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
resetPlayerNotificationData(playerid, index) {

    gPlayerNotificationData[playerid][index][e_notification_created] = false;
    gPlayerNotificationData[playerid][index][e_notification_index] = -1;
    YSI_StopTimerSafely(gPlayerNotificationData[playerid][index][e_notification_timer]);
    return 1;
}

createPlayerNotification(playerid, const notify_sprite[], const notify_text[], bool:notify_twoline = false, boxColor = 255) {

    new
        index;
    
    if ((index = getPlayerNotificationEmptyId(playerid)) == -1) {
        index = 0;
    }

    playerNotificationCount{playerid} ++;

    gPlayerNotificationData[playerid][index][e_notification_created] = true;
    gPlayerNotificationData[playerid][index][e_notification_timer] = defer TimerPlayerDestroyNotification(playerid, index);

    gPlayerNotificationData[playerid][index][e_notification_index] = VSL_CreateTextdrawPlayerNotify(playerid, index, notify_sprite, notify_text, notify_twoline, boxColor);
    return 1;
}

getPlayerNotificationEmptyId(playerid) {

    for (new i = 0; i < MAX_PLAYER_NOTIFICATIONS; i++) {

        if (!gPlayerNotificationData[playerid][i][e_notification_created])
            return i;
    }
    return -1;
}

setPlayerNotificationDataId(playerid, index, value) {
    return gPlayerNotificationData[playerid][index][e_notification_index] = value;
}