/*
	File: fn_civLoadout.sqf
	Author: Tobias 'Xetoxyc' Sittenauer
	Editor: Stevo
	
	Description:
	Loads the civs out with the default gear, with randomized clothing, unless they're in a faction. The civ is assigned the faction clothing.
*/
private["_handle"];
[] call life_fnc_stripDownPlayer;

if (license_civ_corp) then {
	player addUniform ("U_I_CombatUniform");
} Else { If (license_civ_rebel) then {
			player addUniform ("U_OG_Guerilla1_1");
		} Else {
			player addUniform (life_default_clothing select (floor(random (count life_default_clothing))));
		};
};

/* ITEMS */
player addItem "ItemMap";
player assignItem "ItemMap";

[] call life_fnc_saveGear;