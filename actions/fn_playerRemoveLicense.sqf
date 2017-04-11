/*
	File: fn_playerRemoveLicense.sqf
	Author: Stevo
	
	Description:
	Called when a player wants to remove a Faction's license via NPC.
*/
private["_type"];
_type = _this select 0;
if (typename _type == typename objnull) then {
	_type = _this select 3;
};
_STRlicense = "";

_price = [_type] call life_fnc_licensePrice;
_price = round(_price / 10);

_license = [_type,0] call life_fnc_licenseType;
_clothings = ["U_C_Poloshirt_blue","U_C_Poloshirt_burgundy","U_C_Poloshirt_redwhite","U_C_Poloshirt_salmon","U_C_Poloshirt_tricolour"];

if (life_atmcash < _price) exitWith {life_HUD_notifs pushBack ["You do not have enough money in your bank to remove this license",time,2];};

_text = format["Are you sure you wish to remove your %1? The fee to remove this license is %3%2",(_license select 1),[_price] call life_fnc_numberText,"$"];
[_text] call life_fnc_confirmPopup;
waitUntil {isNull (findDisplay 14000)};
if(life_menu_confirm) then {
	
	life_menu_confirm = false;
	
	switch (_type) do {
		case "corp": {
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			life_atmcash = life_atmcash - _price;
			
			[] call life_fnc_paycheckCalculate;
			
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
				player setVariable ["special",0,true];
			};
			
			//Removes Corps License 5, if true
			
			if (license_corp_mp) then {
				_type = "corp_mp";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
				player setVariable ["hunter",0,true];
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

			_string = format["You have removed %1 from your licenses.",_STRlicense];
			life_HUD_notifs pushBack [_string,time,1];
			
			[0] call life_fnc_factionLeave;
			
			[player,0,"civ"] call life_fnc_playerVarUpdater;
		};
		case "rebel": {
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			life_atmcash = life_atmcash - _price;
			
			[] call life_fnc_paycheckCalculate;
			
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
			
			//Remove Rebel License 4, if true
			
			if (license_rebel_mil) then {
				_type = "rebel_mil";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
				player setVariable ["mil",0,true];
			};
			
			//Remove Rebel License 5, if true
			
			if (license_rebel_ter) then {
				_type = "rebel_ter";
				_license = [_type,0] call life_fnc_licenseType;
				missionNamespace setVariable[(_license select 0),false];
				_STRlicense = format["%1, %2",_STRlicense,(_license select 1)];
				player setVariable ["special",0,true];
			};
		
			
			player setVariable ["unit_info",nil,true];
			player setVariable ["squad_info",nil,true];
			
			_string = format["You have removed %1 from your licenses.",_STRlicense];
			life_HUD_notifs pushBack [_string,time,1];
			[1] call life_fnc_factionLeave;
			[player,0,"civ"] call life_fnc_playerVarUpdater;
		};
		case "hitman": {
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			life_atmcash = life_atmcash - _price;

			_string = format["You have removed %1 from your licenses.",_STRlicense];
			life_HUD_notifs pushBack [_string,time,1];
			[3] call life_fnc_factionLeave;
			[player,1,0] call life_fnc_playerVarUpdater;
		};
		case "bh": {
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			life_atmcash = life_atmcash - _price;

			_string = format["You have removed %1 from your licenses.",_STRlicense];
			life_HUD_notifs pushBack [_string,time,1];
			[2] call life_fnc_factionLeave;
			[player,2,0] call life_fnc_playerVarUpdater;
		};
		case "journalist": {
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			life_atmcash = life_atmcash - _price;

			_string = format["You have removed %1 from your licenses.",_STRlicense];
			life_HUD_notifs pushBack [_string,time,1];
			[4] call life_fnc_factionLeave;
			[player,2,0] call life_fnc_playerVarUpdater;
		};
		case "service": {
			_STRlicense = _license select 1;
			missionNamespace setVariable[(_license select 0),false];
			
			life_atmcash = life_atmcash - _price;

			_string = format["You have removed %1 from your licenses.",_STRlicense];
			life_HUD_notifs pushBack [_string,time,1];
			[5] call life_fnc_factionLeave;
			[player,2,0] call life_fnc_playerVarUpdater;
		};
	};

	sleep 0.3;
	[[player,false,playerSide],"TON_fnc_managesc",false,false] spawn life_fnc_MP;
	sleep 0.3;
	[[player,true,playerSide],"TON_fnc_managesc",false,false] spawn life_fnc_MP;
	[] call SOCK_fnc_updateRequest;
} else {
	_string = "License removal cancelled";
	life_HUD_notifs pushBack [_string,time,2];
};
[] spawn life_fnc_jobCheck;
if (license_shop_lock) then {closeDialog 0; license_shop_lock = false;};