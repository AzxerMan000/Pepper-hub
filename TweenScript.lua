-- Black Themed GUI with "Tp Base" Button and Fly to Spawn Functionality

-- Load external script from Pastefy
loadstring(game:HttpGet("https://pastefy.app/5CxQD7nl/raw"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Wait for character and get HumanoidRootPart
local function getCharacter()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart")
end

-- Save spawn position when joining
local rootPart = getCharacter()
local savedSpawnPosition = rootPart.Position

-- GUI Setup
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TpBaseGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Background Frame (optional for style)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 200, 0, 100)
mainFrame.Position = UDim2.new(0.5, -100, 0.75, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- black background
mainFrame.BorderSizePixel = 0
mainFrame.Draggable = true
mainFrame.Active = true
mainFrame.Parent = screenGui

-- UI Corner for curve
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Button
local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 160, 0, 40)
button.Position = UDim2.new(0.5, -80, 0.5, -20)
button.Text = "Tp Base"
button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.BorderSizePixel = 0
button.Parent = mainFrame

-- UI Corner for Button
local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = button

-- Fly function
local function flyTo(position, speed)
	local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")
	local flying = true

	local connection
	connection = RunService.RenderStepped:Connect(function()
		if not flying then
			connection:Disconnect()
			return
		end
		local currentPos = root.Position
		local direction = (position - currentPos)
		if direction.Magnitude < 2 then
			flying = false
			connection:Disconnect()
			return
		end
		local step = direction.Unit * speed * RunService.RenderStepped:Wait()
		root.Velocity = Vector3.zero
		root.CFrame = root.CFrame + step
	end)
end

-- Button Click
button.MouseButton1Click:Connect(function()
	flyTo(savedSpawnPosition + Vector3.new(0, 5, 0), 80) -- speed = 45
end)
