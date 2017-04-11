/*
	File: fn_buyLicense.sqf
	Author: Stevo
	
	Description:
	Called when purchasing a Faction's first license. It removes all other licenses not compatible with the faction.
*/
private["_type","_hitman","_expGain"];
_type = _this select 3;

_price = [_type] call life_fnc_licensePrice;
_license = [_type,0] call life_fnc_licenseType;

if(life_cash < _price) exitWith {_string = format[localize "STR_NOTF_NE_1",[_price] call life_fnc_numberText,_license select 1]; life_HUD_notifs pushBack [_string,time,2];};
if (getplayerUID player in life_election_candidate) exitWith {life_HUD_notifs pushBack ["You are an electoral candidate and cannot join a faction at this time.",time,1];};
if (player == life_kavala_mayor) exitWith {life_HUD_notifs pushBack ["You are the Mayor of Altis, you have much more important things to be doing!",time,1];};

switch (_type) do {
	case "hitman": {
		if (license_civ_rebel) exitWith {life_HUD_Notifs pushBack ["You cannot become a hitman while you are a part of the rebels.",time,0];};
		if (license_civ_corp) exitWith {life_HUD_Notifs pushBack ["You cannot become a hitman while enrolled in the army.",time,0];};
		if (license_civ_bh) exitWith {life_HUD_Notifs pushBack ["You cannot become a hitman while you are a bounty hunter.",time,0];};
		if (license_civ_service) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a part of the Port Authority",time,0];};
		if (license_civ_journalist) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a Journalist",time,0];};
		if (life_rank_bad_lvl < 1) exitWith {Life_hud_notifs pushback ["Your morality is too good to become a hitman.",time,2];};
		
		life_cash = life_cash - _price;
		Life_hud_notifs pushback ["You are now a member of the Agency",time,1];
		_hitman = 1;
		[player,1,_hitman] call life_fnc_playerVarUpdater;
		
		missionNamespace setVariable[(_license select 0),true];
		
		[10,26] call life_fnc_addExp;
		player setVariable ["job","hit",true];
		
		sleep 0.3;
	};

	case "bh": {
		if (license_civ_rebel) exitWith {life_HUD_Notifs pushBack ["You cannot become a bounty hunter while associated with the rebels.",time,0];};
		if (license_civ_corp) exitWith {life_HUD_Notifs pushBack ["You cannot become a bounty hunter while enrolled in the army.",time,0];};
		if (license_civ_hitman) exitWith {life_HUD_Notifs pushBack ["You cannot become a bounty hunter while you are a hitman.",time,0];};
		if (license_civ_service) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a part of the Port Authority",time,0];};
		if (license_civ_journalist) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a Journalist",time,0];};
		
		life_cash = life_cash - _price;
		Life_hud_notifs pushback ["You are now a certified Bounty Hunter",time,1];
		_hunter = 1;
		[player,2,_hunter] call life_fnc_playerVarUpdater;
		
		missionNamespace setVariable[(_license select 0),true];
		
		[10,25] call life_fnc_addExp;
		player setVariable ["job","bh",true];
		
		sleep 0.3;
		if (license_civ_coke) then {license_civ_coke = false};
	};
	case "rebel": {
		["rebel",player] remoteExec ["TON_fnc_licenseCheck",HC1,false];
	};

	case "corp": {
		["corp",player] remoteExec ["TON_fnc_licenseCheck",HC1,false];
	};
	case "journalist": {
		if (license_civ_hitman) exitWith {life_HUD_Notifs pushBack ["You cannot become a Journalist while you are a hitman.",time,0];};
		if (license_civ_rebel) exitWith {life_HUD_Notifs pushBack ["You cannot become a Journalist while you are a part of the rebels.",time,0];};
		if (license_civ_corp) exitWith {life_HUD_Notifs pushBack ["You cannot become a Journalist while enrolled in the army.",time,0];};
		if (license_civ_bh) exitWith {life_HUD_Notifs pushBack ["You cannot become a Journalist while you are a bounty hunter.",time,0];};
		if (license_civ_service) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a part of the Port Authority",time,0];};
		
		life_cash = life_cash - _price;
		Life_hud_notifs pushback ["You are now a Certified Journalist",time,1];
		
		missionNamespace setVariable[(_license select 0),true];
		
		[10,25] call life_fnc_addExp;
		player setVariable ["job","journo",true];
		
		sleep 0.3;
	};
	case "service": {
		if (license_civ_hitman) exitWith {life_HUD_Notifs pushBack ["You cannot become a PA Worker while you are a hitman.",time,0];};
		if (license_civ_rebel) exitWith {life_HUD_Notifs pushBack ["You cannot become a PA Worker while you are a part of the rebels.",time,0];};
		if (license_civ_corp) exitWith {life_HUD_Notifs pushBack ["You cannot become a PA Worker while enrolled in the army.",time,0];};
		if (license_civ_bh) exitWith {life_HUD_Notifs pushBack ["You cannot become a PA Worker while you are a bounty hunter.",time,0];};
		if (license_civ_journalist) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a Journalist",time,0];};
		if (life_rank_good_lvl < 2) exitWith {life_HUD_Notifs pushBack ["Your morality is not good enough for you to buy this license.",time,2];};
		
		life_cash = life_cash - _price;
		Life_hud_notifs pushback ["You are now a member of the Port Authority Service",time,1];
		
		missionNamespace setVariable[(_license select 0),true];
		
		[10,25] call life_fnc_addExp;
		player setVariable ["job","pa",true];
	};
};
[[player,false,playerSide],"TON_fnc_managesc",false,false] spawn life_fnc_MP;
sleep 0.3;
[[player,true,playerSide],"TON_fnc_managesc",false,false] spawn life_fnc_MP;
[] call SOCK_fnc_updateRequest;