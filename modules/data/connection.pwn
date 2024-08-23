//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <a_mysql>
#include <YSI_Coding\y_hooks>

//=-=-=-=-=-=-=-=-=-=-=[Define's]=-=-=-=-=-=-=-=-=-=-=//
#define MYSQL_HOST     "localhost"
#define MYSQL_USER     "root"
#define MYSQL_DATABASE "ub_db"
#define MYSQL_PASSWORD ""

//=-=-=-=-=-=-=-=-=-=-=[Variable's]=-=-=-=-=-=-=-=-=-=-=//
static MySQL:g_Mysql;

//=-=-=-=-=-=-=-=-=-=-=[Callback's]=-=-=-=-=-=-=-=-=-=-=//
hook OnGameModeInit() {

    g_Mysql = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);

    if (mysql_errno() != 0)  {

        print("MySQL: Unable to connect to database.");
        SendRconCommand("exit");
    }
    return 1;
}

hook OnGameModeExit() {

    mysql_close(g_Mysql);
    return 1;
}


//=-=-=-=-=-=-=-=-=-=-=[Function's]=-=-=-=-=-=-=-=-=-=-=//
MySQL:getMySQLHandle() {
    return g_Mysql;
}