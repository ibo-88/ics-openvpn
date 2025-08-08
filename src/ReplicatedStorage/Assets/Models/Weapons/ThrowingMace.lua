-- ThrowingMace.lua
-- Модель метательной булавы
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingMace()
    local model = Instance.new("Model")
    model.Name = "ThrowingMace"
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 1.2, 0.08)
    handle.Position = Vector3.new(0, 0.6, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Головка булавы
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Shape = Enum.PartType.Ball
    head.Size = Vector3.new(0.4, 0.4, 0.4)
    head.Position = Vector3.new(0, 1.3, 0)
    head.Anchored = true
    head.CanCollide = false
    head.Material = Enum.Material.Metal
    head.Color = Color3.fromRGB(105, 105, 105)
    head.Parent = model
    
    -- Шипы
    for i = 1, 6 do
        local spike = Instance.new("Part")
        spike.Name = "Spike" .. i
        spike.Size = Vector3.new(0.08, 0.2, 0.08)
        spike.Position = head.Position + Vector3.new(math.cos(math.pi*2*i/6)*0.2, 1.3, math.sin(math.pi*2*i/6)*0.2)
        spike.Anchored = true
        spike.CanCollide = false
        spike.Material = Enum.Material.Metal
        spike.Color = Color3.fromRGB(192, 192, 192)
        spike.Parent = model
    end
    
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
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration.Position = Vector3.new(0, 0.4, 0)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
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
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(1, 1.5)
    particles.Speed = NumberRange.new(0.8, 1.2)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = head
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_mace")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 70)
    model:SetAttribute("WeaponSpeed", 1.0)
    model:SetAttribute("WeaponRange", 12)
    model:SetAttribute("WeaponWeight", 5)
    model:SetAttribute("WeaponDurability", 90)
    model:SetAttribute("WeaponLevel", 15)
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
    model:SetAttribute("WeaponValue", 1100)
    model:SetAttribute("WeaponDescription", "Метательная булава с шипами")
    
    return model
end

return CreateThrowingMace