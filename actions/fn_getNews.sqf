/*
	Filename: fn_getNews.sqf
	Author: Stevo
	
	Description:
	Used to retrieve an item of news from the server
*/

if (life_cash < 10) exitWith {Life_HUD_notifs pushBack ["You do not have enough money to get the newspaper.",time,2];};

[player] remoteExec ["life_fnc_selectNews",HC2,false];