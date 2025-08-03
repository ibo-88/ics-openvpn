-- BuildStructure.lua
-- RemoteEvent для строительства

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "BuildStructure"
RemoteEvent.Parent = ReplicatedStorage.Remotes.Building

return RemoteEvent