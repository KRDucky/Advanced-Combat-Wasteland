// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_VehicleCapture.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev
//	@file Created: 08/12/2012 15:19
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};
#include "baseMissionDefines.sqf";

private ["_nbUnits", "_banditpost", "_objects"];

_setupVars =
{
	_missionType = "Bandit Camp";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = AI_GROUP_MEDIUM;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;

	_banditpost = (call compile preprocessFileLineNumbers "server\missions\banditposts\banditpostsList.sqf") call BIS_fnc_selectRandom;
	_objects = [_banditpost, _missionPos, 0] call createBanditpost;

	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits, 5] call createCustomGroup2;

	_missionHintText = format ["<br/>A <t color='%1'>group of bandits</t> claim the marked area to their own. <br/> Go there, eliminate these wankers and destroy the camp!", baseMissionColor]
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
};

_successExec =
{
	// Mission complete
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _objects;
	[_locationsArray, _missionLocation, _objects] call setLocationObjects;

	_successHintMessage = "Well done! The bandit camp has been dismantled.";
};

_this call baseMissionProcessor;
