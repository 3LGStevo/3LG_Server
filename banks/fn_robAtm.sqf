/* 		
		file: fn_robShops.sqf
		Author: Stevo		
		
		Description: Executes the rob atm action!
		Thanks: MrKraken (for the barebones tutorial), Ciaran (for assisting with syntax errors and script development) & Erdem Cankiran (for showing how to implement the user of markers)
*/ 

private["_atm","_robber","_loot","_dist","_rip","_marker","_pos","_ui","_progress","_pgText","_cP","_chance","_temp","_alarm","_atmName","_pause","_sound","_expGain","_speed","_perks","_income","_reward","_temp","_enabled"];
_enabled = bank_manager getVariable "rip";
if (_enabled != 1) exitWith {life_hud_notifs pushBack ["You must initiate a robbery with the bank manager.",time,2];};

//The object that has the action attached to it is _this.
_atm = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param; 

//The player.
_robber = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;

//Setting a delay to be used later (seconds).
_pause = 300;

//Establishes the basic experience gain:
_expGain = 50;

//Identifies the Player's Perks and allocates them for use within the action...
_perks = [0] call life_fnc_perkSystem;
_chance = (_perks select 0) * 100;
_speed = _perks select 1;
_income = _perks select 2;
_reward = 0;
_temp = 0;

/* First-Run Checks */

_loot = _atm getVariable "funds";
_rip = _atm getVariable "status";

if ((isNil "_loot") OR (_loot == 0)) then {
	if (!_rip) then {
		_loot = 200 + round(random 600);
		_atm setVariable ["funds",_loot,true];
	};
};

if (isNil "_rip") then {
	_rip = false;
	_atm setVariable ["status",_rip,true];
};

_loot = _atm getVariable "funds";
_rip = _atm getVariable "status";


/* Initiation Checks */
if (_loot == 0) exitWith {life_HUD_notifs pushBack ["There isn't any money in this cash machine!",time,0];};
if (vehicle player != _robber) exitWith {life_HUD_notifs pushBack ["You need to exit your vehicle!",time,2];};
if (_rip) exitWith {life_HUD_notifs pushBack ["A robbery has already taken place!",time,2];};
if !(alive _robber) exitWith {};
if (life_knockout) exitWith {life_HUD_notifs pushBack ["You are unconscious!",time,2];};
if (life_frozen) exitWith {life_HUD_notifs pushBack ["You have been frozen by an admin!",time,0];};
if (life_is_arrested) exitWith {life_HUD_notifs pushBack ["You are under arrest!",time,0];};
if (life_istazed) exitWith {life_HUD_notifs pushBack ["You've been tasered by the police!",time,0];};


/* Robbery Action */

_rip = true; //Robbery in Progress
_atm setVariable ["status",_rip,true];

_pos = getPos player;

//Sets up the Progress Bar
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2...  (1%1)","%",(localize "STR_pAct_RobProgress")];
_progress progressSetPosition 0.01;
_cP = 0.01;

if (_rip) then {
	while{true} do {
		if (_cP >= 1) exitWith {};
		sleep _speed;
		_cP = _cP + 0.01;
		sleep _speed;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3...  (%2%1)","%",round(_cP * 100),(localize "STR_pAct_RobProgress")];
		
		_dist = player distance _pos;
		if (_dist > 1) exitWith {};
		if !(alive _robber) exitWith {};
		if (life_istazed) exitWith {};
		if (life_is_arrested) exitWith {};
	};

	//Exit client script checks
	If !(alive _robber) exitWith {
		_rip = false;
		_atm setVariable ["status",_rip,true];
	};
	If (player distance _pos > 1) exitWith {
		_rip = false;
		_atm setVariable ["status",_rip,true];
		life_HUD_notifs pushBack ["You must remain still while robbing the ATM.",time,1];
		5 cutText ["","PLAIN"];
	};
	if (life_istazed) exitWith {
		_rip = false;
		_atm setVariable ["status",_rip,true];
		life_HUD_notifs pushBack ["You've been tasered by the police!",time,2];
		5 cutText ["","PLAIN"];
	};
	
	//Removes progress bar
	5 cutText ["","PLAIN"];
	
	//Adds player to array of robbers
	[] spawn life_fnc_addRobber;
	
	//Exit code
	if (_income > 1.0) then {
		_temp = _loot * _income;
		_reward = _temp - _loot;
		life_cash = life_cash + _loot;
		_string = format["You have stolen $%1 from this cash machine! You earned an additional $%2 from your unlocked perks!",[_loot] call life_fnc_numberText,[_reward] call life_fnc_numberText];
	} else {
		life_cash = life_cash + _loot;
		_string = format["You have stolen $%1 from this cash machine!",[_loot] call life_fnc_numberText];	
	};
	
	life_HUD_notifs pushBack [_string,time,1];
	
	//Adds to losses for the bank
	_losses = bank_manager getVariable "losses";
	_losses = _losses + _loot;
	bank_manager setVariable["losses",_losses,true];
	
	
	_expGain = round(_expGain + random(100));
	[_expGain,3] call life_fnc_addExp;
		
	_loot = 0;
	_atm setVariable ["funds",_loot,true];
	
	life_use_atm = false;
	waitUntil {bank_manager getVariable "rip" != 1};
	[1] spawn life_fnc_atmBlocker;
	
	[25,26] call life_fnc_addExp;
};

[0] call SOCK_fnc_updatePartial;