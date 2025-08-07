-- Shuriken.lua
-- Модель сюрикена
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateShuriken()
    local model = Instance.new("Model")
    model.Name = "Shuriken"
    
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
    local blade1 = Instance.new("Part")
    blade1.Name = "Blade1"
    blade1.Size = Vector3.new(0.05, 0.8, 0.1)
    blade1.Position = Vector3.new(0, 0.4, 0)
    blade1.Anchored = true
    blade1.CanCollide = false
    blade1.Material = Enum.Material.Metal
    blade1.Color = Color3.fromRGB(192, 192, 192)
    blade1.Parent = model
    
    local blade2 = Instance.new("Part")
    blade2.Name = "Blade2"
    blade2.Size = Vector3.new(0.05, 0.8, 0.1)
    blade2.Position = Vector3.new(0, -0.4, 0)
    blade2.Anchored = true
    blade2.CanCollide = false
    blade2.Material = Enum.Material.Metal
    blade2.Color = Color3.fromRGB(192, 192, 192)
    blade2.Parent = model
    
    local blade3 = Instance.new("Part")
    blade3.Name = "Blade3"
    blade3.Size = Vector3.new(0.1, 0.05, 0.8)
    blade3.Position = Vector3.new(0.4, 0, 0)
    blade3.Anchored = true
    blade3.CanCollide = false
    blade3.Material = Enum.Material.Metal
    blade3.Color = Color3.fromRGB(192, 192, 192)
    blade3.Parent = model
    
    local blade4 = Instance.new("Part")
    blade4.Name = "Blade4"
    blade4.Size = Vector3.new(0.1, 0.05, 0.8)
    blade4.Position = Vector3.new(-0.4, 0, 0)
    blade4.Anchored = true
    blade4.CanCollide = false
    blade4.Material = Enum.Material.Metal
    blade4.Color = Color3.fromRGB(192, 192, 192)
    blade4.Parent = model
    
    -- Острия лезвий
    local tip1 = Instance.new("Part")
    tip1.Name = "Tip1"
    tip1.Shape = Enum.PartType.Wedge
    tip1.Size = Vector3.new(0.05, 0.2, 0.1)
    tip1.Position = Vector3.new(0, 0.9, 0)
    tip1.Rotation = Vector3.new(0, 0, 180)
    tip1.Anchored = true
    tip1.CanCollide = false
    tip1.Material = Enum.Material.Metal
    tip1.Color = Color3.fromRGB(192, 192, 192)
    tip1.Parent = model
    
    local tip2 = Instance.new("Part")
    tip2.Name = "Tip2"
    tip2.Shape = Enum.PartType.Wedge
    tip2.Size = Vector3.new(0.05, 0.2, 0.1)
    tip2.Position = Vector3.new(0, -0.9, 0)
    tip2.Anchored = true
    tip2.CanCollide = false
    tip2.Material = Enum.Material.Metal
    tip2.Color = Color3.fromRGB(192, 192, 192)
    tip2.Parent = model
    
    local tip3 = Instance.new("Part")
    tip3.Name = "Tip3"
    tip3.Shape = Enum.PartType.Wedge
    tip3.Size = Vector3.new(0.1, 0.05, 0.2)
    tip3.Position = Vector3.new(0.9, 0, 0)
    tip3.Rotation = Vector3.new(0, 0, 90)
    tip3.Anchored = true
    tip3.CanCollide = false
    tip3.Material = Enum.Material.Metal
    tip3.Color = Color3.fromRGB(192, 192, 192)
    tip3.Parent = model
    
    local tip4 = Instance.new("Part")
    tip4.Name = "Tip4"
    tip4.Shape = Enum.PartType.Wedge
    tip4.Size = Vector3.new(0.1, 0.05, 0.2)
    tip4.Position = Vector3.new(-0.9, 0, 0)
    tip4.Rotation = Vector3.new(0, 0, -90)
    tip4.Anchored = true
    tip4.CanCollide = false
    tip4.Material = Enum.Material.Metal
    tip4.Color = Color3.fromRGB(192, 192, 192)
    tip4.Parent = model
    
    -- Дополнительные лезвия (диагональные)
    local blade5 = Instance.new("Part")
    blade5.Name = "Blade5"
    blade5.Size = Vector3.new(0.05, 0.6, 0.1)
    blade5.Position = Vector3.new(0.3, 0.3, 0)
    blade5.Rotation = Vector3.new(0, 0, 45)
    blade5.Anchored = true
    blade5.CanCollide = false
    blade5.Material = Enum.Material.Metal
    blade5.Color = Color3.fromRGB(169, 169, 169)
    blade5.Parent = model
    
    local blade6 = Instance.new("Part")
    blade6.Name = "Blade6"
    blade6.Size = Vector3.new(0.05, 0.6, 0.1)
    blade6.Position = Vector3.new(-0.3, 0.3, 0)
    blade6.Rotation = Vector3.new(0, 0, -45)
    blade6.Anchored = true
    blade6.CanCollide = false
    blade6.Material = Enum.Material.Metal
    blade6.Color = Color3.fromRGB(169, 169, 169)
    blade6.Parent = model
    
    local blade7 = Instance.new("Part")
    blade7.Name = "Blade7"
    blade7.Size = Vector3.new(0.05, 0.6, 0.1)
    blade7.Position = Vector3.new(0.3, -0.3, 0)
    blade7.Rotation = Vector3.new(0, 0, -45)
    blade7.Anchored = true
    blade7.CanCollide = false
    blade7.Material = Enum.Material.Metal
    blade7.Color = Color3.fromRGB(169, 169, 169)
    blade7.Parent = model
    
    local blade8 = Instance.new("Part")
    blade8.Name = "Blade8"
    blade8.Size = Vector3.new(0.05, 0.6, 0.1)
    blade8.Position = Vector3.new(-0.3, -0.3, 0)
    blade8.Rotation = Vector3.new(0, 0, 45)
    blade8.Anchored = true
    blade8.CanCollide = false
    blade8.Material = Enum.Material.Metal
    blade8.Color = Color3.fromRGB(169, 169, 169)
    blade8.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 2.5
    glow.Brightness = 0.5
    glow.Parent = center
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.5, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(0.8, 1.5)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = center
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "shuriken")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 40)
    model:SetAttribute("WeaponSpeed", 1.8)
    model:SetAttribute("WeaponRange", 12)
    model:SetAttribute("WeaponWeight", 1)
    model:SetAttribute("WeaponDurability", 50)
    model:SetAttribute("WeaponLevel", 10)
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
    model:SetAttribute("WeaponValue", 500)
    model:SetAttribute("WeaponDescription", "Острый сюрикен с восемью лезвиями")
    
    return model
end

return CreateShuriken