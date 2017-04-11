/*
	File: fn_removeLicenses.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Used for stripping certain licenses off of civilians as punishment.
*/
private["_state"];
_state = [_this,0,1,[0]] call BIS_fnc_param;

switch (_state) do
{
	//Death while being wanted
	case 0:
	{
		//No change
	};
	
	//Jail licenses
	case 1:
	{
		license_civ_gun = false;
		license_civ_coke = false;
		if (license_civ_hitman) then {
			license_civ_hitman = false;
			player setVariable ["hitman",0,true];
		};
	};
	
	//Remove motor vehicle licenses
	case 2:
	{
		if(license_civ_driver OR license_civ_air OR license_civ_truck OR license_civ_boat) then {
			license_civ_driver = false;
			license_civ_air = false;
			license_civ_truck = false;
			license_civ_boat = false;
		};
	};
	//Corp SAF
	case 3:
	{
		if (license_corp_saf) then {
			license_corp_saf = false;
		};
	};
	//Corp UAV
	case 4: {
		if (license_corp_uav) then {
			license_corp_uav = false;
		};
	};
	//Corp MP
	case 5: {
		if (license_corp_mp) then {
			license_corp_mp = false;
		};
	};
	//Rebel Ter
	case 6: {
		if (license_rebel_ter) then {
			license_rebel_ter = false;
		};
	};
	//Rebel Mil
	case 7: {
		if (license_rebel_mil) then {
			license_rebel_mil = false;
		};
	};
};

[] call life_fnc_jobCheck;