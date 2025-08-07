-- UIEvents.lua
-- Remote Events для UI системы

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание папки для UI Remote Events
local uiFolder = Instance.new("Folder")
uiFolder.Name = "UI"
uiFolder.Parent = ReplicatedStorage.Remotes

-- Основные Remote Events
local ShowNotification = Instance.new("RemoteEvent")
ShowNotification.Name = "ShowNotification"
ShowNotification.Parent = uiFolder

local UpdateUI = Instance.new("RemoteEvent")
UpdateUI.Name = "UpdateUI"
UpdateUI.Parent = uiFolder

local SelectClass = Instance.new("RemoteEvent")
SelectClass.Name = "SelectClass"
SelectClass.Parent = uiFolder

local ShowMainMenu = Instance.new("RemoteEvent")
ShowMainMenu.Name = "ShowMainMenu"
ShowMainMenu.Parent = uiFolder

local ShowGameHUD = Instance.new("RemoteEvent")
ShowGameHUD.Name = "ShowGameHUD"
ShowGameHUD.Parent = uiFolder

local UpdateHealth = Instance.new("RemoteEvent")
UpdateHealth.Name = "UpdateHealth"
UpdateHealth.Parent = uiFolder

local UpdateResources = Instance.new("RemoteEvent")
UpdateResources.Name = "UpdateResources"
UpdateResources.Parent = uiFolder

local UpdateAbilities = Instance.new("RemoteEvent")
UpdateAbilities.Name = "UpdateAbilities"
UpdateAbilities.Parent = uiFolder

local ShowInventory = Instance.new("RemoteEvent")
ShowInventory.Name = "ShowInventory"
ShowInventory.Parent = uiFolder

local ShowShop = Instance.new("RemoteEvent")
ShowShop.Name = "ShowShop"
ShowShop.Parent = uiFolder

local ShowSettings = Instance.new("RemoteEvent")
ShowSettings.Name = "ShowSettings"
ShowSettings.Parent = uiFolder

local ShowAchievements = Instance.new("RemoteEvent")
ShowAchievements.Name = "ShowAchievements"
ShowAchievements.Parent = uiFolder

local ShowBuildMenu = Instance.new("RemoteEvent")
ShowBuildMenu.Name = "ShowBuildMenu"
ShowBuildMenu.Parent = uiFolder

local UpdateWaveInfo = Instance.new("RemoteEvent")
UpdateWaveInfo.Name = "UpdateWaveInfo"
UpdateWaveInfo.Parent = uiFolder

local LevelUp = Instance.new("RemoteEvent")
LevelUp.Name = "LevelUp"
LevelUp.Parent = uiFolder

local ShowLootDrop = Instance.new("RemoteEvent")
ShowLootDrop.Name = "ShowLootDrop"
ShowLootDrop.Parent = uiFolder

local CraftingComplete = Instance.new("RemoteEvent")
CraftingComplete.Name = "CraftingComplete"
CraftingComplete.Parent = uiFolder

local AchievementUnlocked = Instance.new("RemoteEvent")
AchievementUnlocked.Name = "AchievementUnlocked"
AchievementUnlocked.Parent = uiFolder

print("[UI Events] Created 18 Remote Events")

return uiFolder