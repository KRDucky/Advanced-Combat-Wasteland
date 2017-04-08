// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_falsecops.sqf
//	@file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk

if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";

private ["_positions", "_camonet", "_hostage", "_obj1", "_obj2", "_obj3", "_obj4", "_vehicleName", "_chair", "_cashrandomizera", "_cashamountrandomizera", "_cashpilerandomizera", "_casha", "_cashamounta", "_cashpilea", "_cashrandomizerb", "_cashamountrandomizerb", "_cashpilerandomizerb", "_cashb", "_cashamountb", "_cashpileb", "_cash1", "_cash2", "_drop_item", "_drugpilerandomizer", "_drugpile"];

_setupVars =
{
	_missionType = "Bandits in Disguise";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 
	
	_camonet = createVehicle ["Land_MetalBarrel_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_hostage = createVehicle ["C_man_polo_1_F", _missionPos, [], 0, "CAN COLLIDE"];
	_hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	removeAllWeapons _hostage;
	removeAllAssignedItems _hostage;
	removeUniform _hostage;
	removeVest _hostage;
	removeBackpack _hostage;
	removeHeadgear _hostage;
	removeGoggles _hostage;
    _hostage addUniform "U_B_GEN_Soldier_F";
	waitUntil {alive _hostage};
	[_hostage, "Acts_ExecutionVictim_Loop"] call switchMoveGlobal;
	_hostage disableAI "anim";
	

	_obj1 = createVehicle ["B_GEN_Offroad_01_gen_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) + 2, _missionPos select 2];
	
	_obj2 = createVehicle ["Box_IED_Exp_F", _missionPos,[], 10,"None"]; 
	_obj2 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) + 2, _missionPos select 2];
		
	_obj3 = createVehicle ["Land_MetalBarrel_F", _missionPos,[], 10,"None"]; 
	_obj3 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) - 2, _missionPos select 2];
	
	_obj4 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj4 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) - 2, _missionPos select 2];

	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,20] spawn createcustomGroupCop;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_vehicleName = "Hostage";
	_missionHintText = format ["<br/>Bandits stopped a <t color='%2'>Gendarmerie Offroader</t> and set the driver captive.<br/> They are <t color='%2'>wearing Gendarmerie uniforms</t>!<br/> Kill these morons and try to keep the real officer alive!", _vehicleName, specialMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage};

_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj2, _obj3, _obj4, _hostage, _chair];
	_failedHintMessage = format ["Well .. the officer is dead. And the loot is gone too!"];
};

_successExec =
{
	// Mission completed
	
	
	{ deleteVehicle _x } forEach [_camonet, _hostage, _chair, _obj3, _obj4];
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_obj1, _obj2, _obj3, _obj4];

	
	
	//Random fake - real money
	_cashrandomizera = ["money","cmoney","money","cmoney"];
	_cashamountrandomizera = [200,300,400,500,600,700];
	_cashpilerandomizera = [3,5];
		
	_casha = _cashrandomizera call BIS_fnc_SelectRandom;
	_cashamounta = _cashamountrandomizera call BIS_fnc_SelectRandom;
	_cashpilea = _cashpilerandomizera call BIS_fnc_SelectRandom;
	
	for "_i" from 1 to _cashpilea do
	{
		_cash1 = createVehicle ["Land_Money_F",[(_lastPos select 0), (_lastPos select 1) - 5,0],[], 0, "NONE"];
		_cash1 setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash1 setDir random 360;
		_cash1 setVariable [_casha, _cashamounta, true];
		_cash1 setVariable ["owner", "world", true];
	};
	
	_cashrandomizerb = ["money","cmoney","money","cmoney"];
	_cashamountrandomizerb = [200,300,400,500,600,700];
	_cashpilerandomizerb = [3,5];
		
	_cashb = _cashrandomizerb call BIS_fnc_SelectRandom;
	_cashamountb = _cashamountrandomizerb call BIS_fnc_SelectRandom;
	_cashpileb = _cashpilerandomizerb call BIS_fnc_SelectRandom;
	
	for "_i" from 1 to _cashpileb do
	{
		_cash2 = createVehicle ["Land_Money_F",[(_lastPos select 0), (_lastPos select 1) - 5,0],[], 0, "NONE"];
		_cash2 setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash2 setDir random 360;
		_cash2 setVariable [_cashb, _cashamountb, true];
		_cash2 setVariable ["owner", "world", true];
	};
	
		
	_successHintMessage = format ["Excellent work! Save the money and the crates and get out of there!"];
};

_this call specialMissionProcessor;