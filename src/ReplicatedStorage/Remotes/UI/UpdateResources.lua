-- UpdateResources.lua
-- RemoteEvent для обновления ресурсов игрока

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "UpdateResources"
RemoteEvent.Parent = ReplicatedStorage.Remotes.UI

return RemoteEvent