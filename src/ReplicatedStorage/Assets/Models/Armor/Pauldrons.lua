-- Pauldrons.lua
-- Модель наплечников
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreatePauldrons()
    local model = Instance.new("Model")
    model.Name = "Pauldrons"
    
    -- Левый наплечник
    local leftPauldron = Instance.new("Part")
    leftPauldron.Name = "LeftPauldron"
    leftPauldron.Size = Vector3.new(0.8, 0.6, 0.3)
    leftPauldron.Position = Vector3.new(-0.8, 0.5, 0)
    leftPauldron.Anchored = true
    leftPauldron.CanCollide = false
    leftPauldron.Material = Enum.Material.Metal
    leftPauldron.Color = Color3.fromRGB(105, 105, 105)
    leftPauldron.Parent = model
    
    -- Правый наплечник
    local rightPauldron = Instance.new("Part")
    rightPauldron.Name = "RightPauldron"
    rightPauldron.Size = Vector3.new(0.8, 0.6, 0.3)
    rightPauldron.Position = Vector3.new(0.8, 0.5, 0)
    rightPauldron.Anchored = true
    rightPauldron.CanCollide = false
    rightPauldron.Material = Enum.Material.Metal
    rightPauldron.Color = Color3.fromRGB(105, 105, 105)
    rightPauldron.Parent = model
    
    -- Дополнительная защита левого плеча
    local leftExtra = Instance.new("Part")
    leftExtra.Name = "LeftExtra"
    leftExtra.Size = Vector3.new(0.4, 0.3, 0.2)
    leftExtra.Position = Vector3.new(-0.8, 0.8, 0)
    leftExtra.Anchored = true
    leftExtra.CanCollide = false
    leftExtra.Material = Enum.Material.Metal
    leftExtra.Color = Color3.fromRGB(105, 105, 105)
    leftExtra.Parent = model
    
    -- Дополнительная защита правого плеча
    local rightExtra = Instance.new("Part")
    rightExtra.Name = "RightExtra"
    rightExtra.Size = Vector3.new(0.4, 0.3, 0.2)
    rightExtra.Position = Vector3.new(0.8, 0.8, 0)
    rightExtra.Anchored = true
    rightExtra.CanCollide = false
    rightExtra.Material = Enum.Material.Metal
    rightExtra.Color = Color3.fromRGB(105, 105, 105)
    rightExtra.Parent = model
    
    -- Декоративные элементы
    local leftDecoration1 = Instance.new("Part")
    leftDecoration1.Name = "LeftDecoration1"
    leftDecoration1.Size = Vector3.new(0.2, 0.2, 0.1)
    leftDecoration1.Position = Vector3.new(-0.8, 0.5, 0.2)
    leftDecoration1.Anchored = true
    leftDecoration1.CanCollide = false
    leftDecoration1.Material = Enum.Material.Metal
    leftDecoration1.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration1.Parent = model
    
    local leftDecoration2 = Instance.new("Part")
    leftDecoration2.Name = "LeftDecoration2"
    leftDecoration2.Size = Vector3.new(0.1, 0.3, 0.1)
    leftDecoration2.Position = Vector3.new(-0.8, 0.3, 0.2)
    leftDecoration2.Anchored = true
    leftDecoration2.CanCollide = false
    leftDecoration2.Material = Enum.Material.Metal
    leftDecoration2.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration2.Parent = model
    
    local rightDecoration1 = Instance.new("Part")
    rightDecoration1.Name = "RightDecoration1"
    rightDecoration1.Size = Vector3.new(0.2, 0.2, 0.1)
    rightDecoration1.Position = Vector3.new(0.8, 0.5, 0.2)
    rightDecoration1.Anchored = true
    rightDecoration1.CanCollide = false
    rightDecoration1.Material = Enum.Material.Metal
    rightDecoration1.Color = Color3.fromRGB(255, 215, 0)
    rightDecoration1.Parent = model
    
    local rightDecoration2 = Instance.new("Part")
    rightDecoration2.Name = "RightDecoration2"
    rightDecoration2.Size = Vector3.new(0.1, 0.3, 0.1)
    rightDecoration2.Position = Vector3.new(0.8, 0.3, 0.2)
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
    leftGlow.Parent = leftPauldron
    
    local rightGlow = Instance.new("PointLight")
    rightGlow.Name = "RightGlow"
    rightGlow.Color = Color3.fromRGB(255, 255, 200)
    rightGlow.Range = 2
    rightGlow.Brightness = 0.3
    rightGlow.Parent = rightPauldron
    
    local leftParticles = Instance.new("ParticleEmitter")
    leftParticles.Name = "LeftParticles"
    leftParticles.Texture = "rbxassetid://241629877"
    leftParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    leftParticles.Size = NumberSequence.new(0.1, 0)
    leftParticles.Transparency = NumberSequence.new(0.6, 1)
    leftParticles.Rate = 6
    leftParticles.Lifetime = NumberRange.new(1, 1.5)
    leftParticles.Speed = NumberRange.new(0.5, 1)
    leftParticles.SpreadAngle = Vector2.new(10, 10)
    leftParticles.Parent = leftPauldron
    
    local rightParticles = Instance.new("ParticleEmitter")
    rightParticles.Name = "RightParticles"
    rightParticles.Texture = "rbxassetid://241629877"
    rightParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    rightParticles.Size = NumberSequence.new(0.1, 0)
    rightParticles.Transparency = NumberSequence.new(0.6, 1)
    rightParticles.Rate = 6
    rightParticles.Lifetime = NumberRange.new(1, 1.5)
    rightParticles.Speed = NumberRange.new(0.5, 1)
    rightParticles.SpreadAngle = Vector2.new(10, 10)
    rightParticles.Parent = rightPauldron
    
    -- Атрибуты
    model:SetAttribute("ArmorType", "pauldrons")
    model:SetAttribute("ArmorMaterial", "metal")
    model:SetAttribute("ArmorQuality", "rare")
    model:SetAttribute("ArmorDefense", 20)
    model:SetAttribute("ArmorWeight", 4)
    model:SetAttribute("ArmorDurability", 70)
    model:SetAttribute("ArmorLevel", 9)
    model:SetAttribute("ArmorRarity", "rare")
    model:SetAttribute("ArmorClass", "warrior")
    model:SetAttribute("ArmorSubclass", "shoulders")
    model:SetAttribute("ArmorCraftable", true)
    model:SetAttribute("ArmorRepairable", true)
    model:SetAttribute("ArmorEnchantable", true)
    model:SetAttribute("ArmorUpgradeable", true)
    model:SetAttribute("ArmorTradeable", true)
    model:SetAttribute("ArmorDroppable", true)
    model:SetAttribute("ArmorSellable", true)
    model:SetAttribute("ArmorValue", 600)
    model:SetAttribute("ArmorDescription", "Металлические наплечники с золотыми украшениями")
    
    return model
end

return CreatePauldrons