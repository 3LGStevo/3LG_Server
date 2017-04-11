/*
	filename: fn_copTimer.sqf
	Author: Stevo
	
	Description:
	Handles the cop timer display
*/
private["_uiDisp","_timer","_time"];

while {true} do {
	waitUntil {(bank_manager getVariable "rip" == 1)};
	disableSerialization;
	26 cutRsc ["life_timer","PLAIN"];
	_uiDisp = uiNamespace getVariable "life_timer";
	_timer = _uiDisp displayCtrl 38301;
	_time = bank_manager getVariable "time";
	
	while {(bank_manager getVariable "rip" == 1)} do {
/*		if(isNull _uiDisp) then {
			26 cutRsc ["life_timer","PLAIN"];
			_uiDisp = uiNamespace getVariable "life_timer";
			_timer = _uiDisp displayCtrl 38301;
		};*/
		if (serverTime - _time > 300) then {
			_timer ctrlSetTextColor [1,0.2,0.2,1];
		} else {
			if (serverTime - _time > 120) then {
				_timer ctrlSetTextColor [0.9,0.5,0.2,1];
			};
		};
		_timer ctrlSetText format["%1",[(serverTime - _time),"MM:SS.MS"] call BIS_fnc_secondsToString];
		sleep 0.08;
	};
	
	sleep 10;
	26 cutText["","PLAIN"];
};

