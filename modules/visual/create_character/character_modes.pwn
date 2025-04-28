//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new _tempPlayerTxdCharacterModeIndex[MAX_PLAYERS char];

new PlayerText:TxdCreateCharacterModesLayout[MAX_PLAYERS][2];
new PlayerText:TxdCreateCharacterModesBox[MAX_PLAYERS][4];
new PlayerText:TxdCreateCharacterModesSprite[MAX_PLAYERS][4];
new PlayerText:TxdCreateCharacterModesName[MAX_PLAYERS][4];
new PlayerText:TxdCreateCharacterModesDescription[MAX_PLAYERS][4];
new PlayerText:TxdCreateCharacterModesLevel[MAX_PLAYERS][4];
new PlayerText:TxdCreateCharacterModesExp[MAX_PLAYERS][4];
new PlayerText:TxdCreateCharacterModesButtonNext[MAX_PLAYERS][2];


//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    _tempPlayerTxdCharacterModeIndex{playerid} = 0;
    return 1;
}

hook OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid) {

    if (!IsPlayerLogged(playerid)) {

        if (playertextid == TxdCreateCharacterModesButtonNext[playerid][1]) {

            SetPlayerLogged(playerid, true);
            SetCharacterSpawned(playerid, true);

            SHARED_DestroyTextdrawLoginBackground(playerid);
            VSL_DestroyTextdrawsModeCharacterModes(playerid);
            // SetSpawnInfo(playerid, NO_TEAM, 292, 375.3465, -175.5020, 1030.6801, 90.0);
            SetSpawnInfo(playerid, NO_TEAM, 292, 0, 0, 0, 90.0);
            TogglePlayerSpectating(playerid, false);
            SpawnPlayer(playerid);
        }
        else {

            for (new txd = 0; txd < 4; txd++) {

                if (playertextid == TxdCreateCharacterModesBox[playerid][txd]) {

                    if (!tempPlayerCharacterModeId{playerid}) {

                        PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 1747094527);
                        PlayerTextDrawColour(playerid, TxdCreateCharacterModesButtonNext[playerid][1], -1);

                        PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesButtonNext[playerid][1], true);

                        PlayerTextDrawShow(playerid, TxdCreateCharacterModesButtonNext[playerid][0]);
                        PlayerTextDrawShow(playerid, TxdCreateCharacterModesButtonNext[playerid][1]);
                    }

                    VSL_UpdateTextdrawsBoxModeCharacterModes(playerid, txd);
                    tempPlayerCharacterModeId{playerid} = txd + 1;
                    break;
                }
            }
        }
    }
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
VSL_CreateTextdrawsCharacterModes(playerid) {

    TxdCreateCharacterModesLayout[playerid][0] = CreatePlayerTextDraw(playerid, 246.000000, 30.000000, "Escolha um modo");
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesLayout[playerid][0], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesLayout[playerid][0], 0.258332, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesLayout[playerid][0], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesLayout[playerid][0], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesLayout[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesLayout[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesLayout[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesLayout[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesLayout[playerid][0], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesLayout[playerid][0], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesLayout[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesLayout[playerid][0], false);

    TxdCreateCharacterModesLayout[playerid][1] = CreatePlayerTextDraw(playerid, 171.000000, 56.000000, "Voce deve escolher um modo para iniciar seu personagem.~n~Os modos lhe ajudaram a dar sentido a historia e nao poderao ser trocados");
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesLayout[playerid][1], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesLayout[playerid][1], 0.237498, 1.250000);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesLayout[playerid][1], 493.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesLayout[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesLayout[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesLayout[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesLayout[playerid][1], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesLayout[playerid][1], -1);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesLayout[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesLayout[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesLayout[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesLayout[playerid][1], false);

    TxdCreateCharacterModesButtonNext[playerid][0] = CreatePlayerTextDraw(playerid, 315.000000, 401.000000, "_");
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesButtonNext[playerid][0], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 0.600000, 3.000000);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 298.500000, 117.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesButtonNext[playerid][0], TEXT_DRAW_ALIGN_CENTER);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesButtonNext[playerid][0], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 255);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesButtonNext[playerid][0], 505290495);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesButtonNext[playerid][0], true);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesButtonNext[playerid][0], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesButtonNext[playerid][0], false);

    TxdCreateCharacterModesButtonNext[playerid][1] = CreatePlayerTextDraw(playerid, 289.000000, 403.000000, "Continuar");
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesButtonNext[playerid][1], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 0.304167, 2.099997);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesButtonNext[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 1347440895);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 255);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesButtonNext[playerid][1], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesButtonNext[playerid][1], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesButtonNext[playerid][1], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesButtonNext[playerid][1], false);


    VSL_CreateTextdrawModeCharacterModes(playerid, "ld_tatt:11dice2", "Nada a Perder", "Voce meteu o louco e veio~n~la do fim do mundo para a~n~cidade grande.~n~~n~O que voce tem e R$200~n~reais no bolso e um sonho!", "LEVEL 1", "EXP: NORMAL");
    VSL_CreateTextdrawModeCharacterModes(playerid, "ld_tatt:7mary", "Ninho Familiar", "Voce ainda mora com seus~n~pais, entao e melhor se~n~comportar ou podera ser~n~expulso.~n~~n~Pelo menos eles te deram~n~um veiculo usado que so faz~n~barulho para voce ir a~n~faculdade.", "LEVEL 4", "EXP: -20% EM PAYDAY");
    VSL_CreateTextdrawModeCharacterModes(playerid, "ld_tatt:6clown", "Simplesmente Eu", "Voce alugou seu proprio~n~cantinho e tem um emprego~n~de meio periodo desde a~n~epoca de escola.~n~~n~Sua fiel lambreta te~n~acompanha, e lenta, mas~n~raramenta te deixa na mao.", "LEVEL 2", "EXP: -15% EM PAYDAY");
    VSL_CreateTextdrawModeCharacterModes(playerid, "ld_tatt:12angel", "Terceira Idade", "Voce ja esta no final da vida~n~e se aposentou, sem muitas~n~obrigacoes. Tem um dinheiro~n~guardado, mas gasta~n~horrores com remedios.~n~~n~Se apegou demais ao seu~n~veiculo para pensar em trocar~n~por um novo.", "LEVEL 10", "EXP: NENHUM");
    return 1;
}

