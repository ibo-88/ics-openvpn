-- Greaves.lua
-- Модель поножей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGreaves()
    local model = Instance.new("Model")
    model.Name = "Greaves"
    
    -- Левый понож
    local leftGreave = Instance.new("Part")
    leftGreave.Name = "LeftGreave"
    leftGreave.Size = Vector3.new(0.6, 1.8, 0.3)
    leftGreave.Position = Vector3.new(-0.4, 0, 0)
    leftGreave.Anchored = true
    leftGreave.CanCollide = false
    leftGreave.Material = Enum.Material.Metal
    leftGreave.Color = Color3.fromRGB(105, 105, 105)
    leftGreave.Parent = model
    
    -- Правый понож
    local rightGreave = Instance.new("Part")
    rightGreave.Name = "RightGreave"
    rightGreave.Size = Vector3.new(0.6, 1.8, 0.3)
    rightGreave.Position = Vector3.new(0.4, 0, 0)
    rightGreave.Anchored = true
    rightGreave.CanCollide = false
    rightGreave.Material = Enum.Material.Metal
    rightGreave.Color = Color3.fromRGB(105, 105, 105)
    rightGreave.Parent = model
    
    -- Коленная защита левая
    local leftKnee = Instance.new("Part")
    leftKnee.Name = "LeftKnee"
    leftKnee.Size = Vector3.new(0.7, 0.4, 0.4)
    leftKnee.Position = Vector3.new(-0.4, 0.5, 0)
    leftKnee.Anchored = true
    leftKnee.CanCollide = false
    leftKnee.Material = Enum.Material.Metal
    leftKnee.Color = Color3.fromRGB(105, 105, 105)
    leftKnee.Parent = model
    
    -- Коленная защита правая
    local rightKnee = Instance.new("Part")
    rightKnee.Name = "RightKnee"
    rightKnee.Size = Vector3.new(0.7, 0.4, 0.4)
    rightKnee.Position = Vector3.new(0.4, 0.5, 0)
    rightKnee.Anchored = true
    rightKnee.CanCollide = false
    rightKnee.Material = Enum.Material.Metal
    rightKnee.Color = Color3.fromRGB(105, 105, 105)
    rightKnee.Parent = model
    
    -- Декоративные элементы
    local leftDecoration1 = Instance.new("Part")
    leftDecoration1.Name = "LeftDecoration1"
    leftDecoration1.Size = Vector3.new(0.1, 0.3, 0.1)
    leftDecoration1.Position = Vector3.new(-0.4, 0.8, 0.2)
    leftDecoration1.Anchored = true
    leftDecoration1.CanCollide = false
    leftDecoration1.Material = Enum.Material.Metal
    leftDecoration1.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration1.Parent = model
    
    local leftDecoration2 = Instance.new("Part")
    leftDecoration2.Name = "LeftDecoration2"
    leftDecoration2.Size = Vector3.new(0.1, 0.3, 0.1)
    leftDecoration2.Position = Vector3.new(-0.4, -0.8, 0.2)
    leftDecoration2.Anchored = true
    leftDecoration2.CanCollide = false
    leftDecoration2.Material = Enum.Material.Metal
    leftDecoration2.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration2.Parent = model
    
    local rightDecoration1 = Instance.new("Part")
    rightDecoration1.Name = "RightDecoration1"
    rightDecoration1.Size = Vector3.new(0.1, 0.3, 0.1)
    rightDecoration1.Position = Vector3.new(0.4, 0.8, 0.2)
    rightDecoration1.Anchored = true
    rightDecoration1.CanCollide = false
    rightDecoration1.Material = Enum.Material.Metal
    rightDecoration1.Color = Color3.fromRGB(255, 215, 0)
    rightDecoration1.Parent = model
    
    local rightDecoration2 = Instance.new("Part")
    rightDecoration2.Name = "RightDecoration2"
    rightDecoration2.Size = Vector3.new(0.1, 0.3, 0.1)
    rightDecoration2.Position = Vector3.new(0.4, -0.8, 0.2)
    rightDecoration2.Anchored = true
    rightDecoration2.CanCollide = false
    rightDecoration2.Material = Enum.Material.Metal
    rightDecoration2.Color = Color3.fromRGB(255, 215, 0)
    rightDecoration2.Parent = model
    
    -- Визуальные эффекты
    local leftGlow = Instance.new("PointLight")
    leftGlow.Name = "LeftGlow"
    leftGlow.Color = Color3.fromRGB(255, 255, 200)
    leftGlow.Range = 2
    leftGlow.Brightness = 0.3
    leftGlow.Parent = leftGreave
    
    local rightGlow = Instance.new("PointLight")
    rightGlow.Name = "RightGlow"
    rightGlow.Color = Color3.fromRGB(255, 255, 200)
    rightGlow.Range = 2
    rightGlow.Brightness = 0.3
    rightGlow.Parent = rightGreave
    
    local leftParticles = Instance.new("ParticleEmitter")
    leftParticles.Name = "LeftParticles"
    leftParticles.Texture = "rbxassetid://241629877"
    leftParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    leftParticles.Size = NumberSequence.new(0.1, 0)
    leftParticles.Transparency = NumberSequence.new(0.6, 1)
    leftParticles.Rate = 7
    leftParticles.Lifetime = NumberRange.new(1, 1.5)
    leftParticles.Speed = NumberRange.new(0.6, 1.2)
    leftParticles.SpreadAngle = Vector2.new(10, 10)
    leftParticles.Parent = leftGreave
    
    local rightParticles = Instance.new("ParticleEmitter")
    rightParticles.Name = "RightParticles"
    rightParticles.Texture = "rbxassetid://241629877"
    rightParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    rightParticles.Size = NumberSequence.new(0.1, 0)
    rightParticles.Transparency = NumberSequence.new(0.6, 1)
    rightParticles.Rate = 7
    rightParticles.Lifetime = NumberRange.new(1, 1.5)
    rightParticles.Speed = NumberRange.new(0.6, 1.2)
    rightParticles.SpreadAngle = Vector2.new(10, 10)
    rightParticles.Parent = rightGreave
    
    -- Атрибуты
    model:SetAttribute("ArmorType", "greaves")
    model:SetAttribute("ArmorMaterial", "metal")
    model:SetAttribute("ArmorQuality", "rare")
    model:SetAttribute("ArmorDefense", 30)
    model:SetAttribute("ArmorWeight", 6)
    model:SetAttribute("ArmorDurability", 90)
    model:SetAttribute("ArmorLevel", 11)
    model:SetAttribute("ArmorRarity", "rare")
    model:SetAttribute("ArmorClass", "warrior")
    model:SetAttribute("ArmorSubclass", "legs")
    model:SetAttribute("ArmorCraftable", true)
    model:SetAttribute("ArmorRepairable", true)
    model:SetAttribute("ArmorEnchantable", true)
    model:SetAttribute("ArmorUpgradeable", true)
    model:SetAttribute("ArmorTradeable", true)
    model:SetAttribute("ArmorDroppable", true)
    model:SetAttribute("ArmorSellable", true)
    model:SetAttribute("ArmorValue", 1000)
    model:SetAttribute("ArmorDescription", "Металлические поножи с золотыми украшениями")
    
    return model
end

return CreateGreaves