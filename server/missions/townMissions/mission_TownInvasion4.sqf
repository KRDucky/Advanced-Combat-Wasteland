// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion4.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, JoSchaap, AgentRev, Zenophon
//  @file Information: JoSchaap's Lite version of 'Infantry Occupy House' Original was made by: Zenophon
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};

#include "townMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_missionPos", "_buildingRadius", "_putOnRoof", "_fillEvenly", "_wreck", "_chair1", "_chair2", "_cFire1", "_wreckPos", "_vehicleName"];

_setupVars =
{
	_missionType = "Hunter's Rescue";
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };

	// settings for this mission
	_locArray = ((call cityList) call BIS_fnc_selectRandom);
	_missionPos = markerPos (_locArray select 0);
	_buildingRadius = _locArray select 1;
	_townName = _locArray select 2;

	//randomize amount of units
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
	// reduce radius for larger towns. for example to avoid endless hide and seek in kavala ;)
	_buildingRadius = if (_buildingRadius > 201) then {(_buildingRadius*0.5)} else {_buildingRadius};
	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
};

_setupObjects =
{
	// spawn some crates in the middle of town (Town marker position)
	_box1 = createVehicle ["Box_NATO_Wps_F", _missionPos, [], 5, "None"];
	_box1 setDir random 360;
	[_box1, "mission_USSpecial"] call fn_refillbox;

	_box2 = createVehicle ["Box_East_Wps_F", _missionPos, [], 5, "None"];
	_box2 setDir random 360;
	[_box2, "mission_USLaunchers"] call fn_refillbox;

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["B_MRAP_01_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	
		
	_chair1 = createVehicle ["MetalBarrel_burning_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Flag_Syndikat_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_cFire1	= createVehicle ["MetalBarrel_burning_F", _missionPos, [], 2, "None"];


	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_box1, _box2];

	// spawn some rebels/enemies :)
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup2;

	// move them into buildings
	[_aiGroup, _missionPos, _buildingRadius, _fillEvenly, _putOnRoof] call moveIntoBuildings;

		
	_missionHintText = format ["<br/>A <t color='%1'>Hunter</t> has been immobilized in or near <t color='%1'>%2</t>! <t color='%1'>%3 armed units</t> just arrived there to save the vehicle. <br/>Kill them all, save the cargo and try to get the Hunter!", townMissionColor, _townName, _nbUnits];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _tent1, _chair1, _chair2, _cFire1];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = format ["Good work!<br/><br/><t color='%1'>%2</t> has been cleared!<br/>What's up with the Hunter ..?", townMissionColor, _townName];
	{ deleteVehicle _x } forEach [_chair1, _chair2, _cFire1];
};

_this call townMissionProcessor;
