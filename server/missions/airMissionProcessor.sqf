// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: airMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Air"
#define MISSION_PROC_TIMEOUT (["A3W_airMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE airMissionColor

#include "airMissions\airMissionDefines.sqf"
#include "missionProcessor.sqf";
