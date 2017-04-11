/*
	File: fn_buyLicense.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Called when purchasing a license. May need to be revised.
*/
private["_type","_expGain"];
if (playerSide == Civilian) then {
	_type = _this select 0;
} else {
	_type = _this select 3;
};

_price = [_type] call life_fnc_licensePrice;
_license = [_type,0] call life_fnc_licenseType;
_expGain = 50;

if ((_type == "gun") && (life_rank_civ_lvl < 2)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "truck") && (life_rank_civ_lvl < 3)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "civ_air") && (life_rank_civ_lvl < 5)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "cair") && (life_rank_cop_lvl < 3)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "mair") && (life_rank_med_lvl < 2)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "jet") && (life_rank_civ_lvl < 5)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "corp_uav") && (life_army_class < 1)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "corp_mp") && (life_army_class < 2)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "corp_saf") && (life_army_class < 3)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "rebel_mil") && (life_rebel_class < 2)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "rebel_ter") && (life_rebel_class < 3)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "service") && (life_rank_civ_lvl < 2) && (life_rank_good_lvl < 2)) exitWith {life_hud_notifs pushBack ["You need to unlock this license.",time,2];};
if ((_type == "service") && (license_civ_rebel OR license_civ_corp OR license_civ_bh OR license_civ_hitman OR license_civ_journalist)) exitWith {life_HUD_notifs pushBack["You cannot become a member of the Port Authority while operating under another faction.",time,0];};
if ((_type == "journalist") && (license_civ_rebel OR license_civ_corp OR license_civ_bh OR license_civ_hitman OR license_civ_service)) exitWith {life_HUD_notifs pushBack["You cannot become a Journalist while operating under another faction.",time,0];};

if(life_cash < _price) exitWith {_string = format[localize "STR_NOTF_NE_1",[_price] call life_fnc_numberText,_license select 1]; life_HUD_notifs pushBack[_string,time,2]; license_shop_lock = false;};

life_cash = life_cash - _price;
_string = format[localize "STR_NOTF_B_1", _license select 1,[_price] call life_fnc_numberText];
life_HUD_notifs pushBack[_string,time,1];
missionNamespace setVariable[(_license select 0),true];

if (_type == "coke") then {
	[player,9,1] call life_fnc_playerVarUpdater;
};

if (_type == "rebel_ter" OR _type == "corp_saf") then {
	player setVariable ["special",1,true];
};

if (_type == "corp_mp") then {
	player setVariable ["hunter",1,true];
};

if (_type == "rebel_mil") then {
	player setVariable ["mil",1,true];
};

[] spawn life_fnc_jobCheck;

[] call SOCK_fnc_updateRequest;