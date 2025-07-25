	local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local boostedSpeed = 50
local enforceConnection

local function enforceSpeed(humanoid)
	if enforceConnection then
		enforceConnection:Disconnect()
	end
	enforceConnection = RunService.Heartbeat:Connect(function()
		if humanoid and humanoid.WalkSpeed ~= boostedSpeed then
			humanoid.WalkSpeed = boostedSpeed
		end
	end)
	
	humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if humanoid.WalkSpeed ~= boostedSpeed then
			humanoid.WalkSpeed = boostedSpeed
		end
	end)
end

local function aktifkanSpeedBooster()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	enforceSpeed(humanoid)
end

player.CharacterAdded:Connect(function()
	aktifkanSpeedBooster()
end)

if player.Character then
	aktifkanSpeedBooster()
end
