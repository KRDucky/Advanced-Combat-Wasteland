// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostageRescue.sqf
//	@file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk

if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";

private ["_positions", "_camonet", "_hostage", "_obj1", "_obj2", "_obj3", "_obj4", "_vehicleName", "_chair", "_cashrandomizera", "_cashamountrandomizera", "_cashpilerandomizera", "_casha", "_cashamounta", "_cashpilea", "_cashrandomizerb", "_cashamountrandomizerb", "_cashpilerandomizerb", "_cashb", "_cashamountb", "_cashpileb", "_cash1", "_cash2", "_drop_item", "_drugpilerandomizer", "_drugpile"];

_setupVars =
{
	_missionType = "Sneak for Ghillie";
	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	
	//delete existing base parts and vehicles at location
	_baseToDelete = nearestObjects [_missionPos, ["All"], 25];
	{ deleteVehicle _x } forEach _baseToDelete; 
	
	_camonet = createVehicle ["CamoNet_INDP_open_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
	_camonet allowdamage false;
	_camonet setDir random 360;
	_camonet setVariable ["R3F_LOG_disabled", false];

	_missionPos = getPosATL _camonet;

	_chair = createVehicle ["Land_Slums02_pole", _missionPos, [], 0, "CAN COLLIDE"];
	_chair setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	
	_hostage = createVehicle ["C_Nikos_aged", _missionPos, [], 0, "CAN COLLIDE"];
	_hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	waitUntil {alive _hostage};
	[_hostage, "Acts_AidlPsitMstpSsurWnonDnon_loop"] call switchMoveGlobal;
	_hostage disableAI "anim";
	
   	

	_obj1 = createVehicle ["I_GMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj1 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) + 2, _missionPos select 2];
	
	_obj2 = createVehicle ["Box_IED_Exp_F", _missionPos,[], 10,"None"]; 
	_obj2 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) + 2, _missionPos select 2];
	_obj2 addItemCargoGlobal ["U_B_FullGhillie_lsh", 1];
	_obj2 addItemCargoGlobal ["U_I_FullGhillie_lsh", 1];
	
	_obj3 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj3 setPosATL [(_missionPos select 0) - 2, (_missionPos select 1) - 2, _missionPos select 2];
	
	_obj4 = createVehicle ["I_HMG_01_high_F", _missionPos,[], 10,"None"]; 
	_obj4 setPosATL [(_missionPos select 0) + 2, (_missionPos select 1) - 2, _missionPos select 2];

	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos,10,20] spawn createcustomGroup;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";	
	
	_vehicleName = "Hostage";
	_missionHintText = format ["<br/>Mercenary soldiers have captured a merchant and claim ransom. <br/> There is <t color='%2'>a crate with 2 Ghillie Suites</t> in it.<br/>Steal the Ghillie Suites <t color='%2'>before</t> you kill every single mercenary!", _vehicleName, specialMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!alive _hostage};

_failedExec =
{
	// Mission failed
	
	{ deleteVehicle _x } forEach [_camonet, _obj1, _obj2, _obj3, _obj4, _hostage, _chair];
	_failedHintMessage = format ["The merchant is dead! What the hell have you not understood? Have you saved one Ghillie Suit at least?!"];
};

_successExec =
{
	// Mission completed
	
	
	{ deleteVehicle _x } forEach [_camonet, _hostage, _chair, _obj2];
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
	
		
	_successHintMessage = format ["Well done! The mercenary soldiers are dead and the merchant alive. He pays for this. Have you saved one of the Ghillies? "];
};

_this call specialMissionProcessor;