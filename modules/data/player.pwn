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

new tempPlayerBirthDay[MAX_PLAYERS][3];
new tempPlayerBirthMonth[MAX_PLAYERS][3];
new tempPlayerBirthYear[MAX_PLAYERS][5];
new tempPlayerPassword[MAX_PLAYERS][20 + 1];
new tempPlayerPasswordConfirm[MAX_PLAYERS][20 + 1];
new tempPlayerCharacterModeId[MAX_PLAYERS char];

new bool:gIsPlayerLogged[MAX_PLAYERS];
new bool:gIsCharacterSpawned[MAX_PLAYERS];

static m_playerCharacterSelected[MAX_PLAYERS char];

new m_playerActorId;

enum e_player_data {

    e_player_database_id,
    e_player_username[MAX_PLAYER_NAME + 1],
    e_player_password[BCRYPT_HASH_LENGTH],
    e_player_email[51],
    e_player_birthdate[11],
    e_player_gender[3],
    e_player_admin,
    e_player_lastlogin[11],
    e_player_ip[17],
}

static gPlayerAccountData[MAX_PLAYERS][e_player_data];


enum e_player_character_data {

    e_character_database_id,
    e_character_username[MAX_PLAYER_NAME + 1],
    e_character_nickname[30],
    e_character_date_birth[11],
    e_character_gender[2],
    e_character_nationality,
    e_character_place_birth,
    e_character_ethnicity,
    e_character_nationality_custom[30],
    e_character_place_birth_custom[30],
    e_character_ethnicity_custom[30]
}

static gPlayerCharacterData[MAX_PLAYERS][MAX_PLAYER_CHARACTERS][e_player_character_data];


enum e_player_cache_email {

    e_player_email_code[7],
    e_player_email_attempt,
    e_player_email_expire
}

static gPlayerCacheEmail[MAX_PLAYERS][e_player_cache_email];


/*======================================================================================================================
                           _  _      ____      _ _ _                _    _         _  _   
                         _| || |_   / ___|__ _| | | |__   __ _  ___| | _( )___   _| || |_ 
                        |_  ..  _| | |   / _` | | | '_ \ / _` |/ __| |/ /// __| |_  ..  _|
                        |_      _| | |__| (_| | | | |_) | (_| | (__|   <  \__ \ |_      _|
                          |_||_|    \____\__,_|_|_|_.__/ \__,_|\___|_|\_\ |___/   |_||_|  

======================================================================================================================*/

hook OnPlayerConnect(playerid) {

    ResetPlayerData(playerid);
    ResetPlayerCharacterData(playerid);

    GetPlayerName(playerid, gPlayerAccountData[playerid][e_player_username]);

    StopAudioStreamForPlayer(playerid);
    PlayAudioStreamForPlayer(playerid, "https://www.dropbox.com/scl/fi/cv6uxqupsvetman3gcu77/Hablemos-de-Futuro.mp3?rlkey=taobh7d72n8z2umjozk2v1693&st=etbdzb3o&dl=1");
    return 1;
}

hook OnPlayerRequestClass(playerid, classid) {

    if (IsCharacterSpawned(playerid))
        return 0;

    ClearPlayerChat(playerid, 10);
    TogglePlayerSpectating(playerid, true);

    SHARED_CreateTextdrawLoginBackgroundBox(playerid);
    SHARED_ShowTextdrawsLoginBackground(playerid);

    // VSL_CreateTextdrawsCreateCharacterClothes(playerid);
    // VSL_ShowTextdrawsCreateCharacterClothes(playerid);

    // VSL_CreateTextdrawsRegisterCharacterModes(playerid);
    // VSL_ShowTextdrawsRegisterCharacterModes(playerid);

    VSL_CreateTextdrawsLoginSplash(playerid);
    VSL_ShowTextdrawsLoginSplash(playerid);
    return 0;
}

public::OnEncryptPasswordRegister(playerid) {

	bcrypt_get_hash(gPlayerAccountData[playerid][e_player_password]);

    SQL_CreatePlayerAccount(playerid);
    return 1;
}

public::BcryptCheckPasswordLogin(playerid, bool:success) {

    DeletePVar(playerid, "temp_password_login");

    if (success) {

        SQL_LoadPlayerAccount(playerid, GetPlayerDatabaseID(playerid));
    }
    else {

        VSL_UpdateTextdrawLayoutFieldPassLogin(playerid);
        VSL_EnableButtonLoginScreenLogin(playerid, false);

        createPlayerNotification(playerid, SPRITE_ERROR_THUMBDN, "Senha incorreta", _, 0x202020FF); // 1296911700
    }
}



/*======================================================================================================================
                        _  _     _____                 _   _             _         _  _   
                      _| || |_  |  ___|   _ _ __   ___| |_(_) ___  _ __ ( )___   _| || |_ 
                     |_  ..  _| | |_ | | | | '_ \ / __| __| |/ _ \| '_ \|// __| |_  ..  _|
                     |_      _| |  _|| |_| | | | | (__| |_| | (_) | | | | \__ \ |_      _|
                       |_||_|   |_|   \__,_|_| |_|\___|\__|_|\___/|_| |_| |___/   |_||_|  

======================================================================================================================*/

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

            SHARED_ShowTextdrawsLoginBackground(playerid);

            VSL_CreateTextdrawsRegister(playerid);
            VSL_ShowTextdrawsRegisterAccount(playerid);
        }

        SHARED_CreateTextdrawsLoginLogo(playerid);
        SHARED_ShowTextdrawsLoginLogo(playerid);
    }

    MySQL_TQueryInline(getMySQLHandle(), using inline Response, query);
    return 1;
}

SQL_LoadPlayerAccount(playerid, accountid) {

    inline Response() {

        if (cache_num_rows() > 0) {
            
            createPlayerNotification(playerid, "LD_CHAT:thumbup", "Voce logou na sua conta");

            SHARED_DestroyTextdrawsLoginBackground(playerid);
            SHARED_DestroyTextdrawsLoginLogo(playerid);
            VSL_DestroyTextdrawsLogin(playerid);

            SetPlayerLogged(playerid, true);
            SetCharacterSpawned(playerid, true);

            SetSpawnInfo(playerid, NO_TEAM, 292, 1484.3187, -1711.7432, 14.0469, 66.8716);
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
    "INSERT INTO accounts (username, password, email, birth_date, gender, register_date) VALUES('%s', '%e', '%e', '%s', '%s', '%s');",
    gPlayerAccountData[playerid][e_player_username], gPlayerAccountData[playerid][e_player_password], gPlayerAccountData[playerid][e_player_email],
    gPlayerAccountData[playerid][e_player_birthdate], gPlayerAccountData[playerid][e_player_gender], GetDateTime());

    inline Response() {

        if (cache_affected_rows() > 0) {

        }
    }

    MySQL_TQueryInline(getMySQLHandle(), using inline Response, query);
    return 1;
}



/*====================================================================================================================*/
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
    gPlayerAccountData[playerid][e_player_gender] = '\0';
    gPlayerAccountData[playerid][e_player_admin] = 0;
    gPlayerAccountData[playerid][e_player_lastlogin] = '\0';
    gPlayerAccountData[playerid][e_player_ip] = '\0';

    SetPlayerTeam(playerid, NO_TEAM);
    StopAudioStreamForPlayer(playerid);
    return 1;
}

ResetPlayerCharacterData(playerid) {

    m_playerCharacterSelected{playerid} = 255;

    for (new i = 0; i < MAX_PLAYER_CHARACTERS; i++) {

        gPlayerCharacterData[playerid][i][e_character_database_id] = 0;
        gPlayerCharacterData[playerid][i][e_character_username] = '\0';
        gPlayerCharacterData[playerid][i][e_character_nickname] = '\0';
        gPlayerCharacterData[playerid][i][e_character_date_birth] = '\0';
        gPlayerCharacterData[playerid][i][e_character_gender] = '\0';
        gPlayerCharacterData[playerid][i][e_character_nationality] = 0;
        gPlayerCharacterData[playerid][i][e_character_place_birth] = 0;
        gPlayerCharacterData[playerid][i][e_character_ethnicity] = 0;
        gPlayerCharacterData[playerid][i][e_character_nationality_custom] = '\0';
        gPlayerCharacterData[playerid][i][e_character_place_birth_custom] = '\0';
        gPlayerCharacterData[playerid][i][e_character_ethnicity_custom] = '\0';
    }
    return 1;
}

SetPlayerCharacterSelected(playerid, index) {
    return m_playerCharacterSelected{playerid} = index;
}

Data_SetPlayerCharacterUsername(playerid, const username[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_username], _, username);
}

Data_SetPlayerCharacterNickname(playerid, const nickname[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_nickname], _, nickname);
}

Data_SetPlayerCharacterDateBirth(playerid, const date_birth[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_date_birth], _, date_birth);
}

Data_SetPlayerCharacterGender(playerid, const gender[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_gender], _, gender);
}

Data_SetPlayerCharacterNationality(playerid, nationality) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_nationality] = nationality;
}

Data_SetPlayerCharacterPlaceBirth(playerid, place_birth) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_place_birth] = place_birth;
}

Data_SetPlayerCharacterEthnicity(playerid, ethnicity) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_ethnicity] = ethnicity;
}

Data_SetPlayerCharacterNationalityCustom(playerid, const nationality[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_nationality_custom], _, nationality);
}

