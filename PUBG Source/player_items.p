#include <YSI\y_hooks>

enum itemsVars {
	iSQLID,
	iItem,
	iItemData1,
	iItemData2,
	bool:iEquipped
}
new Items[MAX_PLAYERS][270][itemsVars];

hook OnPlayerSpawn(playerid) {
	new query[524], name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	mysql_format(databaseHandle, query, 524, "SELECT * FROM items WHERE owner = '%e'", name);
	mysql_tquery(databaseHandle, query, "OnPlayerLoadItems", "i", playerid);
}

forward public OnPlayerLoadItems(playerid);
public OnPlayerLoadItems(playerid) {
	new iID = 0;
	if(cache_num_rows()) {
		for(new id = 0; id < cache_num_rows(); id++) {
			new int;
			cache_get_value_name_int(id, "id", int);
			Items[playerid][iID][iSQLID] = int;

			cache_get_value_name_int(id, "item", int);
			Items[playerid][iID][iItem] = int;

			Player[playerid][pWeight] += GetItemWeight(int);

			cache_get_value_name_int(id, "itemData1", int);
			Items[playerid][iID][iItemData1] = int;

			cache_get_value_name_int(id, "itemData2", int);
			Items[playerid][iID][iItemData2] = int;

			Items[playerid][iID][iEquipped] = true;

			Player[playerid][pMaxItemID] = iID;
			iID++;
		}
	}
	GivePlayerWeapon(playerid, 46, 100);
	SetPlayerArmedWeapon(playerid, 0);	

	SetTimerEx("OnPlayerWeaponStateChange", 500, false, "i", playerid);
}

forward public OnPlayerWeaponStateChange(playerid);
public OnPlayerWeaponStateChange(playerid) {
	if(IsPlayerConnected(playerid)) {
		if(GetPlayerWeapon(playerid) == 46) {
			ResetPlayerWeapons(playerid);
			GivePlayerWeapon(playerid, 46, 100);
			SetPlayerArmedWeapon(playerid, 0);

			if(Player[playerid][pCurrentItem] == Player[playerid][pMaxItemID]) {
				Player[playerid][pCurrentItem] = 0;
			}
			else {
				Player[playerid][pCurrentItem]++;
				while(Items[playerid][Player[playerid][pCurrentItem]][iEquipped] == false) {
					Player[playerid][pCurrentItem]++;
				}
			}

			SetPlayerHoldingItem(playerid);
		}
		else {
			switch(Items[playerid][Player[playerid][pCurrentItem]][iItem]) {
				case ITEM_GUN_AKM: {
					if(GetPlayerWeapon(playerid) != 30) {
						ResetPlayerWeapons(playerid);
						GivePlayerWeapon(playerid, 46, 100);
						SetPlayerArmedWeapon(playerid, 0);

						if(Player[playerid][pCurrentItem] == Player[playerid][pMaxItemID]) {
							Player[playerid][pCurrentItem] = 0;
						}
						else {
							Player[playerid][pCurrentItem]++;
							while(Items[playerid][Player[playerid][pCurrentItem]][iEquipped] == false && Player[playerid][pCurrentItem] != Player[playerid][pMaxItemID]) {
								Player[playerid][pCurrentItem]++;
							}
						}

						SetPlayerHoldingItem(playerid);
					}
				}
			}
		}
		SetTimerEx("OnPlayerWeaponStateChange", 500, false, "i", playerid);
	}
}

SetPlayerHoldingItem(playerid) {
	new slot = Player[playerid][pCurrentItem];
	new item = Items[playerid][slot][iItem];
	PlayerTextDrawSetPreviewModel(playerid, Loadout[playerid][1], GetItemModel(item));
	PlayerTextDrawSetPreviewRot(playerid, Loadout[playerid][1], -45.000000, 45.000000, 0.000000, 0.600000);

	PlayerTextDrawSetString(playerid, Loadout[playerid][2], GetItemName(item));
	PlayerTextDrawSetString(playerid, Loadout[playerid][3], GetItemUsage(item));
	PlayerTextDrawSetString(playerid, Loadout[playerid][4], GetItemData(playerid, slot, item));

	for(new i = 0; i < 5; i++)
		PlayerTextDrawShow(playerid, Loadout[playerid][i]);

	new Float:x, Float:y, Float:z, Float:units;
    GetPlayerVelocity(playerid, x, y, z);
    units = floatsqroot(floatpower(floatabs(x), 2.0) + floatpower(floatabs(y), 2.0) + floatpower(floatabs(z), 2.0)) * 179.28625;
	if(floatround(units) < 0.1552086 && GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK) 
		ApplyAnimation(playerid, "PED", "FIGHTA_BLOCK", 4.1, 0, 0, 0, 0, 480, 1); 

	SetItemInHand(playerid, item); 
}