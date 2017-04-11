/*
	filename: fn_repairWorld.sqf
	Author: Stevo
	
	Description:
	A hopeful script used to repair natural elements of the world.
*/

private ["_worldItem","_damage","_qty","_hasLicense","_newItem"];

if (life_building) exitWith {};
life_building = true;

disableSerialization;
_display = findDisplay 24570;
_list = _display displayCtrl 24571;

_index = lbCurSel _list;
if (_index == -1) exitWith {life_HUD_notifs pushBack["You need to select an item to build.",time,0]; life_building = false;};
_worldItem = _list lbData _index;

if (_worldItem == "---") exitWith {life_HUD_notifs pushBack["You need to select an item to build.",time,0]; life_building = false;};

_qty1 = missionNamespace getVariable (["rockp",0] call life_fnc_varHandle);
_qty2 = missionNamespace getVariable (["ironp",0] call life_fnc_varHandle);
_qty3 = missionNamespace getVariable (["wood",0] call life_fnc_varHandle);

_req1 = 0;
_req2 = 0;
_req3 = 0;

switch (life_rank_repair_lvl) do {
	case 0: {
		switch (_worldItem) do {
			case "Land_City_4m_F": {_req1 = 2; _req2 = 2; _req3 = 0;};
			case "Land_City_8m_F": {_req1 = 4; _req2 = 4; _req3 = 0;};
			case "Land_City2_4m_F": {_req1 = 3; _req2 = 0; _req3 = 0;};
			case "Land_City2_8m_F": {_req1 = 6; _req2 = 0; _req3 = 0;};
			case "Land_City_Pillar_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_City_Gate_F": {_req1 = 2; _req2 = 5; _req3 = 0;};
			case "Land_PipeWall_concretel_8m_F": {_req1 = 2; _req2 = 6; _req3 = 0;};
			case "Land_Wall_IndCnc_4_F": {_req1 = 4; _req2 = 0; _req3 = 0;};
			case "Land_Wall_IndCnc_Pole_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Stone_4m_F": {_req1 = 6; _req2 = 0; _req3 = 0;};
			case "Land_Stone_8m_F": {_req1 = 12; _req2 = 0; _req3 = 0;};
			case "Land_Stone_pillar_F": {_req1 = 4; _req2 = 0; _req3 = 0;};
			case "Land_Stone_Gate_F": {_req1 = 4; _req2 = 5; _req3 = 0;};
			case "Land_IndFnc_3_F": {_req1 = 2; _req2 = 4; _req3 = 0;};
			case "Land_IndFnc_9_F": {_req1 = 5; _req2 = 10; _req3 = 0;};
			case "Land_IndFnc_Pole_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Net_Fence_4m_F": {_req1 = 0; _req2 = 4; _req3 = 0;};
			case "Land_Net_Fence_8m_F": {_req1 = 0; _req2 = 8; _req3 = 0;};
			case "Land_Net_Fence_pole_F": {_req1 = 0; _req2 = 2; _req3 = 0;};
			case "Land_Net_Fence_Gate_F": {_req1 = 0; _req2 = 8; _req3 = 0;};
			case "Land_Pipe_fence_4m_F": {_req1 = 0; _req2 = 4; _req3 = 0;};
			case "Land_LampDecor_F": {_req1 = 2; _req2 = 6; _req3 = 0;};
			case "Land_LampHarbour_F": {_req1 = 0; _req2 = 2; _req3 = 6;};
			case "Land_LampShabby_F": {_req1 = 2; _req2 = 0; _req3 = 5;};
			case "Land_LampStreet_F": {_req1 = 6; _req2 = 3; _req3 = 0;};
			case "Land_LampStreet_small_F": {_req1 = 3; _req2 = 2; _req3 = 0;};
		};
	};
	case 1: {
		switch (_worldItem) do {
			case "Land_City_4m_F": {_req1 = 2; _req2 = 1; _req3 = 0;};
			case "Land_City_8m_F": {_req1 = 4; _req2 = 2; _req3 = 0;};
			case "Land_City2_4m_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_City2_8m_F": {_req1 = 4; _req2 = 0; _req3 = 0;};
			case "Land_City_Pillar_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_City_Gate_F": {_req1 = 2; _req2 = 3; _req3 = 0;};
			case "Land_PipeWall_concretel_8m_F": {_req1 = 2; _req2 = 4; _req3 = 0;};
			case "Land_Wall_IndCnc_4_F": {_req1 = 3; _req2 = 0; _req3 = 0;};
			case "Land_Wall_IndCnc_Pole_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Stone_4m_F": {_req1 = 4; _req2 = 0; _req3 = 0;};
			case "Land_Stone_8m_F": {_req1 = 8; _req2 = 0; _req3 = 0;};
			case "Land_Stone_pillar_F": {_req1 = 3; _req2 = 0; _req3 = 0;};
			case "Land_Stone_Gate_F": {_req1 = 3; _req2 = 4; _req3 = 0;};
			case "Land_IndFnc_3_F": {_req1 = 1; _req2 = 4; _req3 = 0;};
			case "Land_IndFnc_9_F": {_req1 = 3; _req2 = 8; _req3 = 0;};
			case "Land_IndFnc_Pole_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Net_Fence_4m_F": {_req1 = 0; _req2 = 3; _req3 = 0;};
			case "Land_Net_Fence_8m_F": {_req1 = 0; _req2 = 6; _req3 = 0;};
			case "Land_Net_Fence_pole_F": {_req1 = 0; _req2 = 2; _req3 = 0;};
			case "Land_Net_Fence_Gate_F": {_req1 = 0; _req2 = 6; _req3 = 0;};
			case "Land_Pipe_fence_4m_F": {_req1 = 0; _req2 = 3; _req3 = 0;};
			case "Land_LampDecor_F": {_req1 = 2; _req2 = 4; _req3 = 0;};
			case "Land_LampHarbour_F": {_req1 = 0; _req2 = 2; _req3 = 5;};
			case "Land_LampShabby_F": {_req1 = 2; _req2 = 0; _req3 = 4;};
			case "Land_LampStreet_F": {_req1 = 4; _req2 = 3; _req3 = 0;};
			case "Land_LampStreet_small_F": {_req1 = 2; _req2 = 2; _req3 = 0;};
		};
	};
	case 2: {
		switch (_worldItem) do {
			case "Land_City_4m_F": {_req1 = 1; _req2 = 1; _req3 = 0;};
			case "Land_City_8m_F": {_req1 = 2; _req2 = 2; _req3 = 0;};
			case "Land_City2_4m_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_City2_8m_F": {_req1 = 3; _req2 = 0; _req3 = 0;};
			case "Land_City_Pillar_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_City_Gate_F": {_req1 = 1; _req2 = 3; _req3 = 0;};
			case "Land_PipeWall_concretel_8m_F": {_req1 = 1; _req2 = 3; _req3 = 0;};
			case "Land_Wall_IndCnc_4_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Wall_IndCnc_Pole_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_Stone_4m_F": {_req1 = 3; _req2 = 0; _req3 = 0;};
			case "Land_Stone_8m_F": {_req1 = 6; _req2 = 0; _req3 = 0;};
			case "Land_Stone_pillar_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Stone_Gate_F": {_req1 = 2; _req2 = 3; _req3 = 0;};
			case "Land_IndFnc_3_F": {_req1 = 1; _req2 = 3; _req3 = 0;};
			case "Land_IndFnc_9_F": {_req1 = 2; _req2 = 6; _req3 = 0;};
			case "Land_IndFnc_Pole_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_Net_Fence_4m_F": {_req1 = 0; _req2 = 2; _req3 = 0;};
			case "Land_Net_Fence_8m_F": {_req1 = 0; _req2 = 4; _req3 = 0;};
			case "Land_Net_Fence_pole_F": {_req1 = 0; _req2 = 1; _req3 = 0;};
			case "Land_Net_Fence_Gate_F": {_req1 = 0; _req2 = 4; _req3 = 0;};
			case "Land_Pipe_fence_4m_F": {_req1 = 0; _req2 = 2; _req3 = 0;};
			case "Land_LampDecor_F": {_req1 = 1; _req2 = 3; _req3 = 0;};
			case "Land_LampHarbour_F": {_req1 = 0; _req2 = 1; _req3 = 4;};
			case "Land_LampShabby_F": {_req1 = 1; _req2 = 0; _req3 = 3;};
			case "Land_LampStreet_F": {_req1 = 3; _req2 = 2; _req3 = 0;};
			case "Land_LampStreet_small_F": {_req1 = 2; _req2 = 1; _req3 = 0;};
		};
	};
	case 3: {
		switch (_worldItem) do {
			case "Land_City_4m_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_City_8m_F": {_req1 = 2; _req2 = 1; _req3 = 0;};
			case "Land_City2_4m_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_City2_8m_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_City_Pillar_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_City_Gate_F": {_req1 = 1; _req2 = 2; _req3 = 0;};
			case "Land_PipeWall_concretel_8m_F": {_req1 = 1; _req2 = 2; _req3 = 0;};
			case "Land_Wall_IndCnc_4_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_Wall_IndCnc_Pole_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_Stone_4m_F": {_req1 = 2; _req2 = 0; _req3 = 0;};
			case "Land_Stone_8m_F": {_req1 = 4; _req2 = 0; _req3 = 0;};
			case "Land_Stone_pillar_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_Stone_Gate_F": {_req1 = 1; _req2 = 2; _req3 = 0;};
			case "Land_IndFnc_3_F": {_req1 = 1; _req2 = 2; _req3 = 0;};
			case "Land_IndFnc_9_F": {_req1 = 1; _req2 = 4; _req3 = 0;};
			case "Land_IndFnc_Pole_F": {_req1 = 1; _req2 = 0; _req3 = 0;};
			case "Land_Net_Fence_4m_F": {_req1 = 0; _req2 = 1; _req3 = 0;};
			case "Land_Net_Fence_8m_F": {_req1 = 0; _req2 = 2; _req3 = 0;};
			case "Land_Net_Fence_pole_F": {_req1 = 0; _req2 = 1; _req3 = 0;};
			case "Land_Net_Fence_Gate_F": {_req1 = 0; _req2 = 2; _req3 = 0;};
			case "Land_Pipe_fence_4m_F": {_req1 = 0; _req2 = 1; _req3 = 0;};
			case "Land_LampDecor_F": {_req1 = 1; _req2 = 2; _req3 = 0;};
			case "Land_LampHarbour_F": {_req1 = 0; _req2 = 1; _req3 = 2;};
			case "Land_LampShabby_F": {_req1 = 1; _req2 = 0; _req3 = 2;};
			case "Land_LampStreet_F": {_req1 = 2; _req2 = 1; _req3 = 0;};
			case "Land_LampStreet_small_F": {_req1 = 1; _req2 = 1; _req3 = 0;};
		};
	};
};

