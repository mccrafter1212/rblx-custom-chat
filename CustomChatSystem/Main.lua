wait();

--// SERVICES
local PS				= game:GetService("Players");
local TS				= game:GetService("TextService");
local SG				= game:GetService("StarterGui");
local UIS				= game:GetService("UserInputService");
local RS				= game:GetService("ReplicatedStorage");

--// VARIABLES
local plr				= PS.LocalPlayer;
local plrGui			= plr:WaitForChild("PlayerGui");
local chatGui			= plrGui:WaitForChild("CustomChatGui");
local contentFrame		= chatGui:WaitForChild("ContentFrame");
local inputBox			= chatGui:WaitForChild("InputBox");

local chatLines			= {};
local yValue			= 0;
local currentLine		= 1;

--// CONSTANT VARIABLES
local specialChars		= {
	["1"] 	= "?";
	["2"] 	= "?";
	["3"] 	= "?";
	["4"] 	= "?";
	["5"] 	= "?";
	["6"] 	= "?";
	["7"] 	= "•";
	["8"] 	= "?";
	["9"] 	= "?";
	["10"] 	= "?";
	["11"] 	= "?";
	["12"] 	= "?";
	["13"] 	= "?";
	["14"] 	= "?";
	["15"] 	= "?";
	["16"] 	= "?";
	["17"]	= "?";
	["18"]	= "?";
	["19"]	= "?";
	["20"]	= "¶";
	["21"]	= "§";
	["22"]	= "?";
	["23"]	= "?";
	["24"]	= "?";
	["25"]	= "?";
	["26"]	= "?";
	["27"]	= "?";
	["28"]	= "?";
	["29"]	= "?";
	["30"]	= "?";
	["31"] 	= "?";
	["33"] 	= "!";
	["35"] 	= "#";
	["36"] 	= "$";
	["37"] 	= "%";
	["38"] 	= "&";
	["39"] 	= "'";
	["40"] 	= "(";
	["41"] 	= ")";
	["42"] 	= "*";
	["43"] 	= "+";
	["44"] 	= ",";
	["45"] 	= "-";
	["46"] 	= ".";
	["47"]	= "/";
	["174"] = "«";
	["175"] = "»";
	["176"] = "?";
	["177"] = "?";
	["178"] = "?";
	["243"] = "?";
};

local config			= require(script:WaitForChild("Configuration"));

local events			= RS:WaitForChild("ChatSystemEvents");
local sendSystemMsg		= events:WaitForChild("SendSystemMessage");
local processMsg		= events:WaitForChild("ProcessMessage");
local processMsgProxy	= events:WaitForChild("ProcessMessageProxy");
local filterMsg			= events:WaitForChild("FilterMessage");
local msgPosted			= events:WaitForChild("MessagePosted");

