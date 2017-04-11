/*
	File: fn_openPlayerInventory.sqf
	Author: Stevo
	
	Description:
	To be used when a player dies, so that stuck items can be retrieved from a dialog menu similar to a vehicle trunk.
*/
private["_vehicle","_veh_data"];
if(dialog) exitWith {};
_unit = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
if(isNull _unit OR (_unit isKindOf "Car" OR _unit isKindOf "Air" OR _unit isKindOf "Ship" OR _unit isKindOf "House_F")) exitWith {}; //Either a null or invalid type.

if (alive _unit) exitWith {life_HUD_notifs pushBack ["You are not permitted to access this person's inventory items.",time,2];};

if((_unit getVariable ["inv_in_use",false])) exitWith {_string = localize "STR_MISC_PlayerInvUse"; life_hud_notifs pushBack[_string,time,2];};
_unit setVariable["inv_in_use",true,true];
if(!createDialog "TrunkMenu") exitWith {_string = localize "STR_MISC_DialogError"; life_hud_notifs pushBack[_string,time,2];}; //Couldn't create the menu?
disableSerialization;

ctrlSetText[3501,format[(localize "STR_MISC_PlayerStorage")+ " - %1",name _unit]];
ctrlSetText[3504,format[(localize "STR_MISC_Weight")+ " %1/%2",life_carryWeight,life_maxWeight]];


[_unit] call life_fnc_vehInventory;


_vehicle spawn
{
	waitUntil {isNull (findDisplay 3500)};
	_this setVariable["trunk_in_use",false,true];
	if(_this isKindOf "House_F") then {
		[[_this],"TON_fnc_updateHouseTrunk",false,false] spawn life_fnc_MP;
	};
};