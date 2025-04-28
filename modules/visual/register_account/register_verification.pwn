//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
static m_timerCountResendCode[MAX_PLAYERS];
static Timer:m_timerDelayResendCode[MAX_PLAYERS];

static m_playerInputCode[MAX_PLAYERS][15];

static PlayerText:TxdRegisterPlayerVerifLayout[MAX_PLAYERS];
static PlayerText:TxdRegisterPlayerVerifBoxField[MAX_PLAYERS];
static PlayerText:TxdRegisterPlayerVerifTextField[MAX_PLAYERS];
static PlayerText:TxdRegisterPlayerVerifButtonResend[MAX_PLAYERS];
static PlayerText:TxdRegisterPlayerVerifButtonNext[MAX_PLAYERS][2];


//=-=-=-=-=-=-=-=-=-=-=[Timer's]=-=-=-=-=-=-=-=-=-=-=//
timer OnTimerDelayResendCode[1000](playerid) {

    new
        hours,
        minutes,
        seconds
    ;

    m_timerCountResendCode[playerid] --;

    if (m_timerCountResendCode[playerid] > 0) {

        GetElapsedTime(m_timerCountResendCode[playerid], hours, minutes, seconds);

        PlayerTextDrawSetString(playerid, TxdRegisterPlayerVerifButtonResend[playerid], "Reenviar codigo (%02d:%02d)", minutes, seconds);
    }
    else {

        m_timerCountResendCode[playerid] = -1;

        YSI_StopTimerSafely(m_timerDelayResendCode[playerid]);

        PlayerTextDrawSetString(playerid, TxdRegisterPlayerVerifButtonResend[playerid], "Reenviar codigo");
        VSL_EnableRegisterPlayerVerifButtonResend(playerid, true);
    }
}


//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    m_timerCountResendCode[playerid] = -1;
    return 1;
}

hook OnPlayerDisconnect(playerid, reason) {

    YSI_StopTimerSafely(m_timerDelayResendCode[playerid]);
    return 1;
}



PlayerTextDrawClick:OnClickRegisterPlayerVerifCode(playerid, params) {

    VSL_HideTextdrawsRegisterPlayerVerifInputField(playerid);

    ShowPlayerDialogRegisterValidCode(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegPlayerVerifResend(playerid, params) {

    VSL_HideTextdrawsRegisterPlayerVerifInputField(playerid);

    ShowPlayerDialogRegisterResendEmail(playerid);
    return 1;
}

PlayerTextDrawClick:OnClickRegPlayerVerifBtnNext(playerid, params) {

    if (isnull(m_playerInputCode[playerid]) || strlen(m_playerInputCode[playerid]) != 6 || strcmp(GetPlayerCacheEmailCode(playerid), m_playerInputCode[playerid]) != 0) {

        AddPlayerCacheEmailAttempt(playerid);

        if (GetPlayerCacheEmailAttempt(playerid) >= 3) {
            return Kick(playerid);
        }

        new
            string[25];
        
        format(string, _, "Codigo invalido! (%d/3)", GetPlayerCacheEmailAttempt(playerid));
        createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, string, _, 0x202020FF);

        m_playerInputCode[playerid][0] = '\0';

        PlayerTextDrawSetString(playerid, TxdRegisterPlayerVerifTextField[playerid], "Codigo de verificacao");
        VSL_EnableRegisterPlayerVerifButtonNext(playerid, false);
        return 1;
    }

    if (gettime() > GetPlayerCacheEmailExpire(playerid)) {
        createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "Esse codigo expirou.", _, 0x202020FF);
        return 1;
    }

    createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "Conta verificada!", _, 0x202020FF);

    SHARED_DestroyTextdrawsLoginLogo(playerid);
    VSL_DestroyTextdrawsRegisterPlayerVerification(playerid);

    VSL_CreateTextdrawsRegisterCharacterModes(playerid);
    VSL_ShowTextdrawsRegisterCharacterModes(playerid);
    return 1;
}



