/* 		
		file: fn_robRebShops.sqf
		Author: Stevo		
		
		Description: Executes the rob shop action for Rebel owned shops
*/ 

private["_shop","_robber","_loot","_dist","_rip","_marker","_pos","_ui","_progress","_pgText","_cP","_chance","_temp","_alarm","_shopName","_pause","_sound","_expGain","_speed","_perks","_income","_reward","_temp"];

if (serverTime > 14000) exitWith {life_HUD_notifs pushBack ["You cannot obtain laundered money this late in the server cycle. Please wait until server reset.",time,2];};

//The object that has the action attached to it is _this.
_shop = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param; 

//The player.
_robber = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;

//Setting a delay to be used later (seconds).
_pause = 300;

//Establishes the basic experience gain:
_expGain = 25;

//Identifies the Player's Perks and allocates them for use within the action...
_perks = [0] call life_fnc_perkSystem;
_chance = (_perks select 0) * 100;
_speed = _perks select 1;
_income = _perks select 2;
_reward = 0;
_temp = 0;

//Identifying the associated marker with the shop.
_marker = _shop getVariable "marker";

//Giving the shop a friendly name.
_shopName = _shop getVariable ["name","shop"];


if (isNil "_marker") exitWith {};
_pos = getMarkerPos _marker;

/* First-Run Checks */

_loot = _shop getVariable "funds";
_rip = _shop getVariable "status";

if ((isNil "_loot") OR (_loot == 0)) then {
	if (!_rip) then {
		_loot = 50 + round(random 500);
		_shop setVariable ["funds",_loot,true];
	};
};

if (isNil "_rip") then {
	_rip = false;
	_shop setVariable ["status",_rip,true];
};

_loot = _shop getVariable "funds";
_rip = _shop getVariable "status";