Data_SetPlayerCharacterPlaceBirthCustom(playerid, const place_birth[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_place_birth_custom], _, place_birth);
}

Data_SetPlayerCharacterEthnicityCustom(playerid, const ethnicity[]) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return format(gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_ethnicity_custom], _, ethnicity);
}


Data_GetPlayerCharacterUsername(playerid) {

    new
        str[MAX_PLAYER_NAME + 1];

    if (m_playerCharacterSelected{playerid} == 255)
        return str;

    format(str, _, gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_username]);
    return str;
}

Data_GetPlayerCharacterDateBirth(playerid) {

    new
        str[MAX_PLAYER_NAME + 1];

    if (m_playerCharacterSelected{playerid} == 255)
        return str;

    format(str, _, gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_date_birth]);
    return str;
}

Data_GetPlayerCharacterGender(playerid) {

    new
        str[2];

    if (m_playerCharacterSelected{playerid} == 255)
        return str;

    format(str, _, gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_gender]);
    return str;
}

Data_GetPlayerCharacterNationality(playerid) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_nationality];
}

Data_GetPlayerCharacterPlaceBirth(playerid) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_place_birth];
}

Data_GetPlayerCharacterEthnicity(playerid) {

    if (m_playerCharacterSelected{playerid} == 255)
        return 0;

    return gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_ethnicity];
}

Data_GetPlayerCharacterNationalityCustom(playerid) {

    new
        str[30 + 1];

    if (m_playerCharacterSelected{playerid} == 255)
        return str;
    
    strcat(str, gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_nationality_custom]);
    return str;
}

Data_GetPlayerCharacterPlaceBirthCustom(playerid) {

    new
        str[30 + 1];

    if (m_playerCharacterSelected{playerid} == 255)
        return str;
    
    strcat(str, gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_place_birth_custom]);
    return str;
}

Data_GetPlayerCharacterEthnicityCustom(playerid) {

    new
        str[30 + 1];

    if (m_playerCharacterSelected{playerid} == 255)
        return str;
    
    strcat(str, gPlayerCharacterData[playerid][m_playerCharacterSelected{playerid}][e_character_ethnicity_custom]);
    return str;
}


/*====================================================================================================================*/
ResetPlayerCacheEmail(playerid) {

    gPlayerCacheEmail[playerid][e_player_email_code] = '\0';
    gPlayerCacheEmail[playerid][e_player_email_attempt] = 0;
    gPlayerCacheEmail[playerid][e_player_email_expire] = 0;
    return 1;
}

SetPlayerCacheEmailCode(playerid, const code[]) {
    return format(gPlayerCacheEmail[playerid][e_player_email_code], _, code);
}

GetPlayerCacheEmailCode(playerid) {

    new
        code[7];
    
    format(code, _, gPlayerCacheEmail[playerid][e_player_email_code]);
    return code;
}

AddPlayerCacheEmailAttempt(playerid) {
    return gPlayerCacheEmail[playerid][e_player_email_attempt] ++;
}

GetPlayerCacheEmailAttempt(playerid) {
    return gPlayerCacheEmail[playerid][e_player_email_attempt];
}

SetPlayerCacheEmailExpire(playerid, time) {
    return gPlayerCacheEmail[playerid][e_player_email_expire] = time;
}

GetPlayerCacheEmailExpire(playerid) {
    return gPlayerCacheEmail[playerid][e_player_email_expire];
}


/*====================================================================================================================*/



CheckPlayerLogin(playerid) {

    if (!IsValidRoleplayName(ReturnPlayerName(playerid))) {

        SHARED_CreateTextdrawsLoginLogo(playerid);
        SHARED_ShowTextdrawsLoginLogo(playerid);

        Dialog_Show(playerid, DIALOG_STYLE_MSGBOX, "Ops...", "{FFFFFF}Parece que voce esta tentando acessar o servidor\ncom um nickname invalido.\n\nUtilize um nickname no seguinte formato: Nome_Sobrenome\nExemplo: Carlos_Jose, Ana_Maria.\n\nObs: Ambas letras inicias devem estar em maiusculo.", "X", "");
        KickDelay(playerid, 1000);
        return 0;
    }

    SQL_LoginCheckExistsAccount(playerid, ReturnPlayerName(playerid));
    return 1;
}


SendPlayerEmailRegisterAccount(playerid) {

    new
        code[7];
    
    strcat(code, Utils_RandomCodeSafely());

    ResetPlayerCacheEmail(playerid);

    SetPlayerCacheEmailCode(playerid, code);
    SetPlayerCacheEmailExpire(playerid, gettime() + (60 * 5));

    Mailer_SendEmail("welcome-template", GetPlayerEmail(playerid), GetFirstname(GetPlayerNameEx(playerid)), code);

    createPlayerNotification(playerid, SPRITE_EXCLAMATION_BADCHAT, "Enviamos um codigo para seu e-mail", _, 0x202020FF);
    return 1;
}



/*====================================================================================================================*/
GetPlayerDatabaseID(playerid) {
    return gPlayerAccountData[playerid][e_player_database_id];
}

GetPlayerNameEx(playerid) {

    new
        name[MAX_PLAYER_NAME];

    format(name, _, gPlayerAccountData[playerid][e_player_username]);
    return name;
}

GetPlayerPassword(playerid) {

    new
        str[BCRYPT_HASH_LENGTH];
    strcat(str, gPlayerAccountData[playerid][e_player_password]);
    return str;
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
    return gPlayerAccountData[playerid][e_player_gender];
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

GetPlayerPasswordTemp(playerid) {
    return tempPlayerPassword[playerid];
}

GetPlayerPasswordConfirmTemp(playerid) {
    return tempPlayerPasswordConfirm[playerid];
}


/*======================================================================================================================
                               _  _     ____  _       _             _         _  _   
                             _| || |_  |  _ \(_) __ _| | ___   __ _( )___   _| || |_ 
                            |_  ..  _| | | | | |/ _` | |/ _ \ / _` |// __| |_  ..  _|
                            |_      _| | |_| | | (_| | | (_) | (_| | \__ \ |_      _|
                              |_||_|   |____/|_|\__,_|_|\___/ \__, | |___/   |_||_|  
                                                              |___/                  

======================================================================================================================*/

ShowPlayerDialogLogin(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            new passLength = strlen(inputtext);

            if (isnull(inputtext) || passLength < 5 || passLength > 20)
                return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Login", "{FF6347}ERRO: Min 5, Max 20 caracteres\n{FFFFFF}Digite sua senha abaixo para fazer login", "Entrar", "Cancelar");

            SetPVarString(playerid, "temp_password_login", inputtext);

            VSL_SetStrTextFieldPassScreenLogin(playerid, inputtext);
            VSL_EnableButtonLoginScreenLogin(playerid, true);
        }

        VSL_ShowTextdrawsLogin(playerid);
    }

    // Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Logando na conta", "{FFFFFF}Digite sua senha abaixo para fazer login", "Entrar", "Cancelar");
    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Login", "\n{FFFFFF}Digite sua senha para acessar sua conta.\n\n{B366D9}• {FFFFFF}Se voce esqueceu sua senha, use a opcao\n{A9A9A9}** Recuperar minha senha ** {FFFFFF}abaixo.\n\n{B366D9}• {FFFFFF}Mantenha sua senha segura para proteger sua conta.\n ", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterBirthOfDate(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogRegisterBirthOfDate(playerid);

            ShowPlayerDialogRegisterBirthOfDateListId(playerid, listitem);
        }
        else {

            if (!isnull(tempPlayerBirthDay[playerid]) && !isnull(tempPlayerBirthMonth[playerid]) && !isnull(tempPlayerBirthYear[playerid])) {

                format(gPlayerAccountData[playerid][e_player_birthdate], _, "%02d/%02d/%s", strval(tempPlayerBirthDay[playerid]), strval(tempPlayerBirthMonth[playerid]), tempPlayerBirthYear[playerid]);
                VSL_UpdateTextdrawRegisterBirthDate(playerid, gPlayerAccountData[playerid][e_player_birthdate]);
            }

            VSL_ShowTextdrawsRegisterAccount(playerid);
        }
    }

    new
        str[60],
        string[60];

    format(string, _, "Dia\t%02s\nMes\t%s\nAno\t%s",
    isnull(tempPlayerBirthDay[playerid]) ? "DD" : tempPlayerBirthDay[playerid],
    isnull(tempPlayerBirthMonth[playerid]) ? "MM" : GetNameMonth(strval(tempPlayerBirthMonth[playerid])),
    isnull(tempPlayerBirthYear[playerid]) ? "YYYY" : tempPlayerBirthYear[playerid]);

    strcat(str, string);

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Data de Nascimento", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterBirthOfDateListId(playerid, listid) {

    new
        str[200],
        string[15];

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogRegisterBirthOfDateListId(playerid, listid);

            switch (listid) {

                case 0: format(tempPlayerBirthDay[playerid], _, "%d", listitem + 1);
                case 1: format(tempPlayerBirthMonth[playerid], _, "%d", listitem + 1);
                case 2: format(tempPlayerBirthYear[playerid], _, "%d", 2012 - listitem);
            }

            ShowPlayerDialogRegisterBirthOfDate(playerid);
        }
        else {

            ShowPlayerDialogRegisterBirthOfDate(playerid);
        }
    }

    switch (listid) {

        case 0: {

            for (new i = 1; i <= 31; i++) {

                format(string, sizeof(string), "%02d\n", i);
                strcat(str, string);
            }

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Defina um dia", str, ">>", "<<");
        }
        case 1: {

            for (new i = 1; i <= 12; i++) {

                format(string, sizeof(string), "%d. %s\n", i, GetNameMonth(i));
                strcat(str, string);
            }

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Defina um mes", str, ">>", "<<");
        }
        case 2: {

            new
                countYear = 2012;

            while (countYear >= 1974) {

                format(string, sizeof(string), "%d\n", countYear);
                strcat(str, string);

                countYear --;
            }

            Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Defina um ano", str, ">>", "<<");
        }
    }
    return 1;
}

