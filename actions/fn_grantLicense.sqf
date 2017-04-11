/*
	filename: fn_grantLicense.sqf
	Author: Stevo
	
	Description:
	Used to recruit a player into a faction.
*/

private ["_type","_license","_paycheck","_shops","_temp","_cokeSold","_owner","_airdrops"];
_type = [_this,0,"",[""]] call bis_fnc_param;

_license = [_type,0] call life_fnc_licenseType;
_expGain = 50;

switch (_type) do {
	case "rebel": {
		if (license_civ_bh) exitWith {life_HUD_Notifs pushBack ["You cannot join the rebels as a bounty hunter.",time,0];};
		if (license_civ_hitman) exitWith {life_HUD_Notifs pushBack ["You cannot join the rebels as a hitman.",time,0];};
		if (license_civ_corp) exitWith {life_HUD_Notifs pushBack ["You cannot join the rebels when you are part of the army.",time,0];};
		if (license_civ_service) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a part of the Port Authority",time,0];};
		if (license_civ_journalist) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a Journalist",time,0];};
		
		player setVariable ["gang_info",nil,true];
		player setVariable ["unit_info",nil,true];
		[player,0,"rebel"] call life_fnc_playerVarUpdater;	
		missionNamespace setVariable[(_license select 0),true];
		
		Life_hud_notifs pushback ["You are now a member of the Altis Rebel Alliance",time,1];
		
		[50,26] call life_fnc_addExp;
		sleep 0.3;
		[] call life_fnc_paycheckCalculate;
		[] spawn life_fnc_radarReb;
	};

	case "corp": {
		if (license_civ_bh) exitWith {life_HUD_Notifs pushBack ["You cannot join the army as a bounty hunter.",time,0];};
		if (license_civ_hitman) exitWith {life_HUD_Notifs pushBack ["You cannot join the army as a hitman.",time,0];};
		if (license_civ_rebel) exitWith {life_HUD_Notifs pushBack ["You cannot join the army when you are part of the rebels.",time,0];};
		if (license_civ_service) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a part of the Port Authority",time,0];};
		if (license_civ_journalist) exitWith {life_HUD_Notifs pushBack ["You cannot buy this license as you are a Journalist",time,0];};
		
		player setVariable ["gang_info",nil,true];
		player setVariable ["unit_info",nil,true];
		[player,0,"army"] call life_fnc_playerVarUpdater;
		missionNamespace setVariable[(_license select 0),true];
		
		Life_hud_notifs pushback ["You are now conscripted to the Altis Armed Forces",time,1];
		
		[50,25] call life_fnc_addExp;
		sleep 0.3;
		[] call life_fnc_paycheckCalculate;
		if (license_civ_coke) then {license_civ_coke = false};
		[] spawn life_fnc_radarCorp;
	};
	case "corp_saf": {
		license_corp_saf = true;
	};
	case "corp_mp": {
		license_corp_mp = true;
	};
	case "corp_uav": {
		license_corp_uav = true;
	};
	case "rebel_ter": {
		license_rebel_ter = true;
	};
	case "rebel_mil": {
		license_rebel_mil = true;
	};
};

[] spawn life_fnc_jobCheck;
[[player,false,playerSide],"TON_fnc_managesc",false,false] spawn life_fnc_MP;
sleep 0.3;
[[player,true,playerSide],"TON_fnc_managesc",false,false] spawn life_fnc_MP;
[] call SOCK_fnc_updateRequest;