/*
	filename: fn_clearWorld.sqf
	Author: Stevo
	
	Description:
	Used to delete world items that are damaged.
*/
if (life_clearing) exitWith {};
life_clearing = true;
private ["_objects","_structures","_obj","_damage"];
if !(license_civ_service) exitWith {};
if (life_inv_shovel < 1) exitWith {life_HUD_notifs pushBack ["You require a shovel to clear debris.",time,2];};


_objects = nearestObjects [player,[],5];
_structures = [];
_obj = objNull;



{
	if !(_x isKindOf "Man") then {
		if !(_x isKindOf "Car") then {
			if !(_x isKindOf "Truck") then {
				if !(_x isKindOf "Air") then {
					if !(_x isKindOf "HouseFly") then {
						if !(_x isKindOf "HoneyBee") then {
							if !(_x isKindOf "Mosquito") then {
								if !(_x isKindOf "#track") then {
									if !(_x isKindOf "#mark") then {
										_structures pushBack _x;
									};
								};
							};
						};
					};
				};
			};
		};
	};
} forEach _objects;

_count = count _structures;
if (_count == 0) exitWith {life_HUD_notifs pushBack ["Nothing to clear",time,0]; life_clearing = false;};

_obj = objNull;
{
	_damage = damage _x;
	_hidden = isObjectHidden _x;
	if !(_hidden) then {
		if (_damage > 0) exitWith {_obj = _x};
	};
} forEach _structures;

if (isNull _obj) exitWith {life_HUD_notifs pushBack ["There aren't any damaged structures nearby.",time,0]; life_clearing = false;};

[_obj] remoteExec ["TON_Fnc_removeObject",2,false];


[50,10] call life_fnc_addExp;
[5,25] call life_fnc_addExp;
life_clearing = false;