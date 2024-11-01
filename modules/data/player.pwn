//=-=-=-=-=-=-=-=-=-=-=[Include's]-=-=-=-=-=-=-=-=-=-=//
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=//
new bool:gIsPlayerLogged[MAX_PLAYERS];
new bool:gIsCharacterSpawned[MAX_PLAYERS];

new tempPlayerBirthDay[MAX_PLAYERS][3];
new tempPlayerBirthMonth[MAX_PLAYERS][3];
new tempPlayerBirthYear[MAX_PLAYERS][5];
new tempPlayerPassword[MAX_PLAYERS][21];
new tempPlayerPasswordConfirm[MAX_PLAYERS][21];
new tempPlayerCharacterModeId[MAX_PLAYERS char];

enum e_player_adata {

    e_player_database_id,
    e_player_username[MAX_PLAYER_NAME + 1],
    e_player_password[BCRYPT_HASH_LENGTH],
    e_player_email[51],
    e_player_birthdate[11],
    e_player_genre[3],
    e_player_admin,
    e_player_lastlogin[11],
    e_player_ip[17],
}

new gPlayerAccountData[MAX_PLAYERS][e_player_adata];

//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnPlayerConnect(playerid) {

    ResetPlayerData(playerid);

    GetPlayerName(playerid, gPlayerAccountData[playerid][e_player_username]);
    return 1;
}

hook OnPlayerRequestClass(playerid, classid) {

    if (IsCharacterSpawned(playerid))
        return 0;

    ClearPlayerChat(playerid, 10);
    TogglePlayerSpectating(playerid, true);


    SHARED_CreateTextdrawLoginBackground(playerid);
    SHARED_ShowTextdrawLoginBackground(playerid);

    VSL_CreateTextdrawsCharacterModes(playerid);
    VSL_ShowTextdrawsModeCharacterModes(playerid);

    // VSL_CreateTextdrawsLoginSplash(playerid);
    // VSL_ShowTextdrawsLoginSplash(playerid);

    // if (!IsValidRoleplayName(GetPlayerNameEx(playerid))) {

    //     return 0;
    // }
    return 0;
}

public::OnEncryptPasswordRegister(playerid) {

	bcrypt_get_hash(gPlayerAccountData[playerid][e_player_password]);

    SQL_CreatePlayerAccount(playerid);
    return 1;
}

