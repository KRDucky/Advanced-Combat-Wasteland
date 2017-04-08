// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 2.1
//	@file Name: mission_Payday.sqf
//	@file Author: JoSchaap / routes by Del1te - (original idea by Sanjo), AgentRev
//	@file Created: 31/08/2013 18:19
//	@file Tanoa Edit: GriffinSZ

if (!isServer) exitwith {};
#include "mainMissionDefines.sqf";

private ["_MoneyShipment", "_moneyAmount", "_convoys", "_vehChoices", "_moneyText", "_vehClasses", "_createVehicle", "_vehicles", "_veh2", "_leader", "_speedMode", "_waypoint", "_vehicleName", "_numWaypoints", "_cash"];

_setupVars =
{
	_locationsArray = LandConvoyPaths;

	// Money Shipments settings
	// Difficulties : Min = 1, Max = infinite
	// Convoys per difficulty : Min = 1, Max = infinite
	// Vehicles per convoy : Min = 1, Max = infinite
	// Choices per vehicle : Min = 1, Max = infinite
	_MoneyShipment =
	[
		// Easy
		[
			"Small Payday", // Marker text
			5500, // Money
			[
				[ // NATO convoy
					["B_G_Offroad_01_armed_F"], // Veh 1
					["C_Truck_02_transport_F"] // Veh 2
				],
				[ // CSAT convoy
					["B_G_Offroad_01_armed_F"], // Veh 1
					["C_Truck_02_transport_F"] // Veh 2
				],
				[ // AAF convoy
					["B_G_Offroad_01_armed_F"], // Veh 1
					["C_Truck_02_transport_F"] // Veh 2
				]
			]
		],
		// Medium
		[
			"Medium Payday", // Marker text
			11200, // Money
			[
				[ // NATO convoy
					["O_LSV_02_armed_F"], // Veh 1
					["C_Truck_02_covered_F"], // Veh 2
					["O_MRAP_02_gmg_F"] // Veh 3
				],
				[ // CSAT convoy
					["O_LSV_02_armed_F"], // Veh 1
					["C_Truck_02_covered_F"], // Veh 2
					["O_MRAP_02_gmg_F"] // Veh 3
				],
				[ // AAF convoy
					["O_LSV_02_armed_F"], // Veh 1
					["C_Truck_02_covered_F"], // Veh 2
					["O_MRAP_02_gmg_F"] // Veh 3
				]
			]
		],
		// Hard
		[
			"Large Payday", // Marker text
			15800, // Money
			[
				[ // NATO convoy
					["O_APC_Tracked_02_cannon_F"], // Veh 1
					["C_Truck_02_fuel_F"], // Veh 2
					["O_APC_Wheeled_02_rcws_F"] // Veh 3
				],
				[ // CSAT convoy
					["O_APC_Tracked_02_cannon_F"], // Veh 1
					["C_Truck_02_fuel_F"], // Veh 2
					["O_APC_Wheeled_02_rcws_F"] // Veh 3
				],
				[ // AAF convoy
					["O_APC_Tracked_02_cannon_F"], // Veh 1
					["C_Truck_02_fuel_F"], // Veh 2
					["O_APC_Wheeled_02_rcws_F"] // Veh 3
				]
			]
		],
		// Extreme
		[
			"Heavy Payday", // Marker text
			21400, // Money
			[
				[ // NATO convoy
					["O_APC_Tracked_02_AA_F"], // Veh 1
					["C_Truck_02_box_F"], // Veh 2
					["O_MBT_02_cannon_F"], // Veh 3
					["O_MRAP_02_gmg_F"] // Veh 4
				],
				[ // CSAT convoy
					["O_APC_Tracked_02_AA_F"], // Veh 1
					["C_Truck_02_box_F"], // Veh 2
					["O_MBT_02_cannon_F"], // Veh 3
					["O_MRAP_02_gmg_F"] // Veh 4
				],
				[ // AAF convoy
					["O_APC_Tracked_02_AA_F"], // Veh 1
					["C_Truck_02_box_F"], // Veh 2
					["O_MBT_02_cannon_F"], // Veh 3
					["O_MRAP_02_gmg_F"] // Veh 4
				]
			]
		]
	]
	call BIS_fnc_selectRandom;

	_missionType = _MoneyShipment select 0;
	_moneyAmount = _MoneyShipment select 1;
	_convoys = _MoneyShipment select 2;
	_vehChoices = _convoys call BIS_fnc_selectRandom;

	_moneyText = format ["$%1", [_moneyAmount] call fn_numbersText];

	_vehClasses = [];
	{ _vehClasses pushBack (_x call BIS_fnc_selectRandom) } forEach _vehChoices;
};