ShowPlayerDialogRegisterGender(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1)
                return ShowPlayerDialogRegisterGender(playerid);
            
            switch (listitem) {

                case 0: format(gPlayerAccountData[playerid][e_player_gender], _, "M");
                case 1: format(gPlayerAccountData[playerid][e_player_gender], _, "F");
                case 2: format(gPlayerAccountData[playerid][e_player_gender], _, "NB");
            }

            VSL_UpdateTextdrawRegisterGender(playerid, listitem);
        }

        VSL_ShowTextdrawsRegisterAccount(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Defina seu genero", "1. Masculino\n2. Feminino\n3. Nao binario", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterEmail(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {
            
            if (isnull(inputtext) || strlen(inputtext) > 50 || !IsValidEmail(inputtext))
                return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Defina um e-mail", "\n{FF6347}Ops... Parece que voce informou um e-mail invalido!\n\n{FFFFFF}Informe um e-mail valido para vincular a sua conta.\nEle sera utilizado para recuperacao de senha caso necessario.\n\n{B366D9}• {FFFFFF}Aceitamos apenas os dominios: @gmail, @hotmail e @outlook.\n ", ">>", "<<");

            format(gPlayerAccountData[playerid][e_player_email], _, inputtext);
            VSL_UpdateTextdrawRegisterEmail(playerid, inputtext);

            VSL_ShowTextdrawsRegisterAccount(playerid);
        }
        else
            VSL_ShowTextdrawsRegisterAccount(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Defina um e-mail", "\n{FFFFFF}Informe um e-mail valido para vincular a sua conta.\nEle sera utilizado para recuperacao de senha caso necessario.\n\n{B366D9}• {FFFFFF}Aceitamos apenas os dominios: @gmail, @hotmail e @outlook.\n ", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterPassword(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 5 || strlen(inputtext) > 20) {
                
                tempPlayerPassword[playerid][0] = '\0';
                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Defina uma senha", "\n{FF6347}Ops... Parece que voce informou uma senha invalida!\n\n{B366D9}• {FFFFFF}Sua senha deve conter entre 5 e 20 caracteres.\n\n{B366D9}• {FFFFFF}Recomendamos o uso de uma senha forte, combinando letras,\nnumeros e simbolos.\n\n{B366D9}• {FFFFFF}Voce podera altera-la quando quiser nas configuracoes da conta.\n ", ">>", "<<");
                return 1;
            }

            format(tempPlayerPassword[playerid], _, inputtext);
            VSL_UpdateTextdrawRegisterPassword(playerid, inputtext);
        }
        
        VSL_ShowTextdrawsRegisterAccount(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Defina uma senha", "\n{B366D9}• {FFFFFF}Sua senha deve conter entre 5 e 20 caracteres.\n\n{B366D9}• {FFFFFF}Recomendamos o uso de uma senha forte, combinando letras,\nnumeros e simbolos.\n\n{B366D9}• {FFFFFF}Voce podera altera-la quando quiser nas configuracoes da conta.\n ", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterPasswordConfirm(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 5 || strlen(inputtext) > 20 || strcmp(tempPlayerPassword[playerid], inputtext)) {

                tempPlayerPasswordConfirm[playerid][0] = '\0';
                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Confirme sua senha", "\n{FF6347}Ops... As senhas nao coincidem!\n\n{FFFFFF}Digite sua senha novamente para confirmar.\n ", ">>", "<<");
                return 1;
            }

            format(tempPlayerPasswordConfirm[playerid], _, inputtext);
            VSL_UpdateTextdrawRegisterPasswordConfirm(playerid, inputtext);
        }

        VSL_ShowTextdrawsRegisterAccount(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_PASSWORD, "Confirme sua senha", "\n{FFFFFF}Quase la! Digite sua senha novamente para confirmar.\n ", ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterValidCode(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            if (isnull(inputtext))
                return ShowPlayerDialogRegisterValidCode(playerid);

            if (inputtext[1] == '\t') // Fix copy in e-mail
                Utils_StrRemoveAllSpaces(inputtext);

            VSL_SetStringTxdRegisterPlayerVerifCode(playerid, inputtext);
            VSL_ShowTextdrawsRegisterPlayerVerification(playerid);
        }
        else
            VSL_ShowTextdrawsRegisterPlayerVerification(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Verificacao de e-mail", \
    "\n{FFFFFF}Um codigo de verificacao de 6 digitos foi enviado para o e-mail\n\
    {B366D9}**{FFFFFF}wilidasilva16@gmail.com{B366D9}**\n\n\
    {FFFFFF}O recebimento pode levar ate 5 minutos. Caso nao encontre o e-mail,\n\
    verifique tambem a sua caixa de spam.\n\n\
    Insira o codigo abaixo para prosseguir.\n ",
    ">>", "<<");
    return 1;
}

ShowPlayerDialogRegisterResendEmail(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {

            SendPlayerEmailRegisterAccount(playerid);

            VSL_TimerResendRegisterPlayerVerif(playerid, 120);
            VSL_ShowTextdrawsRegisterPlayerVerification(playerid);
        }
        else
            ShowPlayerDialogRegisterResendAlterEmail(playerid);
    }

    new
        str[170];

    format(str, _, "\n{FFFFFF}Deseja reenviar o codigo de verificacao para o e-mail informado?\n{B366D9}**{FFFFFF}%s{B366D9}**\n ", GetPlayerEmail(playerid));
    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_MSGBOX, "Reenviar e-mail", str, "Reenviar", "Alterar");
    return 1;
}

ShowPlayerDialogRegisterResendAlterEmail(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem, inputtext

        if (response) {
            
            if (isnull(inputtext) || strlen(inputtext) > 50 || !IsValidEmail(inputtext))
                return Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Defina um e-mail", "\n{FF6347}Ops... Parece que voce informou um e-mail invalido!\n\n{FFFFFF}Informe um e-mail valido para vincular a sua conta.\nEle sera utilizado para recuperacao de senha caso necessario.\n\n{B366D9}• {FFFFFF}Aceitamos apenas os dominios: @gmail, @hotmail e @outlook.\n ", ">>", "<<");

            format(gPlayerAccountData[playerid][e_player_email], _, inputtext);

            SendPlayerEmailRegisterAccount(playerid);

            VSL_TimerResendRegisterPlayerVerif(playerid, 120);
            VSL_ShowTextdrawsRegisterPlayerVerification(playerid);
        }
        else
            ShowPlayerDialogRegisterResendEmail(playerid);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Defina um e-mail", "\n{FFFFFF}Informe um e-mail valido para vincular a sua conta.\nEle sera utilizado para recuperacao de senha caso necessario.\n\n{B366D9}• {FFFFFF}Aceitamos apenas os dominios: @gmail, @hotmail e @outlook.\n ", ">>", "<<");
    return 1;
}


/*====================================================================================================================*/
bool:ValidateCreateCharacterBirthDate(playerid) {

    if (GetPVarInt(playerid, "create_character_birth_day") && GetPVarInt(playerid, "create_character_birth_month") && GetPVarInt(playerid, "create_character_birth_year")) {

        new
            date_birth[11];
        
        format(date_birth, _, "%02d/%d/%d", GetPVarInt(playerid, "create_character_birth_day"), GetPVarInt(playerid, "create_character_birth_month"), GetPVarInt(playerid, "create_character_birth_year"));
        Data_SetPlayerCharacterDateBirth(playerid, date_birth);

        VSL_SetStrTextdrawCreateCharacterAboutDateBirth(playerid, date_birth);
        return true;
    }
    return false;
}

bool:ValidateCreateCharacterButton(playerid) {

    if (strlen(Data_GetPlayerCharacterUsername(playerid)) > 0 &&
    strlen(Data_GetPlayerCharacterDateBirth(playerid)) > 0 &&
    strlen(Data_GetPlayerCharacterGender(playerid)) > 0 &&
    (Data_GetPlayerCharacterNationality(playerid) || strlen(Data_GetPlayerCharacterNationalityCustom(playerid)) > 0) &&
    (Data_GetPlayerCharacterPlaceBirth(playerid) || strlen(Data_GetPlayerCharacterPlaceBirthCustom(playerid)) > 0) &&
    (Data_GetPlayerCharacterEthnicity(playerid) || strlen(Data_GetPlayerCharacterEthnicityCustom(playerid)) > 0)) {

        VSL_EnaleTextdrawsCreateCharacterAboutButtonNext(playerid, true);
        return true;
    }
    return false;
}

