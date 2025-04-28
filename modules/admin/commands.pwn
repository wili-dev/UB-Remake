//=-=-=-=-=-=-=-=-=-=-=[Command's]=-=-=-=-=-=-=-=-=-=-=//
YCMD:splash(playerid, params[], help) 
{
    VSL_CreateTextdrawsLoginSplash(playerid);
    VSL_ShowTextdrawsLoginSplash(playerid);
    return 1;
}
YCMD:sultan(playerid, params[], help) 
{
    new
        Float:pos_x,
        Float:pos_y,
        Float:pos_z;
    
    GetPlayerPos(playerid, pos_x, pos_y, pos_z);

    CreateVehicle(560, pos_x, pos_y, pos_z + 5, 0.0, 0, 0, -1);
    return 1;
}

YCMD:sultan1(playerid, params[], help) 
{
    new
        Float:pos_x,
        Float:pos_y,
        Float:pos_z;
    
    GetPlayerPos(playerid, pos_x, pos_y, pos_z);

    CreateVehicle(477, pos_x, pos_y, pos_z + 5, 0.0, 0, 0, -1);
    return 1;
}

YCMD:dia(playerid, params[], help) 
{
    SetWorldTime(12);
    return 1;
}

YCMD:noite(playerid, params[], help) 
{
    SetWorldTime(20);
    return 1;
}

YCMD:noite1(playerid, params[], help) 
{
    SetWorldTime(0);
    return 1;
}

timer TimerTest[1000](playerid) {

    static index = 0;

    switch (index) {
        case 0: createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "Voce esta ficando com fome...");
        case 1: createPlayerNotification(playerid, "LD_CHAT:thumbup", "Voce pagou R$50 reais para Jorge_Luis", true);
        case 2: createPlayerNotification(playerid, SPRITE_ERROR_THUMBDN, "Voce nao possui dinheiro suficiente");
        case 3: createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "Voce recebeu R$200 reais de Nando_Oliveira", true);
    }

    index ++;
}
YCMD:notifytest(playerid, params[], help) 
{
    repeat TimerTest(playerid);
    return 1;
}

YCMD:music1(playerid, params[], help) 
{
    PlayAudioStreamForPlayer(playerid, "https://palcocdn.akamaized.net/e/4/6/5/hungriahiphop-amor-e-fe-a4c807bb.mp3",
    -6.0094,-10.3108,3.1172, 20.0, true);
    return 1;
}

YCMD:music2(playerid, params[], help) 
{
    PlayAudioStreamForPlayer(playerid, "https://palcocdn.akamaized.net/7/3/8/9/hungriahiphop-coracao-de-aco-wwwpalcomp3comdjmixer-djmixeroficial-7f241d60.mp3",
    -60.9764,-119.1387,3.1172, 20.0, true);
    return 1;
}