// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Pirates.sqf
//	@file Author: JoSchaap, AgentRev
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};
#include "waterMissionDefines.sqf"

private ["_box1", "_box2", "_boxPos", "_boat1", "_boat2"];

_setupVars =
{
	_missionType = "Pirates of Caribbean";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	{
		_boxPos = getPosASL _x;
		_boxPos set [2, getTerrainHeightASL _boxPos + 1];
		_x setPos _boxPos;
		_x setDir random 360;
		_x setVariable ["R3F_LOG_disabled", true, true];
	} forEach [_box1, _box2];

	// create some atmosphere on sea
	_boat1 = createVehicle ["C_Boat_Civil_04_F", _missionPos, [], 3, "None"];
	_boat1 setDir random 360;
	_boat2 = createVehicle ["Land_Cargo20_yellow_F", _missionPos, [], 2, "None"];
	_boat2 setDir random 90;
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos] call createSmallDivers;

	_missionHintText = format ["<br/>Pirates have entered a <t color='%1'>Trawler</t>, killed the crew and now try to escape.<br/>Head there, take bloody revenge and save the cargo!",  waterMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _boat1, _boat2];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	{ deleteVehicle _x } forEach [_boat1, _boat2];

	_successHintMessage = "Good job! The pirates found their wet grave - deep down in the ocean!";
};

_this call waterMissionProcessor;