ShowPlayerDialogCreateCharacterAboutName(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 8 || strlen(inputtext) > 24 || !IsValidRoleplayName(inputtext)) {

                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Nome",
                "{FF6347}Ops... Parece que voce digitou um nome invalido.\n\n\
                {FFFFFF}Defina um nome para o seu personagem.\n\n\
                {B366D9}• {FFFFFF}O nome deve ter entre 5 e 20 caracteres.\n\
                {B366D9}• {FFFFFF}O formato obrigatorio e: Nome_Sobrenome.\n\
                {B366D9}• {FFFFFF}Evite nomes improprios ou irreais.\n ", 
                ">>", "<<");
                return 1;
            }

            Data_SetPlayerCharacterUsername(playerid, inputtext);

            VSL_SetStrTextdrawCreateCharacterAboutName(playerid, inputtext);
            VSL_SetStrTextdrawCreateCharacterMainMenuName(playerid, inputtext);

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Nome",
    "\n{FFFFFF}Defina um nome para o seu personagem.\n\n\
    {B366D9}• {FFFFFF}O nome deve ter entre 5 e 20 caracteres.\n\
    {B366D9}• {FFFFFF}O formato obrigatorio e: Nome_Sobrenome.\n\
    {B366D9}• {FFFFFF}Evite nomes improprios ou irreais.\n ", 
    ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutNickname(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            if (!isnull(inputtext) && (strlen(inputtext) < 3 || strlen(inputtext) > 30)) {

                Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Apelido",
                "{FF6347}Ops... Parece que voce digitou um apelido invalido.\n\n\
                {FFFFFF}Defina um apelido para seu personagem. (opcional)\n\n\
                {B366D9}• {FFFFFF}O apelido deve ter entre 3 e 30 caracteres.\n ", 
                ">>", "<<");
                return 1;
            }

            if (!isnull(inputtext)) {

                Data_SetPlayerCharacterNickname(playerid, inputtext);

                VSL_SetStrTextdrawCreateCharacterAboutNickname(playerid, inputtext);
                VSL_SetStrTextdrawCreateCharacterMainMenuNickname(playerid, inputtext);
            }
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Apelido", 
    "\n{FFFFFF}Defina um apelido para seu personagem. (opcional)\n\n\
    {B366D9}• {FFFFFF}O apelido deve ter entre 3 e 30 caracteres.\n ", 
    ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutDateBirth(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;
    
    ValidateCreateCharacterBirthDate(playerid);
    ValidateCreateCharacterButton(playerid);

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutDateBirth(playerid);

            switch (listitem) {

                case 0: ShowPlayerDialogCreateCharacterAboutDateBirthDay(playerid);
                case 1: ShowPlayerDialogCreateCharacterAboutDateBirthMonth(playerid);
                case 2: ShowPlayerDialogCreateCharacterAboutDateBirthYear(playerid);
            }
        }
        else
            SelectTextDraw(playerid, 0x7E57C2FF);
    }

    new
        str[60],
        string[60],

        birth_day[3],    
        birth_month[3],    
        birth_year[5]
    ;

    format(birth_day, _, "%02d", GetPVarInt(playerid, "create_character_birth_day"));
    format(birth_month, _, "%d", GetPVarInt(playerid, "create_character_birth_month"));
    format(birth_year, _, "%d", GetPVarInt(playerid, "create_character_birth_year"));

    format(string, _, "Dia\t%02s\nMes\t%s\nAno\t%s",
    
    birth_day[0] == '0' ? "DD" : birth_day,
    birth_month[0] == '0' ? "MM" : birth_month,
    birth_year[0] == '0' ? "YYYY" : birth_year);

    strcat(str, string);

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Sobre mim | Data de nascimento", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutDateBirthDay(playerid) {

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutDateBirthDay(playerid);

            SetPVarInt(playerid, "create_character_birth_day", listitem + 1);
        }

        ShowPlayerDialogCreateCharacterAboutDateBirth(playerid);
    }

    new
        str[200],
        string[15];

    for (new i = 1; i <= 31; i++) {

        format(string, sizeof(string), "%02d\n", i);
        strcat(str, string);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Defina um dia", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutDateBirthMonth(playerid) {

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutDateBirthMonth(playerid);

            SetPVarInt(playerid, "create_character_birth_month", listitem + 1);
        }

        ShowPlayerDialogCreateCharacterAboutDateBirth(playerid);
    }

    new
        str[200],
        string[15];

    for (new i = 1; i <= 12; i++) {

        format(string, sizeof(string), "%d. %s\n", i, GetNameMonth(i));
        strcat(str, string);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Defina um mes", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutDateBirthYear(playerid) {

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutDateBirthYear(playerid);

            SetPVarInt(playerid, "create_character_birth_year", 2012 - listitem);
        }

        ShowPlayerDialogCreateCharacterAboutDateBirth(playerid);
    }

    new
        str[200],
        string[15],
        countYear = 2012;

    while (countYear >= 1974) {

        format(string, sizeof(string), "%d\n", countYear);
        strcat(str, string);

        countYear --;
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST, "Defina um ano", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutGender(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutGender(playerid);
            
            if (listitem) {

                Data_SetPlayerCharacterGender(playerid, "F");
                VSL_SetStrTextdrawCreateCharacterAboutGender(playerid, "Feminino");
            }
            else {

                Data_SetPlayerCharacterGender(playerid, "M");
                VSL_SetStrTextdrawCreateCharacterAboutGender(playerid, "Masculino");
            }

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Sobre mim | Genero", "1. Masculino\n2. Feminino", ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutNationality(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    new
        str[700],
        string[45],

        count_index = 0
    ;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1 || listitem == count_index) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutNationality(playerid);

            new
                nationality_name[40];
            
            if (listitem == count_index + 1) {

                ShowPlayerDialogCreateCharacterAboutNationalityCustom(playerid);
                return 1;
            }

            Data_SetPlayerCharacterNationality(playerid, listitem + 1);
            Data_SetPlayerCharacterNationalityCustom(playerid, "");
            
            new bool:character_is_male = (!strcmp(Data_GetPlayerCharacterGender(playerid), "F")) ? false : true;

            format(nationality_name, _, "%s - %s", GetCountryNationalityId(listitem + 1), GetNationalityId(listitem + 1, character_is_male));
            VSL_SetStrTextdrawCreateCharacterAboutNationality(playerid, nationality_name);

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }


    strcat(str, "Pais\tNacionalidade\n");

    for (new i = 1; i <= 20; i++) {

        format(string, sizeof(string), "%d. %s\t%s\t%s\n", i, GetCountryNationalityId(i), GetNationalityId(i, true), GetNationalityId(i, false));
        strcat(str, string);

        count_index ++;
    }

    strcat(str, "\n \nOutro");

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_TABLIST_HEADERS, "Sobre mim | Nacionalidade", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutPlaceBirth(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    new
        str[700],
        string[40],
        place_birth_list[27][36],

        count_index = 0
    ;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1 || listitem == count_index) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutPlaceBirth(playerid);
            
            if (listitem == count_index + 1)
                return ShowPlayerDialogCreateCharacterAboutPlaceBirthCustom(playerid);
            
            Data_SetPlayerCharacterPlaceBirth(playerid, listitem + 1);
            Data_SetPlayerCharacterPlaceBirthCustom(playerid, "");

            VSL_SetStrTextdrawCreateCharacterAboutPlaceBirth(playerid, place_birth_list[listitem]);

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    place_birth_list = GetPlaceBirth(Data_GetPlayerCharacterNationality(playerid));

    for (new i = 0; i < 27; i++) {

        if (!isnull(place_birth_list[i])) {

            format(string, sizeof(string), "%d. %s\n", i + 1, place_birth_list[i]);
            strcat(str, string);

            count_index ++;
        }
    }

    strcat(str, "\n \nOutro");

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Sobre mim | Naturalidade", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutEthnicity(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    new
        str[300],
        string[20],

        bool:character_is_male = (!strcmp(Data_GetPlayerCharacterGender(playerid), "F")) ? false : true,

        count_index = 0
    ;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused inputtext

        if (response) {

            if (listitem == -1 || listitem == count_index) // Fix Android
                return ShowPlayerDialogCreateCharacterAboutEthnicity(playerid);

            if (listitem == count_index + 1)
                return ShowPlayerDialogCreateCharacterAboutEthnicityCustom(playerid);

            Data_SetPlayerCharacterEthnicity(playerid, listitem + 1);
            Data_SetPlayerCharacterEthnicityCustom(playerid, "");

            VSL_SetStrTextdrawCreateCharacterAboutEthnicity(playerid, GetEthnicityId(listitem + 1, character_is_male));

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }


    for (new i = 1; i <= 20; i++) {

        format(string, sizeof(string), "%d. %s\n", i, GetEthnicityId(i, character_is_male));
        strcat(str, string);

        count_index ++;
    }

    strcat(str, "\n \nOutro");

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_LIST, "Sobre mim | Etnia", str, ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutNationalityCustom(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 3 || strlen(inputtext) > 30)
                return ShowPlayerDialogCreateCharacterAboutNationalityCustom(playerid);
            
            Data_SetPlayerCharacterNationalityCustom(playerid, inputtext);

            VSL_SetStrTextdrawCreateCharacterAboutNationality(playerid, inputtext);

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Nacionalidade", 
    "\n{FFFFFF}Defina a nacionalidade do seu personagem.\n\n\
    {B366D9}• {FFFFFF}A nacionalidade deve ter entre 3 e 30 caracteres.\n\
    {B366D9}• {FFFFFF}Abreviacoes nao sao permitidas.\n\n\
    {FFFFFF}Obs: Informacoes irreais ou inapropriadas podem resultar em punicoes.",
    ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutPlaceBirthCustom(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 3 || strlen(inputtext) > 30)
                return ShowPlayerDialogCreateCharacterAboutPlaceBirthCustom(playerid);

            Data_SetPlayerCharacterPlaceBirthCustom(playerid, inputtext);

            VSL_SetStrTextdrawCreateCharacterAboutPlaceBirth(playerid, inputtext);

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Naturalidade", 
    "\n{FFFFFF}Defina a naturalidade do seu personagem.\n\n\
    {B366D9}• {FFFFFF}A naturalidade deve ter entre 3 e 30 caracteres.\n\
    {B366D9}• {FFFFFF}Abreviacoes nao sao permitidas.\n\n\
    {FFFFFF}Obs: Informacoes irreais ou inapropriadas podem resultar em punicoes.",
    ">>", "<<");
    return 1;
}

