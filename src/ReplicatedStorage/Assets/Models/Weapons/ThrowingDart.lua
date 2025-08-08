-- ThrowingDart.lua
-- Модель метательного дротика
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingDart()
    local model = Instance.new("Model")
    model.Name = "ThrowingDart"
    
    -- Древко
    local shaft = Instance.new("Part")
    shaft.Name = "Shaft"
    shaft.Size = Vector3.new(0.04, 0.8, 0.04)
    shaft.Position = Vector3.new(0, 0.4, 0)
    shaft.Anchored = true
    shaft.CanCollide = false
    shaft.Material = Enum.Material.Wood
    shaft.Color = Color3.fromRGB(139, 69, 19)
    shaft.Parent = model
    
    -- Наконечник
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.06, 0.18, 0.06)
    tip.Position = Vector3.new(0, 0.85, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Оперение
    local feather = Instance.new("Part")
    feather.Name = "Feather"
    feather.Size = Vector3.new(0.08, 0.08, 0.02)
    feather.Position = Vector3.new(0, 0, 0)
    feather.Anchored = true
    feather.CanCollide = false
    feather.Material = Enum.Material.Fabric
    feather.Color = Color3.fromRGB(255, 255, 255)
    feather.Parent = model
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.03, 0.06, 0.03)
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
    glow.Range = 1.2
    glow.Brightness = 0.3
    glow.Parent = tip
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.05, 0)
    particles.Transparency = NumberSequence.new(0.6, 1)
    particles.Rate = 6
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.Speed = NumberRange.new(0.3, 0.8)
    particles.SpreadAngle = Vector2.new(8, 8)
    particles.Parent = tip
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_dart")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 18)
    model:SetAttribute("WeaponSpeed", 2.2)
    model:SetAttribute("WeaponRange", 10)
    model:SetAttribute("WeaponWeight", 0.2)
    model:SetAttribute("WeaponDurability", 20)
    model:SetAttribute("WeaponLevel", 2)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "rogue")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", false)
    model:SetAttribute("WeaponUpgradeable", false)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 50)
    model:SetAttribute("WeaponDescription", "Легкий метательный дротик")
    
    return model
end

return CreateThrowingDart