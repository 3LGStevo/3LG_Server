/*
	File: fn_civInteractionMenu.sqf
	Author: Stevo
	
	Description:
	Replaces the mass addactions for various civ actions towards another player.
*/
#define Btn1 37450
#define Btn2 37451
#define Btn3 37452
#define Btn4 37453
#define Btn5 37454
#define Btn6 37455
#define Btn7 37456
#define Btn8 37457

private["_display","_curTarget","_Btn1","_Btn2","_Btn3","_Btn4","_Btn5","_Btn6","_Btn7","_Btn8","_isHunter"];
if(!dialog) then {
	createDialog "pInteraction_Menu";
};
disableSerialization;
_curTarget = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _curTarget) exitWith {closeDialog 0;}; //Bad target
_isHunter = player getVariable "Hunter";
_unit = "None";
_targetUnit = "None";

diag_log format ["Interaction: %1",_curTarget];
if(_curTarget isKindOf "House_F") exitWith {
	if(_curTarget in [dome1,dome2,dome3,dome4,dome5,dome6]) then {
		if (license_civ_corp) then {
			_display = findDisplay 37400;
			_Btn1 = _display displayCtrl Btn1;
			_Btn2 = _display displayCtrl Btn2;
			_Btn3 = _display displayCtrl Btn3;
			_Btn4 = _display displayCtrl Btn4;
			_Btn5 = _display displayCtrl Btn5;
			_Btn6 = _display displayCtrl Btn6;
			_Btn7 = _display displayCtrl Btn7;
			_Btn8 = _display displayCtrl Btn8;
			life_pInact_curTarget = _curTarget;
			
			_Btn1 ctrlSetText localize "STR_pInAct_Repair";
			_Btn1 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_repairDoor;";
			
			_Btn2 ctrlSetText localize "STR_pInAct_CloseOpen";
			_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_doorAnimate;";
			_Btn3 ctrlShow false;
			_Btn4 ctrlShow false;
			_Btn5 ctrlShow false;
			_Btn6 ctrlShow false;
			_Btn7 ctrlShow false;
			_Btn8 ctrlShow false;
		} else {
			closeDialog 0;
		};
	};
};
		
if(!isPlayer _curTarget) exitWith {closeDialog 0;}; //Bad side check?
_display = findDisplay 37400;
_Btn1 = _display displayCtrl Btn1;
_Btn2 = _display displayCtrl Btn2;
_Btn3 = _display displayCtrl Btn3;
_Btn4 = _display displayCtrl Btn4;
_Btn5 = _display displayCtrl Btn5;
_Btn6 = _display displayCtrl Btn6;
_Btn7 = _display displayCtrl Btn7;
_Btn8 = _display displayCtrl Btn8;
life_pInact_curTarget = _curTarget;


if (_curTarget getVariable["restrained",false]) then {
	_btn2 ctrlShow true;
	_Btn3 ctrlShow true;
	_Btn4 ctrlShow true;
	_Btn5 ctrlShow false;
	_Btn6 ctrlShow false;
	_Btn7 ctrlShow false;
	_Btn8 ctrlShow false;
} else {
	_btn2 ctrlShow false;
	_Btn3 ctrlShow false;
	_Btn4 ctrlShow false;
	_Btn5 ctrlShow false;
	_Btn6 ctrlShow false;
	_Btn7 ctrlShow false;
	_Btn8 ctrlShow false;
};

if (player getVariable["restrained",false]) then {
	_btn1 ctrlEnable false;
	_btn2 ctrlEnable false;
	_btn3 ctrlEnable false;
	_btn4 ctrlEnable false;
	_btn5 ctrlEnable false;
	_btn6 ctrlEnable false;
	_btn7 ctrlEnable false;
	_btn8 ctrlEnable false;
};

//Setup ID
_btn1 ctrlSetText localize "STR_pInAct_ID";
_Btn1 buttonSetAction "[life_pInact_curTarget] call life_fnc_contactsID; closeDialog 0;";

//Set Unrestrain Button
if (player distance _curTarget < 2) then {
	_btn2 ctrlEnable true;
} else {
	_btn2 ctrlEnable false;
};
_Btn2 ctrlSetText localize "STR_pInAct_Unrestrain";
_Btn2 buttonSetAction "[life_pInact_curTarget] call life_fnc_unrestrain; closeDialog 0;";

if((_curTarget getVariable["Escorting",false])) then {
	_Btn3 ctrlSetText localize "STR_pInAct_StopEscort";
	_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_stopEscorting; [life_pInact_curTarget] call life_fnc_civInteractionMenu;";
} else {
	_Btn3 ctrlSetText localize "STR_pInAct_Escort";
	_Btn3 buttonSetAction "[life_pInact_curTarget] call life_fnc_escortAction; closeDialog 0;";
};

_Btn4 ctrlSetText localize "STR_pInAct_PutInCar";
_Btn4 buttonSetAction "[life_pInact_curTarget] call life_fnc_putInCar; closeDialog 0;";


