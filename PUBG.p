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
 	#include <zcmd>
 	#include <FCNPC>
 	#include <MapAndreas>
 	#include <streamer>

 	main() return 1;

 	KickPlayer(playerid) return SetTimerEx("OnServerKickPlayer", GetPlayerPing(playerid), false, "i", playerid);
 	forward public OnServerKickPlayer(playerid);
 	public OnServerKickPlayer(playerid) return Kick(playerid);

 	#define HOLDING(%0) \
		((newkeys & (%0)) == (%0))

	#define RELEASED(%0) \
		(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))
	
	#define PRESSED(%0) \
		(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

 	enum {
 		DIALOG_ID_LOGIN,
 		DIALOG_ID_REGISTER,
 		DIALOG_DEV_CREATE
 	}

 	enum {
		ITEM_FIST = 0,
		ITEM_APPLE,
		ITEM_MUSHROOM,
		ITEM_GUN_AKM,
	}

	enum pickupVars {
		pSQLID,
		bool:pInUse,
		pType,
		Float:pX,
		Float:pY,
		Float:pZ,
		Float:prX,
		Float:prY,
		Float:prZ,

		pStaticID1,
		Text3D:pStaticID2
	}
	new Pickups[MAX_PICKUPS][pickupVars];

 		#include "..\PUBG Source\textdraw_crosshair.p"
 		#include "..\PUBG Source\textdraw_loadout.p"

 		#include "..\PUBG Source\database.p"
 		#include "..\PUBG Source\gamemode.p"
 		#include "..\PUBG Source\default_player.p"
 		#include "..\PUBG Source\player_logs.p"
 		#include "..\PUBG Source\player_items.p"
 		#include "..\PUBG Source\items.p"
 		#include "..\PUBG Source\zombiesManager.p"

 		#include "..\PUBG Source\commands.p"
 		#include "..\PUBG Source\developement.p"