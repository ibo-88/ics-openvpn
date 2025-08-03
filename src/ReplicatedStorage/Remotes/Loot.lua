-- Loot Remotes
-- Remote Events для системы лута

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Создание папки для Remote Events лута
local LootRemotes = Instance.new("Folder")
LootRemotes.Name = "Loot"
LootRemotes.Parent = Remotes

-- Remote Events для лута
local GenerateLoot = Instance.new("RemoteEvent")
GenerateLoot.Name = "GenerateLoot"
GenerateLoot.Parent = LootRemotes

local CollectLoot = Instance.new("RemoteEvent")
CollectLoot.Name = "CollectLoot"
CollectLoot.Parent = LootRemotes

local GetLootInfo = Instance.new("RemoteEvent")
GetLootInfo.Name = "GetLootInfo"
GetLootInfo.Parent = LootRemotes

local GetRareEvents = Instance.new("RemoteEvent")
GetRareEvents.Name = "GetRareEvents"
GetRareEvents.Parent = LootRemotes

local GetLunarPhase = Instance.new("RemoteEvent")
GetLunarPhase.Name = "GetLunarPhase"
GetLunarPhase.Parent = LootRemotes

local GetLootHistory = Instance.new("RemoteEvent")
GetLootHistory.Name = "GetLootHistory"
GetLootHistory.Parent = LootRemotes

local GetLootStatistics = Instance.new("RemoteEvent")
GetLootStatistics.Name = "GetLootStatistics"
GetLootStatistics.Parent = LootRemotes

local GetLootAchievements = Instance.new("RemoteEvent")
GetLootAchievements.Name = "GetLootAchievements"
GetLootAchievements.Parent = LootRemotes

local GetLootLeaderboard = Instance.new("RemoteEvent")
GetLootLeaderboard.Name = "GetLootLeaderboard"
GetLootLeaderboard.Parent = LootRemotes

local GetLootEvents = Instance.new("RemoteEvent")
GetLootEvents.Name = "GetLootEvents"
GetLootEvents.Parent = LootRemotes

local GetLootRewards = Instance.new("RemoteEvent")
GetLootRewards.Name = "GetLootRewards"
GetLootRewards.Parent = LootRemotes

local GetLootSettings = Instance.new("RemoteEvent")
GetLootSettings.Name = "GetLootSettings"
GetLootSettings.Parent = LootRemotes

local UpdateLootSettings = Instance.new("RemoteEvent")
UpdateLootSettings.Name = "UpdateLootSettings"
UpdateLootSettings.Parent = LootRemotes

print("[Loot Remotes] Loot Remote Events created successfully!")