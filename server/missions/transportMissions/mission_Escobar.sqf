// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2
//	@file Name: mission_Escobar.sqf
//	@file Author: Spectryx 
//	@file Tanoa Edit: GriffinZS, soulkobk 
//	@file Created: Sep 2016

if (!isServer) exitwith {};
#include "transportMissionDefines.sqf";

private ["_stealCar","_dropMoney","_dropPos"];

_setupVars =
{
	_missionType = "Escobar's Legacy";
    _dropMoney = 8000;
};

_setupObjects =
{
    _missionVehicles = selectRandom ["C_Plane_Civil_01_F"];
	_missionLocation = selectRandom ["Race_1"];
    _dropOffLocation = selectRandom ["dropOff_1", "dropOff_2", "dropOff_3", "dropOff_4", "dropOff_5", "dropOff_6"];
	
	_missionPos = markerPos _missionLocation;
	_dropOffPos = markerPos _dropOffLocation;
    _missionVehicle = createVehicle [_missionVehicles, _missionPos, [], 5, "None"]; // create the vehicle at the mission position
	_missionVehicle setDir (markerDir _missionLocation); // you don't really need this line (it sets the direction of the vehicle to the direction of the marker), delete it.
	
	// added by soulkobk
	[_missionVehicle,_dropOffPos] spawn { // spawn new thread for activation of _dropOffPos marker once player is in _missionVehicle
		params ["_missionVehicle","_dropOffPos"];
		waitUntil {(!isNull (driver _missionVehicle)) || (!alive _missionVehicle)}; // this line waits until a unit is in the driver seat of _missionVehicle or the _missionVehicle is dead/destroyed
		_vehName = gettext (configFile >> "CfgVehicles" >> (typeOf vehicle _missionVehicle) >> "displayName"); // get vehicle display name eg, 'MB 4WD'
		if (alive _missionVehicle) then // if _missionVehicle is still alive then create marker, else do nothing (exit thread).
		{
			_dropMarker = createMarker ["DropOff", _dropOffPos]; // create 'drop off' marker on _dropOffPos
			_dropMarker setMarkerType "hd_end";
			_dropMarker setMarkerShape "ICON";
			_dropMarker setMarkerSize [0.5, 0.5];
			// _dropMarker setMarkerText "DESTINATION FOR COCAINE"];
			_dropMarker setMarkerText format ["DESTINATION FOR %1",_vehName]; // you don't really need this line, uncomment the above line, delete this one.
			_dropMarker setMarkerColor "ColorRed";
			hint format ["THE STEALCAR %1\nHAS A DRIVER %2, CHECK MAP!",_vehName, name (driver _missionVehicle)]; // you don't really need this line, delete it.
		} // you don't really need this line, delete it.
		else // you don't really need this line, delete it.
		{ // you don't really need this line, delete it.
			hint format ["THE STEALCAR %1\nWAS DESTROYED!\nMISSION FAILED!",_vehName]; // you don't really need this line, delete it.
		};
		waitUntil {(!alive _missionVehicle)}; // waits for the vehicle to not exist anymore (destroyed or successful mission)
		deleteMarker "DropOff"; // deletes the "DropOff" _dropMarker (see above line)
	};
	////////////////////
		
  
	_missionHintText = format ["<br/>600 kg of finest, columbian cocaine are waiting to be transported! <br/>Head to the <t color='%1'>Caesar BTT</t>, get in and fly the cargo to the marked location!",  transportMissionColor];
	
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

_this call transportMissionProcessor;
