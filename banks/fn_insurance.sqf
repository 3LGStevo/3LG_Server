/*
	filename: fn_insurance.sqf
	Author: Stevo
	
	Description:
	Takes a 1% toll from the player's bank account in order to protect it.
*/
private [];
waitUntil {player getVariable "insured"};
while {true} do {
	while {player getVariable "insured"} do {
		if (isNil "life_adminmode") then {
			_fee = round(life_atmcash / (100 * life_mayor_insurance));
			if (_fee < 1) then {
				player setVariable["insured",false];
				life_hud_notifs pushBack ["Your insurance premium has expired due to your inability to afford it.",time,23];
			} else {
				life_atmcash = life_atmcash - _fee;
				_string = format ["You have paid %2%1 for your insurance premium.",[_fee] call life_fnc_numberText,"$"];
				life_hud_notifs pushBack [_string,time,23];
				
				_time = 600;
				while {_time > 0 && (player getVariable "insured")} do {
					_time = _time -1;
					sleep 1;
				};
			};
		};
	};
	life_hud_notifs pushBack ["You are no longer insured.",time,23];
	waitUntil {player getVariable "insured"};
};