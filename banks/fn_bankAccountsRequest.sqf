/*
	filename: fn_bankAccountsInfo.sqf
	Author: Stevo
	
	Description:
	Requests information from the player.
*/
Private ["_display","_list"];
disableSerialization;
_display = findDisplay 38700;
_list = _display displayCtrl 38701;
_index = lbCurSel _list;
_unit = _list lbData _index;

_unit = call compile format ["%1",_unit];

[[player],"life_fnc_bankAccountsInfo",_unit,false] spawn life_fnc_MP;

_ctrl = _display displayCtrl 38702;
_ctrl ctrlSetStructuredText parseText "<t color='#000000'>Querying account...</t>";

