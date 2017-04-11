/*
	File: fn_jailMe.sqf
	Author Bryan "Tonic" Boardwine
	
	Description:
	Once word is received by the server the rest of the jail execution is completed.
*/
private["_ret","_bad","_time","_bail","_esc","_countDown","_boundary"];
_ret = [_this,0,[],[[]]] call BIS_fnc_param;
_bad = [_this,1,false,[false]] call BIS_fnc_param;

_bounty = 0;

[] spawn {
	_markerPos = getMarkerPos "rock_mine_1";
	_markerName = "local_rock_mine_1";
	_marker = createMarkerLocal[_markerName,_markerPos];
	_markerColor = getMarkerColor "rock_mine_1";
	_marker setMarkerColorLocal _markerColor;
	_markerSize = markerSize "rock_mine_1";
	_marker setMarkerSizeLocal _markerSize;
	_markerText = markerText "rock_mine_1";
	_marker setMarkerTextLocal _markerText;			
	_marker setMarkerTypeLocal "n_unknown";
	
	_markerPos = getMarkerPos "m_prison_1";
	_markerName = "local_m_prison_1";
	_marker = createMarkerLocal[_markerName,_markerPos];
	_markerColor = getMarkerColor "m_prison_1";
	_marker setMarkerColorLocal _markerColor;
	_markerSize = markerSize "m_prison_1";
	_marker setMarkerSizeLocal _markerSize;
	_markerText = markerText "m_prison_1";
	_marker setMarkerTextLocal _markerText;
					
	_marker setMarkerTypeLocal "o_unknown";
	
	waitUntil {!(life_is_arrested)};
	
	deleteMarkerLocal "local_rock_mine_1";
	deleteMarkerLocal "local_m_prison_1";
};

if(count _ret > 0) then { 
	_bounty = _ret select 3;
	life_bail_amount = _bounty; 

	_bounty = _bounty / life_mayor_sentences;
	if (_bad) then {_bounty = _bounty + 600};
	if (_bounty < 3600) then {
		_time = time + _bounty;
	} else {
		_time = time + 3600;
	};
} else { 
	_bounty = 300;
	life_bail_amount = _bounty; 
	
	_bounty = _bounty / life_mayor_sentences;
	if (_bad) then {_bounty = _bounty + 600};
	if (_bounty < 3600) then {
		_time = time + _bounty;
	} else {
		_time = time + 3600;
	};
};

_esc = false;
_bail = false;

while {true} do
{
	if((round(_time - time)) > 0) then {
		_countDown = [(_time - time),"MM:SS.MS"] call BIS_fnc_secondsToString;
		hintSilent parseText format[(localize "STR_Jail_Time")+ "<br/> <t size='2'><t color='#336699'>%1</t></t><br/><br/>" +(localize "STR_Jail_Pay")+ " %3<br/>" +(localize "STR_Jail_Price")+ " $%2",_countDown,[life_bail_amount] call life_fnc_numberText,if(isNil "life_canpay_bail") then {"Yes"} else {"No"}];
	};

	//In Jail Zone check - allows 2 second re-check.
	_boundary = list Prison_zone_trigger;
	if (!(player in _boundary)) exitWith {
		_esc = true;
	};

	if(life_bail_paid) exitWith {
		_bail = true;
	};
	
	if((round(_time - time)) < 1) exitWith {hint ""};
	if(!alive player && ((round(_time - time)) > 0)) exitWith {};
	sleep 0.1;
};

switch (true) do
{
	case (_bail) :
	{
		life_is_arrested = false;
		life_bail_paid = false;
		_string = localize "STR_Jail_Paid";
		life_HUD_notifs pushBack [_string,time,27];
		serv_wanted_remove = [player];
		
		
		If (license_civ_rebel) then {
			player setDir (markerDir "jail_spawn_2");
			player setPos (getMarkerPos "jailpoint_2");
			
		} else {
			player setDir (markerDir "jail_spawn_1");
			player setPos (getMarkerPos "jail_spawn_1");
		};
		
		[getPlayerUID player] remoteExec ["life_fnc_wantedRemove",HC1,false];
		[player,10,0] call life_fnc_playerVarUpdater;
		
		
		//Sets players loadout after leaving prison
		removeBackpack player;
		removeUniform player;
		
		player addUniform (life_default_clothing select (floor(random (count life_default_clothing))));

		//Removes prison inventory items from player's inventory
		if(life_inv_rocku > 0) then {[false,"rocku",life_inv_rocku] call life_fnc_handleInv;};
		if(life_inv_rockp > 0) then {[false,"rockp",life_inv_rockp] call life_fnc_handleInv;};
		if(life_inv_pickaxe > 0) then {[false,"pickaxe",life_inv_pickaxe] call life_fnc_handleInv;};
		life_cash = 0;
	
		[15,25] call life_fnc_addExp;
		[] call SOCK_fnc_updateRequest;
	};
	
	case (_esc) :
	{
		life_is_arrested = false;
		_string = localize "STR_Jail_EscapeSelf";
		life_HUD_notifs pushBack [_string,time,27];
		_string = format[localize "STR_Jail_EscapeNOTF",name player];
		[_string,27] remoteExec ["life_fnc_broadcastHUD",0,false];
		[getPlayerUID player,profileName,"501"] remoteExec ["life_fnc_wantedAdd",HC1,false];
		[player,10,1] call life_fnc_playerVarUpdater;
		[1,13] spawn life_fnc_statHandler;
		
		[25,26] call life_fnc_addExp;
		[] call SOCK_fnc_updateRequest;
	};
	
	case (alive player && !_esc && !_bail) :
	{
		life_is_arrested = false;
		_string = localize "STR_Jail_Released";
		life_HUD_notifs pushBack [_string,time,27];
		[getPlayerUID player] remoteExec ["life_fnc_wantedRemove",HC1,false];
		[player,10,0] call life_fnc_playerVarUpdater;
		If (license_civ_rebel) then {
			player setDir (markerDir "jail_spawn_2");
			player setPos (getMarkerPos "jailpoint_2");
			
		} else {
			player setDir (markerDir "jail_spawn_1");
			player setPos (getMarkerPos "jail_spawn_1");
		};
		
		//Sets players loadout after leaving prison
		removeBackpack player;
		removeUniform player;

		player addUniform (life_default_clothing select (floor(random (count life_default_clothing))));
		
		//Removes prison inventory items from player's inventory
		if(life_inv_rocku > 0) then {[false,"rocku",life_inv_rocku] call life_fnc_handleInv;};
		if(life_inv_rockp > 0) then {[false,"rockp",life_inv_rockp] call life_fnc_handleInv;};
		if(life_inv_pickaxe > 0) then {[false,"pickaxe",life_inv_pickaxe] call life_fnc_handleInv;};
		life_cash = 0;
		[5,25] call life_fnc_addExp;
		[] call SOCK_fnc_updateRequest;
	};
};