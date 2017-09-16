#include <YSI\y_hooks>

new PlayerText:Logo[MAX_PLAYERS];

enum playerVars {
	bool:pOnline,
	pWeight,
	pMaxItemID,
	pCurrentItem
}
new Player[MAX_PLAYERS][playerVars];

hook OnIncomingConnection(playerid, ip_address[], port) {
	printf(" [Connection] Incoming connection from %s:%i", ip_address, port);
}

hook OnPlayerConnect(playerid) {
	new ip_port[42];
	NetStats_GetIpPort(playerid, ip_port, 42),
	printf(" [Connection] Connected with %s:%i", ip_port);
	SetTimerEx("OnPlayerEstabilishConnection", 1, false, "i", playerid);

	TogglePlayerSpectating(playerid, true);
	Player[playerid][pOnline] = false;
	Player[playerid][pWeight] = 0;
	Player[playerid][pMaxItemID] = 0;
	Player[playerid][pCurrentItem] = ITEM_FIST;

	Logo[playerid] = CreatePlayerTextDraw(playerid, 320, 60, "San Andreas~n~Battleground's Battle");
	PlayerTextDrawColor(playerid, Logo[playerid], 0xB79761FF);
	PlayerTextDrawSetOutline(playerid, Logo[playerid], 1);
	PlayerTextDrawAlignment(playerid, Logo[playerid], 2);
	PlayerTextDrawFont(playerid, Logo[playerid], 0);
	PlayerTextDrawLetterSize(playerid,Logo[playerid], 1.000000, 2.600000);
	PlayerTextDrawShow(playerid, Logo[playerid]);
}

forward public OnPlayerEstabilishConnection(playerid);
public OnPlayerEstabilishConnection(playerid) {
	new ip_port[42];
	NetStats_GetIpPort(playerid, ip_port, 42),
	printf(" [Connection] Estabilished a stable connection with %s", ip_port);

	for(new id = 0; id < 21; id++)
		SendClientMessage(playerid, 0, " ");

	SetPlayerColor(playerid, 0xAAAAAA00);

	InterpolateCameraPos(playerid, -869.5010, -1963.6543, 59.8985, -688.5210, -1901.6821, 41.1524, 8000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, -868.5317, -1963.3668, 59.7335, -687.5333, -1901.5308, 41.0924, 8000, CAMERA_MOVE);

	SendClientMessage(playerid, 0xB79761FF, " Welcome to San Andreas Battlegound's Battle warzone!");
	SendClientMessage(playerid, 0xB79761FF, " Please login or register depending on your account's status.");

	new query[524], name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	mysql_format(databaseHandle, query, 524, "SELECT * FROM accounts WHERE username = '%e'", name);
	mysql_tquery(databaseHandle, query, "OnPlayerRequestAccountCheck", "i", playerid);
}

forward public OnPlayerRequestAccountCheck(playerid);
public OnPlayerRequestAccountCheck(playerid) {
	if(cache_num_rows()) {
		new fields;
		cache_get_field_count(fields);
		for(new id = 0; id < fields; id++) {
			switch(cache_get_field_type(id)) {
				case 3: {
					new int, field[128];
					cache_get_field_name(id, field);
					cache_get_value_index_int(0, id, int);
					SetPVarInt(playerid, field, int);
				}
				case 253: {
					new string[256], field[128];
					cache_get_field_name(id, field);
					cache_get_value_index(0, id, string, 256);
					SetPVarString(playerid, field, string);
				}
				case MYSQL_TYPE_FLOAT: {
					new Float:floats, field[128];
					cache_get_field_name(id, field);
					cache_get_value_index_float(0, id, floats);
					SetPVarFloat(playerid, field, floats);
				}
			}
		}

		ShowPlayerDialog(playerid, DIALOG_ID_LOGIN, DIALOG_STYLE_PASSWORD, "San Andreas Battleground's Battle",
						"{B79761}Welcome (back) to our battleground's server.\n\
						 {D1B78A}This account is registered as an user in our database..\n\
						 {D1B78A}If you're the owner, please enter your password and continue.", "Submit", "Cancel");
	}
	else {
		ShowPlayerDialog(playerid, DIALOG_ID_REGISTER, DIALOG_STYLE_PASSWORD, "San Andreas Battleground's Battle",
						"{B79761}Welcome to our battleground's server.\n\
						 {D1B78A}This account is not existing in our records of accounts..\n\
						 {D1B78A}Please enter a password to register yourself.", "Submit", "Cancel");
	}
}

