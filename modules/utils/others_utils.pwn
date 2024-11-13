/*
           _  _      ___  _   _                       _  _   
         _| || |_   / _ \| |_| |__   ___ _ __ ___   _| || |_ 
        |_  ..  _| | | | | __| '_ \ / _ \ '__/ __| |_  ..  _|
        |_      _| | |_| | |_| | | |  __/ |  \__ \ |_      _|
          |_||_|    \___/ \__|_| |_|\___|_|  |___/   |_||_|  
                                                             
*/

//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
bool:YSI_StopTimerSafely(&Timer:timer) {

    if (timer != Timer:0) {
        stop timer;
    }

    timer = Timer:0;
    return true;
}

ClearPlayerChat(playerid, lines) {

    for (new i = 0; i < lines; i++) {

        SendClientMessage(playerid, -1, " ");
    }
    return 1;
}


public::OnTimerKickDelay(playerid) {
    Kick(playerid);
}

KickDelay(playerid, time) {
    SetTimerEx("OnTimerKickDelay", time, false, "i", playerid);
}