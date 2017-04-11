/*
	Filename: fn_bankSafeOpen.sqf
	Author: stevo
	
	Description:
	Used to open the bank safe, and retrieve the cash contents.
*/
Private["_loot","_enable","_cd","_perks","_change","_speed","_income","_reward","_temp"];

//Pre-Checks
_loot = bank_manager getVariable["safe_cash",0];
if (_loot == 0) exitWith {life_HUD_notifs pushBack ["The Bank Safe doesn't have any cash in!.",time,1];};
_enable = bank_manager getVariable["rip",0];
if (_enable != 1) exitWith {life_HUD_notifs pushBack ["You must initiate a Bank Robbery with the Bank Manager",time,1];};
_cd = bank_manager getVariable["cooldown",0];
if (_cd != 0) exitWith {life_HUD_notifs pushBack ["There is no money left in the Bank to rob!",time,1];};
_rip = bank_manager getVariable["safe_rip",0];
if (_rip == 1) exitWith {life_HUD_notifs pushBack ["The Bank Safe is already been robbed!",time,0];};
if !(alive _robber) exitWith {};
if (life_knockout) exitWith {life_HUD_notifs pushBack ["You have been knocked out!",time,0];};
if (life_frozen) exitWith {life_HUD_notifs pushBack ["You have been frozen by an Administrator",time,0];};
if (life_is_arrested) exitWith {life_HUD_notifs pushBack ["You have been arrested by the Police!",time,0];};
if (life_istazed) exitWith {life_HUD_notifs pushBack ["You have been knocked out by a rubber bullet!",time,0];};


//Identifies the Player's Perks and allocates them for use within the action...
_perks = [0] call life_fnc_perkSystem;
_chance = (_perks select 0) * 100;
_speed = (_perks select 1) * 4; //Change multiplier to increase or decrease the time it takes to crack safe.
_income = _perks select 2;
_reward = 0;
_temp = 0;

bank_manager setVariable["safe_rip",1,true];

//Sets up the Progress Bar
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2...  (0%1)","%",(localize "STR_pAct_RobProgress")];
_progress progressSetPosition 0.00;
_cP = 0.00;

while{true} do {
		if (_cP >= 1) exitWith {};
		sleep _speed;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3...  (%2%1)","%",round(_cP * 100),(localize "STR_pAct_RobProgress")];
		
		_dist = _robber distance _atm;
		if !(_dist < 3) exitWith {};
		if !(alive _robber) exitWith {};
		if (life_istazed) exitWith {};
		if (life_is_arrested) exitWith {};
		if (bank_manager getVariable "rip" == 0) exitWith {};
	};

//Exit client script checks
If !(alive _robber) exitWith {
	bank_manager setVariable["safe_rip",0,true];
};
If (_robber distance _atm > 2) exitWith {
	bank_manager setVariable["safe_rip",0,true];
	life_HUD_notifs pushBack ["You moved too far away!",time,2];
	5 cutText ["","PLAIN"];
};
if (life_istazed) exitWith {
	bank_manager setVariable["safe_rip",0,true];
	life_HUD_notifs pushBack ["You have been kncoedk out by the rubber bullet!",time,2];
	5 cutText ["","PLAIN"];
};
if (bank_manager getVariable "rip" == 0) exitWith {
	bank_manager setVariable["safe_rip",0,true];
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
	titleText[format["You have stolen $%1 from the safe! You earned an additional $%2 from your unlocked perks!",[_loot] call life_fnc_numberText,[_reward] call life_fnc_numberText],"PLAIN"];
} else {
	life_cash = life_cash + _loot;
	titleText[format["You have stolen $%1 from the safe!",[_loot] call life_fnc_numberText],"PLAIN"];
};
	
//Adds to losses for the bank
_losses = bank_manager getVariable "losses";
_losses = _losses + _loot;
bank_manager setVariable["losses",_losses,true];

_expGain = round(_expGain + random(300));
[_expGain,3] call life_fnc_addExp;
[50,26] call life_fnc_addExp;

bank_manager setVariable["safe_cash",0,true];

life_use_atm = false;
waitUntil {bank_manager getVariable "rip" != 1};
[1] spawn life_fnc_atmBlocker;

[0] call SOCK_fnc_updatePartial;




















