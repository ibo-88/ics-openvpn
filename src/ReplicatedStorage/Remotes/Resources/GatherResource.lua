-- GatherResource.lua
-- RemoteEvent для сбора ресурсов

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "GatherResource"
RemoteEvent.Parent = ReplicatedStorage.Remotes.Resources

return RemoteEvent