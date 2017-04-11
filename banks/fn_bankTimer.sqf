/*
	filename: fn_bankTimer.sqf
	Author: Stevo
	
	Description:
	Handles the timer display
*/
private["_mode","_marker","_pos","_uiDisp","_timer","_time"];
_mode = [_this,0,0,[0]] call bis_fnc_param;
_marker = "m_bank_1";
_pos = getMarkerPos _marker;

switch (_mode) do {
	//Add timer display
	case 0: {
		disableSerialization;
		_uiDisp = uiNamespace getVariable "life_timer";
		if (isNil "_uiDisp") then {
			26 cutRsc ["life_timer","PLAIN"];
		};
		_timer = _uiDisp displayCtrl 38301;
		_time = bank_manager getVariable "time";
		while {(player distance _pos < 30) && (bank_manager getVariable "rip" == 1)} do {
			if(isNil "_uiDisp") then {
				26 cutRsc ["life_timer","PLAIN"];
				_uiDisp = uiNamespace getVariable "life_timer";
				_timer = _uiDisp displayCtrl 38301;
			};
			
			_timer ctrlSetText format["%1",[(serverTime - _time),"MM:SS.MS"] call BIS_fnc_secondsToString];
			sleep 0.08;

		};
		26 cutText["","PLAIN"];
	};
	
	//Remove timer display
	case 1: {
		26 cutText["","PLAIN"];
	};
};