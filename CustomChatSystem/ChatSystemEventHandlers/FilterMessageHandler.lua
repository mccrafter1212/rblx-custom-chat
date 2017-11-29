_G.CustomChatSystemEvents["FilterMessage"].OnServerInvoke = function(plr, message)
	return game:GetService("TextService"):FilterStringAsync(message, plr.UserId):GetNonChatStringForBroadcastAsync();
end