VSL_CreateTextdrawModeCharacterModes(playerid, const sprite_name[], const mode_name[], const mode_description[], const mode_level[], const mode_exp[]) {

    new
        index = _tempPlayerTxdCharacterModeIndex{playerid},
        Float:box_x = 58.0 + 132.0 * index,
        Float:sprite_x = box_x + 33.0,
        Float:mode_name_x = box_x + 6.0,
        Float:mode_description_x = box_x + 5.0;

    TxdCreateCharacterModesBox[playerid][index] = CreatePlayerTextDraw(playerid, box_x, 101.000000, "ld_bum:blkdot");
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesBox[playerid][index], TEXT_DRAW_FONT_SPRITE);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesBox[playerid][index], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesBox[playerid][index], 130.000000, 253.500000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesBox[playerid][index], 1);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesBox[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesBox[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesBox[playerid][index], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesBox[playerid][index], 255);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesBox[playerid][index], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesBox[playerid][index], true);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesBox[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesBox[playerid][index], true);

    TxdCreateCharacterModesSprite[playerid][index] = CreatePlayerTextDraw(playerid, sprite_x, 108.000000, sprite_name);
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesSprite[playerid][index], TEXT_DRAW_FONT_SPRITE);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesSprite[playerid][index], 0.600000, 2.000000);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesSprite[playerid][index], 55.000000, 55.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesSprite[playerid][index], 2);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesSprite[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesSprite[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesSprite[playerid][index], -1);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesSprite[playerid][index], -16776961);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesSprite[playerid][index], -16777166);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesSprite[playerid][index], true);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesSprite[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesSprite[playerid][index], false);

    TxdCreateCharacterModesName[playerid][index] = CreatePlayerTextDraw(playerid, mode_name_x, 170.000000, mode_name);
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesName[playerid][index], TEXT_DRAW_FONT_3);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesName[playerid][index], 0.304167, 2.099997);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesName[playerid][index], 543.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesName[playerid][index], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesName[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesName[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesName[playerid][index], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesName[playerid][index], 255);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesName[playerid][index], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesName[playerid][index], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesName[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesName[playerid][index], false);

    TxdCreateCharacterModesDescription[playerid][index] = CreatePlayerTextDraw(playerid, mode_description_x, 196.000000, mode_description);
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesDescription[playerid][index], TEXT_DRAW_FONT_1);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesDescription[playerid][index], 0.258332, 1.500000);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesDescription[playerid][index], 630.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesDescription[playerid][index], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesDescription[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesDescription[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesDescription[playerid][index], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesDescription[playerid][index], -1);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesDescription[playerid][index], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesDescription[playerid][index], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesDescription[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesDescription[playerid][index], false);

    TxdCreateCharacterModesLevel[playerid][index] = CreatePlayerTextDraw(playerid, mode_description_x, 320.000000, mode_level);
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesLevel[playerid][index], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesLevel[playerid][index], 0.174998, 1.599997);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesLevel[playerid][index], 504.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesLevel[playerid][index], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesLevel[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesLevel[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesLevel[playerid][index], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesLevel[playerid][index], -1);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesLevel[playerid][index], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesLevel[playerid][index], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesLevel[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesLevel[playerid][index], false);

    TxdCreateCharacterModesExp[playerid][index] = CreatePlayerTextDraw(playerid, mode_description_x, 336.000000, mode_exp);
    PlayerTextDrawFont(playerid, TxdCreateCharacterModesExp[playerid][index], TEXT_DRAW_FONT_2);
    PlayerTextDrawLetterSize(playerid, TxdCreateCharacterModesExp[playerid][index], 0.174998, 1.599997);
    PlayerTextDrawTextSize(playerid, TxdCreateCharacterModesExp[playerid][index], 541.500000, 17.000000);
    PlayerTextDrawSetOutline(playerid, TxdCreateCharacterModesExp[playerid][index], 0);
    PlayerTextDrawSetShadow(playerid, TxdCreateCharacterModesExp[playerid][index], 0);
    PlayerTextDrawAlignment(playerid, TxdCreateCharacterModesExp[playerid][index], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesExp[playerid][index], 255);
    PlayerTextDrawBackgroundColour(playerid, TxdCreateCharacterModesExp[playerid][index], -1);
    PlayerTextDrawBoxColour(playerid, TxdCreateCharacterModesExp[playerid][index], 50);
    PlayerTextDrawUseBox(playerid, TxdCreateCharacterModesExp[playerid][index], false);
    PlayerTextDrawSetProportional(playerid, TxdCreateCharacterModesExp[playerid][index], true);
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesExp[playerid][index], false);

    _tempPlayerTxdCharacterModeIndex{playerid} ++;
    return 1;
}

