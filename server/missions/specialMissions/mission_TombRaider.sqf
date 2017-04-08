// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Tombraider.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: BR Script Team

if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";

private [ "_box1", "_barGate", "_bargateArray", "_bargateChosen", "_bunker1","_bunker2","_obj1","_obj2"];

_setupVars =
{
	_missionType = "Tomb Raiders";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
		
	_bargateArray = ["Land_AncientStatue_01_F", "Land_AncientStatue_02_F", "Land_PalmTotem_03_F", "Land_PalmTotem_01_F", "Land_PalmTotem_02_F", "Land_PetroglyphWall_02_F", "Land_PetroglyphWall_01_F"];
	_bargateChosen = _bargateArray select (floor random (count _bargateArray));
	_bargate = createVehicle [_bargateChosen, _missionPos, [], 0, "NONE"];
	_bunker1 = createVehicle ["Land_ClothShelter_01_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj1 = createVehicle ["I_HMG_01_high_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_bunker2 = createVehicle ["Land_ClothShelter_02_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["I_HMG_01_high_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,12,15] spawn createCustomGroup7;
	
	
	_missionHintText = format ["<br/>Tomb raiders have stolen an ancient statue and try to sell it! Kill these scumbags and save this treasure!", specialMissionColor];
	
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
	{ deleteVehicle _x } forEach [_bunker1, _bunker2];
	

	_successHintMessage = format ["Good job! The tombraiders are dead!"];
};

_this call specialMissionProcessor;