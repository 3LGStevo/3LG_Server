/*
	File: fn_jail.sqf
	Author: Bryan "Tonic" Boardwine
	
	Description:
	Starts the initial process of jailing.
*/
private["_bad","_unit"];
_unit = [_this,0,ObjNull,[ObjNull]] call BIS_fnc_param;
if(isNull _unit) exitWith {}; //Dafuq?
if(_unit != player) exitWith {}; //Dafuq?
if(life_is_arrested) exitWith {}; //Dafuq i'm already arrested
_bad = [_this,1,false,[false]] call BIS_fnc_param;
player setVariable["restrained",false,true];
player setVariable["Escorting",false,true];
player setVariable["transporting",false,true];
player setVariable["cuffed",false,true];

player setPos (getMarkerPos "jail_marker");

if(_bad) then
{
	waitUntil {alive player};
	sleep 1;
};

//Check to make sure they goto check
if(player distance (getMarkerPos "jail_marker") > 40) then
{
	player setPos (getMarkerPos "jail_marker");
};
//Removes jail licenses
[1] call life_fnc_removeLicenses;

//Resets player inventory
if(life_inv_cokeu > 0) then {[false,"cokeu",life_inv_cokeu] call life_fnc_handleInv;};
if(life_inv_cokep > 0) then {[false,"cokep",life_inv_cokep] call life_fnc_handleInv;};
if(life_inv_water > 0) then {[false,"water",life_inv_water] call life_fnc_handleInv;};
if(life_inv_donuts > 0) then {[false,"donuts",life_inv_donuts] call life_fnc_handleInv;};
if(life_inv_coffee > 0) then {[false,"coffee",life_inv_coffee] call life_fnc_handleInv;};
if(life_inv_coffee > 0) then {[false,"sandwich",life_inv_sandwich] call life_fnc_handleInv;};
if(life_inv_fuelF > 0) then {[false,"fuelF",life_inv_fuelF] call life_fnc_handleInv;};
if(life_inv_fuelE > 0) then {[false,"fuelE",life_inv_fuelE] call life_fnc_handleInv;};
if(life_inv_pickaxe > 0) then {[false,"pickaxe",life_inv_pickaxe] call life_fnc_handleInv;};
if(life_inv_leadu > 0) then {[false,"leadu",life_inv_leadu] call life_fnc_handleInv;};
if(life_inv_copperu > 0) then {[false,"copperu",life_inv_copperu] call life_fnc_handleInv;};
if(life_inv_ironu > 0) then {[false,"ironu",life_inv_ironu] call life_fnc_handleInv;};
if(life_inv_platinumu > 0) then {[false,"platinumu",life_inv_platinumu] call life_fnc_handleInv;};
if(life_inv_leadp > 0) then {[false,"leadp",life_inv_leadp] call life_fnc_handleInv;};
if(life_inv_copperp > 0) then {[false,"copperp",life_inv_copperp] call life_fnc_handleInv;};
if(life_inv_ironp > 0) then {[false,"ironp",life_inv_ironp] call life_fnc_handleInv;};
if(life_inv_platinump > 0) then {[false,"platinump",life_inv_platinump] call life_fnc_handleInv;};
if(life_inv_lockpick > 0) then {[false,"lockpick",life_inv_lockpick] call life_fnc_handleInv;};
if(life_inv_peachu > 0) then {[false,"peachu",life_inv_peachu] call life_fnc_handleInv;};
if(life_inv_peachp > 0) then {[false,"peachp",life_inv_peachp] call life_fnc_handleInv;};
if(life_inv_diamondu > 0) then {[false,"diamondu",life_inv_diamondu] call life_fnc_handleInv;};
if(life_inv_diamondp > 0) then {[false,"diamondp",life_inv_diamondp] call life_fnc_handleInv;};
if(life_inv_spikeStrip > 0) then {[false,"spikeStrip",life_inv_spikeStrip] call life_fnc_handleInv;};
if(life_inv_rocku > 0) then {[false,"rocku",life_inv_rocku] call life_fnc_handleInv;};
if(life_inv_rockp > 0) then {[false,"rockp",life_inv_rockp] call life_fnc_handleInv;};
if(life_inv_goldbar > 0) then {[false,"goldbar",life_inv_goldbar] call life_fnc_handleInv;};
if(life_inv_blastingcharge > 0) then {[false,"blastingcharge",life_inv_blastingcharge] call life_fnc_handleInv;};
if(life_inv_boltcutter > 0) then {[false,"boltcutter",life_inv_boltcutter] call life_fnc_handleInv;};
if(life_inv_defusekit > 0) then {[false,"defusekit",life_inv_defusekit] call life_fnc_handleInv;};
if(life_inv_storagesmall > 0) then {[false,"storagesmall",life_inv_storagesmall] call life_fnc_handleInv;};
if(life_inv_storagebig > 0) then {[false,"storagebig",life_inv_storagebig] call life_fnc_handleInv;};
if(life_inv_ration > 0) then {[false,"ration",life_inv_ration] call life_fnc_handleInv;};
if(life_inv_ziptie > 0) then {[false,"ziptie",life_inv_ziptie] call life_fnc_handleInv;};
if(life_inv_cuffKeys > 0) then {[false,"cuffKeys",life_inv_cuffKeys] call life_fnc_handleInv;};
if(life_inv_goldbar > 0) then {[false,"goldbar",life_inv_goldbar] call life_fnc_handleInv;};
if (life_inv_hammer > 0) then {[false,"hammer",life_inv_hammer] call life_fnc_handleInv;};
if (life_inv_shovel > 0) then {[false,"shovel",life_inv_shovel] call life_fnc_handleInv;};
if (life_inv_wood > 0) then {[false,"wood",life_inv_wood] call life_fnc_handleInv;};
if (life_inv_quest1 > 0) then {[false,"quest1",life_inv_quest1] call life_fnc_handleInv;};
if (life_inv_quest2 > 0) then {[false,"quest2",life_inv_quest2] call life_fnc_handleInv;};
if (life_inv_quest3 > 0) then {[false,"quest3",life_inv_quest3] call life_fnc_handleInv;};

life_is_arrested = true;

life_HUD_notifs pushBack ["Illegal licenses and all your possessions have been removed from your inventory.",time,27];

//removes players cash, equipment, weapons, etc...

life_cash = 0;
removeAllWeapons player;
{player removeMagazine _x} foreach (magazines player);
removeHeadgear player;
removeBackpack player;
removeVest player;
removeGoggles player;

if(player distance (getMarkerPos "jail_marker") > 40) then
{
	player setPos (getMarkerPos "jail_marker");
};

//Sets player's appearance and items

player addUniform "U_C_WorkerCoveralls";
[] call life_fnc_uniformsColor;

//Adds player inventory items required in prison
[true,"water",1] call life_fnc_handleInv;
[true,"peachu",2] call life_fnc_handleInv;
[true,"pickaxe",1] call life_fnc_handleInv;

[1,14] spawn life_fnc_statHandler;

[player,_bad] remoteExec ["life_fnc_jailSys",HC1,false];
[] call SOCK_fnc_updateRequest;