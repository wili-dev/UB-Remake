/*
    _  _     _____         _      _                        _  _   
  _| || |_  |_   _|____  _| |_ __| |_ __ __ ___      __  _| || |_ 
 |_  ..  _|   | |/ _ \ \/ / __/ _` | '__/ _` \ \ /\ / / |_  ..  _|
 |_      _|   | |  __/>  <| || (_| | | | (_| |\ V  V /  |_      _|
   |_||_|     |_|\___/_/\_\\__\__,_|_|  \__,_| \_/\_/     |_||_|  
                                                                  
*/

//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
getFormatPasswordTextdraw(const password[]) {

    new
        string[13],
        strlenPass = strlen(password) > 12 ? 12 : strlen(password);

    for (new i = 0; i < strlenPass; i++) {
        strcat(string, "]");
    }
    return string;
}