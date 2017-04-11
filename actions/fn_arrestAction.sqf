/*
	File: fn_arrestAction.sqf
	
	Description:
	Arrests the targeted person.
*/
private["_unit","_id","_expGain"];
_ret = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_unit = [_this,1,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit) exitWith {}; //Not valid
if(isNil "_unit") exitwith {}; //Not Valid
if(!(_unit isKindOf "Man")) exitWith {}; //Not a unit
if(!isPlayer _unit) exitWith {}; //Not a human
if(!(_unit getVariable "restrained")) exitWith {}; //He's not restrained.
if(!((side _unit) in [civilian,independent])) exitWith {}; //Not a civ
if(isNull _unit) exitWith {}; //Not valid

[15,25] call life_fnc_addExp;

switch (side _ret) do {
	case west: {
		[1,17] spawn life_fnc_statHandler;
		[_unit,player,false] remoteExec ["life_fnc_wantedBounty",HC1,false];
		detach _unit;
		[[_unit,false],"life_fnc_jail",_unit,false] spawn life_fnc_MP;
		_string = format [(localize "STR_NOTF_Arrested_1"),_unit getVariable["realname",name _unit],profileName];
		[[_string,1],"life_fnc_broadcastHUD",West,false] spawn life_fnc_MP;
	};

	case Civilian: {
		[1,18] spawn life_fnc_statHandler;
		detach _unit;
		[[_unit,false],"life_fnc_jail",_unit,false] spawn life_fnc_MP;
		_string = format [(localize "STR_NOTF_Arrested_1"),_unit getVariable["realname",name _unit],profileName];
		[[_string,1],"life_fnc_broadcastHUD",playableUnits,false] spawn life_fnc_MP;
		[_ret,_unit] remoteExec ["life_fnc_wantedBHQuery",HC1,false];
	};
};
