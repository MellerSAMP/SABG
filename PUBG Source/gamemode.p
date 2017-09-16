#include <YSI\y_hooks>

hook OnGameModeInit() {
	DisableInteriorEnterExits(),
		print(" [Gamemode] Disabling default interiors.");

	ManualVehicleEngineAndLights(),
		print(" [Gamemode] Disabling default vehicle handlings.");

	EnableStuntBonusForAll(0),
		print(" [Gamemode] Disabling default stunt bonuses.");
}
