-- SelectClass.lua
-- RemoteEvent для выбора класса

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "SelectClass"
RemoteEvent.Parent = ReplicatedStorage.Remotes.UI

return RemoteEvent