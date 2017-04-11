/*
	filename: fn_addRobber.sqf
	Author: Stevo
	
	Description:
	Adds a unique robber to the array of robbers.
*/
private["_robbers","_exists"];
_robbers = bank_manager getVariable["robbers",[]];
_exists = 0;
{
	if (player == _x) then {_exists = 1};
}forEach _robbers;

if (_exists == 0) then {
	_robbers pushBack player;
	bank_manager setVariable ["robbers",_robbers,true];
};