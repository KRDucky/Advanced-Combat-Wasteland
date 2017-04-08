// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Sniper.sqf
//	@file Author: JoSchaap, AgentRev, LouD

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_positions", "_boxes1", "_currBox1", "_box1", "_obj", "_tent"];

_setupVars =
{
	_missionType = "Jungle Fever";
	_locationsArray = [ForestMissionMarkers, MissionSpawnMarkers] select (ForestMissionMarkers isEqualTo []);
};


	
_setupObjects =
{
	_missionPos = markerPos _missionLocation;
		//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 
	
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F"] call BIS_fnc_selectRandom;
	
	_tent = createVehicle ["Flag_Syndikat_F", _missionPos, [], 3, "None"];
	_tent allowDamage false;
	_tent setDir random 360;
	_tent setVariable ["R3F_LOG_disabled", false];
	
	_box1 = createVehicle [_randomCase, _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, _randomBox] call fn_refillbox;
	
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1];
	
/*	_missionPos = getPosATL _tent;
	_obj = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj setPosASL [_missionPos select 0, (_missionPos select 1) + 2, _missionPos select 2];
*/	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos] spawn createCustomGroup;
	

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	
	_missionHintText = format ["<br/>A small group mercenary soldiers has been spotted deep in the woods. Find and eliminate them!", sideMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _tent];
	
};

_successExec =
{
	// Mission completed
	
	_successHintMessage = format ["Well done! The mercenary soldiers are dead. No more Robin of the Woods around .."];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_tent, _box1];
	
};

_this call sideMissionProcessor;
