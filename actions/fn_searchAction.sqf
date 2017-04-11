/*
	File: fn_searchAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the searching process.
*/
private["_unit","_expGain"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit) exitWith {};
hint localize "STR_NOTF_Searching";
if (life_action_inUse) exitWith {};
sleep 2;
if(player distance _unit > 5 || !alive player || !alive _unit) exitWith {_string = localize "STR_NOTF_CannotSearchPerson"; life_HUD_notifs pushBack [_string,time,0];};
[[player],"life_fnc_searchClient",_unit,false] spawn life_fnc_MP;
life_action_inUse = true;

_expGain = 25;
[_expGain,18] call life_fnc_addExp;