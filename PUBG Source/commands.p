CMD:command(playerid) {
	if(GetPVarInt(playerid, "developer") == 1) {
		SendClientMessage(playerid, 0xB79761FF, "Developer: {F1F1F1}/developement /create");
	}
	return 1;
}