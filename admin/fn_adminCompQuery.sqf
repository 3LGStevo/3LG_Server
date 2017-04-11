/*
	filename: fn_adminCompQuery.sqf
	Author: Stevo
	
	DEScription:
	Collects cash information from the player to send to the admin, prior to the comp.
*/
Private ["_admin","_ret"];
_admin = [_this,0,objNull,[objNull]] call bis_fnc_param;
if (isNull _admin) exitWith {};
if (isNil "_admin") exitWith {};
_ret = [];
_ret pushBack life_cash;
_ret pushBack life_atmcash;
[[_ret],"life_fnc_adminCompReturn",_admin,false] spawn life_fnc_MP;