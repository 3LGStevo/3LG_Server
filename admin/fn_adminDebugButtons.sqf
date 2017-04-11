/*
	filename: fn_adminDebugButtons.sqf
	Author: Stevo
	
	Description:
	Pretty straight forward...
*/

private ["_mode","_display","_ctrl","_code"];
_mode = [_this,0,1,[0]] call bis_fnc_param;

disableSerialization;
_display = findDisplay 75000;
_ctrl = _display displayCtrl 75001;
_code = ctrlText _ctrl;

admin_debug_code = _code;

switch (_mode) do {
	case 0: {
		[_code,player] remoteExec ["Life_fnc_adminDebugExec",false,false];
	};
	case 1: {
		[_code,player] call Life_fnc_adminDebugExec;
	};
	case 2: {
		[_code,player] remoteExec ["Life_fnc_adminDebugExec",playableUnits,false];
	};
	case 3: {
		_unit = lbData[75002,lbCurSel (75002)];
		_unit = call compile format["%1", _unit];
		[_code,player] remoteExec ["Life_fnc_adminDebugExec",_unit,false];
	};
};