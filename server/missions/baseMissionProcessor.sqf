// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: baseMissionProcessor.sqf
//	@file Author: AgentRev, edit by GriffinSZ

#define MISSION_PROC_TYPE_NAME "Base"
#define MISSION_PROC_TIMEOUT (["A3W_baseMissionTimeout", 60*60] call getPublicVar)
#define MISSION_PROC_COLOR_DEFINE baseMissionColor

#include "baseMissions\baseMissionDefines.sqf"
#include "missionProcessor.sqf";