public::BcryptCheckPasswordLogin(playerid, bool:success) {

    if (success) {
        SQL_LoadPlayerAccount(playerid, GetPlayerDatabaseID(playerid));
    }
    else {

        createPlayerNotification(playerid, SPRITE_ERROR_THUMBDN, "Senha incorreta", _, 0x202020FF); // 1296911700
    }
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
SQL_LoginCheckExistsAccount(playerid, username[]) {

    new
        query[90];

    mysql_format(getMySQLHandle(), query, sizeof(query), "SELECT id, password FROM accounts WHERE username = '%e' LIMIT 1", username);

    inline Response() {

        if (cache_num_rows() > 0) {

            cache_get_value_name_int(0, "id", gPlayerAccountData[playerid][e_player_database_id]);
            cache_get_value_name(0, "password", gPlayerAccountData[playerid][e_player_password]);

            VSL_CreateTextdrawsLogin(playerid);
            VSL_ShowTextdrawsLogin(playerid);
        }
        else {

            VSL_CreateTextdrawsRegister(playerid);
            VSL_ShowTextdrawsRegister(playerid);
        }
    }

    MySQL_TQueryInline(getMySQLHandle(), using inline Response, query);
    return 1;
}

SQL_LoadPlayerAccount(playerid, accountid) {

    inline Response() {

        if (cache_num_rows() > 0) {
            
            createPlayerNotification(playerid, "LD_CHAT:thumbup", "Voce logou na sua conta");

            VSL_DestroyTextdrawsLogin(playerid);

            SetPlayerLogged(playerid, true);
            SetCharacterSpawned(playerid, true);

            // SetSpawnInfo(playerid, NO_TEAM, 292, 1456.1946, -1449.6780, 883.8258, 0.0);
            SetSpawnInfo(playerid, NO_TEAM, 292, 0.0, 0.0, 10.0, 0.0);
            TogglePlayerSpectating(playerid, false);
        }
    }

    MySQL_TQueryInline(getMySQLHandle(), using inline Response, "SELECT email, admin, last_login FROM accounts WHERE id = '%d' LIMIT 1", accountid);
    return 1;
}

SQL_CreatePlayerAccount(playerid) {

    new
        query[300];

    mysql_format(getMySQLHandle(), query, sizeof(query),
    "INSERT INTO accounts (username, password, email, birth_date, genre, register_date) VALUES('%s', '%e', '%e', '%s', '%s', '%s');",
    gPlayerAccountData[playerid][e_player_username], gPlayerAccountData[playerid][e_player_password], gPlayerAccountData[playerid][e_player_email],
    gPlayerAccountData[playerid][e_player_birthdate], gPlayerAccountData[playerid][e_player_genre], GetDateTime());

    inline Response() {

        if (cache_affected_rows() > 0) {

        }
    }

    MySQL_TQueryInline(getMySQLHandle(), using inline Response, query);
    return 1;
}



//----------------------------------------------------//
ResetPlayerData(playerid) {

    gIsPlayerLogged[playerid] = false;
    gIsCharacterSpawned[playerid] = false;

    tempPlayerBirthDay[playerid][0] = '\0';
    tempPlayerBirthMonth[playerid][0] = '\0';
    tempPlayerBirthYear[playerid][0] = '\0';
    tempPlayerPassword[playerid][0] = '\0';
    tempPlayerPasswordConfirm[playerid][0] = '\0';
    tempPlayerCharacterModeId{playerid} = 0;

    gPlayerAccountData[playerid][e_player_database_id] = 0;
    gPlayerAccountData[playerid][e_player_username] = '\0';
    gPlayerAccountData[playerid][e_player_password] = '\0';
    gPlayerAccountData[playerid][e_player_email] = '\0';
    gPlayerAccountData[playerid][e_player_birthdate] = '\0';
    gPlayerAccountData[playerid][e_player_genre] = '\0';
    gPlayerAccountData[playerid][e_player_admin] = 0;
    gPlayerAccountData[playerid][e_player_lastlogin] = '\0';
    gPlayerAccountData[playerid][e_player_ip] = '\0';

    SetPlayerTeam(playerid, NO_TEAM);
    StopAudioStreamForPlayer(playerid);
    return 1;
}

GetPlayerDatabaseID(playerid) {
    return gPlayerAccountData[playerid][e_player_database_id];
}

GetPlayerNameEx(playerid) {
    return gPlayerAccountData[playerid][e_player_username];
}

GetPlayerEmail(playerid) {

    new
        str[55];
    strcat(str, gPlayerAccountData[playerid][e_player_email]);
    return str;
}

GetPlayerBirthDate(playerid) {
    return gPlayerAccountData[playerid][e_player_birthdate];
}

GetPlayerGender(playerid) {
    return gPlayerAccountData[playerid][e_player_genre];
}

IsPlayerLogged(playerid) {
    return (IsPlayerConnected(playerid) && gIsPlayerLogged[playerid]);
}

SetPlayerLogged(playerid, bool:status) {
    return gIsPlayerLogged[playerid] = status;
}

IsCharacterSpawned(playerid) {
    return (IsPlayerConnected(playerid) && gIsPlayerLogged[playerid] && gIsCharacterSpawned[playerid]);
}

SetCharacterSpawned(playerid, bool:status) {
    return gIsCharacterSpawned[playerid] = status;
}



//----------------------------------------------------//
ShowPlayerDialogLogin(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    VSL_HideTextdrawsLoginInputPass(playerid);

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            new passLength = strlen(inputtext);

            if (isnull(inputtext) || passLength < 5 || passLength > 20)
                return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Login", "{FF6347}ERRO: Min 5, Max 20 caracteres\n{FFFFFF}Digite sua senha abaixo para fazer login", "Entrar", "Cancelar");

            bcrypt_verify(playerid, "BcryptCheckPasswordLogin", inputtext, gPlayerAccountData[playerid][e_player_password]);
        }

        VSL_ShowTextdrawsLogin(playerid);
        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Login", "{FFFFFF}Digite sua senha abaixo para fazer login", "Entrar", "Cancelar");
    return 1;
}

