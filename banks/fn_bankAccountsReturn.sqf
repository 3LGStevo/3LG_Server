/*
	filename: fn_bankAccountsReturn.sqf
	Author: Stevo
	
	Description:
	Returns with the information for display...
*/

Private ["_display","_ctrl","_bank","_insured","_pay","_string","_insText"];
_bank = [_this,0,0,[0]] call bis_fnc_param;
_insured = [_this,1,false,[false]] call bis_fnc_param;
_pay = [_this,2,0,[0]] call bis_fnc_param;
_insText = "";

disableSerialization;
_display = findDisplay 38700;
_ctrl = _display displayCtrl 38702;

if (_insured) then {
	_insText = "Premium Insurance holder";
} else {
	_insText = "No insurance provider";
};

_string = parseText format ["<t color='#000000'>Account Balance:<br/>%1<br/><br/>Insurance Status:<br/>%2<br/><br/>Salary Income:<br/>%3</t>",[_bank] call life_fnc_numberText,_insText,[_pay] call life_fnc_numberText];
_ctrl ctrlSetStructuredText _string;

ctrlEnable[38703,true];