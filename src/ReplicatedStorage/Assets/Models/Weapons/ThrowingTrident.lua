-- ThrowingTrident.lua
-- Модель метательного трезубца
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingTrident()
    local model = Instance.new("Model")
    model.Name = "ThrowingTrident"
    
    -- Древко
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.06, 2, 0.06)
    handle.Position = Vector3.new(0, 1, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Центральное острие
    local centerTip = Instance.new("Part")
    centerTip.Name = "CenterTip"
    centerTip.Shape = Enum.PartType.Wedge
    centerTip.Size = Vector3.new(0.08, 0.6, 0.08)
    centerTip.Position = Vector3.new(0, 3, 0)
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
    leftTip.Size = Vector3.new(0.06, 0.5, 0.06)
    leftTip.Position = Vector3.new(-0.12, 2.95, 0)
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
    rightTip.Size = Vector3.new(0.06, 0.5, 0.06)
    rightTip.Position = Vector3.new(0.12, 2.95, 0)
    rightTip.Rotation = Vector3.new(0, 0, 180)
    rightTip.Anchored = true
    rightTip.CanCollide = false
    rightTip.Material = Enum.Material.Metal
    rightTip.Color = Color3.fromRGB(192, 192, 192)
    rightTip.Parent = model
    
    -- Крестовина
    local cross = Instance.new("Part")
    cross.Name = "Cross"
    cross.Size = Vector3.new(0.4, 0.08, 0.15)
    cross.Position = Vector3.new(0, 2.5, 0)
    cross.Anchored = true
    cross.CanCollide = false
    cross.Material = Enum.Material.Metal
    cross.Color = Color3.fromRGB(105, 105, 105)
    cross.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.12, 0.12, 0.12)
    pommel.Position = Vector3.new(0, 0.06, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration1.Position = Vector3.new(0, 1.8, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration2.Position = Vector3.new(0, 1.4, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    local decoration3 = Instance.new("Part")
    decoration3.Name = "Decoration3"
    decoration3.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration3.Position = Vector3.new(0, 1, 0)
    decoration3.Anchored = true
    decoration3.CanCollide = false
    decoration3.Material = Enum.Material.Metal
    decoration3.Color = Color3.fromRGB(255, 215, 0)
    decoration3.Parent = model
    
    local decoration4 = Instance.new("Part")
    decoration4.Name = "Decoration4"
    decoration4.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration4.Position = Vector3.new(0, 0.6, 0)
    decoration4.Anchored = true
    decoration4.CanCollide = false
    decoration4.Material = Enum.Material.Metal
    decoration4.Color = Color3.fromRGB(255, 215, 0)
    decoration4.Parent = model
    
    local decoration5 = Instance.new("Part")
    decoration5.Name = "Decoration5"
    decoration5.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration5.Position = Vector3.new(0, 0.2, 0)
    decoration5.Anchored = true
    decoration5.CanCollide = false
    decoration5.Material = Enum.Material.Metal
    decoration5.Color = Color3.fromRGB(255, 215, 0)
    decoration5.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 2.5
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
    model:SetAttribute("WeaponType", "throwing_trident")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 70)
    model:SetAttribute("WeaponSpeed", 0.9)
    model:SetAttribute("WeaponRange", 24)
    model:SetAttribute("WeaponWeight", 5)
    model:SetAttribute("WeaponDurability", 95)
    model:SetAttribute("WeaponLevel", 18)
    model:SetAttribute("WeaponRarity", "epic")
    model:SetAttribute("WeaponClass", "warrior")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 1500)
    model:SetAttribute("WeaponDescription", "Метательный трезубец с тремя остриями")
    
    return model
end

return CreateThrowingTrident