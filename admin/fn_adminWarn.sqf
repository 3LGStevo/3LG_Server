/*
	filename: fn_adminWarn.sqf
	Author: Stevo
	
	Description:
	Adds to the players warning system.
*/
Private["_display","_unit"];
disableSerialization;
_display = findDisplay 76000;

_unit = lbData[76020,lbCurSel (76020)];

if (_unit == "") exitWith {};

_unit = call compile format["%1", _unit];
if (_unit == player) exitWith {life_HUD_notifs pushBack ["You cannot ban yourself.",time,0];};
_admin = player;

[_unit,_admin] remoteExec ["life_fnc_warn",HC1,false];