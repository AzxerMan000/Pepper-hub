--// Services
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local placeId = game.PlaceId
local jobId = game.JobId

--// GUI Setup
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ServerHopGUI"
gui.ResetOnSpawn = false

--// Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 320, 0, 200)
frame.Position = UDim2.new(0.5, -160, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

-- Rounded Corners
local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 10)

--// Close Button (X)
local closeBtn = Instance.new("TextButton", frame)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0, 5)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

--// Rainbow Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, -40, 0, 40)
title.Position = UDim2.new(0, 10, 0, 5)
title.Text = "Server Hopper"
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 0, 0)

-- Rainbow Title Animation
task.spawn(function()
	while true do
		for hue = 0, 1, 0.01 do
			title.TextColor3 = Color3.fromHSV(hue, 1, 1)
			task.wait(0.03)
		end
	end
end)

--// Server Info Label
local infoLabel = Instance.new("TextLabel", frame)
infoLabel.Size = UDim2.new(1, -20, 0, 60)
infoLabel.Position = UDim2.new(0, 10, 0, 50)
infoLabel.Font = Enum.Font.Code
infoLabel.TextSize = 16
infoLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
infoLabel.BackgroundTransparency = 1
infoLabel.TextWrapped = true
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.TextYAlignment = Enum.TextYAlignment.Top
infoLabel.Text = string.format("Job ID: %s\nPlayers: %d/%d", jobId, #Players:GetPlayers(), game.Players.MaxPlayers)

--// Hop Button
local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(0.8, 0, 0, 40)
hopBtn.Position = UDim2.new(0.1, 0, 1, -50)
hopBtn.Text = "Hop Server"
hopBtn.Font = Enum.Font.GothamMedium
hopBtn.TextSize = 18
hopBtn.TextColor3 = Color3.new(1, 1, 1)
hopBtn.BackgroundColor3 = Color3.fromRGB(80, 170, 255)
hopBtn.BorderSizePixel = 0
hopBtn.AutoButtonColor = true
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 8)

--// Hop Server Logic
local function hopServer()
	local servers = {}
	local cursor = ""
	local found = false

	while not found do
		local url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?limit=100&cursor=%s", placeId, cursor)
		local success, result = pcall(function()
			return HttpService:JSONDecode(game:HttpGet(url))
		end)

		if success and result and result.data then
			for _, server in pairs(result.data) do
				if server.id ~= jobId and server.playing < server.maxPlayers then
					table.insert(servers, server.id)
				end
			end
			cursor = result.nextPageCursor or ""
			if #servers > 0 or cursor == "" then
				found = true
			end
		else
			break
		end
	end

	if #servers > 0 then
		local randomServer = servers[math.random(1, #servers)]
		TeleportService:TeleportToPlaceInstance(placeId, randomServer, player)
	else
		hopBtn.Text = "No servers found"
	end
end

hopBtn.MouseButton1Click:Connect(hopServer)
