// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Gravedigger.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: BR Script Team

if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";

private [ "_box1", "_barGate", "_bargateArray", "_bargateChosen", "_obj1","_obj2"];

_setupVars =
{
	_missionType = "Gravedigger";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
		
	_bargateArray = ["Land_Grave_07_F", "Land_Grave_04_F", "Land_Tombstone_02_F", "Land_Tombstone_03_F", "Land_Mausoleum_01_F", "Land_GardenPavement_01_F", "Land_GardenPavement_02_F"];
	_bargateChosen = _bargateArray select (floor random (count _bargateArray));
	_bargate = createVehicle [_bargateChosen, _missionPos, [], 0, "NONE"];
	_obj1 = createVehicle ["Land_Shovel_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["Land_Shovel_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,12,15] spawn createCustomGroup;
	
	
	_missionHintText = format ["<br/>Immoral bastards raided a nearby graveyard. Kill them all and send them back to this graveyard!", specialMissionColor];
	
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
	{ deleteVehicle _x } forEach [_obj1];
	

	_successHintMessage = format ["Great work! You sent the immoral bastards back to their own graves!<br/> Save the crates and get outa there!"];
};

_this call specialMissionProcessor;