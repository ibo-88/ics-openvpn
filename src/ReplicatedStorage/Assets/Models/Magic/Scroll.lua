-- Scroll.lua
-- Модель магического свитка
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateScroll()
    local model = Instance.new("Model")
    model.Name = "Scroll"
    
    -- Основная часть свитка
    local main = Instance.new("Part")
    main.Name = "Main"
    main.Size = Vector3.new(0.1, 1.5, 0.8)
    main.Position = Vector3.new(0, 0, 0)
    main.Anchored = true
    main.CanCollide = false
    main.Material = Enum.Material.Fabric
    main.Color = Color3.fromRGB(255, 248, 220)
    main.Parent = model
    
    -- Верхний валик
    local topRoll = Instance.new("Part")
    topRoll.Name = "TopRoll"
    topRoll.Shape = Enum.PartType.Cylinder
    topRoll.Size = Vector3.new(0.1, 0.8, 0.8)
    topRoll.Position = Vector3.new(0, 0.75, 0)
    topRoll.Rotation = Vector3.new(0, 0, 90)
    topRoll.Anchored = true
    topRoll.CanCollide = false
    topRoll.Material = Enum.Material.Wood
    topRoll.Color = Color3.fromRGB(139, 69, 19)
    topRoll.Parent = model
    
    -- Нижний валик
    local bottomRoll = Instance.new("Part")
    bottomRoll.Name = "BottomRoll"
    bottomRoll.Shape = Enum.PartType.Cylinder
    bottomRoll.Size = Vector3.new(0.1, 0.8, 0.8)
    bottomRoll.Position = Vector3.new(0, -0.75, 0)
    bottomRoll.Rotation = Vector3.new(0, 0, 90)
    bottomRoll.Anchored = true
    bottomRoll.CanCollide = false
    bottomRoll.Material = Enum.Material.Wood
    bottomRoll.Color = Color3.fromRGB(139, 69, 19)
    bottomRoll.Parent = model
    
    -- Магические символы
    local symbol1 = Instance.new("Part")
    symbol1.Name = "Symbol1"
    symbol1.Size = Vector3.new(0.05, 0.2, 0.2)
    symbol1.Position = Vector3.new(0, 0.3, 0.3)
    symbol1.Anchored = true
    symbol1.CanCollide = false
    symbol1.Material = Enum.Material.Neon
    symbol1.Color = Color3.fromRGB(0, 255, 255)
    symbol1.Parent = model
    
    local symbol2 = Instance.new("Part")
    symbol2.Name = "Symbol2"
    symbol2.Size = Vector3.new(0.05, 0.2, 0.2)
    symbol2.Position = Vector3.new(0, 0, 0.3)
    symbol2.Anchored = true
    symbol2.CanCollide = false
    symbol2.Material = Enum.Material.Neon
    symbol2.Color = Color3.fromRGB(255, 0, 255)
    symbol2.Parent = model
    
    local symbol3 = Instance.new("Part")
    symbol3.Name = "Symbol3"
    symbol3.Size = Vector3.new(0.05, 0.2, 0.2)
    symbol3.Position = Vector3.new(0, -0.3, 0.3)
    symbol3.Anchored = true
    symbol3.CanCollide = false
    symbol3.Material = Enum.Material.Neon
    symbol3.Color = Color3.fromRGB(255, 255, 0)
    symbol3.Parent = model
    
    -- Печать
    local seal = Instance.new("Part")
    seal.Name = "Seal"
    seal.Shape = Enum.PartType.Cylinder
    seal.Size = Vector3.new(0.05, 0.3, 0.3)
    seal.Position = Vector3.new(0, 0, -0.3)
    seal.Rotation = Vector3.new(0, 0, 90)
    seal.Anchored = true
    seal.CanCollide = false
    seal.Material = Enum.Material.Metal
    seal.Color = Color3.fromRGB(255, 215, 0)
    seal.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 3
    glow.Brightness = 0.6
    glow.Parent = main
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.1, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 15
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(20, 20)
    particles.Parent = main
    
    -- Дополнительные частицы для символов
    local symbolParticles = Instance.new("ParticleEmitter")
    symbolParticles.Name = "SymbolParticles"
    symbolParticles.Texture = "rbxassetid://241629877"
    symbolParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    symbolParticles.Size = NumberSequence.new(0.05, 0)
    symbolParticles.Transparency = NumberSequence.new(0.8, 1)
    symbolParticles.Rate = 20
    symbolParticles.Lifetime = NumberRange.new(0.5, 1)
    symbolParticles.Speed = NumberRange.new(0.3, 0.8)
    symbolParticles.SpreadAngle = Vector2.new(5, 5)
    symbolParticles.Parent = symbol1
    
    -- Атрибуты
    model:SetAttribute("MagicType", "scroll")
    model:SetAttribute("MagicMaterial", "paper")
    model:SetAttribute("MagicQuality", "rare")
    model:SetAttribute("MagicPower", 50)
    model:SetAttribute("MagicManaCost", 30)
    model:SetAttribute("MagicCooldown", 60)
    model:SetAttribute("MagicRange", 20)
    model:SetAttribute("MagicWeight", 1)
    model:SetAttribute("MagicDurability", 50)
    model:SetAttribute("MagicLevel", 15)
    model:SetAttribute("MagicRarity", "rare")
    model:SetAttribute("MagicClass", "mage")
    model:SetAttribute("MagicSubclass", "spell")
    model:SetAttribute("MagicCraftable", true)
    model:SetAttribute("MagicRepairable", false)
    model:SetAttribute("MagicEnchantable", true)
    model:SetAttribute("MagicUpgradeable", true)
    model:SetAttribute("MagicTradeable", true)
    model:SetAttribute("MagicDroppable", true)
    model:SetAttribute("MagicSellable", true)
    model:SetAttribute("MagicValue", 1200)
    model:SetAttribute("MagicDescription", "Древний свиток с магическими рунами")
    
    return model
end

return CreateScroll