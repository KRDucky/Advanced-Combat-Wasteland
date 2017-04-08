// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Train.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";

private [ "_box1", "_barGate", "_obj1","_obj2"];

_setupVars =
{
	_missionType = "Night Train";
	_locationsArray = TrainMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 	
	
	_bargate = createVehicle ["O_CargoNet_01_ammo_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_obj1 = createVehicle ["Land_Locomotive_01_v1_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["Land_RailwayCar_01_sugarcane_empty_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_bargate];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,15] spawn createcustomGroup2;
	
	_missionHintText = format ["<br/>A train has derailed!<br/>Go there, kill the guards and save the cargo!", specialMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_barGate, _obj1, _obj2];
	
};

_successExec =
{
	// Mission completed
	
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _randomBox] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];
	{ deleteVehicle _x } forEach [_barGate, _obj1, _obj2];
	

	_successHintMessage = format ["<br/>The cargo of the train has been saved. Good work!"];
};

_this call specialMissionProcessor;