VSL_ShowTextdrawsModeCharacterModes(playerid) {

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawShow(playerid, TxdCreateCharacterModesLayout[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesButtonNext[playerid][txd]);
    }

    for (new txd = 0; txd < 4; txd++) {

        PlayerTextDrawShow(playerid, TxdCreateCharacterModesBox[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesSprite[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesName[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesDescription[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesLevel[playerid][txd]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesExp[playerid][txd]);
    }

    SelectTextDraw(playerid, 0xFAFAFAFF);
    return 1;
}

VSL_UpdateTextdrawsBoxModeCharacterModes(playerid, index) {

    new
        index_old = tempPlayerCharacterModeId{playerid} - 1;

    if (tempPlayerCharacterModeId{playerid}) {

        PlayerTextDrawColour(playerid, TxdCreateCharacterModesBox[playerid][index_old], -1);
        PlayerTextDrawColour(playerid, TxdCreateCharacterModesSprite[playerid][index_old], -1);
        PlayerTextDrawColour(playerid, TxdCreateCharacterModesName[playerid][index_old], 255);
        PlayerTextDrawColour(playerid, TxdCreateCharacterModesDescription[playerid][index_old], 255);
        PlayerTextDrawColour(playerid, TxdCreateCharacterModesLevel[playerid][index_old], 255);
        PlayerTextDrawColour(playerid, TxdCreateCharacterModesExp[playerid][index_old], 255);

        PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesBox[playerid][index_old], true);
        
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesSprite[playerid][index_old]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesName[playerid][index_old]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesDescription[playerid][index_old]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesLevel[playerid][index_old]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesExp[playerid][index_old]);
        PlayerTextDrawShow(playerid, TxdCreateCharacterModesBox[playerid][index_old]);
    }

    PlayerTextDrawColour(playerid, TxdCreateCharacterModesBox[playerid][index], 1747094527);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesSprite[playerid][index], 1747094527);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesName[playerid][index], -1);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesDescription[playerid][index], -1);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesLevel[playerid][index], -1);
    PlayerTextDrawColour(playerid, TxdCreateCharacterModesExp[playerid][index], -1);
    
    PlayerTextDrawSetSelectable(playerid, TxdCreateCharacterModesBox[playerid][index], false);

    PlayerTextDrawShow(playerid, TxdCreateCharacterModesSprite[playerid][index]);
    PlayerTextDrawShow(playerid, TxdCreateCharacterModesName[playerid][index]);
    PlayerTextDrawShow(playerid, TxdCreateCharacterModesDescription[playerid][index]);
    PlayerTextDrawShow(playerid, TxdCreateCharacterModesLevel[playerid][index]);
    PlayerTextDrawShow(playerid, TxdCreateCharacterModesExp[playerid][index]);
    PlayerTextDrawShow(playerid, TxdCreateCharacterModesBox[playerid][index]);
    return 1;
}

VSL_DestroyTextdrawsModeCharacterModes(playerid) {

    for (new txd = 0; txd < 2; txd++) {

        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesLayout[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesButtonNext[playerid][txd]);

        TxdCreateCharacterModesLayout[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdCreateCharacterModesButtonNext[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    for (new txd = 0; txd < 4; txd++) {

        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesBox[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesSprite[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesName[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesDescription[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesLevel[playerid][txd]);
        PlayerTextDrawDestroy(playerid, TxdCreateCharacterModesExp[playerid][txd]);

        TxdCreateCharacterModesBox[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdCreateCharacterModesSprite[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdCreateCharacterModesName[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdCreateCharacterModesDescription[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdCreateCharacterModesLevel[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
        TxdCreateCharacterModesExp[playerid][txd] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
    }

    CancelSelectTextDraw(playerid);
    return 1;
}