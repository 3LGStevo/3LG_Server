#include <macro.h>/*	File: fn_adminTeleport.sqf	Author: ColinM9991	Credits: To original script author(s)	Description:	Teleport to chosen position.*/if(__GETC__(life_adminlevel) == 0) exitWith {closeDialog 0;};life_map_updated = 1;closeDialog 0;closeDialog 0;tele={	_pos = [_this select 0, _this select 1, _this select 2];	(vehicle player) setpos [_pos select 0, _pos select 1, 0];	onMapSingleClick "";	openMap [false, false];	life_HUD_notifs pushBack ["You have teleported to your selected position.",time,20];};openMap [true, false];onMapSingleClick "[_pos select 0, _pos select 1, _pos select 2] call tele; true;";