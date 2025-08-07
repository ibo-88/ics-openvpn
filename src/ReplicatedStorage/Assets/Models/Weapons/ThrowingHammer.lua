-- ThrowingHammer.lua
-- Модель метательного молота
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingHammer()
    local model = Instance.new("Model")
    model.Name = "ThrowingHammer"
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 1.8, 0.08)
    handle.Position = Vector3.new(0, 0.9, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Головка молота
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(0.5, 0.7, 0.3)
    head.Position = Vector3.new(0, 2.25, 0)
    head.Anchored = true
    head.CanCollide = false
    head.Material = Enum.Material.Metal
    head.Color = Color3.fromRGB(105, 105, 105)
    head.Parent = model
    
    -- Боек
    local striker = Instance.new("Part")
    striker.Name = "Striker"
    striker.Size = Vector3.new(0.3, 0.25, 0.3)
    striker.Position = Vector3.new(0, 2.625, 0)
    striker.Anchored = true
    striker.CanCollide = false
    striker.Material = Enum.Material.Metal
    striker.Color = Color3.fromRGB(192, 192, 192)
    striker.Parent = model
    
    -- Крестовина
    local cross = Instance.new("Part")
    cross.Name = "Cross"
    cross.Size = Vector3.new(0.6, 0.15, 0.15)
    cross.Position = Vector3.new(0, 1.8, 0)
    cross.Anchored = true
    cross.CanCollide = false
    cross.Material = Enum.Material.Metal
    cross.Color = Color3.fromRGB(105, 105, 105)
    cross.Parent = model
    
    -- Крепление
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.15, 0.25, 0.15)
    mount.Position = Vector3.new(0, 2.05, 0)
    mount.Anchored = true
    mount.CanCollide = false
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(105, 105, 105)
    mount.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.15, 0.15, 0.15)
    pommel.Position = Vector3.new(0, 0.075, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration1.Position = Vector3.new(0, 1.5, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration2.Position = Vector3.new(0, 0.8, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 2.5
    glow.Brightness = 0.4
    glow.Parent = head
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.12, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 10
    particles.Lifetime = NumberRange.new(1, 1.8)
    particles.Speed = NumberRange.new(0.8, 1.5)
    particles.SpreadAngle = Vector2.new(12, 12)
    particles.Parent = head
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_hammer")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 70)
    model:SetAttribute("WeaponSpeed", 0.9)
    model:SetAttribute("WeaponRange", 16)
    model:SetAttribute("WeaponWeight", 6)
    model:SetAttribute("WeaponDurability", 95)
    model:SetAttribute("WeaponLevel", 16)
    model:SetAttribute("WeaponRarity", "rare")
    model:SetAttribute("WeaponClass", "warrior")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 1100)
    model:SetAttribute("WeaponDescription", "Метательный молот с мощным ударом")
    
    return model
end

return CreateThrowingHammer