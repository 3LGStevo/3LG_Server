#include <macro.h>
/*
	File: fn_adminCompConfirm.sqf
	Author: Stevo
	
	Description:
	Confirm the compensation
*/
private["_value","_action"];
disableSerialization;
_display = findDisplay 76000;
ctrlEnable[76047,false];
_value = parseNumber(ctrlText 76046);
if(_value < 0) exitWith {life_HUD_notifs pushBack ["Value must be greater than 0.",time,0];};
if(_value == 0) exitWith {life_HUD_notifs pushBack ["Value must be greater than 0.",time,0];};
if(_value > 999999) exitWith {_string = localize "STR_ANOTF_Fail"; life_HUD_notifs pushBack [_string,time,0];};

_name = ctrlText 76043;
_index = lbCurSel 76020;
_data = lbData[76020,_index];

if (_data == "") exitWith {life_HUD_Notifs pushBack ["Error identifying selected player...",time,0];};
_unit = call compile format["%1", _data];
if(isNil "_unit") exitWith {life_HUD_Notifs pushBack ["Error identifying selected player...",time,0];};
if(isNull _unit) exitWith {life_HUD_Notifs pushBack ["Error identifying selected player...",time,0];};

if (_value > 2000) then {
	[[0,_value,player],"life_fnc_adminCompEnd",_unit,false] spawn life_fnc_MP;
	_string = format ["You have compensated %1, a sum of $%2 into their Bank.",_name,[_value] call life_fnc_numberText];
	life_HUD_notifs pushBack [_string,time,20];
	
	[[0,format ["Admin %1 has generated $%2 through compensation for %3.",name player,[_value] call life_fnc_numberText,_name]],"life_fnc_Broadcast",playableUnits,false] spawn life_fnc_MP;
} else {
	[[1,_value,player],"life_fnc_adminCompEnd",_unit,false] spawn life_fnc_MP;
	_string = format ["You have compensated %1, a sum of $%2 into their Cash.",_name,[_value] call life_fnc_numberText];
	life_HUD_notifs pushBack [_string,time,20];
	
	[[0,format ["Admin %1 has generated $%2 through compensation for %3.",name player,[_value] call life_fnc_numberText,_name]],"life_fnc_Broadcast",playableUnits,false] spawn life_fnc_MP;
};

ctrlShow[76040,false];
ctrlShow[76041,false];
ctrlShow[76042,false];
ctrlShow[76043,false];
ctrlShow[76044,false];
ctrlShow[76045,false];
ctrlShow[76046,false];
ctrlShow[76047,false];
ctrlShow[76048,false];
ctrlShow[76030,True];

[] call life_fnc_adminQuery;