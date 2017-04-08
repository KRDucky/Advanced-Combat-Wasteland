// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: airMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST AirMissions
#define MISSION_CTRL_TYPE_NAME "Air"
#define MISSION_CTRL_FOLDER "airMissions"
#define MISSION_CTRL_DELAY (["A3W_airMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE airMissionColor

#include "airMissions\airMissionDefines.sqf"
#include "missionController.sqf";
