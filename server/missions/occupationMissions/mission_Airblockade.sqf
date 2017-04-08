// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Airblockade.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "occupationMissionDefines.sqf";

private [ "_box1", "_barGate", "_obj1", "_obj2"];

_setupVars =
{
	_missionType = "Airport Blockade";
	_locationsArray = AirpostMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_markerDir = markerDir _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 	
	
	_bargate = createVehicle ["Land_TentHangar_V1_F", _missionPos, [], 0, "NONE"];
	_bargate setDir _markerDir;
	_obj1 = createVehicle ["I_HMG_01_high_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["I_GMG_01_high_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,15,20] spawn createCustomGroup4;
	
	_missionHintText = format ["<br/>Attention! A group of armed units <br/><t color='%1'>blockades a local airport</t>.<br/>Head there, eliminate them all and break this blockade!", occupationMissionColor];
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
	

	_successHintMessage = format ["<br/>Well done! The airport is free again!"];
};

_this call occupationMissionProcessor;