/*
	filename: fn_adminDebugExec.sqf
	Author: Stevo
	
	Description:
	Used to execute the code
*/

private ["_code","_admin"];
_code = [_this,0,"",[""]] call bis_fnc_param;
_admin = [_this,1,player,[objNull]] call bis_fnc_param;

if(typeName _code == "STRING") then {
	if (_code == "") exitWith {["The code attempted to be executed is empty.",0] remoteExec ["life_fnc_BroadcastHUD",_admin,false];};
	_code = compile format["%1", _code];
	[] call _code;
};

["DEBUG: Code executed successfully...",20] remoteExec ["life_fnc_BroadcastHUD",_admin,false];