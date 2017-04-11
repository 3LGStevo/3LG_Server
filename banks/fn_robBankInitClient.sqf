/*
	filename: fn_robBankInitCleint.sqf
	Author: Stevo
	
	Description:
	Sets up the bank for robberies - clientside
*/
if (isDedicated) exitWith {};
private["_pos","_marker","_bankers","_present"];
_marker = "m_bank_1";
_pos = getMarkerPos _marker;
_bankers = []; //Array to contain civilians inside or near the bank
_present = false;

_buildings = nearestObjects [_pos, ["Land_Offices_01_V1_F"], 10];
kbank = _buildings select 0;
	
while {true} do {
	_dist = player distance _pos;
	_bankers = bank_manager getVariable["bankers",[]];
	_unit = player;
	
	if (_dist < 30) then {
		if (((player getVariable "faction") == "civ") OR ((player getVariable "faction") == "rebel")) then {
			{
				if (player == _x) then {_present = true};
			} forEach _bankers;
			if (!_present) then {
				_bankers pushBack player;
				bank_manager setVariable["bankers",_bankers,true];
				_present = true;
			};
			if (bank_manager getVariable "rip" == 1) then {
				[0] call life_fnc_bankTimer;
			};
		};
	} else {
		{
			if (player == _x) then {_present = true};
		} forEach _bankers;
		if (_present) then {
			_bankers = _bankers - [_unit];
			bank_manager setVariable["bankers",_bankers,true];
			_present = false;
		};
		If (bank_manager getVariable "rip" == 1) then {
			[1] call life_fnc_bankTimer;
		};
	};
	sleep 1;
};
