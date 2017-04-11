/*
	filename: fn_getInsured.sqf
	Author: Stevo
	
	Description:
	Allows the user to become insured.
*/
private ["_insured"];
_insured = player getVariable "insured";

if (_insured) then {
	life_HUD_notifs pushBack ["Your SUATMM Premium Insurance contract has been cancelled.",time,23];
	player setVariable["insured",false];
} else {
	life_HUD_notifs pushBack ["You are now covered with SUATMM Premium Insurance",time,23];
	player setVariable["insured",true];
};