//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsRegisterPlayerVerification(playerid) {

    TxdRegisterPlayerVerifLayout[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 3.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterPlayerVerifLayout[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterPlayerVerifLayout[playerid], 1.158331, 49.900001);
    PlayerTextDrawTextSize(playerid, TxdRegisterPlayerVerifLayout[playerid], 298.500000, 182.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterPlayerVerifLayout[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterPlayerVerifLayout[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterPlayerVerifLayout[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifLayout[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterPlayerVerifLayout[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifLayout[playerid], 168430335);
    PlayerTextDrawUseBox(playerid, TxdRegisterPlayerVerifLayout[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterPlayerVerifLayout[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifLayout[playerid], false);

    TxdRegisterPlayerVerifBoxField[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 174.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterPlayerVerifBoxField[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterPlayerVerifBoxField[playerid], 0.600000, 1.500002);
    PlayerTextDrawTextSize(playerid, TxdRegisterPlayerVerifBoxField[playerid], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterPlayerVerifBoxField[playerid], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterPlayerVerifBoxField[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterPlayerVerifBoxField[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifBoxField[playerid], -1724723969);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterPlayerVerifBoxField[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifBoxField[playerid], -1);
    PlayerTextDrawUseBox(playerid, TxdRegisterPlayerVerifBoxField[playerid], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterPlayerVerifBoxField[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifBoxField[playerid], false);

    TxdRegisterPlayerVerifTextField[playerid] = CreatePlayerTextDraw(playerid, 319.000000, 176.000000, "Codigo de verificacao");
    PlayerTextDrawFont(playerid, TxdRegisterPlayerVerifTextField[playerid], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterPlayerVerifTextField[playerid], 0.141653, 0.999997);
    PlayerTextDrawTextSize(playerid, TxdRegisterPlayerVerifTextField[playerid], 8.000000, 83.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterPlayerVerifTextField[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterPlayerVerifTextField[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterPlayerVerifTextField[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifTextField[playerid], 1296911871);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterPlayerVerifTextField[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifTextField[playerid], 255);
    PlayerTextDrawUseBox(playerid, TxdRegisterPlayerVerifTextField[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterPlayerVerifTextField[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifTextField[playerid], true);

    TxdRegisterPlayerVerifButtonResend[playerid] = CreatePlayerTextDraw(playerid, 318.000000, 216.000000, "Reenviar codigo");
    PlayerTextDrawFont(playerid, TxdRegisterPlayerVerifButtonResend[playerid], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 0.166660, 1.049996);
    PlayerTextDrawTextSize(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 9.000000, 45.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterPlayerVerifButtonResend[playerid], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 1296911871); // -1061109505
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 255);
    PlayerTextDrawUseBox(playerid, TxdRegisterPlayerVerifButtonResend[playerid], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterPlayerVerifButtonResend[playerid], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonResend[playerid], false);


    TxdRegisterPlayerVerifButtonNext[playerid][0] = CreatePlayerTextDraw(playerid, 318.000000, 365.000000, "_");
    PlayerTextDrawFont(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], 0.600000, 1.450003);
    PlayerTextDrawTextSize(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], 298.500000, 116.500000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], -1724724069);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], -1724724069); // 1724724199 // -1724723969
    PlayerTextDrawUseBox(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], false);

    TxdRegisterPlayerVerifButtonNext[playerid][1] = CreatePlayerTextDraw(playerid, 300.000000, 365.000000, "Continuar"); // 
    PlayerTextDrawFont(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], 0.204162, 1.299998);
    PlayerTextDrawTextSize(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], 339.000000, 11.000000);
    PlayerTextDrawSetOutline(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], -101);
    PlayerTextDrawBackgroundColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], 255);
    PlayerTextDrawUseBox(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], false);


    PlayerTextDrawSetClick(playerid, "OnClickRegisterPlayerVerifCode", TxdRegisterPlayerVerifTextField[playerid]);
    PlayerTextDrawSetClick(playerid, "OnClickRegPlayerVerifResend", TxdRegisterPlayerVerifButtonResend[playerid]);
    PlayerTextDrawSetClick(playerid, "OnClickRegPlayerVerifBtnNext", TxdRegisterPlayerVerifButtonNext[playerid][1]);
    return 1;
}

VSL_ShowTextdrawsRegisterPlayerVerification(playerid) {

    PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifLayout[playerid]);
    PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifBoxField[playerid]);

    if (m_playerInputCode[playerid][0] == '\0')
        PlayerTextDrawSetString(playerid, TxdRegisterPlayerVerifTextField[playerid], "Codigo de verificacao");

    PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifTextField[playerid]);

    PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifButtonResend[playerid]);

    VSL_EnableRegisterPlayerVerifButtonResend(playerid, m_timerCountResendCode[playerid] == -1);
    VSL_EnableRegisterPlayerVerifButtonNext(playerid, m_playerInputCode[playerid][0] != '\0');

    SelectTextDraw(playerid, 0x7E57C2FF);
    return 1;
}

