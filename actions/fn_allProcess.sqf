/*
	File: fn_allProcess.sqf
	Author: Stevo
	
	Description:
	Handling of processing all permitted processable items the player has on them and taxing.
*/
private["_vendor","_class","_str","_shrt","_val","_materials","_processCheck","_oldItem","_newItem","_oldVal","_ui","_progress","_pgText","_cP","_lead","_copper","_iron","_diamond","_coke","_peach","_beer","_wine","_mat","_tax","_random","_newVal","_perks","_chance"];

_perks = [9] call life_fnc_perkSystem;
_chance = _perks select 0;

_perks = [6] call life_fnc_perkSystem;
_speed = _perks select 0;



//Setup material Vars
_lead = ["","",0,""];
_copper = ["","",0,""];
_iron = ["","",0];
_diamond = ["","",0,""];
_coke = ["","",0,""];
_peach = ["","",0,""];
_beer = ["","",0,""];
_wine = ["","",0,""];

_materials = [];

_processCheck = 0;

//Setup NPC vars
_vendor = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_class = [_this,3,"",[""]] call BIS_fnc_param;

//Error check
if(isNull _vendor OR _class == "" OR (player distance _vendor > 10)) exitWith {};

//Find out what shit you've got.
{
	_str = [_x] call life_fnc_varToStr;
	_shrt = [_x,1] call life_fnc_varHandle;
	_val = missionNameSpace getVariable _x;
	if (_val > 0) then {
		//If code to determine whether it is a processable material or not
		If ((_x == "life_inv_leadu") OR (_x == "life_inv_copperu") OR (_x == "life_inv_ironu") OR (_x == "life_inv_peachu") OR (_x == "life_inv_beeru") OR (_x == "life_inv_wineu")) then {
			//switch code to determine what type of material it is
			switch (_x) do{
				case "life_inv_leadu": {
					_processCheck = _processCheck +1;
					_lead = ["leadu","leadp",_val,"Lead"];
				};
				case "life_inv_copperu": {
					_processCheck = _processCheck +1;
					_copper = ["copperu","copperp",_val,"Copper"];
				};
				case "life_inv_ironu": {
					_processCheck = _processCheck +1;
					_iron = ["ironu","ironp",_val,"Iron"];
				};
				case "life_inv_peachu": {
					_processCheck = _processCheck +1;
					_peach = ["peachu","peachp",_val,"Peach"];
				};
				case "life_inv_beeru": {
					_processCheck = _processCheck +1;
					_beer = ["beeru","beerp",_val,"Beer"];
				};
				case "life_inv_wineu": {
					_processCheck = _processCheck +1;
					_wine = ["wineu","winep",_val,"Wine"];
				};
			};
		};
	};
} foreach life_inv_items;

_materials pushBack _lead;
_materials pushBack _copper;
_materials pushBack _iron;
_materials pushBack _peach;
_materials pushBack _beer;
_materials pushBack _wine;

//Error-Checking
if (_processCheck < 1) exitWith {life_HUD_notifs pushBack["You do not have any items that can be processed here.",time,0];};

switch (_class) do {
	
	case "civ": {
	//Process action

		{
			_oldItem = _x select 0;
			_newItem = _x select 1;
			_qty = _x select 2;
			_mat = _x select 3;

			if (_qty != 0) then {
				_itemName = [([_newItem,0] call life_fnc_varHandle)] call life_fnc_varToStr;
				_oldVal = missionNamespace getVariable ([_oldItem,0] call life_fnc_varHandle);

				//Some more checks
				if(_oldVal == 0) exitWith {};

				//Setup our progress bar.
				disableSerialization;
				5 cutRsc ["life_progress","PLAIN"];
				_ui = uiNameSpace getVariable "life_progress";
				_progress = _ui displayCtrl 38201;
				_pgText = _ui displayCtrl 38202;
				_pgText ctrlSetText format["Processing %2 (1%1)...","%",_mat];
				_progress progressSetPosition 0.01;
				_cP = 0.01;

				life_is_processing = true;

				//Processing loop
				while{true} do
				{
					sleep  _speed;
					_cP = _cP + 0.01;
					_progress progressSetPosition _cP;
					_pgText ctrlSetText format["Processing %3 (%1%2)...",round(_cP * 100),"%",_mat];
					if(_cP >= 1) exitWith {};
					if(player distance _vendor > 10) exitWith {};
				};
				
				//Taxing
				_random = random(100);
				diag_log format["Chance: %1",_chance];
				if (_random < _chance) then {
					_tax = (_oldVal / 100)* 30;
					_newVal = _oldVal - round(_tax);
					_string = format ["%1 of your materials have been stolen by the rebels!",round(_tax)];
					life_HUD_notifs pushBack [_string,time,2];
					[false,_oldItem,round(_tax)] call life_fnc_handleInv;
				} else {
					_newVal = _oldVal;
				};
				
				//Exit
				if(player distance _vendor > 10) exitWith {_string = localize "STR_Process_Stay"; life_HUD_notifs pushBack [_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
				if(!([false,_oldItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; life_is_processing = false;};
				if(!([true,_newItem,_newVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; [true,_oldItem,_oldVal] call life_fnc_handleInv; life_is_processing = false;};
				5 cutText ["","PLAIN"];
				_string = format[localize "STR_Process_Processed",_oldVal,_itemName];
				life_HUD_notifs pushBack [_string,time,1];
				life_is_processing = false;
				
				[_newVal,11] call life_fnc_addExp;
				[5,26] call life_fnc_addExp;
			};
		} forEach _materials;
	};

	case "rebel": {
		{
			//Process action
			_oldItem = _x select 0;
			_newItem = _x select 1;
			_qty = _x select 2;
			_mat = _x select 3;

			if (_qty != 0) then {
				_itemName = [([_newItem,0] call life_fnc_varHandle)] call life_fnc_varToStr;
				_oldVal = missionNamespace getVariable ([_oldItem,0] call life_fnc_varHandle);

				//Some more checks
				if(_oldVal == 0) exitWith {};

				//Setup our progress bar.
				disableSerialization;
				5 cutRsc ["life_progress","PLAIN"];
				_ui = uiNameSpace getVariable "life_progress";
				_progress = _ui displayCtrl 38201;
				_pgText = _ui displayCtrl 38202;
				_pgText ctrlSetText format["Processing %2 (1%1)...","%",_mat];
				_progress progressSetPosition 0.01;
				_cP = 0.01;

				life_is_processing = true;

				//Processing loop
				while{true} do
				{
					sleep  _speed;
					_cP = _cP + 0.01;
					_progress progressSetPosition _cP;
					_pgText ctrlSetText format["Processing %3 (%1%2)...",round(_cP * 100),"%",_mat];
					if(_cP >= 1) exitWith {};
					if(player distance _vendor > 10) exitWith {};
				};
				
				//Taxing

				_newVal = _oldVal;
				
				//Exit
				if(player distance _vendor > 10) exitWith {_string = localize "STR_Process_Stay"; life_HUD_notifs pushBack [_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
				if(!([false,_oldItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; life_is_processing = false;};
				if(!([true,_newItem,_newVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; [true,_oldItem,_oldVal] call life_fnc_handleInv; life_is_processing = false;};
				5 cutText ["","PLAIN"];
				_string = format[localize "STR_Process_Processed",_oldVal,_itemName];
				life_HUD_notifs pushBack [_string,time,1];
				life_is_processing = false;
				[5,26] call life_fnc_addExp;
			};
		} forEach _materials;
	};
};




