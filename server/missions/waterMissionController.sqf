// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: waterMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST WaterMissions
#define MISSION_CTRL_TYPE_NAME "Water"
#define MISSION_CTRL_FOLDER "waterMissions"
#define MISSION_CTRL_DELAY (["A3W_waterMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE waterMissionColor

#include "waterMissions\waterMissionDefines.sqf"
#include "missionController.sqf";