ShowPlayerDialogRegisterBirthDate(playerid, field_id) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    VSL_HideTextdrawsRegisterInputField(playerid);

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogRegisterBirthDate(playerid, field_id);

            switch (field_id) {

                case 1: ShowPlayerDialogRegisterDateOfBirth(playerid, listitem);
            }
        }
        else {

            switch (field_id) {

                case 1: {
                    
                    if (!isnull(tempPlayerBirthDay[playerid]) && !isnull(tempPlayerBirthMonth[playerid]) && !isnull(tempPlayerBirthYear[playerid])) {

                        format(gPlayerAccountData[playerid][e_player_birthdate], _, "%02d/%02d/%s", strval(tempPlayerBirthDay[playerid]), strval(tempPlayerBirthMonth[playerid]), tempPlayerBirthYear[playerid]);
                        VSL_UpdateTextdrawRegisterBirthDate(playerid, gPlayerAccountData[playerid][e_player_birthdate]);
                    }
                }
            }

            VSL_ShowTextdrawsRegister(playerid);
            SelectTextDraw(playerid, 0x7E57C2FF);
        }
    }

    switch (field_id) {

        case 1: {

            new
                str[60],
                string[60];

            format(string, _, "Dia\t%02s\nMes\t%s\nAno\t%s",
            isnull(tempPlayerBirthDay[playerid]) ? "DD" : tempPlayerBirthDay[playerid],
            isnull(tempPlayerBirthMonth[playerid]) ? "MM" : GetNameMonth(strval(tempPlayerBirthMonth[playerid])),
            isnull(tempPlayerBirthYear[playerid]) ? "YYYY" : tempPlayerBirthYear[playerid]);

            strcat(str, string);

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Data de Nascimento", str, ">>", "<<");
        }
    }
    return 1;
}

ShowPlayerDialogRegisterDateOfBirth(playerid, listid) {

    new
        str[200],
        string[15];

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogRegisterDateOfBirth(playerid, listid);

            switch (listid) {

                case 0: format(tempPlayerBirthDay[playerid], _, "%d", listitem + 1);
                case 1: format(tempPlayerBirthMonth[playerid], _, "%d", listitem + 1);
                case 2: format(tempPlayerBirthYear[playerid], _, "%d", 2012 - listitem);
            }

            ShowPlayerDialogRegisterBirthDate(playerid, 1);
        }
        else {

            ShowPlayerDialogRegisterBirthDate(playerid, 1);
        }
    }

    switch (listid) {

        case 0: {

            for (new i = 1; i <= 31; i++) {

                format(string, sizeof(string), "%02d\n", i);
                strcat(str, string);
            }

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Escolha uma data", str, ">>", "<<");
        }
        case 1: {

            for (new i = 1; i <= 12; i++) {

                format(string, sizeof(string), "%d. %s\n", i, GetNameMonth(i));
                strcat(str, string);
            }

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Escolha uma mes", str, ">>", "<<");
        }
        case 2: {

            new
                countYear = 2012;

            while (countYear >= 1974) {

                format(string, sizeof(string), "%d\n", countYear);
                strcat(str, string);

                countYear --;
            }

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Escolha um ano", str, ">>", "<<");
        }
    }
    return 1;
}

