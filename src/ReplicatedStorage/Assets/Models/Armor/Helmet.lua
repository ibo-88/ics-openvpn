-- Helmet.lua
-- Модель шлема
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateHelmet()
    local model = Instance.new("Model")
    model.Name = "Helmet"
    
    -- Основная часть шлема
    local main = Instance.new("Part")
    main.Name = "Main"
    main.Shape = Enum.PartType.Ball
    main.Size = Vector3.new(1.2, 1.2, 1.2)
    main.Position = Vector3.new(0, 0, 0)
    main.Anchored = true
    main.CanCollide = false
    main.Material = Enum.Material.Metal
    main.Color = Color3.fromRGB(105, 105, 105)
    main.Parent = model
    
    -- Защита лица
    local visor = Instance.new("Part")
    visor.Name = "Visor"
    visor.Size = Vector3.new(0.8, 0.3, 0.05)
    visor.Position = Vector3.new(0, 0.1, 0.5)
    visor.Anchored = true
    visor.CanCollide = false
    visor.Material = Enum.Material.Metal
    visor.Color = Color3.fromRGB(64, 64, 64)
    visor.Parent = model
    
    -- Защита затылка
    local back = Instance.new("Part")
    back.Name = "Back"
    back.Size = Vector3.new(0.8, 0.4, 0.1)
    back.Position = Vector3.new(0, -0.1, -0.5)
    back.Anchored = true
    back.CanCollide = false
    back.Material = Enum.Material.Metal
    back.Color = Color3.fromRGB(105, 105, 105)
    back.Parent = model
    
    -- Гребень
    local crest = Instance.new("Part")
    crest.Name = "Crest"
    crest.Size = Vector3.new(0.1, 0.6, 0.8)
    crest.Position = Vector3.new(0, 0.3, 0)
    crest.Anchored = true
    crest.CanCollide = false
    crest.Material = Enum.Material.Metal
    crest.Color = Color3.fromRGB(255, 215, 0)
    crest.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.05, 0.2, 0.1)
    decoration1.Position = Vector3.new(-0.4, 0.2, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.05, 0.2, 0.1)
    decoration2.Position = Vector3.new(0.4, 0.2, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 2
    glow.Brightness = 0.3
    glow.Parent = main
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.1, 0)
    particles.Transparency = NumberSequence.new(0.6, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(1, 1.5)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = main
    
    -- Атрибуты
    model:SetAttribute("ArmorType", "helmet")
    model:SetAttribute("ArmorMaterial", "metal")
    model:SetAttribute("ArmorQuality", "rare")
    model:SetAttribute("ArmorDefense", 25)
    model:SetAttribute("ArmorWeight", 3)
    model:SetAttribute("ArmorDurability", 80)
    model:SetAttribute("ArmorLevel", 10)
    model:SetAttribute("ArmorRarity", "rare")
    model:SetAttribute("ArmorClass", "warrior")
    model:SetAttribute("ArmorSubclass", "head")
    model:SetAttribute("ArmorCraftable", true)
    model:SetAttribute("ArmorRepairable", true)
    model:SetAttribute("ArmorEnchantable", true)
    model:SetAttribute("ArmorUpgradeable", true)
    model:SetAttribute("ArmorTradeable", true)
    model:SetAttribute("ArmorDroppable", true)
    model:SetAttribute("ArmorSellable", true)
    model:SetAttribute("ArmorValue", 800)
    model:SetAttribute("ArmorDescription", "Надежный металлический шлем")
    
    return model
end

return CreateHelmet