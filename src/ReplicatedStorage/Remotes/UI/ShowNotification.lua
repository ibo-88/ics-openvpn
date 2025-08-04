-- ShowNotification.lua
-- RemoteEvent для показа уведомлений игрокам

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "ShowNotification"
RemoteEvent.Parent = ReplicatedStorage.Remotes.UI

return RemoteEvent