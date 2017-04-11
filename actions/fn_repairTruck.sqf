/*
	File: fn_repairTruck.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Main functionality for toolkits, to be revised in later version.
*/
private["_veh","_upp","_ui","_progress","_pgText","_cP","_displayName","_perks","_speed","_permanent","_state","_stance","_weapon"];
_state = "";
_stance = 0;
_weapon = 0;

_perks = [8] call life_fnc_perkSystem;
_speed = _perks select 0;
if (life_rank_med_lvl > 5) then {
	_permanent = 1;
} else {
	_permanent = 0;
};

_veh = cursorTarget;
life_interrupted = false;
if(isNull _veh) exitwith {};
if((_veh isKindOf "Car") OR (_veh isKindOf "Ship") OR (_veh isKindOf "Air")) then
{
	if("ToolKit" in (items player)) then
	{
		life_action_inUse = true;
		_displayName = getText(configFile >> "CfgVehicles" >> (typeOf _veh) >> "displayName");
		_upp = format[localize "STR_NOTF_Repairing",_displayName];
		//Setup our progress bar.
		disableSerialization;
		5 cutRsc ["life_progress","PLAIN"];
		_ui = uiNameSpace getVariable "life_progress";
		_progress = _ui displayCtrl 38201;
		_pgText = _ui displayCtrl 38202;
		_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
		_progress progressSetPosition 0.01;
		_cP = 0.01;
		_state = animationState player;
		_pos = getPos player;
		
		switch (_state) do {
			//Standing unarmed
			case "amovpercmstpsnonwnondnon": { [5,0,1] spawn life_fnc_animSim; _stance = 2; _weapon = 0;};
			//Crouching unarmed
			case "amovpknlmstpsnonwnondnon": { [0,0,1] spawn life_fnc_animSim; _stance = 0; _weapon = 0;};
			//Prone unarmed
			case "amovppnemstpsnonwnondnon": { [4,0,1] spawn life_fnc_animSim; _stance = 7; _weapon = 0;};
			//Standing with Rifle
			case "amovpercmstpsraswrfldnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [5,0,1] spawn life_fnc_animSim; _stance = 2; _weapon = 2;};
			//Crouching with Rifle
			case "amovpknlmstpsraswrfldnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [0,0,1] spawn life_fnc_animSim; _stance = 0; _weapon = 2;};
			//Prone with Rifle
			case "amovppnemstpsraswrfldnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [4,0,1] spawn life_fnc_animSim; _stance = 7; _weapon = 2;};
			//Standing with Pistol
			case "amovpercmstpsraswpstdnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [5,0,1] spawn life_fnc_animSim; _stance = 2; _weapon = 2;};
			//Crouching with Pistol
			case "amovpknlmstpsraswpstdnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [0,0,1] spawn life_fnc_animSim; _stance = 0; _weapon = 2;};
			//Prone with pistol
			case "amovppnemstpsraswpstdnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [4,0,1] spawn life_fnc_animSim; _stance = 7; _weapon = 2;};
			//Standing with Launcher
			case "amovpercmstpsraswlnrdnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [5,0,1] spawn life_fnc_animSim; _stance = 2; _weapon = 2;};
			//Crouching with Launcher
			case "amovpknlmstpsraswlnrdnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [0,0,1] spawn life_fnc_animSim; _stance = 0; _weapon = 2;};
			//Prone with Launcher
			case "amovppnemstpsraswlnrdnon": { _handle = [0,1,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [4,0,1] spawn life_fnc_animSim; _stance = 7; _weapon = 2;};
			default { _handle = [1,0,0] spawn life_fnc_animSim; waitUntil{scriptDone _handle}; [5,0,1] spawn life_fnc_animSim; _stance = 2; _weapon = 0;};
		};
		
		while{true} do
		{
				sleep _speed;
				_cP = _cP + 0.01;
				_progress progressSetPosition _cP;
				_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
				if(_cP >= 1) exitWith {};
				if(!alive player) exitWith {};
				if(player != vehicle player) exitWith {};
				if(life_interrupted) exitWith {};
				if (_pos distance (getPos player) > 1) exitWith {};
				if (!("ToolKit" in (items player))) exitWith {};
		};
		
		5 cutText ["","PLAIN"];
		if (!("ToolKit" in (items player))) exitWith {_string = localize "STR_NOTF_ActionCancel"; life_HUD_notifs pushBack[_string,time,2]; life_action_inUse = false; [_stance,_weapon,0] spawn life_fnc_animSim;};		
		if(life_interrupted) exitWith {life_interrupted = false; _string = localize "STR_NOTF_ActionCancel"; life_HUD_notifs pushBack[_string,time,2]; life_action_inUse = false; [_stance,_weapon,0] spawn life_fnc_animSim;};
		if (_pos distance (getPos player) > 1) exitWith {_string = localize "STR_NOTF_ActionCancel"; life_HUD_notifs pushBack[_string,time,2]; life_action_inUse = false; [_stance,_weapon,0] spawn life_fnc_animSim;};
		if(player != vehicle player) exitWith {_string = localize "STR_NOTF_RepairingInVehicle"; life_HUD_notifs pushBack[_string,time,2];};
		
		
		life_action_inUse = false;
		[_stance,_weapon,0] spawn life_fnc_animSim;
		
		
		if (_permanent == 0) then {
			player removeItem "ToolKit";
		};
		
		_veh setDamage 0;
		_lockState = _veh getVariable ["lock_broken",true];
		if (_lockState) then {
			_veh setVariable["lock_broken",false,true];
		};
		_string = localize "STR_NOTF_RepairedVehicle";
		life_HUD_notifs pushBack[_string,time,1];
		
		[10,10] call life_fnc_addExp;
	};
};