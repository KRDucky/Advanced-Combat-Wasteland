// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: transportMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Transport"
#define MISSION_PROC_TIMEOUT (["A3W_transportMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE transportMissionColor

#include "transportMissions\transportMissionDefines.sqf"
#include "missionProcessor.sqf";
