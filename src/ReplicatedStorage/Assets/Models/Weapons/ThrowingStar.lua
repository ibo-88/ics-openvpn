-- ThrowingStar.lua
-- Модель метательной звезды
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingStar()
    local model = Instance.new("Model")
    model.Name = "ThrowingStar"
    
    -- Центральная часть
    local center = Instance.new("Part")
    center.Name = "Center"
    center.Shape = Enum.PartType.Cylinder
    center.Size = Vector3.new(0.1, 0.3, 0.3)
    center.Position = Vector3.new(0, 0, 0)
    center.Rotation = Vector3.new(0, 0, 90)
    center.Anchored = true
    center.CanCollide = false
    center.Material = Enum.Material.Metal
    center.Color = Color3.fromRGB(105, 105, 105)
    center.Parent = model
    
    -- Лезвия
    for i = 1, 5 do
        local blade = Instance.new("Part")
        blade.Name = "Blade" .. i
        blade.Size = Vector3.new(0.05, 0.7, 0.1)
        blade.Position = Vector3.new(math.cos(math.pi*2*i/5)*0.35, math.sin(math.pi*2*i/5)*0.35, 0)
        blade.Rotation = Vector3.new(0, 0, 72*i)
        blade.Anchored = true
        blade.CanCollide = false
        blade.Material = Enum.Material.Metal
        blade.Color = Color3.fromRGB(192, 192, 192)
        blade.Parent = model
    end
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Size = Vector3.new(0.05, 0.1, 0.05)
    decoration.Position = Vector3.new(0, 0.2, 0)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 2
    glow.Brightness = 0.4
    glow.Parent = center
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.5, 1)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = center
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_star")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 32)
    model:SetAttribute("WeaponSpeed", 1.9)
    model:SetAttribute("WeaponRange", 11)
    model:SetAttribute("WeaponWeight", 0.7)
    model:SetAttribute("WeaponDurability", 40)
    model:SetAttribute("WeaponLevel", 7)
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
    model:SetAttribute("WeaponValue", 350)
    model:SetAttribute("WeaponDescription", "Метательная звезда с пятью лезвиями")
    
    return model
end

return CreateThrowingStar