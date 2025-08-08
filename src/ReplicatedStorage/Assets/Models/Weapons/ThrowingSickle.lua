-- ThrowingSickle.lua
-- Модель метательного серпа
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingSickle()
    local model = Instance.new("Model")
    model.Name = "ThrowingSickle"
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.06, 0.7, 0.06)
    handle.Position = Vector3.new(0, 0.35, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Лезвие серпа (дуга)
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Shape = Enum.PartType.Cylinder
    blade.Size = Vector3.new(0.05, 0.7, 0.7)
    blade.Position = Vector3.new(0, 0.7, 0)
    blade.Rotation = Vector3.new(0, 0, 90)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192)
    blade.Parent = model
    
    -- Острие
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.08, 0.18, 0.08)
    tip.Position = Vector3.new(0, 1.05, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.04, 0.08, 0.04)
    decoration.Position = Vector3.new(0, 0.2, 0)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 1.5
    glow.Brightness = 0.3
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.07, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 6
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(8, 8)
    particles.Parent = blade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_sickle")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 28)
    model:SetAttribute("WeaponSpeed", 1.6)
    model:SetAttribute("WeaponRange", 9)
    model:SetAttribute("WeaponWeight", 0.9)
    model:SetAttribute("WeaponDurability", 30)
    model:SetAttribute("WeaponLevel", 5)
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
    model:SetAttribute("WeaponValue", 200)
    model:SetAttribute("WeaponDescription", "Метательный серп с острым лезвием")
    
    return model
end

return CreateThrowingSickle