#include <macro.h>
/*
	filename: fn_adminTpTo.sqf
	Author: Stevo
	
	Description:
	TP to player's position.
*/

if(__GETC__(life_adminlevel) == 0) exitWith {closeDialog 0;};
Private ["_unit"];
_unit = lbData[76020,lbCurSel (76020)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit == player) exitWith {life_HUD_notifs pushBack ["You cannot TP TO yourself...",time,0];};

if (vehicle _unit != _unit) then {
	player moveInCargo (vehicle _unit);
	_string = format["You have teleported into %1's vehicle.",_target getVariable["realname",name _target]];
	life_HUD_notifs pushBack [_string,time,20];
} else {
	player setPos (getPos _unit);
	_string = format["You have teleported to %1's location.",_target getVariable["realname",name _target]];
	life_HUD_notifs pushBack [_string,time,20];
};