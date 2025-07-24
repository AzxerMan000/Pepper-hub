local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local function rejoin()
    local player = Players.LocalPlayer
    TeleportService:Teleport(game.PlaceId, player)
end

rejoin() 
