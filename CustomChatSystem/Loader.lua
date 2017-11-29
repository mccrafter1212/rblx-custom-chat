--//
																																																																												--[[
	Thanks for using AstrealDev's Custom Chat System
	
	This is the Loader file which loads in everything needed
	for my Custom Chat System. No need to edit anything here :)
	
	This is licensed under the Apache 2.0 license meaning you may
	freely distribute this ALTHOUGH you must give the proper creator
	(AstrealDev), credit to the original.
	
--//																																																																												]]

local mainScript	= script.Parent:WaitForChild("Main");
local chatGui		= script.Parent:WaitForChild("CustomChatGui");
local eventsFolder	= script.Parent:WaitForChild("ChatSystemEvents");
local eventsHandler = script.Parent:WaitForChild("ChatSystemEventHandlers");

mainScript.Parent	= game:GetService("StarterPack");
mainScript.Disabled = false;

chatGui.Parent 		= game:GetService("StarterGui");
chatGui.Enabled		= true;

eventsFolder.Parent = game:GetService("ReplicatedStorage");
eventsHandler.Parent= game:GetService("ServerScriptService");

_G.CustomChatSystemEvents = {};

for _, event in pairs(eventsFolder:GetChildren()) do
	_G.CustomChatSystemEvents[event.Name] = event;
end

for _, scr in pairs(eventsHandler:GetChildren()) do
	scr.Disabled = false;
end

wait();

for _, player in pairs(game:GetService("Players"):GetPlayers()) do
	if (player:WaitForChild("Backpack"):FindFirstChild("Main") == nil) then
		local mainScriptClone 		= mainScript:Clone();
		mainScriptClone.Parent 		= player:FindFirstChild("Backpack");
		mainScriptClone.Disabled	= false;
	end
	
	if (player:WaitForChild("PlayerGui"):FindFirstChild("CustomChatGui") == nil) then
		local chatGuiClone			= chatGui:Clone();
		chatGuiClone.Parent			= player:FindFirstChild("PlayerGui");
		chatGuiClone.Enabled		= true;
	end
end

warn("[ChatSystem] - Loading complete.");