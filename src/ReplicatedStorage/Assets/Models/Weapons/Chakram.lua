-- Chakram.lua
-- Модель чакрама
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateChakram()
    local model = Instance.new("Model")
    model.Name = "Chakram"
    
    -- Основное кольцо
    local ring = Instance.new("Part")
    ring.Name = "Ring"
    ring.Shape = Enum.PartType.Cylinder
    ring.Size = Vector3.new(0.1, 0.8, 0.8)
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
    inner.Size = Vector3.new(0.12, 0.5, 0.5)
    inner.Position = Vector3.new(0, 0, 0)
    inner.Rotation = Vector3.new(0, 0, 90)
    inner.Anchored = true
    inner.CanCollide = false
    inner.Material = Enum.Material.Metal
    inner.Color = Color3.fromRGB(105, 105, 105)
    inner.Parent = model
    
    -- Лезвия
    local blade1 = Instance.new("Part")
    blade1.Name = "Blade1"
    blade1.Size = Vector3.new(0.05, 0.4, 0.1)
    blade1.Position = Vector3.new(0, 0.4, 0)
    blade1.Anchored = true
    blade1.CanCollide = false
    blade1.Material = Enum.Material.Metal
    blade1.Color = Color3.fromRGB(192, 192, 192)
    blade1.Parent = model
    
    local blade2 = Instance.new("Part")
    blade2.Name = "Blade2"
    blade2.Size = Vector3.new(0.05, 0.4, 0.1)
    blade2.Position = Vector3.new(0, -0.4, 0)
    blade2.Anchored = true
    blade2.CanCollide = false
    blade2.Material = Enum.Material.Metal
    blade2.Color = Color3.fromRGB(192, 192, 192)
    blade2.Parent = model
    
    local blade3 = Instance.new("Part")
    blade3.Name = "Blade3"
    blade3.Size = Vector3.new(0.1, 0.05, 0.4)
    blade3.Position = Vector3.new(0.4, 0, 0)
    blade3.Anchored = true
    blade3.CanCollide = false
    blade3.Material = Enum.Material.Metal
    blade3.Color = Color3.fromRGB(192, 192, 192)
    blade3.Parent = model
    
    local blade4 = Instance.new("Part")
    blade4.Name = "Blade4"
    blade4.Size = Vector3.new(0.1, 0.05, 0.4)
    blade4.Position = Vector3.new(-0.4, 0, 0)
    blade4.Anchored = true
    blade4.CanCollide = false
    blade4.Material = Enum.Material.Metal
    blade4.Color = Color3.fromRGB(192, 192, 192)
    blade4.Parent = model
    
    -- Острия лезвий
    local tip1 = Instance.new("Part")
    tip1.Name = "Tip1"
    tip1.Shape = Enum.PartType.Wedge
    tip1.Size = Vector3.new(0.05, 0.2, 0.1)
    tip1.Position = Vector3.new(0, 0.6, 0)
    tip1.Rotation = Vector3.new(0, 0, 180)
    tip1.Anchored = true
    tip1.CanCollide = false
    tip1.Material = Enum.Material.Metal
    tip1.Color = Color3.fromRGB(192, 192, 192)
    tip1.Parent = model
    
    local tip2 = Instance.new("Part")
    tip2.Name = "Tip2"
    tip2.Shape = Enum.PartType.Wedge
    tip2.Size = Vector3.new(0.05, 0.2, 0.1)
    tip2.Position = Vector3.new(0, -0.6, 0)
    tip2.Anchored = true
    tip2.CanCollide = false
    tip2.Material = Enum.Material.Metal
    tip2.Color = Color3.fromRGB(192, 192, 192)
    tip2.Parent = model
    
    local tip3 = Instance.new("Part")
    tip3.Name = "Tip3"
    tip3.Shape = Enum.PartType.Wedge
    tip3.Size = Vector3.new(0.1, 0.05, 0.2)
    tip3.Position = Vector3.new(0.6, 0, 0)
    tip3.Rotation = Vector3.new(0, 0, 90)
    tip3.Anchored = true
    tip3.CanCollide = false
    tip3.Material = Enum.Material.Metal
    tip3.Color = Color3.fromRGB(192, 192, 192)
    tip3.Parent = model
    
    local tip4 = Instance.new("Part")
    tip4.Name = "Tip4"
    tip4.Shape = Enum.PartType.Wedge
    tip4.Size = Vector3.new(0.1, 0.05, 0.2)
    tip4.Position = Vector3.new(-0.6, 0, 0)
    tip4.Rotation = Vector3.new(0, 0, -90)
    tip4.Anchored = true
    tip4.CanCollide = false
    tip4.Material = Enum.Material.Metal
    tip4.Color = Color3.fromRGB(192, 192, 192)
    tip4.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.05, 0.1, 0.1)
    decoration1.Position = Vector3.new(0, 0.2, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.05, 0.1, 0.1)
    decoration2.Position = Vector3.new(0, -0.2, 0)
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
    glow.Brightness = 0.6
    glow.Parent = ring
    
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
    particles.Parent = ring
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "chakram")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 65)
    model:SetAttribute("WeaponSpeed", 1.3)
    model:SetAttribute("WeaponRange", 20)
    model:SetAttribute("WeaponWeight", 3)
    model:SetAttribute("WeaponDurability", 90)
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
    model:SetAttribute("WeaponValue", 2000)
    model:SetAttribute("WeaponDescription", "Метательное кольцо с острыми лезвиями")
    
    return model
end

return CreateChakram