if (license_civ_rebel OR license_civ_corp) then {
	if (license_civ_corp) then {
		_targetClass = _curTarget getVariable "armyClass";
		_class = player getVariable "armyClass";
		_side = _curTarget getVariable "faction";
		if (isNil {player getVariable "unit_info"}) then {_unit = "None"} else {_unit = player getVariable "unit_info";};
		if (isNil {_curTarget getVariable "unit_info"}) then {_targetUnit = "None"} else {_targetUnit = _curTarget getVariable "unit_info";};
		_targetJob = _curTarget getVariable "job";
		if (_side == "army") then {
			//If Major, allow free recruit
			if ((_class == 5 OR _class == 4 OR _class == 3) && _targetClass <= 2 && _targetUnit == "None") then {
				_Btn6 ctrlShow true;
				_Btn6 ctrlSetText "Recruit Reg.";
				
				switch (_unit) do {
					case "Commandos": {_Btn6 buttonSetAction "[[0,'Commandos'],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP;  closeDialog 0;";};
					case "Highlanders": {_Btn6 buttonSetAction "[[0,'Highlanders'],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";};
					case "Rangers": {_Btn6 buttonSetAction "[[0,'Rangers'],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";};
				};
			};
			if ((_class == 5 OR _class == 4 OR _class == 3) && _targetClass <= 2 && _targetUnit == _unit) then {
				_Btn6 ctrlShow true;
				_Btn6 ctrlSetText "Remove Reg.";
				
				_Btn6 buttonSetAction "[[1,''],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
			};

			if (_curTarget getVariable "restrained") then {
				//IF Restrained and target level Lance Corporal and above... Demote players
				if (((_class == 5 && (_targetClass <= 4 && _targetClass > 0)) OR (_class == 4 && (_targetClass <= 3 && _targetClass > 0)) OR (_class == 3 && (_targetClass <= 2 && _targetClass > 0))) && _unit == _targetUnit) then {
					_Btn7 ctrlShow true;
				
					_Btn7 ctrlSetText "Demote";
					_Btn7 buttonSetAction "[[player,0],'life_fnc_promote',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				//If Restrained and target level Private, remove player from faction
				if (_targetClass == 0 && _class > 3) then {
					_Btn7 ctrlShow true;
				
					_Btn7 ctrlSetText "Dismiss";
					_Btn7 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_punishPlayer; closeDialog 0;";
				};
			} else {
				//If player isn't restrained and meets promotion criteria, grant promotion.
				if (((_class == 5 && _targetClass <= 3) OR (_class == 4 && _targetClass <= 2) OR (_class == 3 && _targetClass <= 1)) && _unit == _targetUnit) then {
					_Btn7 ctrlShow true;
				
					_Btn7 ctrlSetText "Promote";
					_Btn7 buttonSetAction "[[player,1],'life_fnc_promote',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Highlanders" && _targetJob == "none") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Grant U.A.V.";
					_btn5 buttonSetAction "[['corp_uav'],'life_fnc_grantLicense',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Highlanders" && _targetJob == "uav") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Remove U.A.V.";
					_btn5 buttonSetAction "[[4],'life_fnc_removeLicenses',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Commandos" && _targetUnit == "Commandos" && _targetJob == "none") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Grant S.A.F.";
					_btn5 buttonSetAction "[['corp_saf'],'life_fnc_grantLicense',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Commandos" && _targetUnit == "Commandos" && _targetJob == "saf") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Remove S.A.F.";
					_btn5 buttonSetAction "[[3],'life_fnc_removeLicenses',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Rangers" && _targetUnit == "Rangers" && _targetJob == "none") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Grant M.P.";
					_btn5 buttonSetAction "[['corp_mp'],'life_fnc_grantLicense',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Rangers" && _targetUnit == "Rangers" && _targetJob == "mp") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Remove M.P.";
					_btn5 buttonSetAction "[[5],'life_fnc_removeLicenses',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				
			};
		};
	};
	
	if (license_civ_rebel) then {
		_targetClass = _curTarget getVariable "rebelClass";
		_class = player getVariable "rebelClass";
		_side = _curTarget getVariable "faction";
		if (isNil {player getVariable "unit_info"}) then {_unit = "None"} else {_unit = player getVariable "unit_info";};
		if (isNil {_curTarget getVariable "unit_info"}) then {_targetUnit = "None"} else {_targetUnit = _curTarget getVariable "unit_info";};
		_targetJob = _curTarget getVariable "job";
		if (_side == "rebel") then {
			//If Major, allow free recruit
			if ((_class == 5 OR _class == 4 OR _class == 3) && _targetClass <= 2 && _targetUnit == "None") then {
				_Btn6 ctrlShow true;
				_Btn6 ctrlSetText "Recruit Branch";
				
				switch (_unit) do {
					case "Desert Scorpions": {_Btn6 buttonSetAction "[[0,'Desert Scorpions'],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";};
					case "King Cobras": {_Btn6 buttonSetAction "[[0,'King Cobras'],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";};
					case "Hidden Ghosts": {_Btn6 buttonSetAction "[[0,'Hidden Ghosts'],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";};
				};
			};
			if ((_class == 5 OR _class == 4 OR _class == 3) && _targetClass <= 2 && _targetUnit == _unit) then {
				_Btn6 ctrlShow true;
				_Btn6 ctrlSetText "Remove Branch";
				
				_Btn6 buttonSetAction "[[1,''],'life_fnc_factionRecruit',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
			};

			if (_curTarget getVariable "restrained") then {
				//IF Restrained and target level Lance Corporal and above... Demote players
				if (((_class == 5 && (_targetClass <= 4 && _targetClass > 0)) OR (_class == 4 && (_targetClass <= 3 && _targetClass > 0)) OR (_class == 3 && (_targetClass <= 2 && _targetClass > 0))) && _unit == _targetUnit) then {
					_Btn7 ctrlShow true;
					_Btn7 ctrlSetText "Demote";
					_Btn7 buttonSetAction "[[player,0],'life_fnc_promote',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				//If Restrained and target level Private, remove player from faction
				if (_targetClass == 0 && _class > 3) then {
					_Btn7 ctrlShow true;
					_Btn7 ctrlSetText "Dismiss";
					_Btn7 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_punishPlayer; closeDialog 0;";
				};
			} else {
				//If player isn't restrained and meets promotion criteria, grant promotion.
				if (((_class == 5 && _targetClass <= 3) OR (_class == 4 && _targetClass <= 2) OR (_class == 3 && _targetClass <= 1)) && _unit == _targetUnit) then {
					_Btn7 ctrlShow true;
					_Btn7 ctrlSetText "Promote";
					_Btn7 buttonSetAction "[[player,1],'life_fnc_promote',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				
				
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass == 2) && _unit == "Desert Scorpions" && _targetUnit == "Desert Scorpions" && _targetJob == "none") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Grant Ter.";
					_btn5 buttonSetAction "[['rebel_ter'],'life_fnc_grantLicense',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "Desert Scorpions" && _targetUnit == "Desert Scorpions" && _targetJob == "ter") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Remove Ter.";
					_btn5 buttonSetAction "[[6],'life_fnc_removeLicenses',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "King Cobras" && _targetUnit == "King Cobras" && _targetJob == "none") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Grant Mil.";
					_btn5 buttonSetAction "[['rebel_mil'],'life_fnc_grantLicense',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				if ((_class == 5 OR _class == 4 OR _class == 3) && (_targetClass < _class) && _unit == "King Cobras" && _targetUnit == "King Cobras" && _targetJob == "rm") then {
					_btn5 ctrlShow true;
					_btn5 ctrlSetText "Remove Mil.";
					_btn5 buttonSetAction "[[7],'life_fnc_removeLicenses',life_pInact_curTarget,false] spawn life_fnc_MP; closeDialog 0;";
				};
				
			};
		};
	};
};

