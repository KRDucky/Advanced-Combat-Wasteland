// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TheHeist.sqf
//	@file Author: JoSchaap, AgentRev, LouD, GriffinZS

if (!isServer) exitwith {};
#include "moneyMissionDefines.sqf";

private ["_positions", "_camonet", "_laptop", "_obj1", "_obj2", "_obj3", "_obj4", "_vehicleName","_table"];

_setupVars =
{
	_missionType = "The Heist";
	_locationsArray = TheHeistMissionMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	
	
	_camonet = createVehicle ["Land_cargo_addon02_V1_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_table = createVehicle ["Land_WoodenTable_small_F", _missionPos, [], 0, "CAN COLLIDE"];
	_table setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	
	_laptop = createVehicle ["Land_Laptop_unfolded_F", _missionPos, [], 0, "CAN COLLIDE"];
	_laptop attachTo [_table,[0,0,0.60]];

	_obj1 = createVehicle ["Land_Portable_generator_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) + 2, _missionPos select 2];
	
	_obj2 = createVehicle ["Land_SatelliteAntenna_01_F", _missionPos,[], 10,"None"]; 
	_obj2 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) + 2, _missionPos select 2];
	
	_obj3 = createVehicle ["Land_TripodScreen_01_dual_v2_F", _missionPos,[], 10,"None"]; 
	_obj3 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) - 2, _missionPos select 2];
	
	_obj4 = createVehicle ["C_SUV_01_F", _missionPos,[], 10,"None"]; 
	_obj4 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) - 3, _missionPos select 2];

	AddLaptopHandler = _laptop;
	publicVariable "AddLaptopHandler";

	_laptop setVariable [ "Done", false, true ];

	_aiGroup = createGroup CIVILIAN;
	
	
	[_aiGroup,_missionPos,10,10] spawn createCustomGroup7;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_vehicleName = "Laptop";
	_missionHintText = format ["<br/>Armed units try to <t color='%2'>hack an ATM</t> and steal money. <br/>Head there, kill these morons and complete the download on your own!", _vehicleName, moneyMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec =
{
	AddLaptopHandler = _laptop;
	publicVariable "AddLaptopHandler";
};
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { _laptop getVariable ["Done", false] };
_ignoreAiDeaths = true;

_failedExec =
{
	// Mission failed
	RemoveLaptopHandler = _laptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj2, _obj3, _obj4, _laptop, _table];
};

_successExec =
{
	// Mission completed
	RemoveLaptopHandler = _laptop;
	publicVariable "RemoveLaptopHandler";
	{ deleteVehicle _x } forEach [_camonet, _laptop, _table, _obj1, _obj2, _obj3, _obj4];
	

	_successHintMessage = format ["Well done! The ATM has been hacked. Where's the next whorehouse?"];
};

_this call moneyMissionProcessor;