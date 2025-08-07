-- ThrowingKnife.lua
-- Модель метательного ножа
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingKnife()
    local model = Instance.new("Model")
    model.Name = "ThrowingKnife"
    
    -- Лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.1, 1.5, 0.05)
    blade.Position = Vector3.new(0, 0.75, 0)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192)
    blade.Parent = model
    
    -- Острие
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.1, 0.3, 0.05)
    tip.Position = Vector3.new(0, 1.65, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 0.4, 0.08)
    handle.Position = Vector3.new(0, -0.2, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.15, 0.15, 0.15)
    pommel.Position = Vector3.new(0, -0.4, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Дол (канавка на лезвии)
    local fuller = Instance.new("Part")
    fuller.Name = "Fuller"
    fuller.Size = Vector3.new(0.02, 1.2, 0.02)
    fuller.Position = Vector3.new(0, 0.75, 0)
    fuller.Anchored = true
    fuller.CanCollide = false
    fuller.Material = Enum.Material.Metal
    fuller.Color = Color3.fromRGB(169, 169, 169)
    fuller.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.05, 0.1, 0.05)
    decoration1.Position = Vector3.new(0, 0.3, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.05, 0.1, 0.05)
    decoration2.Position = Vector3.new(0, 1.2, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 255)
    glow.Range = 2
    glow.Brightness = 0.4
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.6, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(8, 8)
    particles.Parent = blade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_knife")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 45)
    model:SetAttribute("WeaponSpeed", 1.5)
    model:SetAttribute("WeaponRange", 15)
    model:SetAttribute("WeaponWeight", 1)
    model:SetAttribute("WeaponDurability", 60)
    model:SetAttribute("WeaponLevel", 12)
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
    model:SetAttribute("WeaponValue", 600)
    model:SetAttribute("WeaponDescription", "Острый метательный нож")
    
    return model
end

return CreateThrowingKnife