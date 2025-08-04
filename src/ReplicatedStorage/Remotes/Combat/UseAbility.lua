-- UseAbility.lua
-- RemoteEvent для использования способностей

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemoteEvent = Instance.new("RemoteEvent")
RemoteEvent.Name = "UseAbility"
RemoteEvent.Parent = ReplicatedStorage.Remotes.Combat

return RemoteEvent