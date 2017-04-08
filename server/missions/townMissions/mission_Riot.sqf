// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Riot.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};
#include "townMissionDefines.sqf";

private [ "_box1", "_barGate", "_obj1","_obj2"];

_setupVars =
{
	_missionType = "Violent Riot";
	_locationsArray = RiotMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 	
	
	_bargate = createVehicle ["Flag_Altis_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_obj1 = createVehicle ["MetalBarrel_burning_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["MetalBarrel_burning_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,15] spawn createCustomGroup6;
	
	_missionHintText = format ["<br/>Riots have been spotted in the village - marked on map.<br/>Go there and try to calm them down. If this won't work, you have permission to eliminate them.", townMissionColor];
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
	

	_successHintMessage = format ["<br/>Not the best way, but finally the riots have been dismantled .."];
};

_this call townMissionProcessor;