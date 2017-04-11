/*
	filename: fn_adminDebugMenu.sqf
	Author: Stevo
	
	Description:
	Just fills the players up really...
*/

private ["_display","_ctrl","_civs","_cops","_meds"];
disableSerialization;
_display = findDisplay 75000;
_list = _display displayCtrl 75002;

if (admin_debug_code != "") then {
	ctrlSetText[75001,admin_debug_code];
};

_civs = [];
_cops = [];
_meds = [];

//Construct arrays
{
	switch (side _x) do {
		case west: {_cops pushBack [_x,_x getVariable["realname",name _x]];}; 
		case civilian : {_civs pushBack [_x,_x getVariable["realname",name _x]];}; 
		case independent : {_meds pushBack [_x,_x getVariable["realname",name _x]];}; 
		default {_civs pushBack [_x,_x getVariable["realname",name _x]];};
	};
} foreach playableUnits;

_sortArray = _civs;
_civs = [_sortArray,[],{_x select 1},"ASCEND"] call bis_fnc_sortBy;
_sortArray = _cops;
_cops = [_sortArray,[],{_x select 1},"ASCEND"] call bis_fnc_sortBy;
_sortArray = _meds;
_meds = [_sortArray,[],{_x select 1},"ASCEND"] call bis_fnc_sortBy;

{
	_unit = _x select 0;
	_name = _x select 1;
	_list lbAdd format["%1 - CIV",_name];
	_list lbSetdata [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,[1,1,1,1]];
} forEach _civs;

{
	_unit = _x select 0;
	_name = _x select 1;
	_list lbAdd format["%1 - COP",_name];
	_list lbSetdata [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,[1,1,1,1]];
} forEach _cops;

{
	_unit = _x select 0;
	_name = _x select 1;
	_list lbAdd format["%1 - MED",_name];
	_list lbSetdata [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,[1,1,1,1]];
} forEach _meds;

_list lbAdd "HC1 - HeadlessClient";
_list lbSetdata [(lbSize _list)-1,"HC1"];
_list lbSetColor [(lbSize _list)-1,[1,0,0,1]];
_list lbAdd "HC2 - HeadlessClient";
_list lbSetdata [(lbSize _list)-1,"HC2"];
_list lbSetColor [(lbSize _list)-1,[1,0,0,1]];
_list lbAdd "HC3 - HeadlessClient";
_list lbSetdata [(lbSize _list)-1,"HC3"];
_list lbSetColor [(lbSize _list)-1,[1,0,0,1]];


_list lbSetCurSel 0;
