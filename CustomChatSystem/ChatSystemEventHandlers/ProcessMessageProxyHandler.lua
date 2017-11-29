local cooldown		= 0;

_G.CustomChatSystemEvents["ProcessMessageProxy"].OnServerEvent:Connect(function(plr, message)
	wait(cooldown);
	_G.CustomChatSystemEvents["ProcessMessage"]:FireAllClients(plr, message);
	cooldown = 2;
	repeat
		cooldown = cooldown - 1;
		wait(1);
	until cooldown <= 0;
	cooldown = 0;
end)