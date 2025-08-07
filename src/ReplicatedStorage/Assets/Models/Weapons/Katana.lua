-- Katana.lua
-- Модель катаны
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateKatana()
    local model = Instance.new("Model")
    model.Name = "Katana"
    
    -- Основное лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.15, 3.5, 0.08)
    blade.Position = Vector3.new(0, 1.75, 0)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(220, 220, 220)
    blade.Parent = model
    
    -- Острие лезвия
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.15, 0.4, 0.08)
    tip.Position = Vector3.new(0, 3.7, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(220, 220, 220)
    tip.Parent = model
    
    -- Рукоять (цука)
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.12, 1, 0.12)
    handle.Position = Vector3.new(0, -0.5, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Fabric
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Гарда (цуба)
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Shape = Enum.PartType.Cylinder
    guard.Size = Vector3.new(0.1, 0.6, 0.6)
    guard.Position = Vector3.new(0, 0.5, 0)
    guard.Rotation = Vector3.new(0, 0, 90)
    guard.Anchored = true
    guard.CanCollide = false
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(105, 105, 105)
    guard.Parent = model
    
    -- Навершие (кашира)
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Cylinder
    pommel.Size = Vector3.new(0.1, 0.3, 0.3)
    pommel.Position = Vector3.new(0, -1, 0)
    pommel.Rotation = Vector3.new(0, 0, 90)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Хамон (линия закалки)
    local hamon = Instance.new("Part")
    hamon.Name = "Hamon"
    hamon.Size = Vector3.new(0.02, 3, 0.02)
    hamon.Position = Vector3.new(0, 1.75, 0)
    hamon.Anchored = true
    hamon.CanCollide = false
    hamon.Material = Enum.Material.Metal
    hamon.Color = Color3.fromRGB(169, 169, 169)
    hamon.Parent = model
    
    -- Ножны (сая)
    local saya = Instance.new("Part")
    saya.Name = "Saya"
    saya.Size = Vector3.new(0.2, 4.5, 0.2)
    saya.Position = Vector3.new(0, 2.25, 0.3)
    saya.Anchored = true
    saya.CanCollide = false
    saya.Material = Enum.Material.Wood
    saya.Color = Color3.fromRGB(101, 67, 33)
    saya.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 255)
    glow.Range = 2
    glow.Brightness = 0.3
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    particles.Size = NumberSequence.new(0.05, 0)
    particles.Transparency = NumberSequence.new(0.7, 1)
    particles.Rate = 5
    particles.Lifetime = NumberRange.new(0.5, 1)
    particles.Speed = NumberRange.new(0.3, 0.8)
    particles.SpreadAngle = Vector2.new(5, 5)
    particles.Parent = blade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "katana")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 65)
    model:SetAttribute("WeaponSpeed", 1.2)
    model:SetAttribute("WeaponRange", 3.5)
    model:SetAttribute("WeaponWeight", 3)
    model:SetAttribute("WeaponDurability", 120)
    model:SetAttribute("WeaponLevel", 20)
    model:SetAttribute("WeaponRarity", "epic")
    model:SetAttribute("WeaponClass", "warrior")
    model:SetAttribute("WeaponSubclass", "one-handed")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 2500)
    model:SetAttribute("WeaponDescription", "Изящная катана с идеальным балансом")
    
    return model
end

return CreateKatana