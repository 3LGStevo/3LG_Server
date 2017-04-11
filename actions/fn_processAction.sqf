/*
	File: fn_processAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Master handling for processing an item.
*/
private["_vendor","_type","_itemInfo","_oldItem","_newItem","_cost","_upp","_hasLicense","_itemName","_oldVal","_ui","_progress","_pgText","_cP","_noLicense","_perks","_speed","_temp","_bonus"];
_vendor = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
_type = [_this,3,"",[""]] call BIS_fnc_param;
_noLicense = [all_trader_1];
//Error check
if(isNull _vendor OR _type == "" OR (player distance _vendor > 10)) exitWith {};

_perks = [6] call life_fnc_perkSystem;
_speed = _perks select 0;

//unprocessed item,processed item, cost if no license,Text to display (I.e Processing  (percent) ..."
switch (_type) do{
	
	case "rock": {_bonus = 1; _itemInfo =  ["rocku","rockp",0,(localize "STR_Process_Rock")];};	
	case "lead": {_bonus = 1.5; _itemInfo = ["leadu","leadp",5,(localize "STR_Process_Lead")];};
	case "copper": {_bonus = 2;_itemInfo = ["copperu","copperp",10,(localize "STR_Process_Copper")];};
	case "iron": {_bonus = 2;_itemInfo = ["ironu","ironp",20,(localize "STR_Process_Iron")];};
	case "diamond": {_bonus = 3;_itemInfo = ["diamondu","diamondp",40,(localize "STR_Process_Diamond")];};
	case "platinum": {_bonus = 3;_itemInfo = ["platinumu","platinump",40,(localize "STR_Process_Platinum")];};

	case "coke": {_bonus = 3;_itemInfo = ["cokeu","cokep",40,(localize "STR_Process_Cocaine")];};

	case "pjuice": {_bonus = 1;_itemInfo = ["peachu","peachp",2,(localize "STR_Process_PJuice")];};
	case "beer": {_bonus = 1.5;_itemInfo = ["beeru","beerp",3,(localize "STR_Process_Beer")];};
	case "wine": {_bonus = 1.5;_itemInfo = ["wineu","winep",4,(localize "STR_Process_Wine")];};
	default {[];};
};

//Error checking
if(count _itemInfo == 0) exitWith {};

//Setup vars.
_oldItem = _itemInfo select 0;
_newItem = _itemInfo select 1;
_cost = _itemInfo select 2;
_upp = _itemInfo select 3;

//Checks if Vendors do not require licenses to process.
_hasLicense = missionNamespace getVariable (([_type,0] call life_fnc_licenseType) select 0);

_itemName = [([_newItem,0] call life_fnc_varHandle)] call life_fnc_varToStr;
_oldVal = missionNamespace getVariable ([_oldItem,0] call life_fnc_varHandle);

_cost = _cost * _oldVal;
//Some more checks
if(_oldVal == 0) exitWith {};

//Setup our progress bar.
disableSerialization;
5 cutRsc ["life_progress","PLAIN"];
_ui = uiNameSpace getVariable "life_progress";
_progress = _ui displayCtrl 38201;
_pgText = _ui displayCtrl 38202;
_pgText ctrlSetText format["%2 (1%1)...","%",_upp];
_progress progressSetPosition 0.01;
_cP = 0.01;

life_is_processing = true;

if(_hasLicense) then
{
	if ((_oldItem == "platinumu") or (_oldItem == "diamondu")) then {
		while{true} do
		{
			sleep  _speed;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
			if(_cP >= 1) exitWith {};
			if(player distance _vendor > 10) exitWith {};
		};
		
		if(player distance _vendor > 10) exitWith {_string = localize "STR_Process_Stay"; life_HUD_notifs pushBack[_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
		if(!([false,_oldItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; life_is_processing = false;};
		if(!([true,_newItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; [true,_oldItem,_oldVal] call life_fnc_handleInv; life_is_processing = false;};
		5 cutText ["","PLAIN"];
		_string = format[localize "STR_Process_Processed",_oldVal,_itemName];
		life_HUD_notifs pushBack[_string,time,1];
		life_is_processing = false;
		_expGain = round((_oldVal * _bonus));
		[_expGain,8] call life_fnc_addExp;
	} else {
		while{true} do
		{
			sleep  _speed;
			_cP = _cP + 0.01;
			_progress progressSetPosition _cP;
			_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
			if(_cP >= 1) exitWith {};
			if(player distance _vendor > 10) exitWith {};
		};
		
		if(player distance _vendor > 10) exitWith {_string = localize "STR_Process_Stay"; life_HUD_notifs pushBack[_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
		if(!([false,_oldItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; life_is_processing = false;};
		if(!([true,_newItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; [true,_oldItem,_oldVal] call life_fnc_handleInv; life_is_processing = false;};
		5 cutText ["","PLAIN"];
		_string = format[localize "STR_Process_Processed",_oldVal,_itemName];
		life_HUD_notifs pushBack[_string,time,1];
		life_is_processing = false;
		
		_expGain = round((_oldVal * _bonus));
		[_expGain,8] call life_fnc_addExp;
	};	
}
	else
{
	if(life_cash < _cost) exitWith {_string = format[localize "STR_Process_License",[_cost] call life_fnc_numberText]; life_HUD_notifs pushBack[_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
	
	while{true} do
	{
		sleep  _speed;
		_cP = _cP + 0.01;
		_progress progressSetPosition _cP;
		_pgText ctrlSetText format["%3 (%1%2)...",round(_cP * 100),"%",_upp];
		if(_cP >= 1) exitWith {};
		if(player distance _vendor > 10) exitWith {};
	};
	
	if(player distance _vendor > 10) exitWith {_string = localize "STR_Process_Stay"; life_HUD_notifs pushBack[_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
	if(life_cash < _cost) exitWith {_string = format[localize "STR_Process_License",[_cost] call life_fnc_numberText]; life_HUD_notifs pushBack[_string,time,2]; 5 cutText ["","PLAIN"]; life_is_processing = false;};
	if(!([false,_oldItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; life_is_processing = false;};
	if(!([true,_newItem,_oldVal] call life_fnc_handleInv)) exitWith {5 cutText ["","PLAIN"]; [true,_oldItem,_oldVal] call life_fnc_handleInv; life_is_processing = false;};
	5 cutText ["","PLAIN"];
	_string = format[localize "STR_Process_Processed2",_oldVal,_itemName,[_cost] call life_fnc_numberText];
	life_HUD_notifs pushBack[_string,time,1];
	life_cash = life_cash - _cost;
	life_is_processing = false;
	
	_temp = _oldVal / 2;
	_expGain = round((_oldVal * _bonus));
	[_expGain,8] call life_fnc_addExp;
};	