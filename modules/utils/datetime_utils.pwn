/*
   _  _     ____        _      _____ _                    _  _   
 _| || |_  |  _ \  __ _| |_ __|_   _(_)_ __ ___   ___   _| || |_ 
|_  ..  _| | | | |/ _` | __/ _ \| | | | '_ ` _ \ / _ \ |_  ..  _|
|_      _| | |_| | (_| | ||  __/| | | | | | | | |  __/ |_      _|
  |_||_|   |____/ \__,_|\__\___||_| |_|_| |_| |_|\___|   |_||_|  
                                                                 
*/

//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
GetDateTime() {

	static
	    date[30];

	getdate(date[2], date[1], date[0]);
	gettime(date[3], date[4], date[5]);

	format(date, sizeof(date), "%02d/%02d/%d, %02d:%02d:%02d", date[0], date[1], date[2], date[3], date[4], date[5]);
	return date;
}

GetNameMonth(monthid) {

    new
        name[10];

    switch (monthid) {

        case 1: name = "Janeiro";
        case 2: name = "Fevereiro";
        case 3: name = "Marco";
        case 4: name = "Abril";
        case 5: name = "Maio";
        case 6: name = "Junho";
        case 7: name = "Julho";
        case 8: name = "Agosto";
        case 9: name = "Setembro";
        case 10: name = "Outubro";
        case 11: name = "Novembro";
        case 12: name = "Dezembro";
    }
    return name;
}