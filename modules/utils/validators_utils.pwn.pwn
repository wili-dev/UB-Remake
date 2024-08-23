/*
    _  _    __     __    _ _     _       _                     _  _   
  _| || |_  \ \   / /_ _| (_) __| | __ _| |_ ___  _ __ ___   _| || |_ 
 |_  ..  _|  \ \ / / _` | | |/ _` |/ _` | __/ _ \| '__/ __| |_  ..  _|
 |_      _|   \ V / (_| | | | (_| | (_| | || (_) | |  \__ \ |_      _|
   |_||_|      \_/ \__,_|_|_|\__,_|\__,_|\__\___/|_|  |___/   |_||_|  
                                                                      
*/

//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
bool:IsValidRoleplayName(const name[]) {

	if (!name[0] || strfind(name, "_") == -1)
	    return false;

	else for (new i = 0, len = strlen(name); i != len; i ++) {

	    if ((i == 0) && (name[i] < 'A' || name[i] > 'Z'))
	        return false;

		else if ((i != 0 && i < len  && name[i] == '_') && (name[i + 1] < 'A' || name[i + 1] > 'Z'))
		    return false;

		else if ((name[i] < 'A' || name[i] > 'Z') && (name[i] < 'a' || name[i] > 'z') && name[i] != '_' && name[i] != '.')
		    return false;
	}
 
    for (new i = 0; i < sizeof(BlacklistNames); i++) {

        if (strfind(name, BlacklistNames[i], true) != -1)
            return false;
    }
	return true;
}

bool:IsValidEmail(const email[]) {

	new
		pontos = 0,
		arroba = 0
	;

	for (new i = 0; i < strlen(email); i++)
	{
		if (email[i] == '@')
			arroba ++;

	    if (email[i] == '.')
			pontos ++;
	}

	if (pontos < 6 && arroba < 3 && (strfind(email, "@gmail.") >= 5 || strfind(email, "@hotmail.") >= 5 || strfind(email, "@outlook.") >= 5))
		return true;

	return false;
}