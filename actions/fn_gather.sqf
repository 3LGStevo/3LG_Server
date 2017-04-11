/*
	File: fn_gather.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for gathering.
*/
if(life_action_gathering) exitWith {}; //Action is in use, exit to prevent spamming.
life_action_gathering = true;
private["_gather","_itemWeight","_diff","_itemName","_val","_resourceZones","_zone","_expGain","_expLoss","_perks","_boost"];
_resourceZones = ["peach_1","peach_2","drug_1","drug_2","alcohol_a_1","alcohol_a_2","alcohol_b_1","alcohol_b_2"];
_zone = "";

//Find out what zone we're near
{
	if(player distance (getMarkerPos _x) < 30) exitWith {_zone = _x;};
} foreach _resourceZones;

if(_zone == "") exitWith {
	life_action_gathering = false;
};

//Get the resource that will be gathered from the zone name...
switch(true) do {
	case (_zone in ["peach_1","peach_2"]): {_gather = "peachu";};
	case (_zone in ["alcohol_a_1","alcohol_a_2"]): {_gather = "beeru";};
	case (_zone in ["alcohol_b_1","alcohol_b_2"]): {_gather = "wineu";};
	case (_zone in ["drug_1"]): {_gather = "cokeu";};
	default {""};
};
//gather check??
if(vehicle player != player) exitWith {life_action_gathering = false;};

_perks = [13] call life_fnc_perkSystem;
_val = _perks select 0;

_diff = [_gather,_val,life_carryWeight,life_maxWeight] call life_fnc_calWeightDiff;
if(_diff == 0) exitWith {_string = localize "STR_NOTF_InvFull"; life_HUD_notifs pushBack [_string,time,2]; life_action_gathering = false;};
//for "_i" from 0 to 1 do {
	player playMove "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";
	waitUntil{animationState player != "AinvPercMstpSnonWnonDnon_Putdown_AmovPercMstpSnonWnonDnon";};
	sleep 2.0;
//};
if(([true,_gather,_diff] call life_fnc_handleInv)) then
{
	_itemName = [([_gather,0] call life_fnc_varHandle)] call life_fnc_varToStr;
	titleText[format[localize "STR_NOTF_Gather_Success",_itemName,_diff],"PLAIN"];
	[_val,9] call life_fnc_addExp;
};

if (_zone == "drug_1") then {
	[_val,26] call life_fnc_addExp;
} else {
	[_val,25] call life_fnc_addExp;
};

life_action_gathering = false;
