// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: townMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST TownMissions
#define MISSION_CTRL_TYPE_NAME "Town"
#define MISSION_CTRL_FOLDER "townMissions"
#define MISSION_CTRL_DELAY (["A3W_townMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE townMissionColor

#include "townMissions\townMissionDefines.sqf"
#include "missionController.sqf";
