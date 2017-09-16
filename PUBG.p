/*
  _____  _    _ ____   _____                                       
 |  __ \| |  | |  _ \ / ____|                                      
 | |__) | |  | | |_) | |  __                                       
 |  ___/| |  | |  _ <| | |_ |                                      
 | |    | |__| | |_) | |__| |                                      
 |_|____ \____/|____/ \_____|__    ______    _ _ _   _             
  / ____|  /\    _|  \/  |  __ \  |  ____|  | (_) | (_)            
 | (___   /  \  (_) \  / | |__) | | |__   __| |_| |_ _  ___  _ __  
  \___ \ / /\ \   | |\/| |  ___/  |  __| / _` | | __| |/ _ \| '_ \
  ____) / ____ \ _| |  | | |      | |___| (_| | | |_| | (_) | | | |
 |_____/_/    \_(_)_|  |_|_|      |______\__,_|_|\__|_|\___/|_| |_|
*/

 	#include <a_samp>
 	#include <a_mysql>

 	main() return 1;

 	KickPlayer(playerid) return SetTimerEx("OnServerKickPlayer", GetPlayerPing(playerid), false, "i", playerid);
 	forward public OnServerKickPlayer(playerid);
 	public OnServerKickPlayer(playerid) return Kick(playerid);

 	enum {
 		DIALOG_ID_LOGIN,
 		DIALOG_ID_REGISTER
 	}

 		#include "..\PUBG Source\database.p"
 		#include "..\PUBG Source\gamemode.p"
 		#include "..\PUBG Source\default_player.p"
 		#include "..\PUBG Source\player_logs.p"
 		#include "..\PUBG Source\items.p"

 		#include "..\PUBG Source\player_items.p"