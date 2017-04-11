/*
	filename: fn_adminCompEnd.sqf
	Author: Stevo
	
	Description:
	Finishes the process...
*/
Private ["_mode","_value"];
_mode = [_this,0,0,[0]] call bis_fnc_param;
_value = [_this,1,0,[0]] call bis_fnc_param;
_admin = [_this,2,objnull,[objnull]] call bis_fnc_param;
_string = "";

switch (_mode) do {
	case 0: {life_atmcash = life_atmcash + _value; _string = format ["Admin %1 has generated $%2 in compensation for you. It has been added to your Bank.",name _admin,[_value] call life_fnc_numberText];};
	case 1: {life_cash = life_cash + _value; _string = format ["Admin %1 has generated $%2 in compensation for you. It has been added to your Cash.",name _admin,[_value] call life_fnc_numberText];};
};

life_HUD_notifs pushBack [_string,time,1];