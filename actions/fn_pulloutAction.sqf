/*
	File: fn_pulloutAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Pulls civilians out of a car if it's stopped.
*/
private["_crew"];
_crew = crew cursorTarget;
_vehicle = cursorTarget;

if (playerSide == West) then {
	{
		if (side _x != west && alive _x) then
		{
			_x setVariable ["transporting",false,true]; _x setVariable ["Escorting",false,true];
			[[_x],"life_fnc_pulloutVeh",_x,false] spawn life_fnc_MP;
		};
	} foreach _crew;
} else {
	{
		if (_x getVariable "restrained" && alive _x) then
		{
			_x setVariable ["transporting",false,true]; _x setVariable ["Escorting",false,true];
			[[_x],"life_fnc_pulloutVeh",_x,false] spawn life_fnc_MP;
		};
	} foreach _crew;
};