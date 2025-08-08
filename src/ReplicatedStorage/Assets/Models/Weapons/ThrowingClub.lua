-- ThrowingClub.lua
-- Модель метательной дубинки
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingClub()
    local model = Instance.new("Model")
    model.Name = "ThrowingClub"
    
    -- Основная часть
    local club = Instance.new("Part")
    club.Name = "Club"
    club.Size = Vector3.new(0.15, 1.1, 0.15)
    club.Position = Vector3.new(0, 0.55, 0)
    club.Anchored = true
    club.CanCollide = false
    club.Material = Enum.Material.Wood
    club.Color = Color3.fromRGB(139, 69, 19)
    club.Parent = model
    
    -- Усиленный конец
    local endPart = Instance.new("Part")
    endPart.Name = "EndPart"
    endPart.Size = Vector3.new(0.2, 0.2, 0.2)
    endPart.Position = Vector3.new(0, 1.1, 0)
    endPart.Anchored = true
    endPart.CanCollide = false
    endPart.Material = Enum.Material.Metal
    endPart.Color = Color3.fromRGB(105, 105, 105)
    endPart.Parent = model
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration.Position = Vector3.new(0, 0.3, 0)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 1.5
    glow.Brightness = 0.3
    glow.Parent = endPart
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 6
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(8, 8)
    particles.Parent = endPart
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_club")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 22)
    model:SetAttribute("WeaponSpeed", 1.5)
    model:SetAttribute("WeaponRange", 8)
    model:SetAttribute("WeaponWeight", 1.5)
    model:SetAttribute("WeaponDurability", 35)
    model:SetAttribute("WeaponLevel", 3)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "warrior")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", false)
    model:SetAttribute("WeaponUpgradeable", false)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 80)
    model:SetAttribute("WeaponDescription", "Простая метательная дубинка")
    
    return model
end

return CreateThrowingClub