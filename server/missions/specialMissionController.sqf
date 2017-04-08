// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: specialMissionController.sqf
//	@file Author: AgentRev

#define MISSION_CTRL_PVAR_LIST SpecialMissions
#define MISSION_CTRL_TYPE_NAME "Special"
#define MISSION_CTRL_FOLDER "specialMissions"
#define MISSION_CTRL_DELAY (["A3W_specialMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE specialMissionColor

#include "specialMissions\specialMissionDefines.sqf"
#include "missionController.sqf";
