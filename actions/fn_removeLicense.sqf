/*
	filename: fn_removeLicense.sqf
	Author: stevo
	
	Description:
	Single-use file for license removal
*/
private["_type","_action","_license"];
_type = [_this,0,"",[""]] call bis_fnc_param;
_expGain = 50;

_license = [_type,0] call life_fnc_licenseType;

_text = format["Are you sure you wish to remove %1 from your licenses? There may be a charge included in this transaction...",(_license select 1)];
[_text] call life_fnc_confirmPopup;

waitUntil {isNull (findDisplay 14000)};
if (life_menu_confirm) then {
	life_menu_confirm = false;
	missionNamespace setVariable[(_license select 0),false];
	_STRlicense = format["%1",(_license select 1)];
	if (_type == "coke") then {
		_bank = life_atmcash - 5000;
		if (_bank < 0) then {_bank = 0};
		life_atmcash = _bank;
		_string = format["You have removed %1 from your licenses. A charge of $5,000 was also removed from your bank account.",_STRlicense];
		life_HUD_notifs pushBack [_string,time,2];
	} else {
		_string = format["You have removed %1 from your licenses.",_STRlicense];
		life_HUD_notifs pushBack [_string,time,1];
	};
	[] call life_fnc_licenseShopRefresh;
} else {
	life_HUD_notifs pushBack ["License removal cancelled",time,1];
	license_shop_lock = false;
};

[] spawn life_fnc_jobCheck;