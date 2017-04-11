/*
	filename: fn_rebExecute.sqf
	Author: Stevo
	
	Description:
	Starts the execution.
*/
private ["_unit"];

_unit = player;

[_unit] remoteExec ["life_fnc_executeStart",HC2,false];