#include <macro.h>
/*
	File: fn_freezePlayer.sqf
	Author: ColinM9991
 
	Description: Freezes selected player
*/
private["_admin"];
_admin = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;

if(life_frozen) then {
	_string = localize "STR_NOTF_Unfrozen";
	life_hud_notifs pushback [_string,time,20];
	[[format[localize "STR_ANOTF_Unfrozen",profileName],20],"life_fnc_broadcastHUD",_admin,false] spawn life_fnc_MP;
	disableUserInput false;
	life_frozen = false;
} else {
	_string = localize "STR_NOTF_Frozen";
	life_hud_notifs pushback [_string,time];
	[[format[localize "STR_ANOTF_Frozen",profileName],20],"life_fnc_broadcastHUD",_admin,false] spawn life_fnc_MP;
	disableUserInput true;
	life_frozen = true;
};