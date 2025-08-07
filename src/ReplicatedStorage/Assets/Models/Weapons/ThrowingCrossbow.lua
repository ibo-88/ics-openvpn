-- ThrowingCrossbow.lua
-- Модель метательного арбалета
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingCrossbow()
    local model = Instance.new("Model")
    model.Name = "ThrowingCrossbow"
    
    -- Основная часть арбалета
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(0.1, 1.8, 0.1)
    body.Position = Vector3.new(0, 0.9, 0)
    body.Anchored = true
    body.CanCollide = false
    body.Material = Enum.Material.Wood
    body.Color = Color3.fromRGB(139, 69, 19)
    body.Parent = model
    
    -- Лук арбалета
    local bow = Instance.new("Part")
    bow.Name = "Bow"
    bow.Size = Vector3.new(0.08, 1.2, 0.08)
    bow.Position = Vector3.new(0, 1.8, 0)
    bow.Anchored = true
    bow.CanCollide = false
    bow.Material = Enum.Material.Wood
    bow.Color = Color3.fromRGB(139, 69, 19)
    bow.Parent = model
    
    -- Тетива
    local string = Instance.new("Part")
    string.Name = "String"
    string.Size = Vector3.new(0.02, 1, 0.02)
    string.Position = Vector3.new(0, 1.8, 0.06)
    string.Anchored = true
    string.CanCollide = false
    string.Material = Enum.Material.Fabric
    string.Color = Color3.fromRGB(255, 255, 255)
    string.Parent = model
    
    -- Рукоять
    local grip = Instance.new("Part")
    grip.Name = "Grip"
    grip.Size = Vector3.new(0.08, 0.4, 0.08)
    grip.Position = Vector3.new(0, 0.2, 0)
    grip.Anchored = true
    grip.CanCollide = false
    grip.Material = Enum.Material.Wood
    grip.Color = Color3.fromRGB(101, 67, 33)
    grip.Parent = model
    
    -- Спусковой крючок
    local trigger = Instance.new("Part")
    trigger.Name = "Trigger"
    trigger.Size = Vector3.new(0.02, 0.1, 0.02)
    trigger.Position = Vector3.new(0, 0.4, 0.06)
    trigger.Anchored = true
    trigger.CanCollide = false
    trigger.Material = Enum.Material.Metal
    trigger.Color = Color3.fromRGB(105, 105, 105)
    trigger.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration1.Position = Vector3.new(0, 1.5, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration2.Position = Vector3.new(0, 0.8, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 2.5
    glow.Brightness = 0.4
    glow.Parent = body
    
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
    particles.Parent = body
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_crossbow")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 60)
    model:SetAttribute("WeaponSpeed", 1.0)
    model:SetAttribute("WeaponRange", 25)
    model:SetAttribute("WeaponWeight", 4)
    model:SetAttribute("WeaponDurability", 80)
    model:SetAttribute("WeaponLevel", 14)
    model:SetAttribute("WeaponRarity", "rare")
    model:SetAttribute("WeaponClass", "archer")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 1000)
    model:SetAttribute("WeaponDescription", "Метательный арбалет с тетивой")
    
    return model
end

return CreateThrowingCrossbow