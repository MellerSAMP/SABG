#include <YSI\y_hooks>

enum itemsVars {
	iSQLID,
	iItem,
	iItemData1,
	iItemData2,
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

			iID++;
		}
	}
}