ShowPlayerDialogCreateCharacterAboutEthnicityCustom(playerid) {

    if (IsPlayerLogged(playerid) || IsCharacterSpawned(playerid))
        return 0;

    inline Response(response, listitem, string:inputtext[]) {

        #pragma unused listitem

        if (response) {

            if (isnull(inputtext) || strlen(inputtext) < 3 || strlen(inputtext) > 30)
                return ShowPlayerDialogCreateCharacterAboutEthnicityCustom(playerid);

            Data_SetPlayerCharacterEthnicityCustom(playerid, inputtext);

            VSL_SetStrTextdrawCreateCharacterAboutEthnicity(playerid, inputtext);

            ValidateCreateCharacterButton(playerid);
        }

        SelectTextDraw(playerid, 0x7E57C2FF);
    }

    Dialog_ShowCallback(playerid, using inline Response, DIALOG_STYLE_INPUT, "Sobre mim | Etnia", 
    "\n{FFFFFF}Defina a etnia do seu personagem.\n\n\
    {B366D9}• {FFFFFF}A etnia deve ter entre 3 e 30 caracteres.\n\
    {B366D9}• {FFFFFF}Abreviacoes nao sao permitidas.\n\n\
    {FFFFFF}Obs: Informacoes irreais ou inapropriadas podem resultar em punicoes.",
    ">>", "<<");
    return 1;
}


/*====================================================================================================================*/
GetCountryNationalityId(id) {

    new
        country[15];

    switch (id) {

        case 1: format(country, _, "Alemanha");
        case 2: format(country, _, "Estados Unidos");
        case 3: format(country, _, "Argelia");
        case 4: format(country, _, "Argentina");
        case 5: format(country, _, "Australia");
        case 6: format(country, _, "Brasil");
        case 7: format(country, _, "Canada");
        case 8: format(country, _, "China");
        case 9: format(country, _, "Espanha");
        case 10: format(country, _, "Franca");
        case 11: format(country, _, "India");
        case 12: format(country, _, "Reino Unido");
        case 13: format(country, _, "Italia");
        case 14: format(country, _, "Japao");
        case 15: format(country, _, "Mexico");
        case 16: format(country, _, "Portugal");
        case 17: format(country, _, "Russia");
        case 18: format(country, _, "Suecia");
        case 19: format(country, _, "Coreia do Sul");
        case 20: format(country, _, "Turquia");
    }
    return country;
}

GetNationalityId(id, bool:is_male) {

    new
        nationality[20];

    if (is_male) { // Masculino

        switch (id) {

            case 1: format(nationality, _, "Alemao");
            case 2: format(nationality, _, "Americano");
            case 3: format(nationality, _, "Argelino");
            case 4: format(nationality, _, "Argentino");
            case 5: format(nationality, _, "Australiano");
            case 6: format(nationality, _, "Brasileiro");
            case 7: format(nationality, _, "Canadiano");
            case 8: format(nationality, _, "Chines");
            case 9: format(nationality, _, "Espanhol");
            case 10: format(nationality, _, "Frances");
            case 11: format(nationality, _, "Indiano");
            case 12: format(nationality, _, "Ingles");
            case 13: format(nationality, _, "Italiano");
            case 14: format(nationality, _, "Japones");
            case 15: format(nationality, _, "Mexicano");
            case 16: format(nationality, _, "Portugues");
            case 17: format(nationality, _, "Russo");
            case 18: format(nationality, _, "Sueco");
            case 19: format(nationality, _, "Sul-coreano");
            case 20: format(nationality, _, "Turco");
        }
    }
    else { // Feminino

        switch (id) {

            case 1: format(nationality, _, "Alema");
            case 2: format(nationality, _, "Americana");
            case 3: format(nationality, _, "Argelina");
            case 4: format(nationality, _, "Argentina");
            case 5: format(nationality, _, "Australiana");
            case 6: format(nationality, _, "Brasileira");
            case 7: format(nationality, _, "Canadiana");
            case 8: format(nationality, _, "Chinesa");
            case 9: format(nationality, _, "Espanhola");
            case 10: format(nationality, _, "Francesa");
            case 11: format(nationality, _, "Indiana");
            case 12: format(nationality, _, "Inglesa");
            case 13: format(nationality, _, "Italiana");
            case 14: format(nationality, _, "Japonesa");
            case 15: format(nationality, _, "Mexicana");
            case 16: format(nationality, _, "Portuguesa");
            case 17: format(nationality, _, "Russa");
            case 18: format(nationality, _, "Sueca");
            case 19: format(nationality, _, "Sul-coreana");
            case 20: format(nationality, _, "Turca");
        }
    }
    return nationality;
}

