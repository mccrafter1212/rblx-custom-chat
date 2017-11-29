--//
																																																																												--[[
	Thanks for using AstrealDev's Custom Chat System
	
	This is the Configuration file where you can edit a bunch of settings
	to truly make your chat custom. You can edit colors, tags, filtering,
	and much more.
	
	This is licensed under the Apache 2.0 license meaning you may
	freely distribute this ALTHOUGH you must give the proper creator
	(AstrealDev), credit to the original.
	
	Instructions:
	1) Place CustomChatSystem folder into ServerScriptService
	2) You're done! Just edit this script if you want.
--//																																																																												]]

return {
	--// When true text will be filtered to prevent a violation of ROBLOXs Terms of Service
	--// NOTE: Don't ever turn false as ROBLOX will most likely put your game under review.
	["FilterText"] 					= true;
	["Tags"] 						= {
		--// Add any tags you want into here.
		["Dev"] 					= {
			["Properties"]			= {
				Color 				= Color3.fromRGB(193, 96, 96);
				Text				= "Dev";
				Font				= Enum.Font.SciFi;
			};
			--// You can set members of this tag below in the TagMembers table
		};
		["Tulak Hord"]				= {
			["Properties"]			= {
				Color 				= Color3.fromRGB(213, 115, 61);
				Text				= "Tulak Hord";
				Font				= Enum.Font.SciFi;
			};
		};
		["Emperor"]					= {
			["Properties"]			= {
				Color 				= Color3.fromRGB(117, 0, 0);
				Text				= "Emperor";
				Font				= Enum.Font.SciFi;
			};
		};
		["Powerbase"]				= {
			["Properties"]			= {
				Color 				= Color3.fromRGB(123, 47, 123);
				Text				= "Powerbase";
				Font				= Enum.Font.SciFi;
			};
		};
	};
	--// Are alt codes enabled?
	["AltCodes"] 					= true;
	--// What string should be checked for in a message to trigger alt code characters
	--// Example: Typing @1 would turn into ?, typing @2 would turn into ?, typing @3 would turn into ?, etc.
	["AltCodeTrigger"]				= "@";
	--// The table that contains who has what tag
	["TagMembers"]					= {
		["AstrealDev"]				= {
			"Dev";
		};
		["Player1"]					= {
			"Dev";
		};
		["ThomasStukov"]			= {
			"Emperor";
		};
		["Zraktovian"]				= {
			"Tulak Hord";
		};
		["DanielStukov"]			= {
			"Tulak Hord";
		};
		["JT_zx"]					= {
			"Powerbase";
		};
	};
	--// Message font
	["MessageFont"]					= Enum.Font.SciFi;
	--// Player label font
	["PlayerLabelFont"]				= Enum.Font.SciFi;
	--// Player label color 
	["PlayerLabelColor"]			= Color3.fromRGB(155, 60, 34);
	--// The font used for everything
	["Font"]						= Enum.Font.SciFi;
};