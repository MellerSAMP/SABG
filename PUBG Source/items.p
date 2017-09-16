GetItemWeight(item) {
	switch(item) {
		case ITEM_FIST: return 0;
		case ITEM_APPLE: return 1;
		case ITEM_MUSHROOM: return 1;
		case ITEM_GUN_AKM: return 7;
	}
	return 0;
}

GetItemName(item) {
	new value[32];
	switch(item) {
		case ITEM_FIST: value = "Fist";
		case ITEM_APPLE: value = "Apple";
		case ITEM_MUSHROOM: value = "Mushroom";
		case ITEM_GUN_AKM: value = "AKM";
	}
	return value;
}

GetItemModel(item) {
	switch(item) {
		case ITEM_FIST: return 3022;
		case ITEM_APPLE: return 19576;
		case ITEM_MUSHROOM: return 2246;
		case ITEM_GUN_AKM: return 355;
	}
	return 0;
}

GetItemUsage(item) {
	new value[64];
	switch(item) {
		case ITEM_FIST: value = "Press ~k~~PED_FIREWEAPON~ to punch";
		case ITEM_APPLE: value = "1 LBS weight";
		case ITEM_MUSHROOM: value = "Press ~k~~PED_LOCK_TARGET~ to eat";
		case ITEM_GUN_AKM: value = "Press ~k~~PED_FIREWEAPON~ to shoot";
	}
	return value;
}

GetItemData(playerid, slot, item) {
	new value[128];
	switch(item) {
		case ITEM_FIST: value = " ";
		case ITEM_APPLE: value = "Press ~k~~PED_FIREWEAPON~ to throw~n~Press ~k~~PED_LOCK_TARGET~ to eat";
		case ITEM_MUSHROOM: value = "1 LBS weight";
		case ITEM_GUN_AKM: format(value, 128, "7 LBS weight~n~%i 7.62MM(42B)", Items[playerid][slot][iItemData1]);
	}
	return value;
}

SetItemInHand(playerid, slot) {
	if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
		RemovePlayerAttachedObject(playerid, 0);
	TextDrawHideForPlayer(playerid, Crosshair);
	switch(slot) {
		case ITEM_APPLE: {
			TextDrawShowForPlayer(playerid, Crosshair);
			SetPlayerAttachedObject(playerid, 0, 19576, 6, 0.043000, 0.046000, 0.000000);
		}
		case ITEM_MUSHROOM: SetPlayerAttachedObject(playerid, 0, 2246, 6, 0.027000, 0.041000, 0.005999, 0.000000, 174.400024, -53.099990, 0.172000, 0.175999, 0.198999);
		case ITEM_GUN_AKM: GivePlayerWeapon(playerid, 30, Items[playerid][Player[playerid][pCurrentItem]][iItemData1]);
	}
}

#include "apples.p"

#include <YSI\y_hooks>

hook OnGameModeInit() {
	mysql_tquery(databaseHandle, "SELECT * FROM pickups", "OnGameLoadPickups");
}

forward public OnGameLoadPickups();
public OnGameLoadPickups() {
	if(cache_num_rows()) {
		for(new i = 0; i < cache_num_rows(); i++) {
			Pickups[i][pInUse] = true;
			cache_get_value_name_int(i, "id", Pickups[i][pSQLID]);
			cache_get_value_name_int(i, "type", Pickups[i][pType]);
			cache_get_value_name_float(i, "x", Pickups[i][pX]);
			cache_get_value_name_float(i, "y", Pickups[i][pY]);
			cache_get_value_name_float(i, "z", Pickups[i][pZ]);
			cache_get_value_name_float(i, "rotX", Pickups[i][prX]);
			cache_get_value_name_float(i, "rotY", Pickups[i][prY]);
			cache_get_value_name_float(i, "rotZ", Pickups[i][prZ]);

			Pickups[i][pStaticID1] = CreateDynamicObject(GetItemModel(Pickups[i][pType]), Pickups[i][pX], Pickups[i][pY], Pickups[i][pZ], Pickups[i][prX], Pickups[i][prY], Pickups[i][prZ]);
			switch(Pickups[i][pType]) {
				case ITEM_APPLE: Pickups[i][pStaticID2] = Create3DTextLabel("Green Apple\nPress ALT to pickup", 0x8DB600FF, Pickups[i][pX], Pickups[i][pY], Pickups[i][pZ]+0.27, 1.5, 0, 1);
			}
		}
	}
}