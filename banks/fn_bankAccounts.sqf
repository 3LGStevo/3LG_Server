/*
	filename: fn_bankAccounts.sqf
	Author: Stevo
	
	Description:
	Displays the bank accounts page
*/
Private ["_display","_list"];
disableSerialization;
createDialog "life_hack_bank";
_display = findDisplay 38700;
_list = _display displayCtrl 38701;
lbClear _list;

{
	_UID = getPlayerUID _x;
	_unit = _x;
	_list lbAdd _UID;
	_list lbSetData [(lbSize _list)-1,str(_unit)];
} forEach playableUnits;

ctrlEnable[38703,false];