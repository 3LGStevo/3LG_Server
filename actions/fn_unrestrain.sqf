/*
	File: fn_unrestrain.sqf
*/
private["_unit"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit OR !(_unit getVariable["restrained",FALSE])) exitWith {}; //Error check?

_perks = [4] call life_fnc_perkSystem;
_speed = _perks select 1;

_cuffed = _unit getVariable["cuffed",false];

if (_cuffed) then {
	switch (playerSide) do {
		case West: {
			if (life_inv_cuffKeys == 0) exitWith {_string = "You require your Cuffkeys to unrestrain this person."; life_HUD_notifs pushBack [_string,time,2];};
			_unit setVariable["restrained",FALSE,TRUE];
			_unit setVariable["Escorting",FALSE,TRUE];
			_unit setVariable["transporting",FALSE,TRUE];
			_unit setVariable["cuffed",FALSE,TRUE];
			detach _unit;
			
			_string = format ["%1 was unrestrained by ",name _unit];
			[_string,name player] remoteExec ["TON_fnc_LogIt",HC2,false];
			
			_string = format [localize "STR_NOTF_Unrestrain",_unit getVariable["realname",name _unit],profileName];
			[[_string,1],"life_fnc_broadcastHUD",_unit,FALSE] spawn life_fnc_MP;
			life_HUD_notifs pushBack [format["You have unrestrained %1",_unit getVariable["realname",name _unit]],time,1];
		};
		case Civilian: {
			if(life_inv_cuffKeys > 0) then {
				_unit setVariable["restrained",FALSE,TRUE];
				_unit setVariable["Escorting",FALSE,TRUE];
				_unit setVariable["transporting",FALSE,TRUE];
				_unit setVariable["cuffed",FALSE,TRUE];
				detach _unit;
				
				_string = format ["%1 was unrestrained by ",name _unit];
				[_string,name player] remoteExec ["TON_fnc_LogIt",HC2,false];
				
				_string = format [localize "STR_NOTF_Unrestrain",_unit getVariable["realname",name _unit],profileName];
				[[_string,1],"life_fnc_broadcastHUD",_unit,FALSE] spawn life_fnc_MP;
				life_HUD_notifs pushBack [format["You have unrestrained %1",_unit getVariable["realname",name _unit]],time,1];
			} else {
				if (life_inv_lockpick > 0) then {
					[] spawn life_fnc_lockpick;
				} else {
					_string = "You do not have anything to set this person free with.";
					life_HUD_notifs pushBack [_string,time,2];
				};
			};
		};
	};
} else {
	_unit setVariable["restrained",FALSE,TRUE];
	_unit setVariable["Escorting",FALSE,TRUE];
	_unit setVariable["transporting",FALSE,TRUE];
	detach _unit;
	
	_string = format ["%1 was unrestrained by ",name _unit];
	[_string,name player] remoteExec ["TON_fnc_LogIt",HC2,false];
	
	_string = format [localize "STR_NOTF_Unrestrain",_unit getVariable["realname",name _unit],profileName];
	[[_string,1],"life_fnc_broadcastHUD",_unit,FALSE] spawn life_fnc_MP;
	life_HUD_notifs pushBack [format["You have unrestrained %1",_unit getVariable["realname",name _unit]],time,1];
};