if (_qty1 < _req1) exitWith {life_HUD_notifs pushBack ["You do not have enough concrete to build this item.",time,2]; life_building = false;};
if (_qty2 < _req2) exitWith {life_HUD_notifs pushBack ["You do not have enough iron to build this item.",time,2]; life_building = false;};
if (_qty3 < _req3) exitWith {life_HUD_notifs pushBack ["You do not have enough wood to build this item.",time,2]; life_building = false;};

if (_req1 != 0) then {
	[false,"rockp",_req1] call life_fnc_handleInv;
};
if (_req2 != 0) then {
	[false,"ironp",_req1] call life_fnc_handleInv;
};
if (_req3 != 0) then {
	[false,"wood",_req1] call life_fnc_handleInv;
};

closeDialog 0;

_newItem = createVehicle [_worldItem, [0,0,100], [], 0, "CAN_COLLIDE"];;
_newItem attachTo [player,[0,4,0]];
_newItem enableSimulation false;
life_worldItem = _newItem;

life_action_itemDeploy = player addAction["Place structure",{if(!isNull life_worldItem) then {detach life_worldItem; life_worldItem = ObjNull;}; player removeAction life_action_itemDeploy; life_action_itemDeploy = nil;},"",999,false,false,"",'!isNull life_worldItem'];
[_newItem] spawn {
	private["_newItem"];
	_newItem = _this select 0;
	sleep 2;

	waitUntil {isNull life_worldItem};
	if(!isNil "life_action_itemDeploy") then {player removeAction life_action_itemDeploy;};
	if(isNull _newItem) exitWith {life_worldItem = ObjNull;};
	_newItem setPos [(getPos _newItem select 0),(getPos _newItem select 1),0];
	_newItem setVectorUp [0,0,1];
	_newItem enableSimulation true;
	
	[5,25] call life_fnc_addExp;
	
	life_building = false;
};

