#include <macro.h>
/*
	File: fn_adminMenu.sqf
	Author: Stevo
	
	Description:
	Configures the menu
*/
private["_display","_list","_side","_mode","_adminLvl"];
_mode = [_this,0,0,[0]] call bis_fnc_param;
_adminLvl = __GETC__(life_adminlevel);
if(_adminLvl < 1) exitWith {closeDialog 0;};

disableSerialization;
waitUntil {!isNull (findDisplay 76000)};
_display = findDisplay 76000;

_list = _display displayCtrl 76020;
lbClear _list;
_cops = [];
_civs = [];
_meds = [];

//Construct arrays
{
	switch (side _x) do {
		case west: {_cops pushBack [_x,_x getVariable["realname",name _x]];}; 
		case civilian : {_civs pushBack [_x,_x getVariable["realname",name _x]];}; 
		case independent : {_meds pushBack [_x,_x getVariable["realname",name _x]];}; 
		default {_civs pushBack [_x,_x getVariable["realname",name _x]];};
	};
} foreach playableUnits;

_sortArray = _civs;
_civs = [_sortArray,[],{_x select 1},"ASCEND"] call bis_fnc_sortBy;
_sortArray = _cops;
_cops = [_sortArray,[],{_x select 1},"ASCEND"] call bis_fnc_sortBy;
_sortArray = _meds;
_meds = [_sortArray,[],{_x select 1},"ASCEND"] call bis_fnc_sortBy;

{
	_unit = _x select 0;
	_name = _x select 1;
	_list lbAdd format["%1 - CIV",_name];
	_list lbSetdata [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,[1,1,1,1]];
} forEach _civs;

{
	_unit = _x select 0;
	_name = _x select 1;
	_list lbAdd format["%1 - COP",_name];
	_list lbSetdata [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,[1,1,1,1]];
} forEach _cops;

{
	_unit = _x select 0;
	_name = _x select 1;
	_list lbAdd format["%1 - MED",_name];
	_list lbSetdata [(lbSize _list)-1,str(_unit)];
	_list lbSetColor [(lbSize _list)-1,[1,1,1,1]];
} forEach _meds;

_list lbSetCurSel 0;
if (isNil "life_adminFeed") then {
	[] call life_fnc_adminQuery;
} else {
	[] call life_fnc_adminKillFeed;
};

//Compensate menu controls
ctrlShow[76040,false];
ctrlShow[76041,false];
ctrlShow[76042,false];
ctrlShow[76043,false];
ctrlShow[76044,false];
ctrlShow[76045,false];
ctrlShow[76046,false];
ctrlShow[76047,false];
ctrlEnable[76047,true];
ctrlShow[76048,false];
ctrlEnable[76048,true];

