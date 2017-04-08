// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Explosives.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: BR Script Team

if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";

private [ "_box1", "_barGate", "_bargateArray", "_bargateChosen", "_obj1","_obj2"];

_setupVars =
{
	_missionType = "Explosive Experts";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
		
	_bargateArray = ["Land_Shed_05_ruins_F", "Land_Shed_03_ruins_F", "Land_Shed_01_ruins_F", "Land_Shed_06_ruins_F"];
	_bargateChosen = _bargateArray select (floor random (count _bargateArray));
	_bargate = createVehicle [_bargateChosen, _missionPos, [], 0, "NONE"];
	_obj1 = createVehicle ["Land_PortableGenerator_01_F", _bargate modelToWorld [6.5,-2,-4.1], [], 0, "NONE"];
	_obj2 = createVehicle ["Land_TripodScreen_01_dual_v2_F", _bargate modelToWorld [-8,-2,-4.1], [], 0, "NONE"];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,12,15] spawn createCustomGroup;
	
	
	_missionHintText = format ["<br/>Criminal merchants try to sell nearly everything! Today's offer:<br/><t color='%1'>improvised explosive devices</t>.<br/>Eliminate these jerks and save the IED - for your own interests!", specialMissionColor];
	
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
	_box1 addItemCargoGlobal ["IEDUrbanBig_Remote_Mag",1];
	_box1 addItemCargoGlobal ["IEDLandBig_Remote_Mag",1];
	_box1 addItemCargoGlobal ["IEDUrbanSmall_Remote_Mag",1];
	_box1 addItemCargoGlobal ["IEDLandSmall_Remote_Mag",1];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];
	{ deleteVehicle _x } forEach [_obj1, _bargate, _obj2];
	

	_successHintMessage = format ["Well done! These jerks of merchants are dead. Save the crates, keep the IEDs and use them with sense!"];
};

_this call specialMissionProcessor;