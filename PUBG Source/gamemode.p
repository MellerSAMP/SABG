#include <YSI\y_hooks>

hook OnGameModeInit() {
	DisableInteriorEnterExits(),
		print(" [Gamemode] Disabling default interiors.");

	ManualVehicleEngineAndLights(),
		print(" [Gamemode] Disabling default vehicle handlings.");

	EnableStuntBonusForAll(0),
		print(" [Gamemode] Disabling default stunt bonuses.");

	MapAndreas_Init(MAP_ANDREAS_MODE_FULL);
	FCNPC_InitMapAndreas(MapAndreas_GetAddress());
	FCNPC_SetUpdateRate(80);
}