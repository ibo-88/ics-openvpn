-- ThrowingKatana.lua
-- Модель метательной катаны
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingKatana()
    local model = Instance.new("Model")
    model.Name = "ThrowingKatana"
    
    -- Лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.12, 1.8, 0.06)
    blade.Position = Vector3.new(0, 0.9, 0)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(220, 220, 220)
    blade.Parent = model
    
    -- Острие лезвия
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.12, 0.3, 0.06)
    tip.Position = Vector3.new(0, 1.8, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(220, 220, 220)
    tip.Parent = model
    
    -- Рукоять (цука)
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.1, 0.6, 0.1)
    handle.Position = Vector3.new(0, -0.3, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Fabric
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Гарда (цуба)
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Shape = Enum.PartType.Cylinder
    guard.Size = Vector3.new(0.08, 0.4, 0.4)
    guard.Position = Vector3.new(0, 0, 0)
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
    pommel.Size = Vector3.new(0.08, 0.2, 0.2)
    pommel.Position = Vector3.new(0, -0.6, 0)
    pommel.Rotation = Vector3.new(0, 0, 90)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Хамон (линия закалки)
    local hamon = Instance.new("Part")
    hamon.Name = "Hamon"
    hamon.Size = Vector3.new(0.015, 1.5, 0.015)
    hamon.Position = Vector3.new(0, 0.9, 0)
    hamon.Anchored = true
    hamon.CanCollide = false
    hamon.Material = Enum.Material.Metal
    hamon.Color = Color3.fromRGB(169, 169, 169)
    hamon.Parent = model
    
    -- Ножны (сая)
    local saya = Instance.new("Part")
    saya.Name = "Saya"
    saya.Size = Vector3.new(0.15, 2.4, 0.15)
    saya.Position = Vector3.new(0, 1.2, 0.2)
    saya.Anchored = true
    saya.CanCollide = false
    saya.Material = Enum.Material.Wood
    saya.Color = Color3.fromRGB(101, 67, 33)
    saya.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.04, 0.08, 0.04)
    decoration1.Position = Vector3.new(0, 0.4, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.04, 0.08, 0.04)
    decoration2.Position = Vector3.new(0, 1.4, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 255)
    glow.Range = 2.5
    glow.Brightness = 0.4
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    particles.Size = NumberSequence.new(0.1, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 10
    particles.Lifetime = NumberRange.new(1, 1.5)
    particles.Speed = NumberRange.new(0.8, 1.5)
    particles.SpreadAngle = Vector2.new(12, 12)
    particles.Parent = blade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_katana")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 65)
    model:SetAttribute("WeaponSpeed", 1.2)
    model:SetAttribute("WeaponRange", 16)
    model:SetAttribute("WeaponWeight", 3)
    model:SetAttribute("WeaponDurability", 90)
    model:SetAttribute("WeaponLevel", 17)
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
    model:SetAttribute("WeaponValue", 1400)
    model:SetAttribute("WeaponDescription", "Метательная катана с идеальным балансом")
    
    return model
end

return CreateThrowingKatana