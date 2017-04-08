// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: createRandomDiver.sqf
/*
 * Creates a random civilian diver.
 *
 * Arguments: [ position, group, init, skill, rank]: Array
 *    position: Position - Location unit is created at.
 *    group: Group - Existing group new unit will join.
 *    init: String - (optional, default "") Command to be executed upon creation of unit. Parameter this is set to the created unit and passed to the code.
 *    skill: Number - (optional, default 0.5)
 *    rank: String - (optional, default "PRIVATE")
 */

if (!isServer) exitWith {};

private ["_soldierTypes",
		"_uniformTypes",
		"_vestTypes",
		"_group",
		"_position",
		"_rank",
		"_soldier"];

// params [["_group", grpNull],["_position", [0,0,0]],["_rank", "PRIVATE"]; // I think think is correct -soul.

// according to the Arguments in the header of this file...
params [["_position", [0,0,0]],["_group", grpNull],[_init, ""],[_skill,"0,5"],["_rank", "PRIVATE"];
		
_soldierTypes = ["C_man_polo_1_F", "C_man_polo_2_F", "C_man_polo_3_F", "C_man_polo_4_F", "C_man_polo_5_F", "C_man_polo_6_F"];
_uniformTypes = ["U_O_Wetsuit", "U_B_Wetsuit" ,"U_I_Wetsuit"];
_vestTypes    = ["V_RebreatherB","V_RebreatherIR","V_RebreatherIA"];

_soldier = _group createUnit [(selectRandom _soldierTypes), _position, [], 0, "NONE"];
_soldier forceAddUniform (selectRandom _uniformTypes);
_soldier addVest (selectRandom _vestTypes);
_soldier addGoggles "G_Diving"; 
_soldier addWeapon "arifle_SDAR_F"; 

if (_rank != "") then
{
	_soldier setRank _rank;
};

_soldier spawn refillPrimaryAmmo;
_soldier spawn addMilCap;
_soldier call setMissionSkill;

_soldier addEventHandler ["Killed", server_playerDied];

_soldier