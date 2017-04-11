/*
	File: fn_searchVehAction.sqf
*/
private["_vehicle","_data","_expGain"];
_vehicle = cursorTarget;
if (life_action_inUse) exitWith {};
life_action_inUse = true;

if((_vehicle isKindOf "Car") || !(_vehicle isKindOf "Air") || !(_vehicle isKindOf "Ship")) then
{
	_owners = _vehicle getVariable "vehicle_info_owners";
	if(isNil {_owners}) exitWith {_string = localize "STR_NOTF_VehCheat"; life_HUD_Notifs pushBack [_string,time,2]; deleteVehicle _vehicle; life_action_inUse = false;};
	hint localize "STR_NOTF_Searching";
	sleep 3;
	if(player distance _vehicle > 10 || !alive player || !alive _vehicle) exitWith {_String = localize "STR_NOTF_SearchVehFail"; life_HUD_notifs pushBack [_string,time,0]; life_action_inUse = false;};
	//_inventory = [(_vehicle getVariable "vehicle_info_inv")] call fnc_veh_inv;
	//if(isNil {_inventory}) then {_inventory = "Nothing in storage."};
	_owners = [_owners] call life_fnc_vehicleOwners;
	
	if(_owners == "any<br/>") then
	{
		_owners = "No owners, impound it<br/>";
	};
	hint parseText format[localize "STR_NOTF_SearchVeh",_owners];
	_expGain = 25;
	[_expGain,18] call life_fnc_addExp;
};

life_action_inUse = false;