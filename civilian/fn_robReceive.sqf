/*
	File: fn_robReceive.sqf
	Author: Bryan "Tonic" Boardwine
*/
private["_cash","_expGain"];
_cash = [_this,0,0,[0]] call BIS_fnc_param;
if(_cash == 0) exitWith {_string = localize "STR_Civ_RobFail"; life_HUD_notifs pushBack [_string,time,1];};

life_cash = life_cash + _cash;
_string = format[localize "STR_Civ_Robbed",[_cash] call life_fnc_numberText];
life_HUD_notifs pushBack [_string,time,1];

_expGain = 50;
[_expGain,3] call life_fnc_addExp;
[10,26] call life_fnc_addExp;