ShowPlayerDialogRegisterGender(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    VSL_HideTextdrawsRegisterInputField(playerid);

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            if (listitem == -1)
                return ShowPlayerDialogRegisterGender(playerid);
            
            switch (listitem) {

                case 0: format(gPlayerAccountData[playerid][e_player_genre], _, "M");
                case 1: format(gPlayerAccountData[playerid][e_player_genre], _, "F");
                case 2: format(gPlayerAccountData[playerid][e_player_genre], _, "NB");
            }

            VSL_UpdateTextdrawRegisterGender(playerid, listitem);
        }

        VSL_ShowTextdrawsRegister(playerid);
        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Escolha seu genero", "1. Masculino\n2. Feminino\n3. Nao binario", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterEmail(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    VSL_HideTextdrawsRegisterInputField(playerid);

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {
            
            if (isnull(inputtext) || strlen(inputtext) > 50)// || !IsValidEmail(inputtext))
                return ShowPlayerDialogRegisterEmail(playerid);

            format(gPlayerAccountData[playerid][e_player_email], _, inputtext);
            VSL_UpdateTextdrawRegisterEmail(playerid, inputtext);

            VSL_ShowTextdrawsRegister(playerid);
            SelectTextDraw(playerid, 0x7E57C2FF);
        }
        else {

            VSL_ShowTextdrawsRegister(playerid);
            SelectTextDraw(playerid, 0x7E57C2FF);
        }
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "E-mail", "{FFFFFF}Digite o seu e-mail para validar a sua conta\n{B366D9}LEMBRE-SE: {FFFFFF}Aceitamos somente os dominios @gmail, @hotmail e @outlook", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterPassword(playerid, field_id) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    VSL_HideTextdrawsRegisterInputField(playerid);

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 5 || strlen(inputtext) > 20 || field_id == 2 && strcmp(tempPlayerPassword[playerid], inputtext)) {

                if (field_id == 1) {
 
                    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Ops...", "{FF6347}ERRO: Formato de senha invalido\n{FFFFFF}Digite sua senha abaixo\n\n{B366D9}OBS: {FFFFFF}Min 5, Max 20 caracteres", ">>", "<<");
                }
                else {

                    if (!isnull(tempPlayerPasswordConfirm[playerid])) {
                        
                        tempPlayerPasswordConfirm[playerid][0] = '\0';
                        VSL_UpdateTextdrawRegisterPasswordConfirm(playerid, "Confirme sua senha");
                    }

                    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Ops...", "{FF6347}ERRO: As senhas nao coincidem\n{FFFFFF}Digite novamente sua senha", ">>", "<<");
                }
                return 1;
            }

            if (field_id == 1) {

                format(tempPlayerPassword[playerid], _, inputtext);
                VSL_UpdateTextdrawRegisterPassword(playerid, inputtext);
            }
            else {

                format(tempPlayerPasswordConfirm[playerid], _, inputtext);
                VSL_UpdateTextdrawRegisterPasswordConfirm(playerid, inputtext);
            }

            VSL_ShowTextdrawsRegister(playerid);
            SelectTextDraw(playerid, 0x7E57C2FF);
        }
        else {

            VSL_ShowTextdrawsRegister(playerid);
            SelectTextDraw(playerid, 0x7E57C2FF);
        }
    }

    if (field_id == 1)
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Digite sua senha", "{FFFFFF}Digite sua senha abaixo\n\n{B366D9}OBS: {FFFFFF}Min 5, Max 20 caracteres", ">>", "<<");
    else
        Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Confirme sua senha", "{FFFFFF}Digite novamente sua senha", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterEmailCode(playerid) {

    inline Response(response, listitem, string:inputtext[]) {
       
        #pragma unused listitem, inputtext

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) != 6)
                return ShowPlayerDialogRegisterEmailCode(playerid);

            VSL_UpdateTextdrawRegisterEmailCode(playerid, inputtext);
            VSL_ShowTextdrawsRegisterEmailCode(playerid);
        }
        else
            VSL_ShowTextdrawsRegisterEmailCode(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Insira o codigo de confirmacao", "{FFFFFF}{FFFFFF}Verifique se voce recebeu um e-mail contendo um\ncodigo de 6 digitos.", ">>", "<<");
    return 1;
}