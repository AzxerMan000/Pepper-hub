--// Services
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

--// Variables
local player = Players.LocalPlayer
local placeId = game.PlaceId
local jobId = game.JobId
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = "ServerHopGUI"
gui.ResetOnSpawn = false

--// UI Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 180)
frame.Position = UDim2.new(0.5, -150, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = true

--// Rainbow Title
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = " Server Hopper "
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 0, 0)

--// Server Info
local serverInfo = Instance.new("TextLabel", frame)
serverInfo.Size = UDim2.new(1, -20, 0, 60)
serverInfo.Position = UDim2.new(0, 10, 0, 50)
serverInfo.TextWrapped = true
serverInfo.Font = Enum.Font.Code
serverInfo.TextSize = 16
serverInfo.BackgroundTransparency = 1
serverInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
serverInfo.Text = string.format("Job ID:\n%s\nPlayers: %d/%d", jobId, #Players:GetPlayers(), game.Players.MaxPlayers)

--// Hop Button
local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(0.8, 0, 0, 40)
hopBtn.Position = UDim2.new(0.1, 0, 1, -50)
hopBtn.Text = "Hop Server"
hopBtn.Font = Enum.Font.GothamMedium
hopBtn.TextSize = 18
hopBtn.TextColor3 = Color3.new(1,1,1)
hopBtn.BackgroundColor3 = Color3.fromRGB(80, 170, 255)
hopBtn.BorderSizePixel = 0
hopBtn.AutoButtonColor = true

--// Rainbow Title Tweening
task.spawn(function()
	while true do
		for hue = 0, 1, 0.01 do
			title.TextColor3 = Color3.fromHSV(hue, 1, 1)
			task.wait(0.03)
		end
	end
end)

--// Hop Button Logic
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
		hopBtn.Text = "❌ No servers found!"
	end
end

hopBtn.MouseButton1Click:Connect(hopServer)
