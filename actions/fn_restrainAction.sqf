/*
	File: fn_restrainAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Retrains the target.
*/
private["_unit","_expGain"];
_unit = cursorTarget;
if(isNull _unit) exitWith {}; //Not valid
if((player distance _unit > 3)) exitWith {};
if((_unit getVariable "restrained")) exitWith {};
//if(side _unit == west) exitWith {};
if(player == _unit) exitWith {};
if(!isPlayer _unit) exitWith {};
if ((player getVariable "restrained")) exitWith {};
_isHunter = 0;

switch (playerSide) do {
	case west: {
		_unit setVariable["restrained",true,true];
		_unit setVariable["cuffed",true,true];
		[[player], "life_fnc_restrain", _unit, false] spawn life_fnc_MP;
		_string = format[localize "STR_NOTF_Restrained",_unit getVariable["realname", name _unit], profileName];
		[[_string,1],"life_fnc_broadcastHUD",west,false] spawn life_fnc_MP;
		_string = format ["You have restrained %1",_unit getVariable["realname", name _unit]];
		life_HUD_notifs pushBack[_string,time,1];
	};
	case civilian: {
		_val = missionNamespace getVariable (["ziptie",0] call life_fnc_varHandle);
		if (_val == 0) exitWith {life_HUD_notifs pushBack["You require zipties to restrain someone.",time,2];};
		
		_unit setVariable["restrained",true,true];
		[[player], "life_fnc_restrain", _unit, false] spawn life_fnc_MP;
		_string = format[localize "STR_NOTF_Restrained",_unit getVariable["realname", name _unit], profileName];
		[[_string,1],"life_fnc_broadcastHUD",west,false] spawn life_fnc_MP;
		_string = format ["You have restrained %1",_unit getVariable["realname", name _unit]];
		life_HUD_notifs pushBack[_string,time,1];
		[false,"ziptie",1] call life_fnc_handleInv;
	};
};
