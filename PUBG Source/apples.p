#include <YSI\y_hooks>

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys) {
	if(Items[playerid][Player[playerid][pCurrentItem]][iItem] == ITEM_APPLE) {
		if(PRESSED(KEY_FIRE)) {
			ApplyAnimation(playerid, "GRENADE", "WEAPON_throw", 4.1, 0, 0, 0, 0, 1000, 1);

			//TT
		}
		else if(PRESSED(KEY_HANDBRAKE)) {
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 100, 1);
			Items[playerid][Player[playerid][pCurrentItem]][iItem] = 0;
			Player[playerid][pCurrentItem] = 0;
			SetPlayerHoldingItem(playerid);

			new query[524];
			mysql_format(databaseHandle, query, 524, "DELETE FROM items WHERE id = %i", Items[playerid][Player[playerid][pCurrentItem]][iSQLID]);
			mysql_query(databaseHandle, query, false);
		}
	}
}