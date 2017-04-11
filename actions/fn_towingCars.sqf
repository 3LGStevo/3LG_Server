/*
	filename: fn_towingCars.sqf
	Author: Stevo
	
	Description:
	Used to tow a car using the HEMTT Loader
*/

private ["_cars","_pos","_array","_vehicle","_dir"];

_cars = [
	"C_Quadbike_01_F",
	"C_Hatchback_01_F",
	"C_Offroad_01_F",
	"C_Offroad_02_F",
	"C_Offroad_02_unarmed_F",
	"C_SUV_01_F",
	"C_Hatchback_01_sport_F",
	"B_G_Offroad_01_F",
	"C_Van_01_box_F",
	"C_Van_01_transport_F",
	"B_MRAP_01_F"
];

if (typeOf (vehicle player) != "B_Truck_01_mover_F") exitWith {diag_log "towingCars || Not in the correct vehicle";};
if (speed vehicle player > 1) exitWith {_string = "You must be stationary to tow a vehicle"; life_HUD_notifs pushBack [_string,time,2];};

_pos = (getPos vehicle player);
_array = nearestObjects [_pos,["Car"],10];

if (count _array <= 1) exitWith {};
_vehicle = _array select 0;

if (typeOf _vehicle == "B_Truck_01_mover_F") then {_vehicle = nearestObjects [_pos,["Car"],10] select 1;};

if (life_towing) then {
	if ((getPos vehicle player) distance (getMarkerPos "car_crusher") < 20) then  {
		_dir = MarkerDir "car_crusher";
		_pos = getMarkerPos "car_crusher";
		
		(vehicle player) allowDamage false;
		detach life_tow_vehicle;
		life_tow_vehicle setDir _dir;
		life_tow_vehicle setPos _pos;
		life_tow_vehicle allowDamage true;
		life_towing = false;
		(vehicle player) allowDamage true;
	
	} else {
		(vehicle player) allowDamage false;
		detach life_tow_vehicle;
		life_tow_vehicle attachTo [(vehicle player),[0,-10,1]];
		detach life_tow_vehicle;
		life_tow_vehicle allowDamage true;
		life_towing = false;
		(vehicle player) allowDamage true;
	};
} else {
	if (typeOf _vehicle in _cars) then {
		(vehicle player) allowDamage false;
		life_towing = true;
		life_tow_vehicle = _vehicle;
		life_tow_vehicle allowDamage false;
		life_tow_vehicle attachTo [(vehicle player),[0,-2.5,1]];
		(vehicle player) allowDamage true;
	} else {
		_string = "This vehicle cannot be towed.";
		life_HUD_notifs pushBack [_string,time,0];
	};
};

