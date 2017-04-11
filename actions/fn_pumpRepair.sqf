/*
	File: fn_pumpRepair.sqf
	
	Description:
	Quick simple action that is only temp.
*/
private["_method"];
if(life_cash < 50) then
{
	if(life_atmcash < 50) exitWith {_method = 0;};
	_method = 2;
}
	else
{
	_method = 1;
};

switch (_method) do
{
	case 0: {_string = "You do not have $50 in cash or in your bank account."; life_HUD_notifs pushBack[_string,time,2];};
	case 1: {vehicle player setDamage 0; life_cash = life_cash - 50; _string = "You have repaired your vehicle for $50"; life_HUD_notifs pushBack[_string,time,1];};
	case 2: {vehicle player setDamage 0; life_atmcash = life_atmcash - 50; _string = "You have repaired your vehicle for $50"; life_HUD_notifs pushBack[_string,time,1];};
};