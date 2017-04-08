// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_Smugglers.sqf
//	@file Author: JoSchaap, AgentRev, LouD
//	@file Tanoa Edit: GriffinZS

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf";

private ["_positions", "_smugglerVeh", "_vehicle1", "_vehicle2", "_boxes1", "_currBox1", "_randomBox", "_box1", "_boxes2", "_currBox2", "_box2", "_cashrandomizera", "_cashamountrandomizera", "_cashpilerandomizera", "_casha", "_cashamounta", "_cashpilea", "_cashrandomizerb", "_cashamountrandomizerb", "_cashpilerandomizerb", "_cashb", "_cashamountb", "_cashpileb", "_cash1", "_cash2", "_drop_item", "_drugpilerandomizer", "_drugpile"];

_setupVars =
{
	_missionType = "Tropical Smugglers";

	_locationsArray = MissionSpawnMarkers;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_smugglerVeh = ["O_T_LSV_02_armed_F","O_G_Offroad_01_armed_F","O_T_LSV_02_armed_F"] call BIS_fnc_selectRandom; 

	_vehicle1 = [_smugglerVeh,[(_missionPos select 0) - 5, (_missionPos select 1) + 10,0],0.5,1,0,"NONE"] call createMissionVehicle;
	_vehicle1 setVariable [call vChecksum, true, false];
	_vehicle1 setFuel 1;
	_vehicle1 setVehicleLock "UNLOCKED";
	_vehicle1 setVariable ["R3F_LOG_disabled", false, true];
	
	_vehicle2 = [_smugglerVeh,[(_missionPos select 0) - 5, (_missionPos select 1) - 10,0],0.5,1,0,"NONE"] call createMissionVehicle;
	_vehicle2 setVariable [call vChecksum, true, false];
	_vehicle2 setFuel 1;
	_vehicle2 setVehicleLock "UNLOCKED";
	_vehicle2 setVariable ["R3F_LOG_disabled", false, true];
	
	_boxes1 = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F"];
	_currBox1 = _boxes1 call BIS_fnc_selectRandom;
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_box1 = createVehicle [_currBox1,[(_missionPos select 0), (_missionPos select 1),0],[], 0, "NONE"];
	[_box1, _randomBox] call fn_refillbox;
	
	_boxes2 = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F"];
	_currBox2 = _boxes2 call BIS_fnc_selectRandom;
	_box2 = createVehicle [_currBox2,[(_missionPos select 0) - 5, (_missionPos select 1) - 8,0],[], 0, "NONE"];
	_box2 allowDamage false;
	_box2 setVariable ["R3F_LOG_disabled", true, true];
	
	_aiGroup = createGroup CIVILIAN;
	[_aiGroup,_missionPos] spawn createcustomGroup2;

	_aiGroup setCombatMode "RED";
	_aiGroup setBehaviour "COMBAT";
	
	_missionPicture = getText (configFile >> "CfgVehicles" >> _smugglerVeh >> "picture");
	
	_missionHintText = format ["<br/>Smugglers await the arrival of paramilitary units. Intercept this deal!", sideMissionColor];
};
	
_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _vehicle1, _vehicle2];
};

_drop_item = 
{
	private["_item", "_pos"];
	_item = _this select 0;
	_pos = _this select 1;

	if (isNil "_item" || {typeName _item != typeName [] || {count(_item) != 2}}) exitWith {};
	if (isNil "_pos" || {typeName _pos != typeName [] || {count(_pos) != 3}}) exitWith {};

	private["_id", "_class"];
	_id = _item select 0;
	_class = _item select 1;

	private["_obj"];
	_obj = createVehicle [_class, _pos, [], 5, "None"];
	_obj setPos ([_pos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
	_obj setVariable ["mf_item_id", _id, true];
};

_successExec =
{
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	{ _x setVariable ["A3W_missionVehicle", true] } forEach [_vehicle1, _vehicle2];
	
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
	
	_drugpilerandomizer = [4,8];
	_drugpile = _drugpilerandomizer call BIS_fnc_SelectRandom;
	
	for "_i" from 1 to _drugpile do 
	{
	  private["_item"];
	  _item = [
	          ["lsd", "Land_WaterPurificationTablets_F"],
	          ["crack", "Land_Antibiotic_F"],
	          ["cocaine","Land_PowderedMilk_F"],
	          ["heroin", "Land_PainKillers_F"]
	        ] call BIS_fnc_selectRandom;
	  [_item, _lastPos] call _drop_item;
	};
	
	_successHintMessage = format ["Good job! Save the crates! And watch out for these paramilitary wankers!"];
};

_this call sideMissionProcessor;
