#include <macro.h>
/*
	File: fn_adminGodMode.sqf
	Author: Stevo
 
	Description: Enables admin mode
*/
if(!(__GETC__(life_adminlevel) > 0)) exitWith {closeDialog 0; hint localize "STR_ANOTF_ErrorLevel";};
if (player getVariable["pb",false]) exitWith {closeDialog 0; life_HUD_Notifs pushBack ["You are in the Paintall area and cannot go into greeter mode without breaking it!",time];};
if (player getVariable["gk",false]) exitWith {closeDialog 0; life_HUD_Notifs pushBack ["You are in the Go-Kart area and cannot go into greeter mode without breaking it!",time];};

if (isNil "life_adminmode") then {
	[] call life_fnc_saveGear;
	
	life_adminmode = true;
	player setVariable ["admin_mode",1,true];
	player setVariable ["noDamageAllowed",true,true];
	player setVariable ["admin_lvl",(__GETC__(life_adminlevel)),true];
	if !(player getVariable "insured") then {
		life_HUD_notifs pushBack ["You are now covered with SUATMM Premium Insurance",time,23];
		player setVariable ["insured",true];
	};
	player allowDamage false;
	switch (__GETC__(life_adminlevel)) do {
		case 1: {
			_string = format ["%1 has entered Admin Mode.",name player];
			[[0,_string,false],"life_fnc_broadcast",playableUnits,false] spawn life_fnc_MP;
		};
		case 2: {
			_string = format ["%1 has entered Admin Mode.",name player];
			[[0,_string,false],"life_fnc_broadcast",playableUnits,false] spawn life_fnc_MP;
		};
		case 3: {
			_string = format ["%1 has entered Admin Mode.",name player];
			[[0,_string,false],"life_fnc_broadcast",playableUnits,false] spawn life_fnc_MP;
		};
	};
	[] spawn {
		RemoveAllWeapons player;
		{player removeMagazine _x;} foreach (magazines player);
		removeUniform player;
		removeVest player;
		removeBackpack player;
		removeGoggles player;
		removeHeadGear player;

		{
			player unassignItem _x;
			player removeItem _x;
		} foreach (assignedItems player);

		if(hmd player != "") then {
			player unlinkItem (hmd player);
		};
		
		
		
		player forceAddUniform "U_Rangemaster";
		sleep 0.1;
		[] call life_fnc_uniformsColor;
		player addItem "ItemMap";
		sleep 0.1;
		player assignItem "ItemMap";
		player addItem "NVGoggles";
		player assignItem "NVGoggles";
		
	};
	life_markers = true;
	PlayerMarkers = [];
	FinishedLoop = false;
	[menu_admin_mode] call life_fnc_adminMenu;
	disableSerialization;
	_display = findDisplay 76000;
	_ctrl = _display displayCtrl 76020;
	ctrlSetFocus _ctrl;
	[] call life_fnc_HUDUpdate;
	[] spawn {
		playerMarkers = [];
		while{life_markers} do {
			_temp = playerMarkers;
			{
				if !(_x in allUnits) then {
					deleteMarkerLocal str _x;
					_temp = _temp - [_x];
				};
			} forEach PlayerMarkers;
			
			playerMarkers = _temp;
			
			{
				if(alive _x && isplayer _x) then {
					deleteMarkerLocal str _x;
					_pSee = createMarkerLocal [str _x,getPos _x];
					_pSee setMarkerTypeLocal "mil_triangle";
					_pSee setMarkerPosLocal getPos _x;
					_pSee setMarkerSizeLocal [1,1];
					_pSee setMarkerTextLocal format['%1',_x getVariable["realname",name _x]];
					_pSee setMarkerColorLocal "ColorRed";
					if !(_x in playerMarkers) then {
						PlayerMarkers = PlayerMarkers + [_x];
					};
				};
			} forEach allUnits;
			
			{
				_name = _x getVariable "name";
				_down = _x getVariable ["Revive",false];
				if(!isNil "_name" && !_down) then {
					deleteMarkerLocal str _x;
					_pSee = createMarkerLocal [str _x,getPos _x];
					_pSee setMarkerTypeLocal "mil_dot";
					_pSee setMarkerPosLocal getPos _x;
					_pSee setMarkerSizeLocal [1,1];
					_pSee setMarkerTextLocal format['%1',_x getVariable["realname",name _x]];
					_pSee setMarkerColorLocal "ColorBlack";
					if !(_x in playerMarkers) then {
						PlayerMarkers = PlayerMarkers + [_x];
					};
				};
			} forEach alldeadMen; 
			sleep 0.2;
		};
		FinishedLoop = true;
	};
} else {
	life_adminmode = nil;
	player setVariable ["admin_mode",nil,true];
	player setVariable ["admin_lvl",nil,true];
	player allowDamage true;
	
	switch (__GETC__(life_adminlevel)) do {
		case 1: {
			_string = format ["%1 has left Admin Mode.",name player];
			[[0,_string,false],"life_fnc_broadcast",playableUnits,false] spawn life_fnc_MP;
		};
		case 2: {
			_string = format ["%1 has left Admin Mode.",name player];
			[[0,_string,false],"life_fnc_broadcast",playableUnits,false] spawn life_fnc_MP;
		};
		case 3: {
			_string = format ["%1 has left Admin Mode.",name player];
			[[0,_string,false],"life_fnc_broadcast",playableUnits,false] spawn life_fnc_MP;
		};
	};
	[] spawn {
		if(!(isNil "FinishedLoop")) then {
			life_markers = false;
			waitUntil{FinishedLoop};
			{
				deleteMarkerLocal str _x;
			} forEach PlayerMarkers;	
		};
	};
	life_markers = false;
	life_gear set[14,[]];
	[] spawn {
		[] call life_fnc_loadGear;
		[] call life_fnc_uniformsColor;
	};
	[menu_admin_mode] call life_fnc_adminMenu;
	disableSerialization;
	_display = findDisplay 76000;
	_ctrl = _display displayCtrl 76020;
	ctrlSetFocus _ctrl;
	[] call life_fnc_HUDUpdate;
};

