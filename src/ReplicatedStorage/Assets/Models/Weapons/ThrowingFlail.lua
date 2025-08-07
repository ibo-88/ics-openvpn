-- ThrowingFlail.lua
-- Модель метательного цепа
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingFlail()
    local model = Instance.new("Model")
    model.Name = "ThrowingFlail"
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.06, 1.4, 0.06)
    handle.Position = Vector3.new(0, 0.7, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Цепь
    local chain = Instance.new("Part")
    chain.Name = "Chain"
    chain.Size = Vector3.new(0.04, 1.2, 0.04)
    chain.Position = Vector3.new(0, 1.9, 0)
    chain.Anchored = true
    chain.CanCollide = false
    chain.Material = Enum.Material.Metal
    chain.Color = Color3.fromRGB(192, 192, 192)
    chain.Parent = model
    
    -- Головка цепа
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Shape = Enum.PartType.Ball
    head.Size = Vector3.new(0.3, 0.3, 0.3)
    head.Position = Vector3.new(0, 2.5, 0)
    head.Anchored = true
    head.CanCollide = false
    head.Material = Enum.Material.Metal
    head.Color = Color3.fromRGB(105, 105, 105)
    head.Parent = model
    
    -- Шипы на головке
    local spike1 = Instance.new("Part")
    spike1.Name = "Spike1"
    spike1.Shape = Enum.PartType.Wedge
    spike1.Size = Vector3.new(0.08, 0.2, 0.08)
    spike1.Position = Vector3.new(0, 2.65, 0)
    spike1.Rotation = Vector3.new(0, 0, 180)
    spike1.Anchored = true
    spike1.CanCollide = false
    spike1.Material = Enum.Material.Metal
    spike1.Color = Color3.fromRGB(192, 192, 192)
    spike1.Parent = model
    
    local spike2 = Instance.new("Part")
    spike2.Name = "Spike2"
    spike2.Shape = Enum.PartType.Wedge
    spike2.Size = Vector3.new(0.08, 0.2, 0.08)
    spike2.Position = Vector3.new(0.15, 2.5, 0)
    spike2.Rotation = Vector3.new(0, 0, 90)
    spike2.Anchored = true
    spike2.CanCollide = false
    spike2.Material = Enum.Material.Metal
    spike2.Color = Color3.fromRGB(192, 192, 192)
    spike2.Parent = model
    
    local spike3 = Instance.new("Part")
    spike3.Name = "Spike3"
    spike3.Shape = Enum.PartType.Wedge
    spike3.Size = Vector3.new(0.08, 0.2, 0.08)
    spike3.Position = Vector3.new(-0.15, 2.5, 0)
    spike3.Rotation = Vector3.new(0, 0, -90)
    spike3.Anchored = true
    spike3.CanCollide = false
    spike3.Material = Enum.Material.Metal
    spike3.Color = Color3.fromRGB(192, 192, 192)
    spike3.Parent = model
    
    local spike4 = Instance.new("Part")
    spike4.Name = "Spike4"
    spike4.Shape = Enum.PartType.Wedge
    spike4.Size = Vector3.new(0.08, 0.2, 0.08)
    spike4.Position = Vector3.new(0, 2.35, 0)
    spike4.Anchored = true
    spike4.CanCollide = false
    spike4.Material = Enum.Material.Metal
    spike4.Color = Color3.fromRGB(192, 192, 192)
    spike4.Parent = model
    
    -- Крепление цепи
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.12, 0.12, 0.12)
    mount.Position = Vector3.new(0, 1.4, 0)
    mount.Anchored = true
    mount.CanCollide = false
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(105, 105, 105)
    mount.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.12, 0.12, 0.12)
    pommel.Position = Vector3.new(0, 0.06, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration1.Position = Vector3.new(0, 1.1, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration2.Position = Vector3.new(0, 0.4, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 0, 0)
    glow.Range = 2.5
    glow.Brightness = 0.5
    glow.Parent = head
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    particles.Size = NumberSequence.new(0.12, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = head
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_flail")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 75)
    model:SetAttribute("WeaponSpeed", 0.8)
    model:SetAttribute("WeaponRange", 16)
    model:SetAttribute("WeaponWeight", 6)
    model:SetAttribute("WeaponDurability", 100)
    model:SetAttribute("WeaponLevel", 19)
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
    model:SetAttribute("WeaponValue", 1600)
    model:SetAttribute("WeaponDescription", "Метательный цеп с острыми шипами")
    
    return model
end

return CreateThrowingFlail