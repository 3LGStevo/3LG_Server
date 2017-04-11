/*
    File: fn_robATMInit.sqf
    Author: Jim
    
    Description: Initialises the robable shops and assigns the variables to them.
*/
if (isDedicated) exitWith {};
private ["_robAtm"];
_robAtm = [bank1_atm1,bank1_atm2,bank1_atm3];

{
	_x addAction["<t color='#993333'>Rob ATM</t>",life_fnc_robAtm,format["%1",_x],0,false,false,"",'playerSide == civilian && (!license_civ_corp OR !license_civ_bh)'];
} forEach _robAtm;
