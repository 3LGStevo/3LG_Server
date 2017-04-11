/*
	File: fn_ticketAction.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the ticketing process.
*/
private["_unit","_expGain"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
disableSerialization;
if(!(createDialog "life_ticket_give")) exitWith {_string = localize "STR_Cop_TicketFail"; life_HUD_notifs pushBack [_string,time,2];};
if(isNull _unit OR !isPlayer _unit) exitwith {};
ctrlSetText[2651,format[localize "STR_Cop_Ticket",_unit getVariable["realname",name _unit]]];
life_ticket_unit = _unit;

_expGain = 50;
[_expGain,16] call life_fnc_addExp;