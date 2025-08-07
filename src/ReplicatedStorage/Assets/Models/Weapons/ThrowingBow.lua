-- ThrowingBow.lua
-- Модель метательного лука
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingBow()
    local model = Instance.new("Model")
    model.Name = "ThrowingBow"
    
    -- Основная часть лука
    local bow = Instance.new("Part")
    bow.Name = "Bow"
    bow.Size = Vector3.new(0.08, 2.5, 0.08)
    bow.Position = Vector3.new(0, 1.25, 0)
    bow.Anchored = true
    bow.CanCollide = false
    bow.Material = Enum.Material.Wood
    bow.Color = Color3.fromRGB(139, 69, 19)
    bow.Parent = model
    
    -- Тетива
    local string = Instance.new("Part")
    string.Name = "String"
    string.Size = Vector3.new(0.02, 2.3, 0.02)
    string.Position = Vector3.new(0, 1.25, 0.05)
    string.Anchored = true
    string.CanCollide = false
    string.Material = Enum.Material.Fabric
    string.Color = Color3.fromRGB(255, 255, 255)
    string.Parent = model
    
    -- Рукоять
    local grip = Instance.new("Part")
    grip.Name = "Grip"
    grip.Size = Vector3.new(0.12, 0.3, 0.12)
    grip.Position = Vector3.new(0, 1.25, 0)
    grip.Anchored = true
    grip.CanCollide = false
    grip.Material = Enum.Material.Fabric
    grip.Color = Color3.fromRGB(101, 67, 33)
    grip.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration1.Position = Vector3.new(0, 2, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.08, 0.15, 0.08)
    decoration2.Position = Vector3.new(0, 0.5, 0)
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
    glow.Brightness = 0.3
    glow.Parent = bow
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.6, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(1, 1.5)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = bow
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_bow")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 45)
    model:SetAttribute("WeaponSpeed", 1.4)
    model:SetAttribute("WeaponRange", 18)
    model:SetAttribute("WeaponWeight", 2)
    model:SetAttribute("WeaponDurability", 70)
    model:SetAttribute("WeaponLevel", 11)
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
    model:SetAttribute("WeaponValue", 800)
    model:SetAttribute("WeaponDescription", "Метательный лук с тетивой")
    
    return model
end

return CreateThrowingBow