GetPlaceBirth(nationality_id) {

    new
        place_birth[27][36];

    switch (nationality_id) {

        case 6: { // Nacionalidade Brasileira
            strcopy(place_birth[0], "Sao Paulo");
            strcopy(place_birth[1], "Rio de Janeiro");
            strcopy(place_birth[2], "Belo Horizonte");
            strcopy(place_birth[3], "Porto Alegre");
            strcopy(place_birth[4], "Salvador");
            strcopy(place_birth[5], "Curitiba");
            strcopy(place_birth[6], "Recife");
            strcopy(place_birth[7], "Fortaleza");
            strcopy(place_birth[8], "Manaus");
            strcopy(place_birth[9], "Brasilia");
            strcopy(place_birth[10], "Campinas");
            strcopy(place_birth[11], "Sao Luis");
            strcopy(place_birth[12], "Vitoria");
            strcopy(place_birth[13], "Natal");
            strcopy(place_birth[14], "Maceio");
            strcopy(place_birth[15], "Cuiaba");
            strcopy(place_birth[16], "Joao Pessoa");
            strcopy(place_birth[17], "Aracaju");
            strcopy(place_birth[18], "Porto Velho");
            strcopy(place_birth[19], "Boa Vista");
            strcopy(place_birth[20], "Teresina");
            strcopy(place_birth[21], "Anapolis");
            strcopy(place_birth[22], "Uberlandia");
            strcopy(place_birth[23], "Barretos");
            strcopy(place_birth[24], "Aparecida de Goiania");
            strcopy(place_birth[25], "Bauru");
            strcopy(place_birth[26], "Ribeirao Preto");
        }
        case 4: { // Nacionalidade Argentina
            strcopy(place_birth[0], "Buenos Aires");
            strcopy(place_birth[1], "Cordoba");
            strcopy(place_birth[2], "Rosario");
            strcopy(place_birth[3], "Mendoza");
            strcopy(place_birth[4], "La Plata");
            strcopy(place_birth[5], "Tucuman");
            strcopy(place_birth[6], "Mar del Plata");
            strcopy(place_birth[7], "Salta");
            strcopy(place_birth[8], "Santa Fe");
            strcopy(place_birth[9], "San Juan");
            strcopy(place_birth[10], "Resistencia");
            strcopy(place_birth[11], "San Miguel de Tucuman");
            strcopy(place_birth[12], "Posadas");
            strcopy(place_birth[13], "Neuquen");
            strcopy(place_birth[14], "Chaco");
            strcopy(place_birth[15], "Comodoro Rivadavia");
            strcopy(place_birth[16], "Bahia Blanca");
            strcopy(place_birth[17], "San Fernando del Valle de Catamarca");
            strcopy(place_birth[18], "Cali");
            strcopy(place_birth[19], "El Calafate");
            strcopy(place_birth[20], "Trelew");
            strcopy(place_birth[21], "Rio Gallegos");
            strcopy(place_birth[22], "Parana");
            strcopy(place_birth[23], "Corrientes");
            strcopy(place_birth[24], "Marcos Juarez");
            strcopy(place_birth[25], "San Nicolas de los Arroyos");
            strcopy(place_birth[26], "Villa Maria");
        }
        case 2: { // Nacionalidade Americana
            strcopy(place_birth[0], "Nova York");
            strcopy(place_birth[1], "Los Angeles");
            strcopy(place_birth[2], "Chicago");
            strcopy(place_birth[3], "Houston");
            strcopy(place_birth[4], "Phoenix");
            strcopy(place_birth[5], "Filadelfia");
            strcopy(place_birth[6], "San Francisco");
            strcopy(place_birth[7], "Miami");
            strcopy(place_birth[8], "Dallas");
            strcopy(place_birth[9], "Washington D.C.");
            strcopy(place_birth[10], "Boston");
            strcopy(place_birth[11], "Atlanta");
            strcopy(place_birth[12], "Seattle");
            strcopy(place_birth[13], "San Diego");
            strcopy(place_birth[14], "Denver");
            strcopy(place_birth[15], "Minneapolis");
            strcopy(place_birth[16], "Indianapolis");
            strcopy(place_birth[17], "Detroit");
            strcopy(place_birth[18], "Portland");
            strcopy(place_birth[19], "Baltimore");
            strcopy(place_birth[20], "Sacramento");
            strcopy(place_birth[21], "Orlando");
            strcopy(place_birth[22], "Charlotte");
            strcopy(place_birth[23], "Austin");
            strcopy(place_birth[24], "Cleveland");
            strcopy(place_birth[25], "Kansas City");
            strcopy(place_birth[26], "Las Vegas");
        }
        case 7: { // Nacionalidade Canadense
            strcopy(place_birth[0], "Toronto");
            strcopy(place_birth[1], "Vancouver");
            strcopy(place_birth[2], "Montreal");
            strcopy(place_birth[3], "Calgary");
            strcopy(place_birth[4], "Ottawa");
            strcopy(place_birth[5], "Edmonton");
            strcopy(place_birth[6], "Quebec");
            strcopy(place_birth[7], "Winnipeg");
            strcopy(place_birth[8], "Hamilton");
            strcopy(place_birth[9], "Kitchener");
            strcopy(place_birth[10], "London");
            strcopy(place_birth[11], "Brampton");
            strcopy(place_birth[12], "Surrey");
            strcopy(place_birth[13], "Mississauga");
            strcopy(place_birth[14], "Richmond");
            strcopy(place_birth[15], "Burnaby");
            strcopy(place_birth[16], "Markham");
            strcopy(place_birth[17], "Saskatoon");
            strcopy(place_birth[18], "Regina");
            strcopy(place_birth[19], "Lethbridge");
            strcopy(place_birth[20], "Halifax");
            strcopy(place_birth[21], "St. John's");
            strcopy(place_birth[22], "Charlottetown");
            strcopy(place_birth[23], "Fredericton");
            strcopy(place_birth[24], "Moncton");
            strcopy(place_birth[25], "Nanaimo");
            strcopy(place_birth[26], "Kamloops");
        }
        case 16: { // Nacionalidade Portuguesa
            strcopy(place_birth[0], "Lisboa");
            strcopy(place_birth[1], "Porto");
            strcopy(place_birth[2], "Amadora");
            strcopy(place_birth[3], "Braga");
            strcopy(place_birth[4], "Coimbra");
            strcopy(place_birth[5], "Aveiro");
            strcopy(place_birth[6], "Funchal");
            strcopy(place_birth[7], "Cascais");
            strcopy(place_birth[8], "Vila Nova de Gaia");
            strcopy(place_birth[9], "Setubal");
            strcopy(place_birth[10], "Almada");
            strcopy(place_birth[11], "Evora");
            strcopy(place_birth[12], "Guimaraes");
            strcopy(place_birth[13], "Leiria");
            strcopy(place_birth[14], "Viseu");
            strcopy(place_birth[15], "Braganca");
            strcopy(place_birth[16], "Faro");
            strcopy(place_birth[17], "Aveiro");
            strcopy(place_birth[18], "Braga");
            strcopy(place_birth[19], "Ponta Delgada");
            strcopy(place_birth[20], "Barreiro");
            strcopy(place_birth[21], "Beja");
            strcopy(place_birth[22], "Castelo Branco");
            strcopy(place_birth[23], "Odivelas");
            strcopy(place_birth[24], "Amadora");
            strcopy(place_birth[25], "Cascais");
            strcopy(place_birth[26], "Sintra");
        }
        case 9: { // Nacionalidade Espanhola
            strcopy(place_birth[0], "Madrid");
            strcopy(place_birth[1], "Barcelona");
            strcopy(place_birth[2], "Valencia");
            strcopy(place_birth[3], "Sevilha");
            strcopy(place_birth[4], "Zaragoza");
            strcopy(place_birth[5], "Malaga");
            strcopy(place_birth[6], "Murcia");
            strcopy(place_birth[7], "Palma de Mallorca");
            strcopy(place_birth[8], "Bilbao");
            strcopy(place_birth[9], "Alicante");
            strcopy(place_birth[10], "Cordoba");
            strcopy(place_birth[11], "Valladolid");
            strcopy(place_birth[12], "Granada");
            strcopy(place_birth[13], "Oviedo");
            strcopy(place_birth[14], "Salamanca");
            strcopy(place_birth[15], "Gijon");
            strcopy(place_birth[16], "Albacete");
            strcopy(place_birth[17], "Badajoz");
            strcopy(place_birth[18], "Logrono");
            strcopy(place_birth[19], "Santander");
            strcopy(place_birth[20], "Huelva");
            strcopy(place_birth[21], "Toledo");
            strcopy(place_birth[22], "Burgos");
            strcopy(place_birth[23], "Almeria");
            strcopy(place_birth[24], "Santiago de Compostela");
            strcopy(place_birth[25], "Lerida");
            strcopy(place_birth[26], "La Coruna");
        }
        case 10: { // Nacionalidade Francesa
            strcopy(place_birth[0], "Paris");
            strcopy(place_birth[1], "Marseille");
            strcopy(place_birth[2], "Lyon");
            strcopy(place_birth[3], "Toulouse");
            strcopy(place_birth[4], "Nice");
            strcopy(place_birth[5], "Nantes");
            strcopy(place_birth[6], "Montpellier");
            strcopy(place_birth[7], "Strasbourg");
            strcopy(place_birth[8], "Bordeaux");
            strcopy(place_birth[9], "Lille");
            strcopy(place_birth[10], "Rennes");
            strcopy(place_birth[11], "Le Havre");
            strcopy(place_birth[12], "Reims");
            strcopy(place_birth[13], "Saint-Etienne");
            strcopy(place_birth[14], "Toulon");
            strcopy(place_birth[15], "Le Mans");
            strcopy(place_birth[16], "Aix-en-Provence");
            strcopy(place_birth[17], "Angers");
            strcopy(place_birth[18], "Villeurbanne");
            strcopy(place_birth[19], "Clermont-Ferrand");
            strcopy(place_birth[20], "Dijon");
            strcopy(place_birth[21], "La Rochelle");
            strcopy(place_birth[22], "Nimes");
            strcopy(place_birth[23], "Tours");
            strcopy(place_birth[24], "Limoges");
            strcopy(place_birth[25], "Amiens");
            strcopy(place_birth[26], "Brest");
        }
        case 13: { // Nacionalidade Italiana
            strcopy(place_birth[0], "Roma");
            strcopy(place_birth[1], "Milao");
            strcopy(place_birth[2], "Napoles");
            strcopy(place_birth[3], "Turim");
            strcopy(place_birth[4], "Palermo");
            strcopy(place_birth[5], "Genova");
            strcopy(place_birth[6], "Bologna");
            strcopy(place_birth[7], "Florenca");
            strcopy(place_birth[8], "Bari");
            strcopy(place_birth[9], "Catania");
            strcopy(place_birth[10], "Verona");
            strcopy(place_birth[11], "Veneza");
            strcopy(place_birth[12], "Messina");
            strcopy(place_birth[13], "Padova");
            strcopy(place_birth[14], "Trieste");
            strcopy(place_birth[15], "Brescia");
            strcopy(place_birth[16], "Prato");
            strcopy(place_birth[17], "Reggio Calabria");
            strcopy(place_birth[18], "Modena");
            strcopy(place_birth[19], "Perugia");
            strcopy(place_birth[20], "Livorno");
            strcopy(place_birth[21], "Ravenna");
            strcopy(place_birth[22], "La Spezia");
            strcopy(place_birth[23], "Lecce");
            strcopy(place_birth[24], "Cagliari");
            strcopy(place_birth[25], "Ancona");
            strcopy(place_birth[26], "Sassari");
        }
        case 14: { // Nacionalidade Japonesa
            strcopy(place_birth[0], "Toquio");
            strcopy(place_birth[1], "Osaka");
            strcopy(place_birth[2], "Yokohama");
            strcopy(place_birth[3], "Nagoya");
            strcopy(place_birth[4], "Sapporo");
            strcopy(place_birth[5], "Fukuoka");
            strcopy(place_birth[6], "Kobe");
            strcopy(place_birth[7], "Kyoto");
            strcopy(place_birth[8], "Kawasaki");
            strcopy(place_birth[9], "Saitama");
            strcopy(place_birth[10], "Hiroshima");
            strcopy(place_birth[11], "Sendai");
            strcopy(place_birth[12], "Chiba");
            strcopy(place_birth[13], "Saitama");
            strcopy(place_birth[14], "Shizuoka");
            strcopy(place_birth[15], "Sapporo");
            strcopy(place_birth[16], "Okayama");
            strcopy(place_birth[17], "Kochi");
            strcopy(place_birth[18], "Nagasaki");
            strcopy(place_birth[19], "Nara");
            strcopy(place_birth[20], "Shizuoka");
            strcopy(place_birth[21], "Niigata");
            strcopy(place_birth[22], "Ibaraki");
            strcopy(place_birth[23], "Mito");
            strcopy(place_birth[24], "Okinawa");
            strcopy(place_birth[25], "Miyagi");
            strcopy(place_birth[26], "Hokkaido");
        }
        case 8: { // Nacionalidade Chinesa
            strcopy(place_birth[0], "Pequim");
            strcopy(place_birth[1], "Xangai");
            strcopy(place_birth[2], "Hong Kong");
            strcopy(place_birth[3], "Cantao");
            strcopy(place_birth[4], "Shenzhen");
            strcopy(place_birth[5], "Tianjin");
            strcopy(place_birth[6], "Chongqing");
            strcopy(place_birth[7], "Dongguan");
            strcopy(place_birth[8], "Nanjing");
            strcopy(place_birth[9], "Wuhan");
            strcopy(place_birth[10], "Hangzhou");
            strcopy(place_birth[11], "Suzhou");
            strcopy(place_birth[12], "Xi'an");
            strcopy(place_birth[13], "Shijiazhuang");
            strcopy(place_birth[14], "Zhengzhou");
            strcopy(place_birth[15], "Fuzhou");
            strcopy(place_birth[16], "Harbin");
            strcopy(place_birth[17], "Jinan");
            strcopy(place_birth[18], "Changsha");
            strcopy(place_birth[19], "Ningbo");
            strcopy(place_birth[20], "Shenyang");
            strcopy(place_birth[21], "Qingdao");
            strcopy(place_birth[22], "Dalian");
            strcopy(place_birth[23], "Tianjin");
            strcopy(place_birth[24], "Nanning");
            strcopy(place_birth[25], "Luoyang");
            strcopy(place_birth[26], "Yantai");
        }
        case 15: { // Nacionalidade Mexicana
            strcopy(place_birth[0], "Cidade do Mexico");
            strcopy(place_birth[1], "Guadalajara");
            strcopy(place_birth[2], "Monterrey");
            strcopy(place_birth[3], "Puebla");
            strcopy(place_birth[4], "Cancun");
            strcopy(place_birth[5], "Tijuana");
            strcopy(place_birth[6], "Leon");
            strcopy(place_birth[7], "Chihuahua");
            strcopy(place_birth[8], "Toluca");
            strcopy(place_birth[9], "Merida");
            strcopy(place_birth[10], "Hermosillo");
            strcopy(place_birth[11], "Saltillo");
            strcopy(place_birth[12], "Mexicali");
            strcopy(place_birth[13], "San Luis Potosi");
            strcopy(place_birth[14], "Aguascalientes");
            strcopy(place_birth[15], "Morelia");
            strcopy(place_birth[16], "Culiacan");
            strcopy(place_birth[17], "Mazatlan");
            strcopy(place_birth[18], "Xalapa");
            strcopy(place_birth[19], "Villahermosa");
            strcopy(place_birth[20], "Campeche");
            strcopy(place_birth[21], "Colima");
            strcopy(place_birth[22], "Cuernavaca");
            strcopy(place_birth[23], "Tepic");
            strcopy(place_birth[24], "Zacatecas");
            strcopy(place_birth[25], "Oaxaca");
            strcopy(place_birth[26], "Tuxtla Gutierrez");
        }
        case 12: { // Nacionalidade Inglesa
            strcopy(place_birth[0], "Londres");
            strcopy(place_birth[1], "Manchester");
            strcopy(place_birth[2], "Birmingham");
            strcopy(place_birth[3], "Leeds");
            strcopy(place_birth[4], "Glasgow");
            strcopy(place_birth[5], "Liverpool");
            strcopy(place_birth[6], "Sheffield");
            strcopy(place_birth[7], "Edimburgo");
            strcopy(place_birth[8], "Bristol");
            strcopy(place_birth[9], "Cardiff");
            strcopy(place_birth[10], "Nottingham");
            strcopy(place_birth[11], "Southampton");
            strcopy(place_birth[12], "Newcastle");
            strcopy(place_birth[13], "Leicester");
            strcopy(place_birth[14], "Hull");
            strcopy(place_birth[15], "Bradford");
            strcopy(place_birth[16], "Coventry");
            strcopy(place_birth[17], "Oxford");
            strcopy(place_birth[18], "Cambridge");
            strcopy(place_birth[19], "York");
            strcopy(place_birth[20], "Blackpool");
            strcopy(place_birth[21], "Wolverhampton");
            strcopy(place_birth[22], "Middlesbrough");
            strcopy(place_birth[23], "Plymouth");
            strcopy(place_birth[24], "Derby");
            strcopy(place_birth[25], "Swindon");
            strcopy(place_birth[26], "Stoke-on-Trent");
        }
        case 1: { // Nacionalidade Alema
            strcopy(place_birth[0], "Berlim");
            strcopy(place_birth[1], "Munique");
            strcopy(place_birth[2], "Hamburgo");
            strcopy(place_birth[3], "Frankfurt");
            strcopy(place_birth[4], "Colonia");
            strcopy(place_birth[5], "Dusseldorf");
            strcopy(place_birth[6], "Stuttgart");
            strcopy(place_birth[7], "Dortmund");
            strcopy(place_birth[8], "Essen");
            strcopy(place_birth[9], "Leipzig");
            strcopy(place_birth[10], "Dresden");
            strcopy(place_birth[11], "Hannover");
            strcopy(place_birth[12], "Nuremberg");
            strcopy(place_birth[13], "Bremen");
            strcopy(place_birth[14], "Mannheim");
            strcopy(place_birth[15], "Aachen");
            strcopy(place_birth[16], "Karlsruhe");
            strcopy(place_birth[17], "Freiburg");
            strcopy(place_birth[18], "Wiesbaden");
            strcopy(place_birth[19], "Bonn");
            strcopy(place_birth[20], "Kiel");
            strcopy(place_birth[21], "Augsburg");
            strcopy(place_birth[22], "Rostock");
            strcopy(place_birth[23], "Gottingen");
            strcopy(place_birth[24], "Erfurt");
            strcopy(place_birth[25], "Chemnitz");
            strcopy(place_birth[26], "Cottbus");
        }
        case 17: { // Nacionalidade Russa
            strcopy(place_birth[0], "Moscovo");
            strcopy(place_birth[1], "Sao Petersburgo");
            strcopy(place_birth[2], "Novosibirsk");
            strcopy(place_birth[3], "Ekaterinburgo");
            strcopy(place_birth[4], "Nizhni Novgorod");
            strcopy(place_birth[5], "Samara");
            strcopy(place_birth[6], "Omsk");
            strcopy(place_birth[7], "Kazan");
            strcopy(place_birth[8], "Chelyabinsk");
            strcopy(place_birth[9], "Omsk");
            strcopy(place_birth[10], "Rostov-on-Don");
            strcopy(place_birth[11], "Ufa");
            strcopy(place_birth[12], "Volgogrado");
            strcopy(place_birth[13], "Perm");
            strcopy(place_birth[14], "Voronezh");
            strcopy(place_birth[15], "Krasnoyarsk");
            strcopy(place_birth[16], "Saratov");
            strcopy(place_birth[17], "Tyumen");
            strcopy(place_birth[18], "Izhevsk");
            strcopy(place_birth[19], "Barnaul");
            strcopy(place_birth[20], "Tolyatti");
            strcopy(place_birth[21], "Krasnodar");
            strcopy(place_birth[22], "Kaliningrado");
            strcopy(place_birth[23], "Minsk");
            strcopy(place_birth[24], "Sochi");
            strcopy(place_birth[25], "Vladivostok");
            strcopy(place_birth[26], "Irkutsk");
        }
        case 11: { // Nacionalidade Indiana
            strcopy(place_birth[0], "Nova Delhi");
            strcopy(place_birth[1], "Bombaim");
            strcopy(place_birth[2], "Bangalore");
            strcopy(place_birth[3], "Haidarabad");
            strcopy(place_birth[4], "Calcuta");
            strcopy(place_birth[5], "Chennai");
            strcopy(place_birth[6], "Ahmedabad");
            strcopy(place_birth[7], "Pune");
            strcopy(place_birth[8], "Jaipur");
            strcopy(place_birth[9], "Lucknow");
            strcopy(place_birth[10], "Kanpur");
            strcopy(place_birth[11], "Nagpur");
            strcopy(place_birth[12], "Indore");
            strcopy(place_birth[13], "Surate");
            strcopy(place_birth[14], "Madurai");
            strcopy(place_birth[15], "Patna");
            strcopy(place_birth[16], "Visakhapatnam");
            strcopy(place_birth[17], "Vadodara");
            strcopy(place_birth[18], "Ludhiana");
            strcopy(place_birth[19], "Bhopal");
            strcopy(place_birth[20], "Agra");
            strcopy(place_birth[21], "Vishakhapatnam");
            strcopy(place_birth[22], "Coimbatore");
            strcopy(place_birth[23], "Meerut");
            strcopy(place_birth[24], "Rajkot");
            strcopy(place_birth[25], "Faridabad");
            strcopy(place_birth[26], "Amritsar");
        }
        case 5: { // Nacionalidade Australiana
            strcopy(place_birth[0], "Sydney");
            strcopy(place_birth[1], "Melbourne");
            strcopy(place_birth[2], "Brisbane");
            strcopy(place_birth[3], "Perth");
            strcopy(place_birth[4], "Adelaida");
            strcopy(place_birth[5], "Canberra");
            strcopy(place_birth[6], "Hobart");
            strcopy(place_birth[7], "Darwin");
            strcopy(place_birth[8], "Gold Coast");
            strcopy(place_birth[9], "Newcastle");
            strcopy(place_birth[10], "Wollongong");
            strcopy(place_birth[11], "Geelong");
            strcopy(place_birth[12], "Cairns");
            strcopy(place_birth[13], "Toowoomba");
            strcopy(place_birth[14], "Ballarat");
            strcopy(place_birth[15], "Bendigo");
            strcopy(place_birth[16], "Launceston");
            strcopy(place_birth[17], "Albury");
            strcopy(place_birth[18], "Maitland");
            strcopy(place_birth[19], "Sunshine Coast");
            strcopy(place_birth[20], "Central Coast");
            strcopy(place_birth[21], "Townsville");
            strcopy(place_birth[22], "Shepparton");
            strcopy(place_birth[23], "Bundaberg");
            strcopy(place_birth[24], "Wagga Wagga");
            strcopy(place_birth[25], "Rockhampton");
            strcopy(place_birth[26], "Coffs Harbour");
        }
        case 3: { // Nacionalidade Argelina
            strcopy(place_birth[0], "Algiers");
            strcopy(place_birth[1], "Oran");
            strcopy(place_birth[2], "Constantina");
            strcopy(place_birth[3], "Blida");
            strcopy(place_birth[4], "Annaba");
            strcopy(place_birth[5], "Batna");
            strcopy(place_birth[6], "Setif");
            strcopy(place_birth[7], "Tizi Ouzou");
            strcopy(place_birth[8], "Djelfa");
            strcopy(place_birth[9], "Biskra");
            strcopy(place_birth[10], "Bejaia");
            strcopy(place_birth[11], "Tlemcen");
            strcopy(place_birth[12], "Sidi Bel Abbes");
            strcopy(place_birth[13], "Skikda");
            strcopy(place_birth[14], "Chlef");
            strcopy(place_birth[15], "Mascara");
            strcopy(place_birth[16], "El Oued");
            strcopy(place_birth[17], "Laghouat");
            strcopy(place_birth[18], "Tiaret");
            strcopy(place_birth[19], "Ghardaia");
            strcopy(place_birth[20], "Saida");
            strcopy(place_birth[21], "Ain Temouchent");
            strcopy(place_birth[22], "Tizi Ouzou");
            strcopy(place_birth[23], "M'sila");
            strcopy(place_birth[24], "Bordj Bou Arreridj");
            strcopy(place_birth[25], "El Tarf");
            strcopy(place_birth[26], "Medea");
        }
        case 19: { // Nacionalidade Sul-coreana
            strcopy(place_birth[0], "Seul");
            strcopy(place_birth[1], "Busan");
            strcopy(place_birth[2], "Incheon");
            strcopy(place_birth[3], "Daegu");
            strcopy(place_birth[4], "Daejeon");
            strcopy(place_birth[5], "Gwangju");
            strcopy(place_birth[6], "Suwon");
            strcopy(place_birth[7], "Ulsan");
            strcopy(place_birth[8], "Changwon");
            strcopy(place_birth[9], "Jeonju");
            strcopy(place_birth[10], "Jeju");
            strcopy(place_birth[11], "Pohang");
            strcopy(place_birth[12], "Cheongju");
            strcopy(place_birth[13], "Gumi");
            strcopy(place_birth[14], "Gyeongju");
            strcopy(place_birth[15], "Gangneung");
            strcopy(place_birth[16], "Wonju");
            strcopy(place_birth[17], "Seongnam");
            strcopy(place_birth[18], "Iksan");
            strcopy(place_birth[19], "Sangju");
            strcopy(place_birth[20], "Andong");
            strcopy(place_birth[21], "Tongyeong");
            strcopy(place_birth[22], "Yeosu");
            strcopy(place_birth[23], "Jinju");
            strcopy(place_birth[24], "Gwangmyeong");
            strcopy(place_birth[25], "Ansan");
            strcopy(place_birth[26], "Yangju");
        }
        case 20: { // Nacionalidade Turca
            strcopy(place_birth[0], "Istambul");
            strcopy(place_birth[1], "Ancara");
            strcopy(place_birth[2], "Izmir");
            strcopy(place_birth[3], "Bursa");
            strcopy(place_birth[4], "Antalia");
            strcopy(place_birth[5], "Adana");
            strcopy(place_birth[6], "Konya");
            strcopy(place_birth[7], "Gaziantep");
            strcopy(place_birth[8], "Mersin");
            strcopy(place_birth[9], "Kocaeli");
            strcopy(place_birth[10], "Samsun");
            strcopy(place_birth[11], "Trabzon");
            strcopy(place_birth[12], "Eskisehir");
            strcopy(place_birth[13], "Kayseri");
            strcopy(place_birth[14], "Diyarbakir");
            strcopy(place_birth[15], "Sanliurfa");
            strcopy(place_birth[16], "Denizli");
            strcopy(place_birth[17], "Bolu");
            strcopy(place_birth[18], "Tekirdag");
            strcopy(place_birth[19], "Aydin");
            strcopy(place_birth[20], "Balikesir");
            strcopy(place_birth[21], "Manisa");
            strcopy(place_birth[22], "Sakarya");
            strcopy(place_birth[23], "Corum");
            strcopy(place_birth[24], "Aksaray");
            strcopy(place_birth[25], "Erzurum");
            strcopy(place_birth[26], "Rize");
        }
        case 18: { // Nacionalidade Sueca
            strcopy(place_birth[0], "Estocolmo");
            strcopy(place_birth[1], "Gotemburgo");
            strcopy(place_birth[2], "Malmo");
            strcopy(place_birth[3], "Uppsala");
            strcopy(place_birth[4], "Vasteras");
            strcopy(place_birth[5], "Orebro");
            strcopy(place_birth[6], "Linkoping");
            strcopy(place_birth[7], "Helsingborg");
            strcopy(place_birth[8], "Jonkoping");
            strcopy(place_birth[9], "Norrkoping");
            strcopy(place_birth[10], "Lund");
            strcopy(place_birth[11], "Vaxjo");
            strcopy(place_birth[12], "Sundsvall");
            strcopy(place_birth[13], "Ostersund");
            strcopy(place_birth[14], "Karlstad");
            strcopy(place_birth[15], "Umea");
            strcopy(place_birth[16], "Eskilstuna");
            strcopy(place_birth[17], "Trollhattan");
            strcopy(place_birth[18], "Boras");
            strcopy(place_birth[19], "Halmstad");
            strcopy(place_birth[20], "Gavle");
            strcopy(place_birth[21], "Molndal");
            strcopy(place_birth[22], "Nykoping");
            strcopy(place_birth[23], "Kalmar");
            strcopy(place_birth[24], "Falun");
            strcopy(place_birth[25], "Lulea");
            strcopy(place_birth[26], "Visby");
        }
    }
    return place_birth;
}

