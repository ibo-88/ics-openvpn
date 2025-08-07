-- Gauntlets.lua
-- Модель перчаток
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGauntlets()
    local model = Instance.new("Model")
    model.Name = "Gauntlets"
    
    -- Левая перчатка
    local leftGauntlet = Instance.new("Part")
    leftGauntlet.Name = "LeftGauntlet"
    leftGauntlet.Size = Vector3.new(0.8, 1.2, 0.3)
    leftGauntlet.Position = Vector3.new(-0.5, 0, 0)
    leftGauntlet.Anchored = true
    leftGauntlet.CanCollide = false
    leftGauntlet.Material = Enum.Material.Metal
    leftGauntlet.Color = Color3.fromRGB(105, 105, 105)
    leftGauntlet.Parent = model
    
    -- Правая перчатка
    local rightGauntlet = Instance.new("Part")
    rightGauntlet.Name = "RightGauntlet"
    rightGauntlet.Size = Vector3.new(0.8, 1.2, 0.3)
    rightGauntlet.Position = Vector3.new(0.5, 0, 0)
    rightGauntlet.Anchored = true
    rightGauntlet.CanCollide = false
    rightGauntlet.Material = Enum.Material.Metal
    rightGauntlet.Color = Color3.fromRGB(105, 105, 105)
    rightGauntlet.Parent = model
    
    -- Защита пальцев левой руки
    local leftFingers = Instance.new("Part")
    leftFingers.Name = "LeftFingers"
    leftFingers.Size = Vector3.new(0.6, 0.3, 0.2)
    leftFingers.Position = Vector3.new(-0.5, 0.6, 0)
    leftFingers.Anchored = true
    leftFingers.CanCollide = false
    leftFingers.Material = Enum.Material.Metal
    leftFingers.Color = Color3.fromRGB(105, 105, 105)
    leftFingers.Parent = model
    
    -- Защита пальцев правой руки
    local rightFingers = Instance.new("Part")
    rightFingers.Name = "RightFingers"
    rightFingers.Size = Vector3.new(0.6, 0.3, 0.2)
    rightFingers.Position = Vector3.new(0.5, 0.6, 0)
    rightFingers.Anchored = true
    rightFingers.CanCollide = false
    rightFingers.Material = Enum.Material.Metal
    rightFingers.Color = Color3.fromRGB(105, 105, 105)
    rightFingers.Parent = model
    
    -- Декоративные элементы
    local leftDecoration = Instance.new("Part")
    leftDecoration.Name = "LeftDecoration"
    leftDecoration.Size = Vector3.new(0.2, 0.2, 0.1)
    leftDecoration.Position = Vector3.new(-0.5, 0.2, 0.2)
    leftDecoration.Anchored = true
    leftDecoration.CanCollide = false
    leftDecoration.Material = Enum.Material.Metal
    leftDecoration.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration.Parent = model
    
    local rightDecoration = Instance.new("Part")
    rightDecoration.Name = "RightDecoration"
    rightDecoration.Size = Vector3.new(0.2, 0.2, 0.1)
    rightDecoration.Position = Vector3.new(0.5, 0.2, 0.2)
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
    leftGlow.Parent = leftGauntlet
    
    local rightGlow = Instance.new("PointLight")
    rightGlow.Name = "RightGlow"
    rightGlow.Color = Color3.fromRGB(255, 255, 200)
    rightGlow.Range = 1.5
    rightGlow.Brightness = 0.3
    rightGlow.Parent = rightGauntlet
    
    local leftParticles = Instance.new("ParticleEmitter")
    leftParticles.Name = "LeftParticles"
    leftParticles.Texture = "rbxassetid://241629877"
    leftParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    leftParticles.Size = NumberSequence.new(0.08, 0)
    leftParticles.Transparency = NumberSequence.new(0.6, 1)
    leftParticles.Rate = 6
    leftParticles.Lifetime = NumberRange.new(0.8, 1.2)
    leftParticles.Speed = NumberRange.new(0.5, 1)
    leftParticles.SpreadAngle = Vector2.new(8, 8)
    leftParticles.Parent = leftGauntlet
    
    local rightParticles = Instance.new("ParticleEmitter")
    rightParticles.Name = "RightParticles"
    rightParticles.Texture = "rbxassetid://241629877"
    rightParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    rightParticles.Size = NumberSequence.new(0.08, 0)
    rightParticles.Transparency = NumberSequence.new(0.6, 1)
    rightParticles.Rate = 6
    rightParticles.Lifetime = NumberRange.new(0.8, 1.2)
    rightParticles.Speed = NumberRange.new(0.5, 1)
    rightParticles.SpreadAngle = Vector2.new(8, 8)
    rightParticles.Parent = rightGauntlet
    
    -- Атрибуты
    model:SetAttribute("ArmorType", "gauntlets")
    model:SetAttribute("ArmorMaterial", "metal")
    model:SetAttribute("ArmorQuality", "rare")
    model:SetAttribute("ArmorDefense", 15)
    model:SetAttribute("ArmorWeight", 2)
    model:SetAttribute("ArmorDurability", 60)
    model:SetAttribute("ArmorLevel", 8)
    model:SetAttribute("ArmorRarity", "rare")
    model:SetAttribute("ArmorClass", "warrior")
    model:SetAttribute("ArmorSubclass", "hands")
    model:SetAttribute("ArmorCraftable", true)
    model:SetAttribute("ArmorRepairable", true)
    model:SetAttribute("ArmorEnchantable", true)
    model:SetAttribute("ArmorUpgradeable", true)
    model:SetAttribute("ArmorTradeable", true)
    model:SetAttribute("ArmorDroppable", true)
    model:SetAttribute("ArmorSellable", true)
    model:SetAttribute("ArmorValue", 600)
    model:SetAttribute("ArmorDescription", "Металлические перчатки для защиты рук")
    
    return model
end

return CreateGauntlets