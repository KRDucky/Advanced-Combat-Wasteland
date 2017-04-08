// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};


WaterMissions =
[
	// Mission filename, weight
	["mission_ArmedDiversquad", 1],
	["mission_SunkenTreasure", 1],
	["mission_Coastal_Jetski", 1],
	["mission_SunkenSupplies", 1],
	["mission_Coastal_Convoy", 1],
	["mission_Pirates", 1]
	
];

BaseMissions =
[
	// Mission filename, weight
	["mission_Banditpost"],
	["mission_Outpost", 1],
	["mission_BaseHeli", 1],
	["mission_BaseConvoy", 1],
	["mission_TrenchHuron", 1]
	
	
];


TransportMissions =
[
	// Mission filename, weight
	["mission_Convoy", 1],
	["mission_HellDrugs", 1],
	["mission_MiniConvoy", 1],
	["mission_WalterWhite", 1],
	["mission_IS", 1]
	
	
];


OccupationMissions =
[
	// Mission filename, weight
	["mission_Roadblock", 1],
	["mission_Industryannexation", 1],
	["mission_Conqueror", 1],
	["mission_Gasstation", 1],
	["mission_Airpost", 1],
	["mission_CommunicationInterruption", 1],
	["mission_Harborinvasion", 1]
	
	
];


AirMissions =
[
	// Mission filename, weight
	["mission_GhostSwarm", 1],
	["mission_TanoaPatrol", 1],
	["mission_HostileJetFormation", 1],
	["mission_HostileHeliFormation", 0.5],
	["mission_HostileHelicopter", 0.5],
	["mission_HostileJet", 1],
	["mission_PawneeSquadron", 1],
	["mission_BlackfootTwins", 1],
	["mission_DeadSky", 1],
	["mission_JetFormation", 1]
	
	
];

SpecialMissions =
[
	// Mission filename, weight
	["mission_Roulette", 1],
	["mission_falsecops", 1],
	["mission_Falcon", 1],
	["mission_StomperSOS", 1],
	["mission_HostageRescue", 1],
	["mission_TombRaider", 1],
	["mission_UAV", 1],
	["mission_Explosives", 1],
	["mission_Gravedigger", 1],
	["mission_Train", 1]
	
	
];

TownMissions =
[
	// Mission filename, weight
	["mission_TownInvasion", 1],
	["mission_TownInvasion2", 1],
	["mission_TownInvasion3", 1],
	["mission_TownInvasion4", 1],
	["mission_Riot", 1],
	["mission_SuicideSquad", 1]
	
	
];

MainMissions =
[
	// Mission filename, weight
	["mission_APC", 1],
	["mission_MBT", 1],
	["mission_HeavyMetal", 1],
	["mission_LightArmVeh", 1],
	["mission_ArmedHeli", 1],
	["mission_CivHeli", 1],
	["mission_Payday", 1]
	
];

SideMissions =
[
	// Mission filename, weight
	["mission_AirWreck", 1],
	["mission_drugsRunners", 1],
	["mission_geoCache", 1],
	["mission_Sniper", 1],
	["mission_WepCache", 1],
	["mission_Smugglers", 1],
	["mission_Truck", 1]
	
];

MoneyMissions =
[
	// Mission filename, weight
	["mission_MoneyShipment", 1],
	["mission_altisPatrol", 1],
	//["mission_altisPatrol2", 1],
	["mission_TroopsRelocation", 1],
	["mission_TheHeist", 1]
];

MissionSpawnMarkers = (allMapMarkers select {["Mission_", _x] call fn_startsWith}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call fn_startsWith}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call fn_startsWith}) apply {[_x, false]};
RoadblockMissionMarkers = (allMapMarkers select {["Roadblock_", _x] call fn_startsWith}) apply {[_x, false]};
GasstationMissionMarkers = (allMapMarkers select {["Gasstation_", _x] call fn_startsWith}) apply {[_x, false]};
AirpostMissionMarkers = (allMapMarkers select {["Airpost_", _x] call fn_startsWith}) apply {[_x, false]};
IndustryMissionMarkers = (allMapMarkers select {["Industry_", _x] call fn_startsWith}) apply {[_x, false]};
ConquerorMissionMarkers = (allMapMarkers select {["Conqueror_", _x] call fn_startsWith}) apply {[_x, false]};
RiotMissionMarkers = (allMapMarkers select {["Riot_", _x] call fn_startsWith}) apply {[_x, false]};
CommMissionMarkers = (allMapMarkers select {["Comm_", _x] call fn_startsWith}) apply {[_x, false]};
TrainMissionMarkers = (allMapMarkers select {["Train_", _x] call fn_startsWith}) apply {[_x, false]};
HarborMissionMarkers = (allMapMarkers select {["Harbor_", _x] call fn_startsWith}) apply {[_x, false]};
TheHeistMissionMarkers = (allMapMarkers select {["TheHeist_", _x] call fn_startsWith}) apply {[_x, false]};
RaceMissionMarkers = (allMapMarkers select {["Race_", _x] call fn_startsWith}) apply {[_x, false]};




if !(ForestMissionMarkers isEqualTo []) then
{
	SideMissions append
	[
		["mission_AirWreck", 1.5],
		["mission_WepCache", 1.5],
		["mission_Sniper", 1]
	];
};

LandConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\landConvoysList.sqf") apply {[_x, false]};
CoastalConvoyPaths = (call compile preprocessFileLineNumbers "mapConfig\convoys\coastalConvoysList.sqf") apply {[_x, false]};

MainMissions = [MainMissions, [["A3W_heliPatrolMissions", ["mission_Coastal_Convoy", "mission_HostileHeliFormation"]], ["A3W_underWaterMissions", ["mission_ArmedDiversquad"]]]] call removeDisabledMissions;
SideMissions = [SideMissions, [["A3W_heliPatrolMissions", ["mission_HostileHelicopter"]], ["A3W_underWaterMissions", ["mission_SunkenSupplies"]]]] call removeDisabledMissions;
MoneyMissions = [MoneyMissions, [["A3W_underWaterMissions", ["mission_SunkenTreasure"]]]] call removeDisabledMissions;
AirMissions = [AirMissions, [["A3W_heliPatrolMissions", ["mission_SunkenTreasure", "mission_GhostSwarm","mission_TanoaPatrol", "mission_HostileJetFormation", "mission_HostileHeliFormation", "mission_HostileHelicopter", "mission_HostileJet", "mission_PawneeSquadron"]]]] call removeDisabledMissions;


{ _x set [2, false] } forEach MainMissions;
{ _x set [2, false] } forEach SideMissions;
{ _x set [2, false] } forEach MoneyMissions;
{ _x set [2, false] } forEach TownMissions;
{ _x set [2, false] } forEach SpecialMissions;
{ _x set [2, false] } forEach AirMissions;
{ _x set [2, false] } forEach OccupationMissions;
{ _x set [2, false] } forEach TransportMissions;
{ _x set [2, false] } forEach BaseMissions;
{ _x set [2, false] } forEach WaterMissions;
