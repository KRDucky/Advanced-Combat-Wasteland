// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Escobar.sqf
//	@file Author: Spectryx 
//	@file Tanoa Edit: GriffinZS, soulkobk 
//	@file Created: Sep 2016

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_stealCar","_dropMoney","_dropPos"];

_setupVars =
{
	_missionType = "Escobar's Legacy";
    _dropMoney = 8000;
};

_setupObjects =
{
    _missionLocation = ["Race_1", "Race_2"] call bis_fnc_selectRandom;
    _dropLoc1 = ["dropOff_1","dropOff_2","dropOff_3","dropOff_4","dropOff_5","dropOff_6","dropOff_7"] call bis_fnc_selectRandom;
	
	_missionPos = markerPos _missionLocation;
	_dropPos = markerPos _dropLoc1;
    _stealCar = createVehicle ["C_Plane_Civil_01_F", _missionPos, [], 5, "None"];

	// added by soulkobk
	[_stealCar,_dropPos] spawn { // spawn new thread for activation of _dropPos marker once player is in _stealCar
		params ["_stealCar","_dropPos"];
		waitUntil { (!isNull (driver _stealCar)) || (!alive _stealCar)}; // this line waits until a unit is in the _stealCar or the _stealCar is dead/destroyed
		if (alive _stealCar) then // if _stealCar is still alive then create marker, else do nothing (exit thread).
		{
			_dropMarker = createMarker ["DropOff", _dropPos]; // create 'drop off' marker on _dropPos
			_dropMarker setMarkerType "hd_end";
			_dropMarker setMarkerShape "ICON";
			_dropMarker setMarkerSize [0.5, 0.5];
			_dropMarker setMarkerText "Destination for Cocaine";
			_dropMarker setMarkerColor "ColorRed";
		};
	};
	////////////////////
		
  
	_missionHintText = format ["<br/>600 kg of finest, columbian cocaine are waiting to be transported! <br/>Head to the <t color='%1'>Civil Plane</t>, get in and fly the cargo to the marked location!", mainMissionColor];
	
};

_ignoreAiDeaths = true;
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _stealCar}; // changed by soulkobk - if vehicle is no longer alive (destroyed) then mission fail
_waitUntilSuccessCondition = {(_stealCar distance _dropPos) <5}; // if vehicle is less than 5 meters from the drop off position then mission successful

_failedExec =
{
	{ deleteVehicle _x } forEach [_stealCar];
	deleteMarker "DropOff";
};

_successExec =
{
    for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _dropPos, [], 5, "None"];
		_cash setPos ([_dropPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _dropMoney / 10, true];
		_cash setVariable ["owner", "world", true];
	};
	
    { deleteVehicle _x } forEach [_stealCar];
    deleteMarker "DropOff";
   
    _successHintMessage = "Well done! The cocaine has been delivered. Pablo would have been proud of you!";
};

_this call mainMissionProcessor;