VSL_HideTextdrawsRegisterPlayerVerifInputField(playerid) {

    PlayerTextDrawHide(playerid, TxdRegisterPlayerVerifBoxField[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterPlayerVerifTextField[playerid]);
    PlayerTextDrawHide(playerid, TxdRegisterPlayerVerifButtonResend[playerid]);

    PlayerTextDrawHide(playerid, TxdRegisterPlayerVerifButtonResend[playerid]);
    
    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawHide(playerid, TxdRegisterPlayerVerifButtonNext[playerid][txd]);
    }
    
    CancelSelectTextDraw(playerid);
    return 1;
}

VSL_DestroyTextdrawsRegisterPlayerVerification(playerid) {

    PlayerTextDrawDestroy(playerid, TxdRegisterPlayerVerifLayout[playerid]);
    TxdRegisterPlayerVerifLayout[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterPlayerVerifBoxField[playerid]);
    TxdRegisterPlayerVerifBoxField[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterPlayerVerifTextField[playerid]);
    TxdRegisterPlayerVerifTextField[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    PlayerTextDrawDestroy(playerid, TxdRegisterPlayerVerifButtonResend[playerid]);
    TxdRegisterPlayerVerifButtonResend[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawDestroy(playerid, TxdRegisterPlayerVerifButtonNext[playerid][txd]);
        TxdRegisterPlayerVerifButtonNext[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }
    
    CancelSelectTextDraw(playerid);
    return 1;
}

VSL_SetStringTxdRegisterPlayerVerifCode(playerid, const code[]) {

    format(m_playerInputCode[playerid], _, code);
    PlayerTextDrawSetString(playerid, TxdRegisterPlayerVerifTextField[playerid], "%s", m_playerInputCode[playerid]);
    return 1;
}

VSL_EnableRegisterPlayerVerifButtonResend(playerid, bool:toggle) {

    if (toggle) {

        PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonResend[playerid], -1061109505);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonResend[playerid], true);

        PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifButtonResend[playerid]);
    }
    else {

        PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonResend[playerid], 1296911871);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonResend[playerid], false);

        PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifButtonResend[playerid]);
    }
    return 1;
}

VSL_EnableRegisterPlayerVerifButtonNext(playerid, bool:toggle) {

    if (toggle) {

        PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], -1724723969);

        PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], -1);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], true);
    }
    else {

        PlayerTextDrawBoxColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][0], -1724724069);

        PlayerTextDrawColour(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], -101);
        PlayerTextDrawSetSelectable(playerid, TxdRegisterPlayerVerifButtonNext[playerid][1], false);
    }

    for (new txd = 0; txd < 2; txd++) {
        PlayerTextDrawShow(playerid, TxdRegisterPlayerVerifButtonNext[playerid][txd]);
    }
    return 1;
}

VSL_TimerResendRegisterPlayerVerif(playerid, sec_time) {

    m_playerInputCode[playerid][0] = '\0';

    m_timerCountResendCode[playerid] = sec_time;
    m_timerDelayResendCode[playerid] = repeat OnTimerDelayResendCode(playerid);
    return 1;
}