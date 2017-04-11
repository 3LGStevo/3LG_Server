/*
	filename: fn_punish.sqf
	Author: Stevo
	
	Description:
	Used for removing a player's faction license as punishment.
*/

private ["_unit"];
_unit = [_this,0,objNull,[objNull]] call bis_fnc_param;

_team = _unit getVariable "faction";

_clothings = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour"];

switch (_team) do {
	case "army": {
		if (license_civ_corp) then {
			_type = "corp";
			_license = [_type,0] call life_fnc_licenseType;
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			//Removes Corps License 2, if true
			if (license_corp_air) then {
				_type = "corp_air";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			//Removes Corps License 3, if true
			
			if (license_civ_platinum) then {
				_type = "platinum";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			//Removes Corps License 4, if true

			if (license_corp_saf) then {
				_type = "corp_saf";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			//Removes Corps License 5, if true
			
			if (license_corp_mp) then {
				_type = "corp_mp";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			//Removes Corps License 6, if true
			
			if (license_corp_uav) then {
				_type = "corp_uav";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			player setVariable ["unit_info",nil,true];
			player setVariable ["squad_info",nil,true];

			_string = format["You have been punished by your superior. As a result, the following has been removed from your licenses; %1",_STRlicense];
			life_HUD_notifs pushBack[_string,time,2];
			removeUniform player;
			sleep 1;
			player addUniform (_clothings select (floor(random (count _clothings))));
			removeAllWeapons player;
			{player removeMagazine _x} forEach magazines player;
			removeHeadgear player;
			//removeBackpack player;
			removeGoggles player;
			removeVest player;
			[player,0,"civ"] call life_fnc_playerVarUpdater;
			[] call SOCK_fnc_syncData;
			[] call life_fnc_paycheckCalculate;
			[] call life_fnc_jobCheck;
			
			[["You have punished the player.",1],"life_fnc_broadcastHUD",_unit,false] spawn life_fnc_MP;
			
		} else {
			[["This player is not a part of your faction!",2],"life_fnc_broadcastHUD",_unit,false] spawn life_fnc_MP;
		};
	};
	case "rebel": {
		if (license_civ_rebel) then {
			_type = "rebel";
			_license = [_type,0] call life_fnc_licenseType;
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			//Removes Rebel License 2, if true	
			if (license_rebel_air) then {
				_type = "rebel_air";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			//Removes Rebel License 3, if true
			
			if (license_civ_diamond) then {
				_type = "diamond";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
			};
			
			player setVariable ["unit_info",nil,true];
			player setVariable ["squad_info",nil,true];
			
			_string = format["You have been punished by your superior. As a result, the following has been removed from your licenses; %1",_STRlicense];
			life_HUD_notifs pushBack[_string,time,2];
			removeUniform player;
			sleep 1;
			player addUniform (_clothings select (floor(random (count _clothings))));
			removeAllWeapons player;
			{player removeMagazine _x} forEach magazines player;
			removeHeadgear player;
			//removeBackpack player;
			removeGoggles player;
			removeVest player;
			[player,0,"civ"] call life_fnc_playerVarUpdater;
			[] call SOCK_fnc_syncData;
			[] call life_fnc_paycheckCalculate;
			[] call life_fnc_jobCheck;
			
			[["You have punished the player.",1],"life_fnc_broadcastHUD",_unit,false] spawn life_fnc_MP;
			
		} else {
			[["This player is not a part of your faction!",2],"life_fnc_broadcastHUD",_unit,false] spawn life_fnc_MP;
		};
	};
	case "cop": {
		[_unit,0] call life_fnc_promote;
		sleep 5;
		disableUserInput true;
		life_frozen = true;
		_string = "You have been discharged from the Altis Police Department";
		life_HUD_notifs pushBack[_string,time,2];
		["NotWhitelisted",false,true] call BIS_fnc_endMission;
		sleep 35;
	};
};

[] spawn life_fnc_jobCheck;