// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: waterMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Water"
#define MISSION_PROC_TIMEOUT (["A3W_waterMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE waterMissionColor

#include "waterMissions\waterMissionDefines.sqf"
#include "missionProcessor.sqf";
