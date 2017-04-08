// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: Banditpost1.sqf
//	@file Author: JoSchaap, AgentRev
//	@file Bandit Edit: GriffinZS

[
	// Class, Position, Direction, Init (optional)
	["Flag_Syndikat_F", [-0.188477, 9.95068, -0.0161819], 1.90371],
	["Land_Razorwire_F", [-0.232666, 10.4307, 0.153743], 359.72],
	["Land_BagBunker_01_small_green_F", [-5.16577, 6.29346, 0.0585103], 180.219],
	["MetalBarrel_burning_F", [-0.163574, 1.57666, -0.0357904], 1.34008],
	["Land_BagBunker_01_small_green_F", [4.52393, 6.37305, 0.0791397], 179.5],
	["Box_IND_WpsSpecial_F", [-1.04126, 0.24707, 0], 286.415, { [_this, ["mission_USSpecial", "mission_DLCLMGs"] call BIS_fnc_selectRandom] call fn_refillbox }],
	["Land_HBarrier_01_line_5_green_F", [-6.46558, 2.6377, 0.0582647], 90.8417],
	["CamoNet_OPFOR_open_F", [0, 0, -0.00534153], 0.243539],
	["Box_East_WpsSpecial_F", [0.470947, -0.591309, 0], 85.8074, { [_this, "mission_USLaunchers"] call fn_refillbox }],
	["Land_Ancient_Wall_8m_F", [-7.76196, 2.66602, 0.0108471], 270.574],
	["Land_HBarrier_01_line_5_green_F", [5.80786, 2.78027, 0.100734], 269.176],
	["Land_WoodenTable_large_F", [-0.246338, -1.82959, -0.0460205], 359.373],
	["Land_Ancient_Wall_4m_F", [7.11743, 3.08105, 0.0197954], 269.531],
	["Land_HBarrier_01_line_5_green_F", [-6.46436, -2.58936, 0.0695257], 89.8022],
	["Land_HBarrier_01_line_5_green_F", [5.92725, -2.4458, 0.0815554], 269.256],
	["Land_Ancient_Wall_4m_F", [-7.75244, -2.91895, -0.0287189], 269.564],
	["Land_Ancient_Wall_8m_F", [7.14795, -2.55615, 0.016717], 269.598],
	["Land_BagBunker_01_small_green_F", [-5.20874, -6.12061, 0.0614038], 359.567],
	["Land_BagBunker_01_small_green_F", [4.69092, -6.15381, 0.0623822], 0.837728],
	["Land_Wreck_Car2_F", [-0.244873, -9.31641, -0.042263], 308.13],
	["Land_Razorwire_F", [-0.29248, -10.4473, 0.116841], 1.21038],
	["I_HMG_01_high_F", [4.2, 6.6, 0], 0, { if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup }],
	["I_HMG_01_high_F", [-4.5, 6.6, 0], 0, { if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup }],
	["I_HMG_01_high_F", [-4.9, -6.5, 0], 180, { if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup }],
	["I_HMG_01_high_F", [4.1, -6.5, 0], 180, { if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup }]
]
