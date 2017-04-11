/*
	filename: fn_punishPlayer.sqf
	Author: Stevo 
	
	Description:
	Used for starting the action of punishing a player.
*/

private ["_curTarget","_action"];
_curTarget = [_this,0,objNull,[objNull]] call bis_fnc_param;

switch (playerSide) do {
	case civilian: {
		_text = format["Are you sure you wish to punish %1? This will result in them being removed from your faction and the loss of all their faction licenses...",name _curTarget];
		[_text] call life_fnc_confirmPopup;	

		if (life_menu_confirm) then {
			life_menu_confirm = false;
			[[player],"life_fnc_punish",_curTarget,false] spawn life_fnc_MP;
		} else {
			_string = "You have cancelled the punishment.";
			life_HUD_notifs pushback [_string,time,1];
		};
	};
	case West: {
		_text = format["Are you sure you wish to punish %1? This will result in them being discharged from the Altis Police Department...",name _curTarget];
		[_text] call life_fnc_confirmPopup;	

		if (life_menu_confirm) then {
			life_menu_confirm = false;
			[[player],"life_fnc_punish",_curTarget,false] spawn life_fnc_MP;
		} else {
			_string = "You have cancelled the punishment.";
			life_HUD_notifs pushback [_string,time,1];
		};
	};
};