/*
	File: fn_postBail.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when the player attempts to post bail.
	Needs to be revised.
*/
private["_unit","_expGain"];
_unit = _this select 1;
if(life_bail_paid) exitWith {};
if(isNil "life_bail_amount") then {life_bail_amount = 350;};
if(!isNil "life_canpay_bail") exitWith {_string = localize "STR_NOTF_Bail_Post"; life_HUD_notifs pushBack [_string,time,2];};
if(life_cash < life_bail_amount) exitWith {_string = format[localize "STR_NOTF_Bail_NotEnough",life_bail_amount]; life_HUD_notifs pushBack [_string,time,2];};

life_cash = life_cash - life_bail_amount;
life_bail_paid = true;
[[0,"STR_NOTF_Bail_Bailed",true,[profileName]],"life_fnc_broadcast",true,false] spawn life_fnc_MP;
