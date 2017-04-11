/*
	File: fn_searchInventory.sqf
	Author: Stevo
	
	Description:
	Starts the searching for weapons
*/
private["_unit"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit) exitWith {};
hint "Searching...";
sleep 2;
if(player distance _unit > 5 || !alive player || !alive _unit) exitWith {_string = localize "STR_NOTF_CannotSearchPerson"; life_HUD_notifs pushBack [_string,time,0];};
[[player],"life_fnc_searchWeapons",_unit,false] spawn life_fnc_MP;
life_action_inUse = true;