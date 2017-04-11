/*
	File: fn_robPerson.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Getting tired of adding descriptions...
*/
private["_robber"];
_robber = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _robber) exitWith {}; //No one to return it to?

if(life_cash > 0) then
{
	[[life_cash],"life_fnc_robReceive",_robber,false] spawn life_fnc_MP;
	[[getPlayerUID _robber,_robber getVariable["realname",name _robber],"211"],"life_fnc_wantedAdd",false,false] spawn life_fnc_MP;
	[[_robber,10,1],"life_fnc_playerVarUpdater",_robber,false] spawn life_fnc_MP;
	_string = format [localize "STR_NOTF_Robbed",_robber getVariable["realname",name _robber],profileName,[life_cash] call life_fnc_numberText];
	[[_string,1],"life_fnc_broadcastHUD",nil,false] spawn life_fnc_MP;
	life_cash = 0;
}
	else
{
	_string = format [localize "STR_NOTF_RobFail",profileName];
	[[_string,1],"life_fnc_broadcastHUD",_robber,false] spawn life_fnc_MP;
};