--// FUNCTIONS
local function newChatLine(fromPlr, message)
	
	if (currentLine > 10) then
		currentLine = 1;
		for _, line in pairs(contentFrame:GetChildren()) do
			for _, lineObj in pairs(line:GetChildren()) do
				lineObj:TweenPosition(UDim2.new(-1, 0, 0, lineObj.Position.Y.Offset), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25);
			end
			wait();
			line:Destroy();
		end
		yValue		= 0;
	end
	
	local chatLine 			= Instance.new("Folder");
	chatLine.Name			= "Line" .. tostring(currentLine);
	chatLine.Parent			= contentFrame;
	
	local x					= 2;
	
	local tagsTable			= {};
	if (config.TagMembers[fromPlr.Name] ~= nil) then
		for _, plrTagName in pairs(config.TagMembers[fromPlr.Name]) do
			for tagName, tag in pairs(config.Tags) do
				if (tagName == plrTagName) then
					table.insert(tagsTable, tag);
				end
			end
		end
	end
	
	local tagFrameSize = Vector2.new(0,20);
	
	for _, tag in pairs(tagsTable) do
		local textSize					= TS:GetTextSize(tag.Properties.Text, 20, config.Font, tagFrameSize);
		
		local tagLabel					= Instance.new("TextLabel", chatLine);
		tagLabel.Text					= tag.Properties.Text;
		tagLabel.BackgroundColor3		= tag.Properties.Color;
		tagLabel.Size					= UDim2.new(0, textSize.X, 0, textSize.Y);
		tagLabel.Position				= UDim2.new(-1, x, 0, yValue);
		tagLabel.BorderSizePixel		= 0;
		tagLabel.TextColor3				= Color3.fromRGB(255,255,255);
		tagLabel.Font					= tag.Properties.Font or config.Font;
		tagLabel.TextSize				= 15;
		tagLabel.ZIndex					= 2;
		tagLabel.Name					= "Tag-" .. tag.Properties.Text;
		
		local shadow					= Instance.new("Frame", tagLabel);
		shadow.Size						= UDim2.new(1, 0, 1, 0);
		shadow.Position					= UDim2.new(0, 2, 0, 2);
		shadow.BackgroundColor3			= Color3.fromRGB(80,80,80);
		shadow.BorderSizePixel			= 0;				
		shadow.Name						= "Shadow";
		
		tagLabel:TweenPosition(UDim2.new(0, x, 0, yValue), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
		x								= x + tagLabel.Size.X.Offset + 10;
	end
	
	local plrLabelTS					= TS:GetTextSize(fromPlr.Name, 20, config.Font, tagFrameSize);
	
	local plrLabel						= Instance.new("TextLabel", chatLine);
	plrLabel.Text						= fromPlr.Name;
	plrLabel.BackgroundColor3			= config.PlayerLabelColor;
	plrLabel.Size						= UDim2.new(0, plrLabelTS.X, 0, plrLabelTS.Y);
	plrLabel.Position					= UDim2.new(-1, x, 0, yValue);
	plrLabel.BorderSizePixel			= 0;
	plrLabel.TextColor3					= Color3.fromRGB(255,255,255);
	plrLabel.Font						= config.PlayerLabelFont or config.Font;
	plrLabel.TextSize					= 15;
	plrLabel.ZIndex						= 2;
	plrLabel.Name						= "PlayerLabel";
	
	local shadow						= Instance.new("Frame", plrLabel);
	shadow.Size							= UDim2.new(1, 0, 1, 0);
	shadow.Position						= UDim2.new(0, 2, 0, 2);
	shadow.BackgroundColor3				= Color3.fromRGB(80,80,80);
	shadow.BorderSizePixel				= 0;				
	shadow.Name							= "Shadow";
	
	plrLabel:TweenPosition(UDim2.new(0, x, 0, yValue), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
	x									= x + plrLabel.Size.X.Offset + 10;
	
	local msgFrameSize					= Vector2.new(0, 20);
	local msgTextSize					= TS:GetTextSize(" " .. message, 20, config.Font, msgFrameSize);
	
	local messageLabel					= Instance.new("TextLabel", chatLine);
	messageLabel.Text					= " " .. filterMsg:InvokeServer(message);
	messageLabel.BackgroundTransparency = 0;
	messageLabel.BackgroundColor3		= Color3.fromRGB(255, 255, 255);
	messageLabel.Size					= UDim2.new(0, msgTextSize.X, 0, msgTextSize.Y);
	messageLabel.Position				= UDim2.new(-1, x, 0, yValue);
	messageLabel.BorderSizePixel		= 0;
	messageLabel.TextColor3				= Color3.fromRGB(80,80,80);
	messageLabel.TextXAlignment			= Enum.TextXAlignment.Left;
	messageLabel.Font					= config.MessageFont or config.Font;
	messageLabel.TextSize				= 15;
	messageLabel.ZIndex					= 2;
	messageLabel.Name					= "MessageLabel";
	
	local shadow						= Instance.new("Frame", messageLabel);
	shadow.Size							= UDim2.new(1, 0, 1, 0);
	shadow.Position						= UDim2.new(0, 2, 0, 2);
	shadow.BackgroundColor3				= Color3.fromRGB(80,80,80);
	shadow.BorderSizePixel				= 0;
	shadow.Name							= "Shadow";
	
	messageLabel:TweenPosition(UDim2.new(0, x, 0, yValue), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
	x									= x + messageLabel.Size.X.Offset;

	currentLine							= currentLine + 1;
	yValue								= yValue + 30;
	
	if (config.AltCodes) then
		for usageNumber, specialChar in pairs(specialChars) do
			if (string.find(message, config.AltCodeTrigger .. usageNumber) ~= nil) then
				local a, b = string.find(message, config.AltCodeTrigger .. usageNumber);
				if (message:sub(b + 1, b + 1) == " " or message:sub(b + 1, b + 1) == "") then
					local val, count = string.gsub(message, config.AltCodeTrigger .. usageNumber, specialChar);
					message = val;
				end
			end
		end
	end
	
	messageLabel.Text					= " " .. filterMsg:InvokeServer(message);
	
	return chatLine;
end

local function newSystemMessage(message)
	
	if (currentLine > 10) then
		currentLine = 1;
		for _, line in pairs(contentFrame:GetChildren()) do
			for _, lineObj in pairs(line:GetChildren()) do
				lineObj:TweenPosition(UDim2.new(-1, 0, 0, lineObj.Position.Y.Offset), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.25);
			end
			wait();
			line:Destroy();
		end
		yValue		= 0;
	end
	
	local chatLine 			= Instance.new("Folder");
	chatLine.Name			= "Line" .. tostring(currentLine);
	chatLine.Parent			= contentFrame;
	
	local x					= 2;
	
	local tagFrameSize					= Vector2.new(0, 20);
	
	local plrLabelTS					= TS:GetTextSize("System", 20, config.Font, tagFrameSize);
	
	local plrLabel						= Instance.new("TextLabel", chatLine);
	plrLabel.Text						= "System";
	plrLabel.BackgroundColor3			= Color3.fromRGB(104, 130, 158);
	plrLabel.Size						= UDim2.new(0, plrLabelTS.X, 0, plrLabelTS.Y);
	plrLabel.Position					= UDim2.new(-1, x, 0, yValue);
	plrLabel.BorderSizePixel			= 0;
	plrLabel.TextColor3					= Color3.fromRGB(255,255,255);
	plrLabel.Font						= config.PlayerLabelFont or config.Font;
	plrLabel.TextSize					= 15;
	plrLabel.ZIndex						= 2;
	plrLabel.Name						= "PlayerLabel";
	
	local shadow						= Instance.new("Frame", plrLabel);
	shadow.Size							= UDim2.new(1, 0, 1, 0);
	shadow.Position						= UDim2.new(0, 2, 0, 2);
	shadow.BackgroundColor3				= Color3.fromRGB(80,80,80);
	shadow.BorderSizePixel				= 0;				
	shadow.Name							= "Shadow";
	
	plrLabel:TweenPosition(UDim2.new(0, x, 0, yValue), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
	x									= x + plrLabel.Size.X.Offset + 10;
	
	local msgFrameSize					= Vector2.new(0, 20);
	local msgTextSize					= TS:GetTextSize(" " .. message, 20, config.Font, msgFrameSize);
	
	local messageLabel					= Instance.new("TextLabel", chatLine);
	messageLabel.Text					= " " .. message;
	messageLabel.BackgroundTransparency = 0;
	messageLabel.BackgroundColor3		= Color3.fromRGB(255, 255, 255);
	messageLabel.Size					= UDim2.new(0, msgTextSize.X, 0, msgTextSize.Y);
	messageLabel.Position				= UDim2.new(-1, x, 0, yValue);
	messageLabel.BorderSizePixel		= 0;
	messageLabel.TextColor3				= Color3.fromRGB(80, 81, 96);
	messageLabel.TextXAlignment			= Enum.TextXAlignment.Left;
	messageLabel.Font					= config.MessageFont or config.Font;
	messageLabel.TextSize				= 15;
	messageLabel.ZIndex					= 2;
	messageLabel.Name					= "MessageLabel";
	
	local shadow						= Instance.new("Frame", messageLabel);
	shadow.Size							= UDim2.new(1, 0, 1, 0);
	shadow.Position						= UDim2.new(0, 2, 0, 2);
	shadow.BackgroundColor3				= Color3.fromRGB(80,80,80);
	shadow.BorderSizePixel				= 0;
	shadow.Name							= "Shadow";
	
	messageLabel:TweenPosition(UDim2.new(0, x, 0, yValue), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5);
	x									= x + messageLabel.Size.X.Offset;

	currentLine							= currentLine + 1;
	yValue								= yValue + 30;
	
	if (config.AltCodes) then
		for usageNumber, specialChar in pairs(specialChars) do
			if (string.find(message, config.AltCodeTrigger .. usageNumber) ~= nil) then
				local a, b = string.find(message, config.AltCodeTrigger .. usageNumber);
				if (message:sub(b + 1, b + 1) == " " or message:sub(b + 1, b + 1) == "") then
					local val, count = string.gsub(message, config.AltCodeTrigger .. usageNumber, specialChar);
					message = val;
				end
			end
		end
	end
	
	messageLabel.Text					= " " .. filterMsg:InvokeServer(message);
	
	return chatLine;
end

--// CODE
SG:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
SG:SetCore("CoreGuiChatConnections", {ChatWindow = {MessagePosted = msgPosted}});

UIS.InputBegan:Connect(function(key, gpe)
	if (not gpe) then
		if (key.KeyCode == Enum.KeyCode.Slash) then
			inputBox.Parent = chatGui;
			inputBox.Position = UDim2.new(0,0,1,0);
			inputBox.Visible = true;
			
			inputBox:TweenPosition(UDim2.new(0,0,0.975,0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1);
			inputBox:CaptureFocus();
		end
	end
end)

inputBox.FocusLost:Connect(function(enterPressed, keyFocus)
	if (enterPressed) then
		if (inputBox.Text:sub(1,3) ~= "/e ") then
			wait();
			processMsgProxy:FireServer(inputBox.Text);
			msgPosted:Fire(inputBox.Text);
		end
		inputBox.Position = UDim2.new(0,0,0.975,0);
		inputBox.Visible = true;
		inputBox:TweenPosition(UDim2.new(0,0,1,0), Enum.EasingDirection.Out, Enum.EasingStyle.Linear, 0.1);
	end
end)

sendSystemMsg.OnClientEvent:Connect(function(msg)
	wait();
	newSystemMessage(msg);
end)

processMsg.OnClientEvent:Connect(function(fromPlayer, msg)
	if (msg ~= "" and msg ~= " " and msg ~= "  ") then
		wait();
		newChatLine(fromPlayer, msg);
	end
end)