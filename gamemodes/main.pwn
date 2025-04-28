/*======================================================================================================================
                              _  _     ___            _           _      _         _  _   
                            _| || |_  |_ _|_ __   ___| |_   _  __| | ___( )___   _| || |_ 
                           |_  ..  _|  | || '_ \ / __| | | | |/ _` |/ _ \// __| |_  ..  _|
                           |_      _|  | || | | | (__| | |_| | (_| |  __/ \__ \ |_      _|
                             |_||_|   |___|_| |_|\___|_|\__,_|\__,_|\___| |___/   |_||_|  

======================================================================================================================*/

#include <open.mp>
#include <a_npc>
#include <crashdetect>
#include <a_mysql>
#include <sscanf2>
#include <streamer>
#include <samp_bcrypt>
#include <mailer>
#include <textdraw-simple-click>

#include <YSI_Core\y_utils>
#include <YSI_Extra\y_inline_mysql>
#include <YSI_Extra\y_inline_timers>
#include <YSI_Coding\y_timers>
#include <YSI_Visual\y_dialog>
#include <YSI_Visual\y_commands>


/*======================================================================================================================
                              _  _     __  __           _       _      _           _  _   
                            _| || |_  |  \/  | ___   __| |_   _| | ___( )  ___   _| || |_ 
                           |_  ..  _| | |\/| |/ _ \ / _` | | | | |/ _ \/  / __| |_  ..  _|
                           |_      _| | |  | | (_) | (_| | |_| | |  __/   \__ \ |_      _|
                             |_||_|   |_|  |_|\___/ \__,_|\__,_|_|\___|   |___/   |_||_|  

======================================================================================================================*/

// # Def #
#include "../modules/def/sprites.pwn"
#include "../modules/def/player_defines.pwn"
#include "../modules/def/blacklist_names.pwn"
#include "../modules/def/character_modes.pwn"

// # Utils #
#include "../modules/utils/macros.pwn"
#include "../modules/utils/datetime.pwn"
#include "../modules/utils/validators.pwn"
#include "../modules/utils/textdraws.pwn"
#include "../modules/utils/others.pwn"

// # Data #
#include "../modules/data/connection.pwn"
#include "../modules/data/player.pwn"

// # Player #
#include "../modules/player/notifications.pwn"

// # Admin #
#include "../modules/admin/commands.pwn"

// # Shared #
#include "../modules/visual/shared/login_background.pwn"
#include "../modules/visual/shared/login_logo.pwn"
#include "../modules/visual/shared/notifications.pwn"

// # Visual #
#include "../modules/visual/login_splash/login_splash.pwn"

#include "../modules/visual/login_account/login.pwn"

#include "../modules/visual/register_account/register_data.pwn"
#include "../modules/visual/register_account/register_verification.pwn"

#include "../modules/visual/create_character/character_modes.pwn"
#include "../modules/visual/create_character/main_menu.pwn"
#include "../modules/visual/create_character/about_menu.pwn"
#include "../modules/visual/create_character/clothes_menu.pwn"

// # Objects #
#include "../modules/objects/library/library.pwn"
#include "../modules/objects/centralApartments/apartmentsLS.pwn"

//#include "../modules/objects/praia.pwn"


/*====================================================================================================================*/
main() {

    print("Servidor iniciado com sucesso.\n");
}