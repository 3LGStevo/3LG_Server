/*
	filename: fn_robBank.sqf
	Author: Stevo
	
	Description:
	Initiates the start of the Bank Robbery Scenario, allowing the player (or players) to rob the ATM machines and the Bank Safe.
*/
private["_cops","_enabled","_marker","_pos"];

//Pre-Checks
if (serverTime > 14000) exitWith {life_HUD_notifs pushBack ["You cannot rob the bank this late in the server cycle. Please wait until server reset.",time,0];};
_cops = west countSide playableUnits;
if (_cops < (4 + life_mayor_security)) exitWith {life_HUD_notifs pushBack ["There aren't enough police online to perform this action...",time,1];};
_enabled = bank_manager getVariable "rip";
if (_enabled == 1) exitWith {life_HUD_notifs pushBack ["A robbery is already in progress!",time,2];};
_cd = bank_manager getVariable "cooldown";
if (_cd == 1) exitWith {life_HUD_notifs pushBack ["There is no money left in the bank to rob!",time,1];};
if (currentWeapon player == "") exitWith {life_HUD_notifs pushBack ["You need a weapon to rob the bank!",time,1];};
_cash = bank_manager getVariable "safe_cash";
if (_cash == 0) exitWith {life_HUD_notifs pushBack ["There is no money left in the bank to rob!",time,1];};

//Init Variables/Settings
_enabled = 1;
bank_manager setVariable["rip",1,true];
_marker = "m_bank_1";
_pos = getMarkerPos _marker;
_markerColor = getMarkerColor _marker;
_marker setMarkerColor "ColorEast";
bank_manager setVariable["time",serverTime,true];

_robbers = [];

{
	if (side _x == Civilian) then {
		if (_x distance _pos < 15) then {
			_robbers pushBack _x;
		};
	};
} forEach playableUnits;

bank_manager setVariable ["robbers",_robbers,true];

life_HUD_notifs pushBack["The safe can be found in the managers office.",time,1];
[["<t size='1.0'>The silent alarm has been triggered at Kavala bank.</t>",23], "life_fnc_broadcastHUD",west,false] spawn life_fnc_MP;
["<t size='1.0'>There is an armed robbery taking place at Kavala bank.</t>",23] call life_fnc_broadcastJournos;

[_marker,_markerColor] remoteExec ["life_fnc_bankRobbery",HC2,false];