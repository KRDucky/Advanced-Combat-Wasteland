// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: Banditpost2.sqf
//	@file Author: JoSchaap, AgentRev
//	@file Bandit Edit: GriffinZS

[
	// Class, Position, Direction, Init (optional)
	["CamoNet_INDP_open_F", [3.50317, 2.47949, 0], 325],
	["MetalBarrel_burning_F", [-4.50623, 2.23486, 0], 35],
	["Land_BagFence_01_long_green_F", [3.52722, 4.10938, 0], 90],
	["Land_Razorwire_F", [0.08623, 5.86182, 0], 180],
	["MetalBarrel_burning_F", [3.95813, -4.55029, 0], 210],
	["MetalBarrel_burning_F", [-3.84167, -4.69043, 0], 150],
	["Land_BagFence_01_long_green_F", [-4.8949, 3.82715, 0], 90],
	["Land_BagFence_01_long_green_F", [4.29211, -6.27881, 0], 90],
	["Land_BagFence_01_long_green_F", [-4.06665, -6.43359, 0], 90],
	["Land_Razorwire_F", [0.25195, -7.94873, 0], 180],
	["Land_BagBunker_01_small_green_F", [5.96436, 7.86963, 0], 180],
	["Box_IND_WpsSpecial_F", [-6.24817, 8.69141, 0], 180, { [_this, ["mission_USSpecial", "mission_Main_A3snipers"] call BIS_fnc_selectRandom] call fn_refillbox }],
	["Land_BagBunker_01_small_green_F", [-6.35974, 7.86914, 0], 180],
	["Land_BagBunker_01_small_green_F", [-6.06433, -10.0005, 0], 0],
	["Land_BagBunker_01_small_green_F", [6.27478, -9.8975, 0], 0],
	["Box_East_WpsSpecial_F", [6.26294, -10.02422, 0], 180, { [_this, "mission_USLaunchers"] call fn_refillbox }],
	["Land_HistoricalPlaneWreck_02_rear_F", [-11.583, -5.92871, 0], 135],
	["Land_StoneWall_01_s_10m_F", [-12.4873, 5.40869, 0], 315],
	["Land_StoneWall_01_s_10m_F", [10.9138, 4.86182, 0], 45],
	["Land_Wreck_Ural_F", [11.8104, -6.33154, 0], 225],
	["Land_Razorwire_F", [14.4102, -1.2915, 0], 270],
	["Land_Razorwire_F", [-15.6963, -0.902344, 0], 90],
	["Flag_Syndikat_F", [14.8219, 1.71777, 0], 85],
	["Flag_Syndikat_F", [-15.5142, -4.27295, 0], 275],
	["I_HMG_01_high_F", [6.15, 8.8, 0], 0, { if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup }],
	["I_HMG_01_high_F", [-6.25, -9.8, 0], 180, { if (random 1 < 0.5) exitWith { deleteVehicle _this }; [_this] call vehicleSetup }]
]