diag_log format ["isHunter: %1",_isHunter];
if (_isHunter == 1) then {
	_Btn8 ctrlSetText localize "STR_pInAct_Arrest";
	_btn8 ctrlShow true;
	_btn8 ctrlEnable false;
	
	if (license_civ_bh) then {
		if(((player distance (getMarkerPos "jailpoint_1")) < 30) OR ((player distance (getMarkerPos "jailpoint_2")) < 30)) then 
		{
			_Btn8 ctrlEnable true;
			_Btn8 buttonSetAction "[player,life_pInact_curTarget] call life_fnc_arrestAction; closeDialog 0;";
		};
	};
	if (license_corp_mp) then {
		if (((player distance (getMarkerPos "jailpoint_3")) < 30)) then 
		{
			_Btn8 ctrlEnable true;
			_Btn8 buttonSetAction "[player,life_pInact_curTarget] call life_fnc_arrestAction; closeDialog 0;";
		};
		
		_btn5 ctrlShow true;
		_btn5 ctrlEnable true;
		_btn5 ctrlSetText "Search";
		_btn5 buttonSetAction "[life_pInact_curTarget] spawn life_fnc_searchAction; closeDialog 0;";
	};
};

if (license_civ_hitman) then {
	if (_curTarget getVariable["restrained",false]) then {
		_Btn5 ctrlShow true;
		_btn5 ctrlSetText "Reject Hit";
		_btn5 ctrlEnable false;
		_btn5 buttonSetAction "[] spawn life_fnc_hitReject; closeDialog 0;";
		diag_log format ["civInteractionMenu || Hitman Target || Target: %1 | Target UID: %2",player getVariable "target",getPlayerUID _curTarget];
		_uid = str(getPlayerUID _curTarget);
		if (player getVariable "target" == _uid) then {
			_btn5 ctrlEnable true;
		};
	};
};
