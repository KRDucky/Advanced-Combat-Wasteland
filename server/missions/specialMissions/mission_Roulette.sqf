// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//  @file Name: mission_Roulette.sqf
//  @file Author: JoSchaap, AgentRev, GriffinZS, RickB, soulkobk
 
if (!isServer) exitwith {};
#include "specialMissionDefines.sqf";
 
private ["_positions", "_camonet", "_hostage", "_hostage2", "_vehicleName", "_randomBox", "_randomCase", "_box1", "_para", "_geoPos"];
 
_setupVars =
{
    _missionType = "Tanoa Roulette";
    _locationsArray = MissionSpawnMarkers;
};
 
_setupObjects =
{
    _missionPos = markerPos _missionLocation;
	_geoPos = _missionPos vectorAdd ([[25 + random 20, 0, 0], random 360] call BIS_fnc_rotateVector2D);

   
    //delete existing base parts and vehicles at location
    _baseToDelete = nearestObjects [_missionPos, ["All"], 25];
    { deleteVehicle _x } forEach _baseToDelete;
   
    _camonet = createVehicle ["Land_IRMaskingCover_02_F", [_missionPos select 0, _missionPos select 1], [], 0, "CAN COLLIDE"];
    _camonet allowdamage false;
    _camonet setDir random 360;
    _camonet setVariable ["R3F_LOG_disabled", false];
 
    _missionPos = getPosATL _camonet;
 
    _hostage = createVehicle ["C_man_1", _missionPos,[], 10,"None"];
    _hostage setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
    removeAllWeapons _hostage;
	removeAllAssignedItems _hostage;
	removeUniform _hostage;
	removeVest _hostage;
	removeBackpack _hostage;
	removeHeadgear _hostage;
	removeGoggles _hostage;
	_hostage addHeadgear "H_RacingHelmet_1_black_F";
	[_hostage, "Acts_ExecutionVictim_Loop"] call switchMoveGlobal;
    _hostage disableAI "anim";
   
    _hostage2 = createVehicle ["C_man_1_1_F", _missionPos,[], 10,"None"];
    _hostage2 setPosATL [_missionPos select 0, _missionPos select 1, _missionPos select 2];
	 removeAllWeapons _hostage2;
	removeAllAssignedItems _hostage2;
	removeUniform _hostage2;
	removeVest _hostage2;
	removeBackpack _hostage2;
	removeHeadgear _hostage2;
	removeGoggles _hostage2;
	_hostage2 addHeadgear "H_RacingHelmet_1_black_F";
	[_hostage2, "Acts_ExecutionVictim_Loop"] call switchMoveGlobal;
    _hostage2 disableAI "anim";
      
     
    _aiGroup = createGroup CIVILIAN;
    [_aiGroup,_missionPos,2,10] spawn createcustomGroupCopSmall;
 
    _aiGroup setCombatMode "RED";
    _aiGroup setBehaviour "COMBAT";
   
    _vehicleName = "Hostage";
    _missionHintText = format ["<br/>Two aspirants of <t color='%2'>Tanoa Gendarmerie</t> set two civilians captive to play justice.<br/> Head there, show them the brutality of real justice:<br/>kill them and <t color='%2'>execute ONLY the guilty civilian</t>!", _vehicleName, specialMissionColor];
};
 
    _ignoreAiDeaths = true;
    _waitUntilMarkerPos = nil;
    _waitUntilExec = nil;
    _waitUntilCondition = {!alive _hostage}; // fail
    _waitUntilSuccessCondition = {alive _hostage && !alive _hostage2}; // win


 
_failedExec =
{
    // Mission failed
   
    { deleteVehicle _x } forEach [_camonet, _hostage, _hostage2];
    _failedHintMessage = format ["Excellent work. You ASSHOLE! You killed the innocent!"];
};
 
_successExec =
{
    // Mission completed
   
   
    { deleteVehicle _x } forEach [_camonet, _hostage, _hostage2];
    
	_randomBox = ["mission_USLaunchers","mission_USSpecial","mission_Main_A3snipers"] call BIS_fnc_selectRandom;
	_randomCase = ["Box_FIA_Support_F","Box_FIA_Wps_F","Box_FIA_Ammo_F","Box_NATO_WpsSpecial_F","Box_East_WpsSpecial_F","Box_NATO_Ammo_F","Box_East_Ammo_F"] call BIS_fnc_selectRandom;
	
	_box1 = createVehicle [_randomCase,[(_geoPos select 0), (_geoPos select 1),200],[], 0, "NONE"];
	_box1 setDir random 360;
	_box1 addItemCargoGlobal ["H_RacingHelmet_1_black_F",1];
	_box1 allowdamage false;
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1];

	playSound3D ["A3\data_f_curator\sound\cfgsounds\air_raid.wss", _box1, false, _box1, 15, 1, 1500];
	
	_para = createVehicle [format ["I_parachute_02_F"], [0,0,999999], [], 0, ""];

	_para setDir getDir _box1;
	_para setPosATL getPosATL _box1;

	_para attachTo [_box1, [0, 0, 0]];
	uiSleep 2;

	detach _para;
	_box1 attachTo [_para, [0, 0, 0]];

	while {(getPos _box1) select 2 > 3 && attachedTo _box1 == _para} do
	{
		_para setVectorUp [0,0,1];
		_para setVelocity [0, 0, (velocity _para) select 2];
		uiSleep 0.1;
	};
   
       
    _successHintMessage = format ["Not bad. More luck than skill, huh?"];
};
 
_this call specialMissionProcessor;