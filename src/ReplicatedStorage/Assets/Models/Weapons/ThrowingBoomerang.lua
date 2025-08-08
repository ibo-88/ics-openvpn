-- ThrowingBoomerang.lua
-- Модель метательного бумеранга
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingBoomerang()
    local model = Instance.new("Model")
    model.Name = "ThrowingBoomerang"
    
    -- Основная часть
    local boomerang = Instance.new("Part")
    boomerang.Name = "Boomerang"
    boomerang.Shape = Enum.PartType.CornerWedge
    boomerang.Size = Vector3.new(1.2, 0.15, 0.4)
    boomerang.Position = Vector3.new(0, 0.1, 0)
    boomerang.Anchored = true
    boomerang.CanCollide = false
    boomerang.Material = Enum.Material.Wood
    boomerang.Color = Color3.fromRGB(139, 69, 19)
    boomerang.Parent = model
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.2, 0.15, 0.2)
    decoration.Position = Vector3.new(0.4, 0.1, 0)
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
    glow.Brightness = 0.3
    glow.Parent = boomerang
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = boomerang
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_boomerang")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 35)
    model:SetAttribute("WeaponSpeed", 1.7)
    model:SetAttribute("WeaponRange", 14)
    model:SetAttribute("WeaponWeight", 1)
    model:SetAttribute("WeaponDurability", 60)
    model:SetAttribute("WeaponLevel", 8)
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
    model:SetAttribute("WeaponValue", 400)
    model:SetAttribute("WeaponDescription", "Метательный бумеранг из прочного дерева")
    
    return model
end

return CreateThrowingBoomerang