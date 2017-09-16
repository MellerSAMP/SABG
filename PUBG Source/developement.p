#include <YSI\y_hooks>

CMD:developement(playerid) {
	if(GetPVarInt(playerid, "developer") == 1) {
		if(GetPlayerColor(playerid) == 0xF1F1F100) {
			new message[144], name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, MAX_PLAYER_NAME);
			format(message, 144, " Developer %s(%i) has gone on-duty and cannot take damage.", name, playerid);
			SendClientMessageToAll(0x85C474FF, message);
			SetPlayerColor(playerid, 0x85C47400);
		}
		else {
			new message[144], name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, MAX_PLAYER_NAME);
			format(message, 144, " Developer %s(%i) has gone off-duty and is interacting with the battle again.", name, playerid);
			SendClientMessageToAll(0x85C474FF, message);
			SetPlayerColor(playerid, 0xF1F1F100);
		}
	}
	else
		SendClientMessage(playerid, 0xAB4F53FF, "Error! {F1F1F1}You're not authorized to use this command.");
	return 1;
}

CMD:create(playerid) {
	if(GetPVarInt(playerid, "developer") == 1) {
		if(GetPlayerColor(playerid) == 0x85C47400) {
			ShowPlayerDialog(playerid, DIALOG_DEV_CREATE, DIALOG_STYLE_TABLIST_HEADERS, "Restricted Developement Tools", "{B79761}Select an item to create\nApple Pickup", "Select", "Canecl");
		}
		else 
			SendClientMessage(playerid, 0xAB4F53FF, "Error! {F1F1F1}You're not on developer duty, use /developement!");
	}
	else
		SendClientMessage(playerid, 0xAB4F53FF, "Error! {F1F1F1}You're not authorized to use this command.");
	return 1;
}

new Apples[MAX_PLAYERS];

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case DIALOG_DEV_CREATE: {
			if(response) {
				switch(listitem) {
					case 0: { // Apple Pickup
						DestroyDynamicObject(Apples[playerid]);
						new Float:x, Float:y, Float:z;
						GetPlayerPos(playerid, x, y, z);
						Apples[playerid] = CreateDynamicObject(19576, x, y, z, 0, 0, 0);
						EditDynamicObject(playerid, Apples[playerid]);
						SendClientMessage(playerid, 0x85C474FF, " Developement Mode > {F1F1F1}Move and rotate the apple and then save it.");
					}
				}
			}
		}
	}
}

hook OnPlayerEditDynamicObj(playerid, STREAMER_TAG_OBJECT objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	if(Apples[playerid] == objectid) {
		if(response == EDIT_RESPONSE_FINAL) {
			new query[524];
			mysql_format(databaseHandle, query, 524, "INSERT INTO pickups SET type = %i, x = %f, y = %f, z = %f, rotX = %f, rotY = %f, rotZ = %f", ITEM_APPLE, x, y, z, rx, ry, rz);
			mysql_tquery(databaseHandle, query, "OnPlayerCreateApple", "iffffff", playerid, x, y, z, rx, ry, rz);
			DestroyDynamicObject(Apples[playerid]);
		}
	}
}

forward public OnPlayerCreateApple(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz);
public OnPlayerCreateApple(playerid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz) {
	new sqlid = cache_insert_id();
	for(new i = 0; i < MAX_PICKUPS; i++) {
		if(Pickups[i][pInUse] != true) {
			Pickups[i][pSQLID] = sqlid;
			Pickups[i][pType] = ITEM_APPLE;
			Pickups[i][pX] = x;
			Pickups[i][pY] = y;
			Pickups[i][pZ] = z;
			Pickups[i][prX] = rx;
			Pickups[i][prY] = ry;
			Pickups[i][prZ] = rz;

			Pickups[i][pStaticID1] = CreateDynamicObject(GetItemModel(ITEM_APPLE), x, y, z, rx, ry, rz);
			Pickups[i][pStaticID2] = Create3DTextLabel("Green Apple\nPress ALT to pickup", 0x8DB600DD, x, y, z+0.27, 1.5, 0, 1);
			break;
		}
	}
}