_setupObjects =
{
	private ["_starts", "_startDirs", "_waypoints"];
	call compile preprocessFileLineNumbers format ["mapConfig\convoys\%1.sqf", _missionLocation];

	_createVehicle =
	{
		private ["_type", "_position", "_direction", "_vehicle", "_soldier"];

		_type = _this select 0;
		_position = _this select 1;
		_direction = _this select 2;

		_vehicle = createVehicle [_type, _position, [], 0, "None"];
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		[_vehicle] call vehicleSetup;

		_vehicle setDir _direction;
		_aiGroup addVehicle _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInDriver _vehicle;

		_soldier = [_aiGroup, _position] call createRandomSoldier;
		_soldier moveInCargo [_vehicle, 0];

		if !(_type isKindOf "Truck_F") then
		{
			_soldier = [_aiGroup, _position] call createRandomSoldier;
			_soldier moveInGunner _vehicle;

			_soldier = [_aiGroup, _position] call createRandomSoldier;

			if (_vehicle emptyPositions "commander" > 0) then
			{
				_soldier moveInCommander _vehicle;
			}
			else
			{
				_soldier moveInCargo [_vehicle, 1];
			};
		};

		[_vehicle, _aiGroup] spawn checkMissionVehicleLock;

		_vehicle
	};

	_aiGroup = createGroup CIVILIAN;

	_vehicles = [];
	{
		_vehicles pushBack ([_x, _starts select 0, _startdirs select 0, _aiGroup] call _createVehicle);
	} forEach _vehClasses;

	_veh2 = _vehClasses select (1 min (count _vehClasses - 1));

	_leader = effectiveCommander (_vehicles select 0);
	_aiGroup selectLeader _leader;

	_aiGroup setCombatMode "GREEN"; // units will defend themselves
	_aiGroup setBehaviour "SAFE"; // units feel safe until they spot an enemy or get into contact
	_aiGroup setFormation "STAG COLUMN";

	_speedMode = if (missionDifficultyHard) then { "NORMAL" } else { "LIMITED" };

	_aiGroup setSpeedMode _speedMode;

	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 25;
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointBehaviour "SAFE"; // safe is the best behaviour to make AI follow roads, as soon as they spot an enemy or go into combat they WILL leave the road for cover though!
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _waypoints;

	_missionPos = getPosATL leader _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> _veh2 >> "picture");
	_vehicleName = getText (configFile >> "cfgVehicles" >> _veh2 >> "displayName");

	_missionHintText = format ["A <t color='%1'>%3</t> is on the way to support nearby paramilitary outposts.<br/> Rumors say, they also transporting soldiers' earnings for this week: <t color='%1'>%2</t>! <br/>Stop this convoy and let their families eat shit this month!", mainMissionColor, _moneyText, _vehicleName];

	_numWaypoints = count waypoints _aiGroup;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;

// _vehicles are automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	for "_i" from 1 to 10 do
	{
		_cash = createVehicle ["Land_Money_F", _lastPos, [], 5, "None"];
		_cash setPos ([_lastPos, [[2 + random 3,0,0], random 360] call BIS_fnc_rotateVector2D] call BIS_fnc_vectorAdd);
		_cash setDir random 360;
		_cash setVariable ["cmoney", _moneyAmount / 10, true];
		_cash setVariable ["owner", "world", true];
	};

	_successHintMessage = "Excellent! The wages have been reduced. To zero!";
};

_this call mainMissionProcessor;
