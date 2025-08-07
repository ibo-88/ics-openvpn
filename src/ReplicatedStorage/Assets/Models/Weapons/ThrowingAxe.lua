-- ThrowingAxe.lua
-- Модель метательного топора
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingAxe()
    local model = Instance.new("Model")
    model.Name = "ThrowingAxe"
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 1.5, 0.08)
    handle.Position = Vector3.new(0, 0.75, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Головка топора
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(0.4, 0.6, 0.15)
    head.Position = Vector3.new(0, 1.8, 0)
    head.Anchored = true
    head.CanCollide = false
    head.Material = Enum.Material.Metal
    head.Color = Color3.fromRGB(105, 105, 105)
    head.Parent = model
    
    -- Лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.5, 0.1, 0.05)
    blade.Position = Vector3.new(0, 2.05, 0)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192)
    blade.Parent = model
    
    -- Острие лезвия
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.1, 0.5, 0.05)
    tip.Position = Vector3.new(0, 2.35, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Крепление
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.15, 0.2, 0.15)
    mount.Position = Vector3.new(0, 1.5, 0)
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
    decoration1.Position = Vector3.new(0, 1.2, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration2.Position = Vector3.new(0, 0.3, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 2
    glow.Brightness = 0.4
    glow.Parent = head
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.1, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 10
    particles.Lifetime = NumberRange.new(1, 1.5)
    particles.Speed = NumberRange.new(0.8, 1.5)
    particles.SpreadAngle = Vector2.new(12, 12)
    particles.Parent = head
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_axe")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 55)
    model:SetAttribute("WeaponSpeed", 1.2)
    model:SetAttribute("WeaponRange", 18)
    model:SetAttribute("WeaponWeight", 4)
    model:SetAttribute("WeaponDurability", 80)
    model:SetAttribute("WeaponLevel", 14)
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
    model:SetAttribute("WeaponValue", 900)
    model:SetAttribute("WeaponDescription", "Метательный топор с острым лезвием")
    
    return model
end

return CreateThrowingAxe