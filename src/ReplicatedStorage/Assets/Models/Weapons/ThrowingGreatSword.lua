-- ThrowingGreatSword.lua
-- Модель метательного двуручного меча
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingGreatSword()
    local model = Instance.new("Model")
    model.Name = "ThrowingGreatSword"
    
    -- Лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.15, 2.2, 0.08)
    blade.Position = Vector3.new(0, 1.1, 0)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192)
    blade.Parent = model
    
    -- Острие лезвия
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.15, 0.4, 0.08)
    tip.Position = Vector3.new(0, 2.2, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.12, 0.8, 0.12)
    handle.Position = Vector3.new(0, -0.4, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Гарда
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.6, 0.08, 0.2)
    guard.Position = Vector3.new(0, 0, 0)
    guard.Anchored = true
    guard.CanCollide = false
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(105, 105, 105)
    guard.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.18, 0.18, 0.18)
    pommel.Position = Vector3.new(0, -0.8, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Дол (канавка на лезвии)
    local fuller = Instance.new("Part")
    fuller.Name = "Fuller"
    fuller.Size = Vector3.new(0.03, 1.8, 0.03)
    fuller.Position = Vector3.new(0, 1.1, 0)
    fuller.Anchored = true
    fuller.CanCollide = false
    fuller.Material = Enum.Material.Metal
    fuller.Color = Color3.fromRGB(169, 169, 169)
    fuller.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.06, 0.1, 0.06)
    decoration1.Position = Vector3.new(0, 0.6, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.06, 0.1, 0.06)
    decoration2.Position = Vector3.new(0, 1.6, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 3
    glow.Brightness = 0.5
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.12, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = blade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_greatsword")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 80)
    model:SetAttribute("WeaponSpeed", 0.8)
    model:SetAttribute("WeaponRange", 18)
    model:SetAttribute("WeaponWeight", 7)
    model:SetAttribute("WeaponDurability", 110)
    model:SetAttribute("WeaponLevel", 20)
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
    model:SetAttribute("WeaponValue", 1800)
    model:SetAttribute("WeaponDescription", "Метательный двуручный меч")
    
    return model
end

return CreateThrowingGreatSword