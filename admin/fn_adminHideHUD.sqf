#include <macro.h>
/*
	File: fn_adminGodMode.sqf
	Author: Stevo
 
	Description: hides/unhides HUD
*/

if (isNil "life_HideHUD") then {
	2 cutText ["","PLAIN"];
	life_hideHUD = True;
} else {
	[] call life_fnc_HUDSetup;
	life_hideHUD = nil;
};