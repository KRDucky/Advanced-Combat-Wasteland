// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: townMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Town"
#define MISSION_PROC_TIMEOUT (["A3W_townMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE townMissionColor

#include "townMissions\townMissionDefines.sqf"
#include "missionProcessor.sqf";
