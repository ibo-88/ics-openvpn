-- ThrowingDisk.lua
-- Модель метательного диска
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingDisk()
    local model = Instance.new("Model")
    model.Name = "ThrowingDisk"
    
    -- Основное кольцо
    local ring = Instance.new("Part")
    ring.Name = "Ring"
    ring.Shape = Enum.PartType.Cylinder
    ring.Size = Vector3.new(0.12, 0.7, 0.7)
    ring.Position = Vector3.new(0, 0, 0)
    ring.Rotation = Vector3.new(0, 0, 90)
    ring.Anchored = true
    ring.CanCollide = false
    ring.Material = Enum.Material.Metal
    ring.Color = Color3.fromRGB(192, 192, 192)
    ring.Parent = model
    
    -- Внутреннее отверстие
    local inner = Instance.new("Part")
    inner.Name = "Inner"
    inner.Shape = Enum.PartType.Cylinder
    inner.Size = Vector3.new(0.13, 0.4, 0.4)
    inner.Position = Vector3.new(0, 0, 0)
    inner.Rotation = Vector3.new(0, 0, 90)
    inner.Anchored = true
    inner.CanCollide = false
    inner.Material = Enum.Material.Metal
    inner.Color = Color3.fromRGB(105, 105, 105)
    inner.Parent = model
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.05, 0.1, 0.1)
    decoration.Position = Vector3.new(0, 0.2, 0)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 2
    glow.Brightness = 0.4
    glow.Parent = ring
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = ring
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_disk")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 38)
    model:SetAttribute("WeaponSpeed", 1.6)
    model:SetAttribute("WeaponRange", 13)
    model:SetAttribute("WeaponWeight", 1.2)
    model:SetAttribute("WeaponDurability", 55)
    model:SetAttribute("WeaponLevel", 9)
    model:SetAttribute("WeaponRarity", "rare")
    model:SetAttribute("WeaponClass", "rogue")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 500)
    model:SetAttribute("WeaponDescription", "Метательный диск с острыми краями")
    
    return model
end

return CreateThrowingDisk