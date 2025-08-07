-- Chestplate.lua
-- Модель нагрудника
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateChestplate()
    local model = Instance.new("Model")
    model.Name = "Chestplate"
    
    -- Основная часть нагрудника
    local main = Instance.new("Part")
    main.Name = "Main"
    main.Size = Vector3.new(1.5, 2, 0.3)
    main.Position = Vector3.new(0, 0, 0)
    main.Anchored = true
    main.CanCollide = false
    main.Material = Enum.Material.Metal
    main.Color = Color3.fromRGB(105, 105, 105)
    main.Parent = model
    
    -- Плечевые пластины
    local leftShoulder = Instance.new("Part")
    leftShoulder.Name = "LeftShoulder"
    leftShoulder.Size = Vector3.new(0.8, 0.6, 0.2)
    leftShoulder.Position = Vector3.new(-1, 0.5, 0)
    leftShoulder.Anchored = true
    leftShoulder.CanCollide = false
    leftShoulder.Material = Enum.Material.Metal
    leftShoulder.Color = Color3.fromRGB(105, 105, 105)
    leftShoulder.Parent = model
    
    local rightShoulder = Instance.new("Part")
    rightShoulder.Name = "RightShoulder"
    rightShoulder.Size = Vector3.new(0.8, 0.6, 0.2)
    rightShoulder.Position = Vector3.new(1, 0.5, 0)
    rightShoulder.Anchored = true
    rightShoulder.CanCollide = false
    rightShoulder.Material = Enum.Material.Metal
    rightShoulder.Color = Color3.fromRGB(105, 105, 105)
    rightShoulder.Parent = model
    
    -- Защита живота
    local abdomen = Instance.new("Part")
    abdomen.Name = "Abdomen"
    abdomen.Size = Vector3.new(1.2, 0.8, 0.2)
    abdomen.Position = Vector3.new(0, -0.8, 0)
    abdomen.Anchored = true
    abdomen.CanCollide = false
    abdomen.Material = Enum.Material.Metal
    abdomen.Color = Color3.fromRGB(105, 105, 105)
    abdomen.Parent = model
    
    -- Декоративные элементы
    local crest = Instance.new("Part")
    crest.Name = "Crest"
    crest.Size = Vector3.new(0.1, 1.5, 0.1)
    crest.Position = Vector3.new(0, 0, 0.2)
    crest.Anchored = true
    crest.CanCollide = false
    crest.Material = Enum.Material.Metal
    crest.Color = Color3.fromRGB(255, 215, 0)
    crest.Parent = model
    
    local leftDecoration = Instance.new("Part")
    leftDecoration.Name = "LeftDecoration"
    leftDecoration.Size = Vector3.new(0.3, 0.3, 0.1)
    leftDecoration.Position = Vector3.new(-0.5, 0.3, 0.2)
    leftDecoration.Anchored = true
    leftDecoration.CanCollide = false
    leftDecoration.Material = Enum.Material.Metal
    leftDecoration.Color = Color3.fromRGB(255, 215, 0)
    leftDecoration.Parent = model
    
    local rightDecoration = Instance.new("Part")
    rightDecoration.Name = "RightDecoration"
    rightDecoration.Size = Vector3.new(0.3, 0.3, 0.1)
    rightDecoration.Position = Vector3.new(0.5, 0.3, 0.2)
    rightDecoration.Anchored = true
    rightDecoration.CanCollide = false
    rightDecoration.Material = Enum.Material.Metal
    rightDecoration.Color = Color3.fromRGB(255, 215, 0)
    rightDecoration.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 3
    glow.Brightness = 0.4
    glow.Parent = main
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.15, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(0.8, 1.5)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = main
    
    -- Атрибуты
    model:SetAttribute("ArmorType", "chestplate")
    model:SetAttribute("ArmorMaterial", "metal")
    model:SetAttribute("ArmorQuality", "rare")
    model:SetAttribute("ArmorDefense", 45)
    model:SetAttribute("ArmorWeight", 8)
    model:SetAttribute("ArmorDurability", 120)
    model:SetAttribute("ArmorLevel", 12)
    model:SetAttribute("ArmorRarity", "rare")
    model:SetAttribute("ArmorClass", "warrior")
    model:SetAttribute("ArmorSubclass", "chest")
    model:SetAttribute("ArmorCraftable", true)
    model:SetAttribute("ArmorRepairable", true)
    model:SetAttribute("ArmorEnchantable", true)
    model:SetAttribute("ArmorUpgradeable", true)
    model:SetAttribute("ArmorTradeable", true)
    model:SetAttribute("ArmorDroppable", true)
    model:SetAttribute("ArmorSellable", true)
    model:SetAttribute("ArmorValue", 1500)
    model:SetAttribute("ArmorDescription", "Надежный металлический нагрудник")
    
    return model
end

return CreateChestplate