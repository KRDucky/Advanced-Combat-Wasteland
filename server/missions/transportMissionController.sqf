// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: transportMissionController.sqf
//	@file Author: AgentRev, edit GriffinSZ

#define MISSION_CTRL_PVAR_LIST TransportMissions
#define MISSION_CTRL_TYPE_NAME "Transport"
#define MISSION_CTRL_FOLDER "transportMissions"
#define MISSION_CTRL_DELAY (["A3W_transportMissionDelay", 15*60] call getPublicVar)
#define MISSION_CTRL_COLOR_DEFINE transportMissionColor

#include "transportMissions\transportMissionDefines.sqf"
#include "missionController.sqf";
