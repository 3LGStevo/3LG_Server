/*
	Filename: fn_crushVehicle.sqf
	Author: Stevo
	
	Description:
	Used to crush a vehicle, or a wreck in Altis.
*/
if (life_crushing) exitWith {};
life_crushing = true;
private ["_vehicle","_array"];

_array = NearestObjects [getMarkerPos "car_crusher",["Car"],5];
_count = count _array;
if (_count == 0) exitWith {life_crushing = false;};

_vehicle = _array select 0;

_perks = [13] call life_fnc_perkSystem;
_qty = _perks select 0;

if (_vehicle isKindOf "Car") then {
	_vehicle enableSimulation false;
	HideObject _vehicle;
	_vehicle setPos [0,0,100];
	[_vehicle] remoteExec ["TON_fnc_vehicleDead",HC1,false];
	
	
	[true,"ironp",_qty] call life_fnc_handleInv;
	_string = format["You have received %1 processed iron for crushing the vehicle.",_qty];
	Life_HUD_notifs pushBack [_string,time,1];
};


life_crushing = false;