switch (_mode) do {
	case 0: {
		ctrlEnable[76001,false];
		if (_adminLvl > 1) then {
			ctrlShow [76002,true];
			ctrlEnable[76002,true];
		} else {
			ctrlShow [76002,false];
			ctrlEnable[76002,false];
		};
		ctrlSetText[76003,"Administrator Menu - Basic Controls"];
		//Button 1
		_btn1 = _display displayCtrl 76011;
		if (life_is_respawning) then {
			_btn1 ctrlEnable false;
		} else {
			_btn1 ctrlEnable true;
		};
		_btn1 ctrlShow true;
		if (isNil "life_adminMode") then {
			_btn1 ctrlSetText localize "STR_Admin_Off";
			_btn1 ctrlSetTextColor [0.7,0,0,1];
		} else {
			_btn1 ctrlSetText localize "STR_Admin_On";
			_btn1 ctrlSetTextColor [0,0.5,0,1];
		};
		
		//Button 2
		_btn2 = _display displayCtrl 76012;
		_btn2 ctrlShow true;
		_btn2 ctrlEnable true;
		_btn2 ctrlSetText localize "Str_Admin_KillFeed";
		_btn2 buttonSetAction "[] call life_fnc_adminKillFeed;";
		
		//Button 3
		_btn3 = _display displayCtrl 76013;
		_btn3 ctrlShow true;
		if (life_is_respawning) then {
			_btn3 ctrlEnable false;
		} else {
			_btn3 ctrlEnable true;
		};
		_btn3 ctrlSetText localize "Str_Admin_HideHUD";
		_btn3 buttonSetAction "[] spawn life_fnc_adminHideHUD;";
		
		//Button 4
		_btn4 = _display displayCtrl 76014;
		_btn4 ctrlShow true;
		if (isNil "life_adminMode") then {
			_btn4 ctrlEnable false;
		} else {
			if (life_is_respawning) then {
				_btn4 ctrlEnable true;
			} else {
				_btn4 ctrlEnable true;
			};
		};
		_btn4 ctrlSetText localize "Str_Admin_Teleport";
		_btn4 buttonSetAction "[] spawn life_fnc_adminTeleport;";
		
		//Button 5
		_btn5 = _display displayCtrl 76015;
		_btn5 ctrlShow true;
		if (isNil "life_adminMode") then {
			_btn5 ctrlEnable false;
		} else {
			if (life_is_respawning) then {
				_btn5 ctrlEnable false;
			} else {
				if (lbCurSel _list != -1) then {
					_btn5 ctrlEnable true;
				} else {
					_btn5 ctrlEnable false;
				};
			};
		};
		_btn5 ctrlSetText localize "Str_Admin_TPHere";
		_btn5 buttonSetAction "[] spawn life_fnc_AdminTPhere;";
		
		//Button 6
		_btn6 = _display displayCtrl 76016;
		_btn6 ctrlShow true;
		if (isNil "life_adminMode") then {
			_btn6 ctrlEnable false;
		} else {
			if (life_is_respawning) then {
				_btn6 ctrlEnable false;
			} else {
				if (lbCurSel _list != -1) then {
					_btn6 ctrlEnable true;
				} else {
					_btn6 ctrlEnable false;
				};
			};
		};
		_btn6 ctrlSetText localize "Str_Admin_TPTo";
		_btn6 buttonSetAction "[] spawn life_fnc_AdminTPTo";
		
		menu_admin_mode = 0;
	};
	case 1: {
		ctrlEnable[76001,true];
		ctrlEnable[76002,false];
		ctrlSetText[76003,"Administrator Menu - Advanced Controls"];
	
		//Button 1
		_btn1 = _display displayCtrl 76011;
		if (life_is_respawning) then {
			_btn1 ctrlEnable false;
		} else {
			_btn1 ctrlEnable true;
		};
		_btn1 ctrlShow true;
		if (isNil "life_adminMode") then {
			_btn1 ctrlSetText localize "STR_Admin_Off";
			_btn1 ctrlSetTextColor [0.7,0,0,1];
		} else {
			_btn1 ctrlSetText localize "STR_Admin_On";
			_btn1 ctrlSetTextColor [0,0.5,0,1];
		};
		
		//Button 2
		_btn2 = _display displayCtrl 76012;
		_btn2 ctrlShow true;
		if (isNil "life_adminMode") then {
			if (life_is_respawning) then {
				if (lbCurSel _list != -1) then {
					_btn2 ctrlEnable true;
				} else {
					_btn2 ctrlEnable false;
				};
			} else {
				_btn2 ctrlEnable false;
			};
		} else {
			if (lbCurSel _list != -1) then {
				_btn2 ctrlEnable true;
			} else {
				_btn2 ctrlEnable false;
			};
		};
		_btn2 ctrlSetText localize "Str_Admin_Comp";
		_btn2 buttonSetAction "[] call life_fnc_adminCompMenu;";
		
		//Button 3
		_btn3 = _display displayCtrl 76013;
		_btn3 ctrlShow true;
		if (isNil "life_adminMode") then {
			if (life_is_respawning) then {
				if (lbCurSel _list != -1) then {
					_btn3 ctrlEnable true;
				} else {
					_btn3 ctrlEnable false;
				};
			} else {
				_btn3 ctrlEnable false;
			};
		} else {
			if (lbCurSel _list != -1) then {
				_btn3 ctrlEnable true;
			} else {
				_btn3 ctrlEnable false;
			};
		};
		_btn3 ctrlSetText localize "Str_Admin_Spectate";
		_btn3 buttonSetAction "[] call life_fnc_adminSpectate;";
		
		//Button 4
		_btn4 = _display displayCtrl 76014;
		_btn4 ctrlShow true;
		if (isNil "life_adminMode") then {
			if (life_is_respawning) then {
				if (lbCurSel _list != -1) then {
					_btn4 ctrlEnable true;
				} else {
					_btn4 ctrlEnable false;
				};
			} else {
				_btn4 ctrlEnable false;
			};
		} else {
			if (lbCurSel _list != -1) then {
				_btn4 ctrlEnable true;
			} else {
				_btn4 ctrlEnable false;
			};
		};
		_btn4 ctrlSetText localize "Str_Admin_Freeze";
		_btn4 buttonSetAction "[] call life_fnc_adminFreeze;";
		
		//Button 5
		_btn5 = _display displayCtrl 76015;
		_btn5 ctrlShow true;
		if (isNil "life_adminMode") then {
			if (life_is_respawning) then {
				if (lbCurSel _list != -1) then {
					_btn5 ctrlEnable true;
				} else {
					_btn5 ctrlEnable false;
				};
			} else {
				_btn5 ctrlEnable false;
			};
		} else {
			if (lbCurSel _list != -1) then {
				_btn5 ctrlEnable true;
			} else {
				_btn5 ctrlEnable false;
			};
		};
		_btn5 ctrlSetText localize "Str_Admin_Punish";
		_btn5 buttonSetAction "[] spawn life_fnc_adminWarn;";
		
		//Button 6
		_btn6 = _display displayCtrl 76016;
		_btn6 ctrlShow true;
		if (isNil "life_adminMode") then {
			if (life_is_respawning) then {
				if (_adminLvl == 3) then {
					_btn6 ctrlEnable true;
				} else {
					_btn6 ctrlEnable false;
				};
			} else {
				_btn6 ctrlEnable false;
			};
		} else {
			if (_adminLvl == 3) then {
				_btn6 ctrlEnable true;
			} else {
				_btn6 ctrlEnable false;
			};
		};
		_btn6 ctrlSetText localize "Str_Admin_Debug";
		_btn6 buttonSetAction "createDialog ""life_debug_menu"";";
		
		menu_admin_mode = 1;
	};
};