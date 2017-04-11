/*
	filename: fn_adminCompensateMenu.sqf
	Author: Stevo
	
	Description:
	Configures the admin menu to allow the compensation.
*/
private ["_display","_admin","_ctrl","_data","_unit"];
_admin = objNull;
disableSerialization;
_display = findDisplay 76000;

ctrlShow[76040,true];
ctrlShow[76041,true];
ctrlShow[76042,true];
ctrlShow[76043,true];
ctrlShow[76044,true];
ctrlShow[76045,true];
ctrlShow[76046,true];
ctrlShow[76047,true];
ctrlEnable[76047,true];
ctrlShow[76048,true];
ctrlEnable[76048,true];
ctrlShow[76030,false];

ctrlEnable [76001,false];
ctrlEnable [76011,false];
ctrlEnable [76012,false];
ctrlEnable [76013,false];
ctrlEnable [76014,false];
ctrlEnable [76015,false];
ctrlEnable [76016,false];

_ctrl = _display displayCtrl 76040;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl = _display displayCtrl 76041;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl = _display displayCtrl 76042;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl = _display displayCtrl 76043;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl = _display displayCtrl 76044;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl = _display displayCtrl 76045;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl = _display displayCtrl 76046;
_ctrl ctrlSetTextColor[0.7,0.7,0.7,1];
_ctrl ctrlSetBackgroundColor[0,0,0,1];

_index = lbCurSel 76020;
_data = lbData[76020,_index];

if (_data == "") exitWith {life_HUD_Notifs pushBack ["Error identifying selected data...",time,0];};
_unit = call compile format["%1", _data];
if(isNil "_unit") exitWith {life_HUD_Notifs pushBack ["Error identifying selected player...",time,0];};
if(isNull _unit) exitWith {life_HUD_Notifs pushBack ["Error identifying selected player...",time,0];};

_name = _unit getVariable ["realname",name _unit];
ctrlSetText[76043,_name];
_admin = player;
[[_admin],"life_fnc_adminCompQuery",_unit,false] spawn life_fnc_MP;