-- WaveEnded.lua
-- RemoteEvent для уведомления о завершении волны

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "WaveEnded"
RemoteEvent.Parent = ReplicatedStorage.Remotes.UI

return RemoteEvent