local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local visitedServers = {}

local function serverHop()
	while true do
		local success, response = pcall(function()
			return HttpService:JSONDecode(game:HttpGet(
				("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=Asc&limit=100"):format(game.PlaceId)
			))
		end)

		if success and response and response.data then
			for _, server in pairs(response.data) do
				if server.playing < server.maxPlayers and server.id ~= game.JobId and not visitedServers[server.id] then
					visitedServers[server.id] = true
					TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, Players.LocalPlayer)
					return
				end
			end
		end

		wait(5) -- ⏱️ Wait 5 seconds before checking again
	end
end

-- serverHop() -- You can bind this to a GUI button
