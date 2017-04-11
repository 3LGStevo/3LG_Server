/*
	filename: fn_adminKillFeed.sqf
	Author: Stevo
	
	Description:
	Sets up the page for the kill feed.
*/

Private ["_display","_str","_text"];
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
ctrlEnable[76047,true];
ctrlShow[76048,false];
ctrlEnable[76048,true];

_text = _display displayCtrl 76030;

if (isNil "life_adminFeed") then {
	life_adminFeed = true;
	ctrlEnable[76020,false];
	(_display displayCtrl 76020) lbSetCurSel -1;
	_str = parseText "";
	_text ctrlSetStructuredText _str;
	
	[[player],"life_fnc_killFeedRequest",false,false] spawn life_fnc_MP;
} else {
	life_adminFeed = nil;
	ctrlEnable[76020,true];
	(_display displayCtrl 76020) lbSetCurSel 0;
	[] call life_fnc_adminQuery;
};

