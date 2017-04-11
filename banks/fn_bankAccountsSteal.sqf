/*
	filename: fn_bankAccountsSteal.sqf
	Author: Stevo
	
	Description:
	Used to steal a person's bank account information.
*/

private ["_display","_list","_index","_unit"];
disableSerialization;
_display = findDisplay 38700;
_list = _display displayCtrl 38701;
_index = lbCurSel _list;
_unit = _list lbData _index;
_unit = call compile format ["%1",_unit];

if (_unit == player) exitWith {life_HUD_notifs pushBack ["You cannot steal your own account information",time,2];};

_name = _unit getVariable ["realname",name _unit];

_uid = getPlayerUID _unit;
_splitUID = _uid splitString "";
_PIN = format["%1%2%3%4",_splitUID select 13,_splitUID select 14, _splitUID select 15, _splitUID select 16];

_account = [];
_account pushBack _PIN;
_account pushBack _uid;

life_bank_accounts pushBack _account;

_string = format ["You have stolen the account information for %1's Account",_name];
life_hud_notifs pushBack [_string,time,23];

closeDialog 0;


