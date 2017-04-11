#include <macro.h>
/*
	File: fn_adminQuery.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the query on a player.
*/
private["_display","_text","_info","_prim","_sec","_vest","_uni","_bp","_attach","_tmp"];
disableSerialization;
_display = findDisplay 76000;

ctrlShow[76040,false];
ctrlShow[76041,false];
ctrlShow[76042,false];
ctrlShow[76043,false];
ctrlShow[76044,false];
ctrlShow[76045,false];
ctrlShow[76046,false];
ctrlShow[76047,false];
ctrlShow[76048,false];
ctrlShow[76030,true];


if(!isNil {admin_query_ip}) exitWith {life_HUD_notifs pushBack ["Unknown error with admin_query_ip",time,0];};
_text = _display displayCtrl 76030;
_info = lbData[76020,lbCurSel (76020)];
_info = call compile format["%1", _info];
if(isNil "_info") exitWith {_text ctrlSetText localize "STR_ANOTF_QueryFail";};
if(isNull _info) exitWith {_text ctrlSetText localize "STR_ANOTF_QueryFail";};
[[player],"TON_fnc_player_query",_info,false] spawn life_fnc_MP;
_text ctrlSetText localize "STR_ANOTF_Query";

switch (menu_admin_mode) do {
	case 0: {
		if (isNil "life_adminMode") then {
			ctrlEnable[76011,true];
			ctrlEnable[76012,true];
			ctrlEnable[76013,true];
			ctrlEnable[76014,false];
			ctrlEnable[76015,false];
			ctrlEnable[76016,false];
		} else {
			if (life_is_respawning) then {
				ctrlEnable[76011,false];
				ctrlEnable[76012,true];
				ctrlEnable[76013,true];
				ctrlEnable[76014,false];
				ctrlEnable[76015,false];
				ctrlEnable[76016,false];
			} else {
				ctrlEnable[76011,true];
				ctrlEnable[76012,true];
				ctrlEnable[76013,true];
				ctrlEnable[76014,true];
				ctrlEnable[76015,true];
				ctrlEnable[76016,true];
			};
		};
	};
	case 1: {
		if (isNil "life_adminMode") then {
			if (life_is_respawning) then {
				ctrlEnable[76011,false];
				ctrlEnable[76012,true];
				ctrlEnable[76013,true];
				ctrlEnable[76014,true];
				ctrlEnable[76015,true];
				if (__GETC__(life_adminLevel) == 3) then {
					ctrlEnable[76016,true];
				} else {
					ctrlEnable[76016,false];
				};
			} else {
				ctrlEnable[76011,true];
				ctrlEnable[76012,false];
				ctrlEnable[76013,false];
				ctrlEnable[76014,false];
				ctrlEnable[76015,false];
				if (__GETC__(life_adminLevel) == 3) then {
					ctrlEnable[76016,true];
				} else {
					ctrlEnable[76016,false];
				};
			};
		} else {
			if (life_is_respawning) then {
				ctrlEnable[76011,false];
				ctrlEnable[76012,true];
				ctrlEnable[76013,true];
				ctrlEnable[76014,true];
				ctrlEnable[76015,true];
				if (__GETC__(life_adminLevel) == 3) then {
					ctrlEnable[76016,true];
				} else {
					ctrlEnable[76016,false];
				};
			} else {
				ctrlEnable[76011,true];
				ctrlEnable[76012,true];
				ctrlEnable[76013,true];
				ctrlEnable[76014,true];
				ctrlEnable[76015,true];
				if (__GETC__(life_adminLevel) == 3) then {
					ctrlEnable[76016,true];
				} else {
					ctrlEnable[76016,false];
				};
			};
		};
	};
};