/*
	Filename: fn_adminKillFeedReturn.sqf
	Author: STevo
	
	Description:
	Returns the values from the kill feed, populates the text, and adds it to the tb
*/
Private ["_ret","_display"];
_ret = [_this,0,[],[[]]] call bis_fnc_param;
disableSerialization;
_display = findDisplay 76000;
_tb = _display displayCtrl 76030;
if (count _ret == 0) exitWith {
	_text = parseText "No kill feed entries exist.";
	_tb ctrlSetStructuredText _text;
};

_string = "";

{
	_time = _x select 0;
	_unit = _x select 1;
	_killer = _x select 2;
	_mode = _x select 3;
	
	_string = _string + format ["%1 - %2 killed by %3 - %4<br/>",_time,_unit,_killer,_mode];
} forEach _ret;

_text = parseText _string;
_tb ctrlSetStructuredText _text;