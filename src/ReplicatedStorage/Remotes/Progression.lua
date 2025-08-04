-- Progression Remotes
-- Remote Events для системы прогрессии

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

-- Создание папки для Remote Events прогрессии
local ProgressionRemotes = Instance.new("Folder")
ProgressionRemotes.Name = "Progression"
ProgressionRemotes.Parent = Remotes

-- Remote Events для прогрессии
local GetProgress = Instance.new("RemoteEvent")
GetProgress.Name = "GetProgress"
GetProgress.Parent = ProgressionRemotes

local AddExperience = Instance.new("RemoteEvent")
AddExperience.Name = "AddExperience"
AddExperience.Parent = ProgressionRemotes

local LevelUp = Instance.new("RemoteEvent")
LevelUp.Name = "LevelUp"
LevelUp.Parent = ProgressionRemotes

local GetSkillTrees = Instance.new("RemoteEvent")
GetSkillTrees.Name = "GetSkillTrees"
GetSkillTrees.Parent = ProgressionRemotes

local PurchaseSkill = Instance.new("RemoteEvent")
PurchaseSkill.Name = "PurchaseSkill"
PurchaseSkill.Parent = ProgressionRemotes

local GetPrestigeInfo = Instance.new("RemoteEvent")
GetPrestigeInfo.Name = "GetPrestigeInfo"
GetPrestigeInfo.Parent = ProgressionRemotes

local PerformPrestige = Instance.new("RemoteEvent")
PerformPrestige.Name = "PerformPrestige"
PerformPrestige.Parent = ProgressionRemotes

local GetBattlePassInfo = Instance.new("RemoteEvent")
GetBattlePassInfo.Name = "GetBattlePassInfo"
GetBattlePassInfo.Parent = ProgressionRemotes

local PurchaseBattlePassPremium = Instance.new("RemoteEvent")
PurchaseBattlePassPremium.Name = "PurchaseBattlePassPremium"
PurchaseBattlePassPremium.Parent = ProgressionRemotes

local GetWaveRewards = Instance.new("RemoteEvent")
GetWaveRewards.Name = "GetWaveRewards"
GetWaveRewards.Parent = ProgressionRemotes

local GetExperienceToNextLevel = Instance.new("RemoteEvent")
GetExperienceToNextLevel.Name = "GetExperienceToNextLevel"
GetExperienceToNextLevel.Parent = ProgressionRemotes

local GetAvailableSkills = Instance.new("RemoteEvent")
GetAvailableSkills.Name = "GetAvailableSkills"
GetAvailableSkills.Parent = ProgressionRemotes

local GetPlayerStats = Instance.new("RemoteEvent")
GetPlayerStats.Name = "GetPlayerStats"
GetPlayerStats.Parent = ProgressionRemotes

local UpdateSkillEffects = Instance.new("RemoteEvent")
UpdateSkillEffects.Name = "UpdateSkillEffects"
UpdateSkillEffects.Parent = ProgressionRemotes

local GetPrestigeRewards = Instance.new("RemoteEvent")
GetPrestigeRewards.Name = "GetPrestigeRewards"
GetPrestigeRewards.Parent = ProgressionRemotes

local GetBattlePassRewards = Instance.new("RemoteEvent")
GetBattlePassRewards.Name = "GetBattlePassRewards"
GetBattlePassRewards.Parent = ProgressionRemotes

local GetSkillTreeProgress = Instance.new("RemoteEvent")
GetSkillTreeProgress.Name = "GetSkillTreeProgress"
GetSkillTreeProgress.Parent = ProgressionRemotes

local ResetSkillTree = Instance.new("RemoteEvent")
ResetSkillTree.Name = "ResetSkillTree"
ResetSkillTree.Parent = ProgressionRemotes

local GetPrestigeHistory = Instance.new("RemoteEvent")
GetPrestigeHistory.Name = "GetPrestigeHistory"
GetPrestigeHistory.Parent = ProgressionRemotes

local GetBattlePassHistory = Instance.new("RemoteEvent")
GetBattlePassHistory.Name = "GetBattlePassHistory"
GetBattlePassHistory.Parent = ProgressionRemotes

print("[Progression Remotes] Progression Remote Events created successfully!")