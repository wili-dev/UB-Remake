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

Utils_RandomCodeSafely() {

    new
        str_code[7];

    for (new i = 0; i < 6; i++) {
        str_code[i] = random(10) + '0';
    }

    str_code[6] = '\0';
    return str_code;
}

Utils_StrRemoveAllSpaces(string[])
{
    new i, j = 0;

    for (i = 0; string[i] != '\0'; i++) {

        if (string[i] != ' ' && string[i] != '\t') {
            string[j++] = string[i];
        }
    }

    string[j] = '\0';
}



GetFirstname(const name[])
{
	new
        underscore,
        playername[MAX_PLAYER_NAME + 1];

    strcat(playername, name);

	return underscore = strfind(playername, "_"), strdel(playername, underscore, MAX_PLAYER_NAME), playername;
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