GetEthnicityId(id, bool:is_male) {

    new
        ethnicity[40];

    if (is_male) {

        switch (id) {

            case 1: format(ethnicity, _, "Africano");
            case 2: format(ethnicity, _, "Amarelo");
            case 3: format(ethnicity, _, "Arabe");
            case 4: format(ethnicity, _, "Asiatico");
            case 5: format(ethnicity, _, "Australiano");
            case 6: format(ethnicity, _, "Branco");
            case 7: format(ethnicity, _, "Cigano");
            case 8: format(ethnicity, _, "Celta");
            case 9: format(ethnicity, _, "Esquimo");
            case 10: format(ethnicity, _, "Europeu");
            case 11: format(ethnicity, _, "Hispanico");
            case 12: format(ethnicity, _, "Indigena");
            case 13: format(ethnicity, _, "Judeu");
            case 14: format(ethnicity, _, "Latino");
            case 15: format(ethnicity, _, "Maori");
            case 16: format(ethnicity, _, "Melanesio");
            case 17: format(ethnicity, _, "Negro");
            case 18: format(ethnicity, _, "Pardo");
            case 19: format(ethnicity, _, "Siciliano");
            case 20: format(ethnicity, _, "Tartaro");
        }
    }
    else {

        switch (id) {

            case 1: format(ethnicity, _, "Africana");
            case 2: format(ethnicity, _, "Amarela");
            case 3: format(ethnicity, _, "Arabe");
            case 4: format(ethnicity, _, "Asiatica");
            case 5: format(ethnicity, _, "Australiana");
            case 6: format(ethnicity, _, "Branca");
            case 7: format(ethnicity, _, "Cigana");
            case 8: format(ethnicity, _, "Celta");
            case 9: format(ethnicity, _, "Esquimo");
            case 10: format(ethnicity, _, "Europeia");
            case 11: format(ethnicity, _, "Hispanica");
            case 12: format(ethnicity, _, "Indigena");
            case 13: format(ethnicity, _, "Judia");
            case 14: format(ethnicity, _, "Latina");
            case 15: format(ethnicity, _, "Maori");
            case 16: format(ethnicity, _, "Melanesia");
            case 17: format(ethnicity, _, "Negra");
            case 18: format(ethnicity, _, "Parda");
            case 19: format(ethnicity, _, "Siciliana");
            case 20: format(ethnicity, _, "Tartara");
        }
    }
    return ethnicity;
}
