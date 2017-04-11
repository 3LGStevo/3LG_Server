/*
	File: fn_copLights.sqf
	Author: mindstorm, modified by Adanteh
	Link: http://forums.bistudio.com/showthread.php?157474-Offroad-Police-sirens-lights-and-underglow
	
	Description:
	Adds the light effect to port authority vehicles, specifically the offroad.
*/
Private ["_vehicle","_lightAmber","_lightleft","_lightright","_leftOn"];
_vehicle = _this select 0;
	
if(isNil "_vehicle" OR isNull _vehicle OR !(_vehicle getVariable "lights")) exitWith {};
_lightAmber = [20, 12, 0.1];

_lightleft = "#lightpoint" createVehicle getpos _vehicle;   
sleep 0.2;
_lightleft setLightColor _lightAmber; 
_lightleft setLightBrightness 0.2;  
_lightleft setLightAmbient [1,0.5,0.1];

switch (typeOf _vehicle) do
{
	case "B_G_Offroad_01_F":
	{
		_lightleft lightAttachObject [_vehicle, [-0.37, 0.0, 0.56]];
	};
	
	case "B_Truck_01_mover_F":
	{
		_lightleft lightAttachObject [_vehicle, [-0.37, 3.5, 0.8]];
	};
	
};

_lightleft setLightAttenuation [0.181, 0, 1000, 130]; 
_lightleft setLightIntensity 10;
_lightleft setLightFlareSize 0.38;
_lightleft setLightFlareMaxDistance 50;
_lightleft setLightUseFlare true;

_lightright = "#lightpoint" createVehicle getpos _vehicle;   
sleep 0.2;
_lightright setLightColor _lightAmber; 
_lightright setLightBrightness 0.2;  
_lightright setLightAmbient [1,0.5,0.1]; 

switch (typeOf _vehicle) do
{
	case "B_G_Offroad_01_F":
	{
		_lightright lightAttachObject [_vehicle, [0.37, 0.0, 0.56]];
	};
	
	case "B_Truck_01_mover_F":
	{
		_lightright lightAttachObject [_vehicle, [0.37, 3.5, 0.8]];
	};

};
  
_lightright setLightAttenuation [0.181, 0, 1000, 130]; 
_lightright setLightIntensity 10;
_lightright setLightFlareSize 0.38;
_lightright setLightFlareMaxDistance 50;
_lightright setLightUseFlare true;

//ARE YOU ALL HAPPY?!?!?!?!?!?!?!?!?%#?@WGD?TGD?BN?ZDHBFD?GA
_lightleft setLightDayLight true;
_lightright setLightDayLight true;

_leftOn = true;  
while{ (alive _vehicle)} do  
{  
	if(!(_vehicle getVariable "lights")) exitWith {};
	if(_leftOn) then  
	{  
		_leftOn = false;  
		_lightright setLightBrightness 0.0;  
		sleep 0.05;
		_lightleft setLightBrightness 6;  
	}  
		else  
	{  
		_leftOn = true;  
		_lightleft setLightBrightness 0.0;  
		sleep 0.05;
		_lightright setLightBrightness 6;  
	};  
	sleep (_this select 1);  
};  
deleteVehicle _lightleft;
deleteVehicle _lightright;