//=-=-=-=-=-=-=-=-=-=-=[Include's]=-=-=-=-=-=-=-=-=-=-=//
#include <open.mp>

main() {
    print("Servidor iniciado com sucesso.");
}

public OnPlayerRequestClass(playerid, classid) {

    SpawnPlayer(playerid);
    return 1;
}

