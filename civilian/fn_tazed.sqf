/*
	File: fn_tazed.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the tazed animation and broadcasts out what it needs to.
*/
private["_unit","_shooter","_curWep","_curMags","_attach"];
_unit = [_this,0,Objnull,[Objnull]] call BIS_fnc_param;
_shooter = [_this,1,Objnull,[Objnull]] call BIS_fnc_param;
if(isNull _unit OR isNull _shooter) exitWith {player allowDamage true; life_istazed = false;};

if(_shooter isKindOf "Man" && alive player) then
{
	if(!life_istazed) then
	{
		life_istazed = true;
		
		//Force player to lay down
		player playMoveNow "AmovPpneMstpSnonWnonDnon";
		
		//Dims screen
		0 cutText["You have been knocked out by Rubber Bullets...","BLACK OUT",3];
		0 cutFadeOut 9999999;
		_string = format [localize "STR_NOTF_Tazed",profileName];
		[[_string,1],"life_fnc_broadcastHUD",true,false] spawn life_fnc_MP;
		disableUserInput true;
		
		sleep 10;
		0 cutText["","BLACK",0];
		
		sleep 20;
		
		disableUserInput false;
		0 cutText ["","BLACK IN",3];
		
		
		//If not restrained, stand player up.
		if (!(player getVariable ["restrained",false])) then {
			player playMoveNow "AmovPercMstpSnonWnonDnon";
		};
		
		//If not escorting anymore, ensure player is detached from objects
		if(!(player getVariable["Escorting",false])) then {
			detach player;
		};
		
		//Exit variables
		life_istazed = false;
		player allowDamage true;
		
		[1,26] call life_fnc_addExp;
	};
}
	else
{
	_unit allowDamage true;
	life_iztazed = false;
};