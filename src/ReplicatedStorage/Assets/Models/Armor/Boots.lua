-- Boots.lua
-- Модель сапог
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBoots()
    local model = Instance.new("Model")
    model.Name = "Boots"
    
    -- Левый сапог
    local leftBoot = Instance.new("Part")
    leftBoot.Name = "LeftBoot"
    leftBoot.Size = Vector3.new(0.8, 1.5, 0.4)
    leftBoot.Position = Vector3.new(-0.5, -0.75, 0)
    leftBoot.Anchored = true
    leftBoot.CanCollide = false
    leftBoot.Material = Enum.Material.Metal
    leftBoot.Color = Color3.fromRGB(105, 105, 105)
    leftBoot.Parent = model
    
    -- Правый сапог
    local rightBoot = Instance.new("Part")
    rightBoot.Name = "RightBoot"
    rightBoot.Size = Vector3.new(0.8, 1.5, 0.4)
    rightBoot.Position = Vector3.new(0.5, -0.75, 0)
    rightBoot.Anchored = true
    rightBoot.CanCollide = false
    rightBoot.Material = Enum.Material.Metal
    rightBoot.Color = Color3.fromRGB(105, 105, 105)
    rightBoot.Parent = model
    
    -- Подошва левого сапога
    local leftSole = Instance.new("Part")
    leftSole.Name = "LeftSole"
    leftSole.Size = Vector3.new(0.9, 0.1, 0.5)
    leftSole.Position = Vector3.new(-0.5, -1.3, 0)
    leftSole.Anchored = true
    leftSole.CanCollide = false
    leftSole.Material = Enum.Material.Metal
    leftSole.Color = Color3.fromRGB(64, 64, 64)
    leftSole.Parent = model
    
    -- Подошва правого сапога
    local rightSole = Instance.new("Part")
    rightSole.Name = "RightSole"
    rightSole.Size = Vector3.new(0.9, 0.1, 0.5)
    rightSole.Position = Vector3.new(0.5, -1.3, 0)
    rightSole.Anchored = true
    rightSole.CanCollide = false
    rightSole.Material = Enum.Material.Metal
    rightSole.Color = Color3.fromRGB(64, 64, 64)
    rightSole.Parent = model
    
    -- Шпоры
    local leftSpur = Instance.new("Part")
    leftSpur.Name = "LeftSpur"
    leftSpur.Size = Vector3.new(0.1, 0.3, 0.1)
    leftSpur.Position = Vector3.new(-0.5, -0.2, 0.3)
    leftSpur.Anchored = true
    leftSpur.CanCollide = false
    leftSpur.Material = Enum.Material.Metal
    leftSpur.Color = Color3.fromRGB(255, 215, 0)
    leftSpur.Parent = model
    
    local rightSpur = Instance.new("Part")
    rightSpur.Name = "RightSpur"
    rightSpur.Size = Vector3.new(0.1, 0.3, 0.1)
    rightSpur.Position = Vector3.new(0.5, -0.2, 0.3)
    rightSpur.Anchored = true
    rightSpur.CanCollide = false
    rightSpur.Material = Enum.Material.Metal
    rightSpur.Color = Color3.fromRGB(255, 215, 0)
    rightSpur.Parent = model
    
    -- Декоративные элементы
    local leftDecoration = Instance.new("Part")
    leftDecoration.Name = "LeftDecoration"
    leftDecoration.Size = Vector3.new(0.2, 0.2, 0.1)
    leftDecoration.Position = Vector3.new(-0.5, 0.2, 0.25)
    leftDecoration.Anchored = true
    leftDecoration.CanCollide = false
    leftDecoration.Material = Enum.Material.Metal
    leftDecoration.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration.Parent = model
    
    local rightDecoration = Instance.new("Part")
    rightDecoration.Name = "RightDecoration"
    rightDecoration.Size = Vector3.new(0.2, 0.2, 0.1)
    rightDecoration.Position = Vector3.new(0.5, 0.2, 0.25)
    rightDecoration.Anchored = true
    rightDecoration.CanCollide = false
    rightDecoration.Material = Enum.Material.Metal
    rightDecoration.Color = Color3.fromRGB(255, 215, 0)
    rightDecoration.Parent = model
    
    -- Визуальные эффекты
    local leftGlow = Instance.new("PointLight")
    leftGlow.Name = "LeftGlow"
    leftGlow.Color = Color3.fromRGB(255, 255, 200)
    leftGlow.Range = 1.5
    leftGlow.Brightness = 0.3
    leftGlow.Parent = leftBoot
    
    local rightGlow = Instance.new("PointLight")
    rightGlow.Name = "RightGlow"
    rightGlow.Color = Color3.fromRGB(255, 255, 200)
    rightGlow.Range = 1.5
    rightGlow.Brightness = 0.3
    rightGlow.Parent = rightBoot
    
    local leftParticles = Instance.new("ParticleEmitter")
    leftParticles.Name = "LeftParticles"
    leftParticles.Texture = "rbxassetid://241629877"
    leftParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    leftParticles.Size = NumberSequence.new(0.08, 0)
    leftParticles.Transparency = NumberSequence.new(0.6, 1)
    leftParticles.Rate = 5
    leftParticles.Lifetime = NumberRange.new(0.8, 1.2)
    leftParticles.Speed = NumberRange.new(0.5, 1)
    leftParticles.SpreadAngle = Vector2.new(8, 8)
    leftParticles.Parent = leftBoot
    
    local rightParticles = Instance.new("ParticleEmitter")
    rightParticles.Name = "RightParticles"
    rightParticles.Texture = "rbxassetid://241629877"
    rightParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    rightParticles.Size = NumberSequence.new(0.08, 0)
    rightParticles.Transparency = NumberSequence.new(0.6, 1)
    rightParticles.Rate = 5
    rightParticles.Lifetime = NumberRange.new(0.8, 1.2)
    rightParticles.Speed = NumberRange.new(0.5, 1)
    rightParticles.SpreadAngle = Vector2.new(8, 8)
    rightParticles.Parent = rightBoot
    
    -- Атрибуты
    model:SetAttribute("ArmorType", "boots")
    model:SetAttribute("ArmorMaterial", "metal")
    model:SetAttribute("ArmorQuality", "rare")
    model:SetAttribute("ArmorDefense", 20)
    model:SetAttribute("ArmorWeight", 4)
    model:SetAttribute("ArmorDurability", 70)
    model:SetAttribute("ArmorLevel", 9)
    model:SetAttribute("ArmorRarity", "rare")
    model:SetAttribute("ArmorClass", "warrior")
    model:SetAttribute("ArmorSubclass", "feet")
    model:SetAttribute("ArmorCraftable", true)
    model:SetAttribute("ArmorRepairable", true)
    model:SetAttribute("ArmorEnchantable", true)
    model:SetAttribute("ArmorUpgradeable", true)
    model:SetAttribute("ArmorTradeable", true)
    model:SetAttribute("ArmorDroppable", true)
    model:SetAttribute("ArmorSellable", true)
    model:SetAttribute("ArmorValue", 700)
    model:SetAttribute("ArmorDescription", "Металлические сапоги с золотыми шпорами")
    
    return model
end

return CreateBoots