hook OnDialogResponse(playerid, dialogid, response, listitem, inputtext[]) {
	switch(dialogid) {
		case DIALOG_ID_LOGIN: {
			if(response) {
				if(!isnull(inputtext)) {
					new hashed[256], password[256];
					GetPVarString(playerid, "password", password, 256);
					SHA256_PassHash(inputtext, "-***-", hashed, 256);
					if(!strcmp(hashed, password, false)) {
						SetPlayerColor(playerid, 0xF1F1F1F1FF);
						Player[playerid][pOnline] = true;
						TogglePlayerSpectating(playerid, false);
						SetSpawnInfo(playerid, 0, 299, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0);
						SpawnPlayer(playerid);
					}
					else {
						ShowPlayerDialog(playerid, DIALOG_ID_LOGIN, DIALOG_STYLE_PASSWORD, "San Andreas Battleground's Battle",
										"{B79761}Welcome (back) to our battleground's server.\n\
										 {D1B78A}This account is registered as an user in our database..\n\
										 {D1B78A}If you're the owner, please enter your password and continue.\n \n\
										{AB4F53}Error! {F1F1F1}The passwords don't match!", "Submit", "Cancel");
					}
				}
				else {
					ShowPlayerDialog(playerid, DIALOG_ID_LOGIN, DIALOG_STYLE_PASSWORD, "San Andreas Battleground's Battle",
									"{B79761}Welcome (back) to our battleground's server.\n\
									 {D1B78A}This account is registered as an user in our database..\n\
									 {D1B78A}If you're the owner, please enter your password and continue.\n \n\
									{AB4F53}Error! {F1F1F1}You must enter a password!", "Submit", "Cancel");
				}
			}
			else {
				SendClientMessage(playerid, 0xB79761FF, " You failed to spawn and was kicked.");
				KickPlayer(playerid);
			}
		}

		case DIALOG_ID_REGISTER: {
			if(response) {
				if(!isnull(inputtext)) {
					new hashed[256], name[MAX_PLAYER_NAME];
					SHA256_PassHash(inputtext, "-***-", hashed, 256);
					GetPlayerName(playerid, name, MAX_PLAYER_NAME);

					new query[524];
					mysql_format(databaseHandle, query, 524, "INSERT INTO accounts SET username = '%e', password = '%e'", name, hashed);
					mysql_tquery(databaseHandle, query, "OnPlayerRegister", "ii", playerid, 0);
				}
				else {
					ShowPlayerDialog(playerid, DIALOG_ID_REGISTER, DIALOG_STYLE_PASSWORD, "San Andreas Battleground's Battle",
									"{B79761}Welcome to our battleground's server.\n\
									 {D1B78A}This account is not existing in our records of accounts..\n\
									 {D1B78A}Please enter a password to register yourself.\n \n\
									{AB4F53}Error! {F1F1F1}You must enter a password!", "Submit", "Cancel");
				}
			}
			else {
				SendClientMessage(playerid, 0xB79761FF, " You failed to spawn and was kicked.");
				KickPlayer(playerid);
			}
		}
	}
}

forward public OnPlayerRegister(playerid, stage);
public OnPlayerRegister(playerid, stage) {
	if(stage != 0) {
		new fields = cache_get_field_count(fields);
		for(new id = 0; id < fields; id++) {
			switch(cache_get_field_type(id)) {
				case MYSQL_TYPE_INT24: {
					new int, field[128];
					cache_get_field_name(id, field);
					cache_get_value_index_int(0, id, int);
					SetPVarInt(playerid, field, int);
				}
				case MYSQL_TYPE_VARCHAR: {
					new string[256], field[128];
					cache_get_field_name(id, field);
					cache_get_value_index(0, id, string, 256);
					SetPVarString(playerid, field, string);
				}
				case MYSQL_TYPE_FLOAT: {
					new Float:floats, field[128];
					cache_get_field_name(id, field);
					cache_get_value_index_float(0, id, floats);
					SetPVarFloat(playerid, field, floats);
				}
			}
		}

		SetPlayerColor(playerid, 0xF1F1F1F1FF);
		Player[playerid][pOnline] = true;
		TogglePlayerSpectating(playerid, false);
		SetSpawnInfo(playerid, 0, 299, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	}
	else {
		new name[MAX_PLAYER_NAME], query[524];
		GetPlayerName(playerid, name, MAX_PLAYER_NAME);
		mysql_format(databaseHandle, query, 524, "SELECT * FROM accounts WHERE username = '%e'", name);
		mysql_tquery(databaseHandle, query, "OnPlayerRegister", "ii", playerid, 1);
	}
}

hook OnPlayerSpawn(playerid) {
	for(new i = 0; i < 21; i++)
		SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, 0xB79761FF, "Welcome back to the battle! Gear up and head out fighting!");
	PlayerTextDrawHide(playerid, Logo[playerid]);
}