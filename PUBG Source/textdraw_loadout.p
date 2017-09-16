#include <YSI\y_hooks>

new PlayerText:Loadout[MAX_PLAYERS][5];

hook OnPlayerConnect(playerid) {
	Loadout[playerid][0] = CreatePlayerTextDraw(playerid,499.000000, 105.000000, "blank");
	PlayerTextDrawBackgroundColor(playerid,Loadout[playerid][0], 255);
	PlayerTextDrawFont(playerid,Loadout[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid,Loadout[playerid][0], 0.500000, 4.700000);
	PlayerTextDrawColor(playerid,Loadout[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid,Loadout[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,Loadout[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,Loadout[playerid][0], 0);
	PlayerTextDrawUseBox(playerid,Loadout[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid,Loadout[playerid][0], 102);
	PlayerTextDrawTextSize(playerid,Loadout[playerid][0], 607.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,Loadout[playerid][0], 0);

	Loadout[playerid][1] = CreatePlayerTextDraw(playerid,500.000000, 106.000000, "TD:");
	PlayerTextDrawBackgroundColor(playerid,Loadout[playerid][1], 255);
	PlayerTextDrawFont(playerid,Loadout[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid,Loadout[playerid][1], 1.380000, 0.699999);
	PlayerTextDrawColor(playerid,Loadout[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid,Loadout[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid,Loadout[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,Loadout[playerid][1], 1);
	PlayerTextDrawUseBox(playerid,Loadout[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid,Loadout[playerid][1], 0);
	PlayerTextDrawTextSize(playerid,Loadout[playerid][1], 40.000000, 40.000000);
	PlayerTextDrawSetPreviewModel(playerid, Loadout[playerid][1], 19576);
	PlayerTextDrawSetPreviewRot(playerid, Loadout[playerid][1], -45.000000, 45.000000, 0.000000, 0.600000);
	PlayerTextDrawSetSelectable(playerid,Loadout[playerid][1], 0);

	Loadout[playerid][2] = CreatePlayerTextDraw(playerid,543.000000, 107.000000, "Apple");
	PlayerTextDrawBackgroundColor(playerid,Loadout[playerid][2], 255);
	PlayerTextDrawFont(playerid,Loadout[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid,Loadout[playerid][2], 0.290000, 1.100000);
	PlayerTextDrawColor(playerid,Loadout[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,Loadout[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid,Loadout[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,Loadout[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid,Loadout[playerid][2], 0);

	Loadout[playerid][3] = CreatePlayerTextDraw(playerid,543.000000, 138.000000, "Press ~k~~PED_ANSWER_PHONE~ to eat");
	PlayerTextDrawBackgroundColor(playerid,Loadout[playerid][3], 255);
	PlayerTextDrawFont(playerid,Loadout[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid,Loadout[playerid][3], 0.150000, 0.799999);
	PlayerTextDrawColor(playerid,Loadout[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,Loadout[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,Loadout[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,Loadout[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid,Loadout[playerid][3], 0);

	Loadout[playerid][4] = CreatePlayerTextDraw(playerid,543.000000, 119.000000, "1 stock~n~1 LBS weight");
	PlayerTextDrawBackgroundColor(playerid,Loadout[playerid][4], 255);
	PlayerTextDrawFont(playerid,Loadout[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid,Loadout[playerid][4], 0.2, 0.8);
	PlayerTextDrawColor(playerid,Loadout[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid,Loadout[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid,Loadout[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid,Loadout[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid,Loadout[playerid][4], 0);
}

hook OnPlayerSpawn(playerid) {
	PlayerTextDrawSetPreviewModel(playerid, Loadout[playerid][1], 3022);
	PlayerTextDrawSetPreviewRot(playerid, Loadout[playerid][1], -45.000000, 45.000000, 0.000000, 1.00000);

	PlayerTextDrawSetString(playerid, Loadout[playerid][2], "Fist");
	PlayerTextDrawSetString(playerid, Loadout[playerid][3], "Press ~k~~PED_FIREWEAPON~ to punch");
	PlayerTextDrawSetString(playerid, Loadout[playerid][4], " ");

	for(new i = 0; i < 5; i++)
		PlayerTextDrawShow(playerid, Loadout[playerid][i]);
}