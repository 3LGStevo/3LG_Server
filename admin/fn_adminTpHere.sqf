#include <macro.h>
/*
	File: fn_adminTpHere.sqf
	Author: ColinM9991
	
	Description:
	Teleport selected player to you.
*/
if(__GETC__(life_adminlevel) == 0) exitWith {closeDialog 0;};

private["_target"];
_target = lbData[76020,lbCurSel (76020)];
_target = call compile format["%1", _target];
if(isNil "_target") exitwith {};
if(isNull _target) exitWith {};
if(_target == player) exitWith {life_HUD_notifs pushBack ["You cannot TP HERE yourself...",time,0];};

_target setPos (getPos player);
_string = format["You have teleported %1 to your location.",_target getVariable["realname",name _target]];
life_HUD_notifs pushBack [_string,time,20];
