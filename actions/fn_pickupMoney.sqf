/*
	File: fn_pickupMoney.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Picks up money
*/

private["_obj","_val","_expGain"];
_obj = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_val = (_obj getVariable "item") select 1;
if(isNil {_val}) exitWith {};
if(isNull _obj || player distance _obj > 8) exitWith {if(!isNull _obj) then {_obj setVariable["inUse",false,true];};};
if((_obj getVariable["PickedUp",false])) exitWith {deleteVehicle _obj;}; //Object was already picked up.
_obj setVariable["PickedUp",TRUE,TRUE];
if(!isNil {_val}) then
{
	deleteVehicle _obj;
	//waitUntil {isNull _obj};
	
	//Stop people picking up huge values of money which should stop spreading dirty money.
	switch (true) do
	{
		//case (_val > 20000000) : {_val = 100000;}; //VAL>20mil->100k
		case (_val > 5000000) : {_val = 5000000;}; //VAL>5mil->5mil
		default {};
	};
	
	player playmove "AinvPknlMstpSlayWrflDnon";
	_string = format[localize "STR_NOTF_PickedMoney",[_val] call life_fnc_numberText];
	life_HUD_notifs pushBack [_string,time,1];
	life_cash = life_cash + _val;
	life_action_delay = time;
};

[5,9] call life_fnc_addExp;