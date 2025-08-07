-- Trident.lua
-- Модель трезубца
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateTrident()
    local model = Instance.new("Model")
    model.Name = "Trident"
    
    -- Древко
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.1, 3.5, 0.1)
    handle.Position = Vector3.new(0, 1.75, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Центральное острие
    local centerTip = Instance.new("Part")
    centerTip.Name = "CenterTip"
    centerTip.Shape = Enum.PartType.Wedge
    centerTip.Size = Vector3.new(0.1, 0.8, 0.1)
    centerTip.Position = Vector3.new(0, 4.15, 0)
    centerTip.Rotation = Vector3.new(0, 0, 180)
    centerTip.Anchored = true
    centerTip.CanCollide = false
    centerTip.Material = Enum.Material.Metal
    centerTip.Color = Color3.fromRGB(192, 192, 192)
    centerTip.Parent = model
    
    -- Левое острие
    local leftTip = Instance.new("Part")
    leftTip.Name = "LeftTip"
    leftTip.Shape = Enum.PartType.Wedge
    leftTip.Size = Vector3.new(0.08, 0.6, 0.08)
    leftTip.Position = Vector3.new(-0.15, 4.05, 0)
    leftTip.Rotation = Vector3.new(0, 0, 180)
    leftTip.Anchored = true
    leftTip.CanCollide = false
    leftTip.Material = Enum.Material.Metal
    leftTip.Color = Color3.fromRGB(192, 192, 192)
    leftTip.Parent = model
    
    -- Правое острие
    local rightTip = Instance.new("Part")
    rightTip.Name = "RightTip"
    rightTip.Shape = Enum.PartType.Wedge
    rightTip.Size = Vector3.new(0.08, 0.6, 0.08)
    rightTip.Position = Vector3.new(0.15, 4.05, 0)
    rightTip.Rotation = Vector3.new(0, 0, 180)
    rightTip.Anchored = true
    rightTip.CanCollide = false
    rightTip.Material = Enum.Material.Metal
    rightTip.Color = Color3.fromRGB(192, 192, 192)
    rightTip.Parent = model
    
    -- Крестовина
    local cross = Instance.new("Part")
    cross.Name = "Cross"
    cross.Size = Vector3.new(0.6, 0.1, 0.2)
    cross.Position = Vector3.new(0, 3.7, 0)
    cross.Anchored = true
    cross.CanCollide = false
    cross.Material = Enum.Material.Metal
    cross.Color = Color3.fromRGB(105, 105, 105)
    cross.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.2, 0.2, 0.2)
    pommel.Position = Vector3.new(0, 0.1, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.1, 0.2, 0.1)
    decoration1.Position = Vector3.new(0, 2.5, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.1, 0.2, 0.1)
    decoration2.Position = Vector3.new(0, 1.5, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 3
    glow.Brightness = 0.5
    glow.Parent = centerTip
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.12, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = centerTip
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "trident")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 70)
    model:SetAttribute("WeaponSpeed", 0.9)
    model:SetAttribute("WeaponRange", 4.5)
    model:SetAttribute("WeaponWeight", 6)
    model:SetAttribute("WeaponDurability", 110)
    model:SetAttribute("WeaponLevel", 19)
    model:SetAttribute("WeaponRarity", "epic")
    model:SetAttribute("WeaponClass", "warrior")
    model:SetAttribute("WeaponSubclass", "polearm")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 2200)
    model:SetAttribute("WeaponDescription", "Мощный трезубец с тремя остриями")
    
    return model
end

return CreateTrident