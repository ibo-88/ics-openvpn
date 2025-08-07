-- ThrowingSpear.lua
-- Модель метательного копья
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingSpear()
    local model = Instance.new("Model")
    model.Name = "ThrowingSpear"
    
    -- Древко
    local shaft = Instance.new("Part")
    shaft.Name = "Shaft"
    shaft.Size = Vector3.new(0.06, 2.2, 0.06)
    shaft.Position = Vector3.new(0, 1.1, 0)
    shaft.Anchored = true
    shaft.CanCollide = false
    shaft.Material = Enum.Material.Wood
    shaft.Color = Color3.fromRGB(139, 69, 19)
    shaft.Parent = model
    
    -- Наконечник
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.08, 0.6, 0.08)
    tip.Position = Vector3.new(0, 2.5, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Крепление наконечника
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.12, 0.15, 0.12)
    mount.Position = Vector3.new(0, 2.2, 0)
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
    decoration1.Position = Vector3.new(0, 1.8, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration2.Position = Vector3.new(0, 1.4, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    local decoration3 = Instance.new("Part")
    decoration3.Name = "Decoration3"
    decoration3.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration3.Position = Vector3.new(0, 1, 0)
    decoration3.Anchored = true
    decoration3.CanCollide = false
    decoration3.Material = Enum.Material.Metal
    decoration3.Color = Color3.fromRGB(255, 215, 0)
    decoration3.Parent = model
    
    local decoration4 = Instance.new("Part")
    decoration4.Name = "Decoration4"
    decoration4.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration4.Position = Vector3.new(0, 0.6, 0)
    decoration4.Anchored = true
    decoration4.CanCollide = false
    decoration4.Material = Enum.Material.Metal
    decoration4.Color = Color3.fromRGB(255, 215, 0)
    decoration4.Parent = model
    
    local decoration5 = Instance.new("Part")
    decoration5.Name = "Decoration5"
    decoration5.Size = Vector3.new(0.06, 0.12, 0.06)
    decoration5.Position = Vector3.new(0, 0.2, 0)
    decoration5.Anchored = true
    decoration5.CanCollide = false
    decoration5.Material = Enum.Material.Metal
    decoration5.Color = Color3.fromRGB(255, 215, 0)
    decoration5.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 2
    glow.Brightness = 0.4
    glow.Parent = tip
    
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
    particles.Parent = tip
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_spear")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 55)
    model:SetAttribute("WeaponSpeed", 1.1)
    model:SetAttribute("WeaponRange", 22)
    model:SetAttribute("WeaponWeight", 4)
    model:SetAttribute("WeaponDurability", 80)
    model:SetAttribute("WeaponLevel", 13)
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
    model:SetAttribute("WeaponValue", 850)
    model:SetAttribute("WeaponDescription", "Метательное копье с острым наконечником")
    
    return model
end

return CreateThrowingSpear