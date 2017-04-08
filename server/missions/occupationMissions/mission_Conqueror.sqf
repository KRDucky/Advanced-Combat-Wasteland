// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Conqueror.sqf
//	@file Author: JoSchaap, AgentRev, LouD, GriffinZS

if (!isServer) exitwith {};
#include "occupationMissionDefines.sqf";

private [ "_box1", "_barGate", "_bunker1","_bunker2","_obj1","_obj2"];

_setupVars =
{
	_missionType = "Island Conqueror";
	_locationsArray = ConquerorMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 	
	
	_bargate = createVehicle ["Flag_HorizonIslands_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_bunker1 = createVehicle ["CamoNet_OPFOR_open_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj1 = createVehicle ["O_Boat_Transport_01_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_bunker1 setDir _markerDir;
	_bunker2 = createVehicle ["CamoNet_OPFOR_open_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["I_GMG_01_high_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_bunker2 setDir _markerDir;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,15] spawn createCustomGroup;
	
	_missionHintText = format ["<br/>Reportedly armed units try to <br/><t color='%1'>conquer a small island</t>.<br/>Check this island, find the invaders and kick them back to the sea!", occupationMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_barGate, _bunker1, _bunker2, _obj1, _obj2];
	
};

_successExec =
{
	// Mission completed
	
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _randomBox] call fn_refillbox;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];
	{ deleteVehicle _x } forEach [_barGate, _bunker1, _bunker2];
	

	_successHintMessage = format ["<br/>Good work! The invaders have been defeated!"];
};

_this call occupationMissionProcessor;