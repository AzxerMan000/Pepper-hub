local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Create GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "RGBJobIDTool"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 320, 0, 160)
Frame.Position = UDim2.new(0.5, -160, 0.5, -80)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundTransparency = 1
Title.Text = "JOB ID TOOL"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26

-- RGB animated title
coroutine.wrap(function()
	local t = 0
	while true do
		t += 1
		local r = math.sin(t / 30) * 127 + 128
		local g = math.sin(t / 30 + 2) * 127 + 128
		local b = math.sin(t / 30 + 4) * 127 + 128
		Title.TextColor3 = Color3.fromRGB(r, g, b)
		RunService.RenderStepped:Wait()
	end
end)()

local JobIdBox = Instance.new("TextBox", Frame)
JobIdBox.Position = UDim2.new(0, 10, 0, 45)
JobIdBox.Size = UDim2.new(1, -20, 0, 35)
JobIdBox.Text = game.JobId
JobIdBox.TextColor3 = Color3.new(1, 1, 1)
JobIdBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
JobIdBox.ClearTextOnFocus = false
JobIdBox.Font = Enum.Font.Gotham
JobIdBox.TextSize = 18

local JobCorner = Instance.new("UICorner", JobIdBox)
JobCorner.CornerRadius = UDim.new(0, 8)

local CopyButton = Instance.new("TextButton", Frame)
CopyButton.Position = UDim2.new(0, 10, 0, 90)
CopyButton.Size = UDim2.new(0.45, -15, 0, 35)
CopyButton.Text = " COPY"
CopyButton.Font = Enum.Font.GothamBold
CopyButton.TextSize = 18
CopyButton.TextColor3 = Color3.new(1, 1, 1)
CopyButton.BackgroundColor3 = Color3.fromRGB(40, 120, 40)

local CopyCorner = Instance.new("UICorner", CopyButton)
CopyCorner.CornerRadius = UDim.new(0, 8)

local TeleportButton = Instance.new("TextButton", Frame)
TeleportButton.Position = UDim2.new(0.55, 5, 0, 90)
TeleportButton.Size = UDim2.new(0.45, -15, 0, 35)
TeleportButton.Text = "TELEPORT"
TeleportButton.Font = Enum.Font.GothamBold
TeleportButton.TextSize = 18
TeleportButton.TextColor3 = Color3.new(1, 1, 1)
TeleportButton.BackgroundColor3 = Color3.fromRGB(120, 40, 40)

local TeleCorner = Instance.new("UICorner", TeleportButton)
TeleCorner.CornerRadius = UDim.new(0, 8)

-- Clipboard
CopyButton.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(game.JobId)
	else
		JobIdBox.Text = "Clipboard not supported!"
	end
end)

-- Teleport
TeleportButton.MouseButton1Click:Connect(function()
	local targetJobId = JobIdBox.Text
	if targetJobId and targetJobId ~= "" then
		TeleportService:TeleportToPlaceInstance(game.PlaceId, targetJobId, player)
	end
end)
