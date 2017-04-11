/*
	filename: fn_adminCompReturn.sqf
	Author: Stevo
	
	Description: 
	Returns the information, finalises the menu
*/
Private ["_ret"];
_ret = [_this,0,[],[[]]] call bis_fnc_param;
_count = count _ret;
if (_count == 0) exitWith {life_HUD_Notifs pushBack ["There was an error with the return values.",time,0];};

_cash = _ret select 0;
_bank = _ret select 1;
_text = format ["$%1",[_cash] call life_fnc_numberText];
ctrlSetText [76044,_text];
_text = format ["$%1",[_bank] call life_fnc_numberText];
ctrlSetText [76045,_text];


