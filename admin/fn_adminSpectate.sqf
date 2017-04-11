#include <macro.h>
/*
	File: fn_adminSpectate.sqf
	Author: ColinM9991
	
	Description:
	Spectate the chosen player.
*/
if(__GETC__(life_adminlevel) < 2) exitWith {closeDialog 0;};

private["_unit"];
_unit = lbData[76020,lbCurSel (76020)];
_unit = call compile format["%1", _unit];
if(isNil "_unit") exitwith {};
if(isNull _unit) exitWith {};
if(_unit == player) exitWith {life_HUD_notifs pushBack ["You cannot SPECTATE yourself...",time,0];};

[] spawn {
  while {dialog} do {
   closeDialog 0;
   sleep 0.01;
  };
};

_unit switchCamera "INTERNAL";
_string = format["You are now spectating %1. Press F10 to stop Spectating.",_unit getVariable["realname",name _unit]];
life_HUD_notifs pushBack [_string,time,20];
AM_Exit = (findDisplay 46) displayAddEventHandler ["KeyDown","if((_this select 1) == 68) then {(findDisplay 46) displayRemoveEventHandler ['KeyDown',AM_Exit];player switchCamera 'INTERNAL'; life_HUD_notifs pushBack ['You have stopped spectating.',time];};false"]; 