if (license_civ_corp) then {

	/* Initiation Checks */
	if (_loot == 0) exitWith {life_HUD_notifs pushBack ["There isn't any money in this shop!",time,0];};
	if (vehicle player != _robber) exitWith {life_HUD_notifs pushBack ["You need to exit your vehicle!",time,2];};
	if (currentWeapon _robber == "") exitWith {life_HUD_notifs pushBack ["You need to be armed to obtain information from the shopkeeper about the laundered money!",time,2];};
	if (currentWeapon _robber == "Binocular") exitWith {life_HUD_notifs pushBack ["You need to be armed to obtain information from the shopkeeper about the laundered money!",time,2];};
	_rebels = [];
	{
		if (_x getVariable "faction" == "rebel") then {_rebels pushBack _x};
	} forEach playableUnits;
	if (count _rebels < 1) exitWith {life_HUD_notifs pushBack ["There aren't any rebels online!",time,0];};
	if (_rip) exitWith {life_HUD_notifs pushBack ["Someone is already speaking with the shopkeeper!",time,2];};
	if !(alive _robber) exitWith {};
	if (life_knockout) exitWith {life_HUD_notifs pushBack ["You are unconscious.",time,2];};
	if (life_frozen) exitWith {life_HUD_notifs pushBack ["You have been frozen by an admin.",time,0];};
	if (life_istazed) exitWith {life_HUD_notifs pushBack ["You are unconscious.",time,2];};


	/* Robbery Action */

	_rip = true; //Robbery in Progress
	_shop setVariable ["status",_rip,true];
	_marker setMarkerColor "ColorOPFOR";

	//Sets up the Progress Bar
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2...  (1%1)","%",(localize "STR_pAct_RobProgress")];
	_progress progressSetPosition 0.01;
	_cP = 0.01;

	_alarm = false;

	//Randomises the value for triggering the alarm.
	_random = random(10000);
	diag_log format["Random: %1",_random];

	if (_rip) then {
		while{true} do {
			if (_cP >= 1) exitWith {};
			sleep _speed;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["%3...  (%2%1)","%",round(_cP * 100),(localize "STR_pAct_RobProgress")];
			
			_dist = _robber distance _shop;
			if !(_dist < 11) exitWith {};
			if !(alive _robber) exitWith {};
			if (life_istazed) exitWith {};
			if (life_is_arrested) exitWith {};

			
			//Randomises the alarm at any point, to trigger once
			if (!_alarm) then {
				//Triggering the alarm + adding player to wanted system
				if (_random < _chance) then {
					life_HUD_notifs pushBack["The cashier hit the alarm, the rebels have been alerted of your actions!",time,21];
					[[format["Attention: The army are trying to secure your laundered money at %1!", _shopName],21], "life_fnc_broadcastHUD",_rebels,false] spawn life_fnc_MP;
					//[[getPlayerUID _robber,name _robber,"327"],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP;
					//[player,10,1] call life_fnc_playerVarUpdater;
					_alarm = true;
				};
			};
		};

		//Exit client script checks
		If !(alive _robber) exitWith {
			if (!_alarm) then {
				_rip = false;
				_shop setVariable ["status",_rip,true];
				_marker = _shop getVariable "marker";
				_markerColor = _shop getVariable "markerColor";
				_marker setMarkerColor _markerColor;
			} else {
				[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
			};
			5 cutText ["","PLAIN"];
		};
		If (_robber distance _shop > 10) exitWith {
			if (!_alarm) then {
				_rip = false;
				_shop setVariable ["status",_rip,true];
				_marker = _shop getVariable "marker";
				_markerColor = _shop getVariable "markerColor";
				_marker setMarkerColor _markerColor;
			} else {
				_shop setVariable ["robber",player,true];
				[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
			};
			life_HUD_notifs pushBack ["You ran too far away.",time,2];
			5 cutText ["","PLAIN"];
		};
		if (life_istazed) exitWith {
			if (!_alarm) then {
				_rip = false;
				_shop setVariable ["status",_rip,true];
				_marker = _shop getVariable "marker";
				_markerColor = _shop getVariable "markerColor";
				_marker setMarkerColor _markerColor;
			} else {
				[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
			};
			5 cutText ["","PLAIN"];
		};
		
		//Removes progress bar
		5 cutText ["","PLAIN"];
		_shop setVariable ["robber",player,true];
		if (_alarm) then {_loot = round(_loot / 2)};

		//Exit code
		if (_income > 1.0) then {
			_temp = round(_loot * _income);
			_reward = _temp - _loot;
			life_cash = life_cash + _temp;
			_string = format["You have secured $%1 of laundered money! You found an additional $%2 because of your perks!",[_loot] call life_fnc_numberText,[_reward] call life_fnc_numberText];
			life_HUD_notifs pushBack [_string,time,1];
		} else {
			life_cash = life_cash + _loot;
			_string = format["You have secured $%1 of laundered money!",[_loot] call life_fnc_numberText];
			life_HUD_notifs pushBack [_string,time,1];
			
		};
		
		[1,10] spawn life_fnc_statHandler;
		
		_expGain = round(_expGain + random(100));
		[_expGain,3] call life_fnc_addExp;
		[10,25] call life_fnc_addExp;

			
		_loot = 0;
		_shop setVariable ["funds",_loot,true];
		_shop setVariable ["income",0,true];
		
		_army = [];
		{
			if (_x getVariable "faction" == "army") then {_army pushBack _x};
		} forEach playableUnits;
		
		[[format["%2 just secured laundered money at %1!",_shopName,name player],1],"life_fnc_broadcastHUD",_army,false] spawn life_fnc_MP;
		
		_news = format ["%1 secured laundered money from %2",name player,_shopName];
		[_news,serverTime] spawn life_fnc_sendNews;
		
		[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
		
		[0] spawn life_fnc_atmBlocker;
	};	
} else {
	
	/* Initiation Checks */
	if (_loot == 0) exitWith {life_HUD_notifs pushBack ["There isn't any money in this shop!",time,0];};
	if (vehicle player != _robber) exitWith {life_HUD_notifs pushBack ["You need to exit your vehicle!",time,2];};
	if (currentWeapon _robber == "") exitWith {life_HUD_notifs pushBack ["You need to be armed to obtain information from the shopkeeper about the laundered money!",time,2];};
	if (currentWeapon _robber == "Binocular") exitWith {life_HUD_notifs pushBack ["You need to be armed to obtain information from the shopkeeper about the laundered money!",time,2];};
	_rebels = [];
	{
		if (_x getVariable "faction" == "rebel") then {_rebels pushBack _x};
	} forEach playableUnits;
	if (count _rebels < 1) exitWith {life_HUD_notifs pushBack ["There aren't any rebels online!",time,0];};
	if (_rip) exitWith {life_HUD_notifs pushBack ["Someone is already speaking with the shopkeeper!",time,2];};
	if !(alive _robber) exitWith {};
	if (life_knockout) exitWith {life_HUD_notifs pushBack ["You are unconscious.",time,2];};
	if (life_frozen) exitWith {life_HUD_notifs pushBack ["You have been frozen by an admin.",time,0];};
	if (life_istazed) exitWith {life_HUD_notifs pushBack ["You are unconscious.",time,2];};


	/* Robbery Action */

	_rip = true; //Robbery in Progress
	_shop setVariable ["status",_rip,true];
	_marker setMarkerColor "ColorOPFOR";

	//Sets up the Progress Bar
	disableSerialization;
	5 cutRsc ["life_progress","PLAIN"];
	_ui = uiNameSpace getVariable "life_progress";
	_progress = _ui displayCtrl 38201;
	_pgText = _ui displayCtrl 38202;
	_pgText ctrlSetText format["%2...  (1%1)","%",(localize "STR_pAct_RobProgress")];
	_progress progressSetPosition 0.01;
	_cP = 0.01;

	_alarm = false;

	//Randomises the value for triggering the alarm.
	_random = random(10000);
	diag_log format["Random: %1",_random];

	if (_rip) then {
		while{true} do {
			if (_cP >= 1) exitWith {};
			sleep _speed;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["%3...  (%2%1)","%",round(_cP * 100),(localize "STR_pAct_RobProgress")];
			
			_dist = _robber distance _shop;
			if !(_dist < 11) exitWith {};
			if !(alive _robber) exitWith {};
			if (life_istazed) exitWith {};
			if (life_is_arrested) exitWith {};

			
			//Randomises the alarm at any point, to trigger once
			if (!_alarm) then {
				//Triggering the alarm + adding player to wanted system
				if (_random < _chance) then {
					life_HUD_notifs pushBack["The cashier hit the alarm, the rebels have been alerted of your actions!",time,21];
					[[format["Attention: A robbery is taking place at %1!", _shopName],21], "life_fnc_broadcastHUD",_rebels,false] spawn life_fnc_MP;
					//[[getPlayerUID _robber,name _robber,"327"],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP;
					//[player,10,1] call life_fnc_playerVarUpdater;
					_alarm = true;
				};
			};
		};

		//Exit client script checks
		If !(alive _robber) exitWith {
			if (!_alarm) then {
				_rip = false;
				_shop setVariable ["status",_rip,true];
				_marker = _shop getVariable "marker";
				_markerColor = _shop getVariable "markerColor";
				_marker setMarkerColor _markerColor;
			} else {
				[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
			};
			5 cutText ["","PLAIN"];
		};
		If (_robber distance _shop > 10) exitWith {
			if (!_alarm) then {
				_rip = false;
				_shop setVariable ["status",_rip,true];
				_marker = _shop getVariable "marker";
				_markerColor = _shop getVariable "markerColor";
				_marker setMarkerColor _markerColor;
			} else {
				_shop setVariable ["robber",player,true];
				[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
			};
			hint "You ran too far away.";
			5 cutText ["","PLAIN"];
		};
		if (life_istazed) exitWith {
			if (!_alarm) then {
				_rip = false;
				_shop setVariable ["status",_rip,true];
				_marker = _shop getVariable "marker";
				_markerColor = _shop getVariable "markerColor";
				_marker setMarkerColor _markerColor;
			} else {
				[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
			};
			5 cutText ["","PLAIN"];
		};
		
		//Removes progress bar
		5 cutText ["","PLAIN"];
		_shop setVariable ["robber",player,true];
		if (_alarm) then {_loot = round(_loot / 2)};

		//Exit code
		if (_income > 1.0) then {
			_temp = round(_loot * _income);
			_reward = _temp - _loot;
			life_cash = life_cash + _temp;
			_string = format["You have stolen $%1 from the cash register! You earned an additional $%2 from your perks!",[_loot] call life_fnc_numberText,[_reward] call life_fnc_numberText];
			life_HUD_notifs pushBack [_string,time,1];
		} else {
			life_cash = life_cash + _loot;
			_string = format["You have stolen $%1 from the cash register!",[_loot] call life_fnc_numberText];
			life_HUD_notifs pushBack [_string,time,1];
			
		};
		
		[1,10] spawn life_fnc_statHandler;
		
		_expGain = round(_expGain + random(100));
		[_expGain,3] call life_fnc_addExp;
		[10,26] call life_fnc_addExp;

			
		_loot = 0;
		_shop setVariable ["funds",_loot,true];
		_shop setVariable ["income",0,true];
		[format["Somebody just got away with a robbery at %1!", _shopName],22] call life_fnc_broadcastJournos;
		
		_news = format ["%1 robbed %2",name player,_shopName];
		[_news,serverTime] spawn life_fnc_sendNews;
		
		[_shop,0] remoteExec ["TON_fnc_shopActionReset",HC2,false];
		
		[0] spawn life_fnc_atmBlocker;
	};

};

[0] call SOCK_fnc_updatePartial;

