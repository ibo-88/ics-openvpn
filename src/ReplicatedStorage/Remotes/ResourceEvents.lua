-- ResourceEvents.lua
-- Remote Events для системы ресурсов и строительства

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Создание папки для Resource Remote Events
local resourceFolder = Instance.new("Folder")
resourceFolder.Name = "Resources"
resourceFolder.Parent = ReplicatedStorage.Remotes

-- Remote Events для ресурсов
local GatherResource = Instance.new("RemoteEvent")
GatherResource.Name = "GatherResource"
GatherResource.Parent = resourceFolder

local ResourceGathered = Instance.new("RemoteEvent")
ResourceGathered.Name = "ResourceGathered"
ResourceGathered.Parent = resourceFolder

local ResourceDepleted = Instance.new("RemoteEvent")
ResourceDepleted.Name = "ResourceDepleted"
ResourceDepleted.Parent = resourceFolder

local ResourceSpawned = Instance.new("RemoteEvent")
ResourceSpawned.Name = "ResourceSpawned"
ResourceSpawned.Parent = resourceFolder

local UpdateInventory = Instance.new("RemoteEvent")
UpdateInventory.Name = "UpdateInventory"
UpdateInventory.Parent = resourceFolder

-- Remote Events для строительства
local BuildStructure = Instance.new("RemoteEvent")
BuildStructure.Name = "BuildStructure"
BuildStructure.Parent = resourceFolder

local StructureBuilt = Instance.new("RemoteEvent")
StructureBuilt.Name = "StructureBuilt"
StructureBuilt.Parent = resourceFolder

local StructureDestroyed = Instance.new("RemoteEvent")
StructureDestroyed.Name = "StructureDestroyed"
StructureDestroyed.Parent = resourceFolder

local StructureDamaged = Instance.new("RemoteEvent")
StructureDamaged.Name = "StructureDamaged"
StructureDamaged.Parent = resourceFolder

local StructureRepaired = Instance.new("RemoteEvent")
StructureRepaired.Name = "StructureRepaired"
StructureRepaired.Parent = resourceFolder

local BuildPreview = Instance.new("RemoteEvent")
BuildPreview.Name = "BuildPreview"
BuildPreview.Parent = resourceFolder

local BuildCancel = Instance.new("RemoteEvent")
BuildCancel.Name = "BuildCancel"
BuildCancel.Parent = resourceFolder

local BuildMode = Instance.new("RemoteEvent")
BuildMode.Name = "BuildMode"
BuildMode.Parent = resourceFolder

local DemolishStructure = Instance.new("RemoteEvent")
DemolishStructure.Name = "DemolishStructure"
DemolishStructure.Parent = resourceFolder

local UpgradeStructure = Instance.new("RemoteEvent")
UpgradeStructure.Name = "UpgradeStructure"
UpgradeStructure.Parent = resourceFolder

local StructureUpgraded = Instance.new("RemoteEvent")
StructureUpgraded.Name = "StructureUpgraded"
StructureUpgraded.Parent = resourceFolder

local RotateStructure = Instance.new("RemoteEvent")
RotateStructure.Name = "RotateStructure"
RotateStructure.Parent = resourceFolder

local MoveStructure = Instance.new("RemoteEvent")
MoveStructure.Name = "MoveStructure"
MoveStructure.Parent = resourceFolder

local StructureMoved = Instance.new("RemoteEvent")
StructureMoved.Name = "StructureMoved"
StructureMoved.Parent = resourceFolder

local BuildLimit = Instance.new("RemoteEvent")
BuildLimit.Name = "BuildLimit"
BuildLimit.Parent = resourceFolder

local BuildArea = Instance.new("RemoteEvent")
BuildArea.Name = "BuildArea"
BuildArea.Parent = resourceFolder

local BuildableStructures = Instance.new("RemoteEvent")
BuildableStructures.Name = "BuildableStructures"
BuildableStructures.Parent = resourceFolder

local StructureInfo = Instance.new("RemoteEvent")
StructureInfo.Name = "StructureInfo"
StructureInfo.Parent = resourceFolder

local BuildCost = Instance.new("RemoteEvent")
BuildCost.Name = "BuildCost"
BuildCost.Parent = resourceFolder

local InsufficientResources = Instance.new("RemoteEvent")
InsufficientResources.Name = "InsufficientResources"
InsufficientResources.Parent = resourceFolder

local ResourceCost = Instance.new("RemoteEvent")
ResourceCost.Name = "ResourceCost"
ResourceCost.Parent = resourceFolder

local ResourceEarned = Instance.new("RemoteEvent")
ResourceEarned.Name = "ResourceEarned"
ResourceEarned.Parent = resourceFolder

local ResourceSpent = Instance.new("RemoteEvent")
ResourceSpent.Name = "ResourceSpent"
ResourceSpent.Parent = resourceFolder

print("[Resource Events] Created 28 Remote Events")

return resourceFolder