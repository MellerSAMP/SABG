#include <YSI\y_hooks>

new Text:Crosshair;

hook OnGameModeInit() {
	Crosshair = TextDrawCreate(333.000000, 171.000000, "X");
	TextDrawBackgroundColor(Crosshair, 255);
	TextDrawFont(Crosshair, 1);
	TextDrawLetterSize(Crosshair, 0.470000, 1.600000);
	TextDrawColor(Crosshair, -1);
	TextDrawSetOutline(Crosshair, 1);
	TextDrawSetProportional(Crosshair, 1);
	TextDrawSetSelectable(Crosshair, 0);
}