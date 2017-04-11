/*
	filename: fn_bankViewCam.sqf
	Author: Stevo
	
	Description:
	View inside the security room at the Bank
*/

_display = _this select 0;
_mode = _this select 3;

if(!isPiPEnabled) exitWith {_string = localize "STR_Cop_EnablePiP"; life_HUD_notifs pushBack [_string,time,0];};
if(isNil "bank_sec_cam") then {
	bank_sec_cam = "camera" camCreate [0,0,0];
	bank_sec_cam camSetFov 0.5;
	bank_sec_cam camCommit 0;
	"bankTarget1" setPiPEffect [0];
	bank_sec_cam cameraEffect ["INTERNAL", "BACK", "bankTarget1"];
	_display setObjectTexture [0,"#(argb,256,256,1)r2t(bankTarget1,1.0)"];
};

switch (_mode) do {
	case "on": {
		bank_sec_cam camSetPos [3691.949,13147.45,3.937];
		bank_sec_cam camSetTarget [3699.454,13145.834,0];
		bank_sec_cam camCommit 0;
	};
	
	case "off" :{
		bank_sec_cam cameraEffect ["terminate", "back"];
		camDestroy bank_sec_cam;
		_display setObjectTexture [0,""];
		bank_sec_cam = nil;
	};
};
