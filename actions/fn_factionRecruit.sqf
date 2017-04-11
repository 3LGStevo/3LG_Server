/*
	filename: fn_factionRecruit.sqf
	Author: Stevo
	
	Description:
	Assigns a player to the subfaction branch/regiment
*/

private ["_mode","_type"];
_mode = [_this,0,0,[0]] call bis_fnc_param;
_type = [_this,1,"",[""]] call bis_fnc_param;
if (_type == "") exitWith {};

switch (_mode) do {
	case 0: {player setVariable ["unit_info",_type,true];};
	case 1: {player setVariable ["unit_info",nil,true]; player setVariable ["squad_info",nil,true];};
};


[] call SOCK_fnc_updateRequest;