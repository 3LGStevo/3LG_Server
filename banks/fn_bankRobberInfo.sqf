/*
	filename: fn_bankRobberInfo.sqf
	Author: Stevo
	
	Description:
	Get information on the bank robbers...
*/
disableSerialization;
private["_robbers","_robber","_suspects","_cd","_info","_count","_index","_perks","_chance","_speed","_duration","_ui","_progress","_pgText","_cp"];
_robbers = bank_manager getVariable["robbers",[]];
_robber = objNull;

//Variables
_count = count _robbers;
_index = 0;
_suspects = [];
_expGain = 25;

//Pre-Checks
_cd = bank_manager getVariable["cooldown",1];
if (_cd != 1) exitWith {life_HUD_notifs pushBack ["The bank has not been robbed recently.",time,0];};
_info = bank_manager getVariable["info",0];
if (_info == 1) exitWith {life_HUD_notifs pushBack ["The Bank Manager has already given their statement.",time,1];};
if (playerSide != West) exitWith {life_HUD_notifs pushBack ["This is a matter for the Altis Police Department.",time,2];};
if (_count == 0) exitWith {life_HUD_notifs pushBack ["Nothing was taken from the Bank. The Bank Manager doesn't wish to press charges.",time,1];};

//Perk system
_perks = [2] call life_fnc_perkSystem;
_chance = _perks select 0; //Chance of Failure
_speed = (_perks select 1) / _count; //Speed of action
_duration = _perks select 2; //Duration of result

bank_manager setVariable["info",1,true];

5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText "Taking statements...";
_progress progressSetPosition 0.00;
_cP = 0;

sleep 2;

{
	_index = _index +1;
	//Progress
	while {true} do {
		if (_cP >= 1) exitWith {5 cutText ["","PLAIN"];};
		sleep _speed;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["Attempting to Identify Suspect %4%3...  (%2%1)","%",round(_cP * 100),_index,"#"];
				
		//Exit Progress conditions
		if ((player getVariable "restrained")) exitWith {};
		if (player distance bank_manager > 5) exitWith {};
		if (life_isTazed) exitWith {};
	};
		
	//Success / Failure
	_random = random(100);
	if (_random > _chance) then {
		_suspects pushback _x;
	};	
}forEach _robbers;


_count = count _suspects;
if (_count == 0) exitWith {
	[_expGain,5] call life_fnc_addExp;
	[_expGain,18] call life_fnc_addExp;
};

_expGain = _expGain * (_count + 1);
[_expGain,5] call life_fnc_addExp;
[_expGain,18] call life_fnc_addExp;


{
	if (!alive _x) then {
		_suspects = _suspects - [_x];
	} else {
		[getPlayerUID _x,name _x,"428"] remoteExec ["life_fnc_wantedAdd",HC1,false];
	};
}forEach _suspects;
[["The Bank Manager has released a formal statement about one or more suspects in the Bank Robbery.",23],"life_fnc_broadcastHUD",west,false] spawn life_fnc_MP;

//Marker creation script
[[0,_duration,_suspects],"life_fnc_radarReveal",west,false] spawn life_fnc_MP;














