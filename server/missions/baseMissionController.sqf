// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: baseMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST BaseMissions
#define MISSION_CTRL_TYPE_NAME "Base"
#define MISSION_CTRL_FOLDER "baseMissions"
#define MISSION_CTRL_DELAY (["A3W_baseMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE baseMissionColor

#include "baseMissions\baseMissionDefines.sqf"
#include "missionController.sqf";
