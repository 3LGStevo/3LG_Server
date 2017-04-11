/*
	filename: fn_bankAccountsInfo.sqf
	Author: Stevo
	
	Description:
	Gathers info about the player to send back to the requester.
*/
private ["_unit"];
_unit = [_this,0,objNull,[objNull]] call bis_fnc_param;

_bank = life_atmcash;
_insured = player getVariable ["insured",false];
_paycheck = life_paycheck call bis_fnc_parseNumber;

[[_bank,_insured,_paycheck],"life_fnc_bankAccountsReturn",_unit,false] spawn life_fnc_MP;