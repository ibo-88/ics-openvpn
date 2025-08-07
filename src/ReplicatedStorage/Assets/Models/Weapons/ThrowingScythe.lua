-- ThrowingScythe.lua
-- Модель метательной косы
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingScythe()
    local model = Instance.new("Model")
    model.Name = "ThrowingScythe"
    
    -- Древко
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.06, 1.8, 0.06)
    handle.Position = Vector3.new(0, 0.9, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Лезвие косы
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.6, 0.08, 0.04)
    blade.Position = Vector3.new(0.3, 1.8, 0)
    blade.Rotation = Vector3.new(0, 0, 45)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192)
    blade.Parent = model
    
    -- Острие лезвия
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.08, 0.6, 0.04)
    tip.Position = Vector3.new(0.6, 1.8, 0)
    tip.Rotation = Vector3.new(0, 0, 45)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192)
    tip.Parent = model
    
    -- Крепление лезвия
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.15, 0.15, 0.15)
    mount.Position = Vector3.new(0, 1.8, 0)
    mount.Anchored = true
    mount.CanCollide = false
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(105, 105, 105)
    mount.Parent = model
    
    -- Дополнительные лезвия
    local blade2 = Instance.new("Part")
    blade2.Name = "Blade2"
    blade2.Size = Vector3.new(0.4, 0.08, 0.04)
    blade2.Position = Vector3.new(0.2, 1.6, 0)
    blade2.Rotation = Vector3.new(0, 0, 30)
    blade2.Anchored = true
    blade2.CanCollide = false
    blade2.Material = Enum.Material.Metal
    blade2.Color = Color3.fromRGB(169, 169, 169)
    blade2.Parent = model
    
    local blade3 = Instance.new("Part")
    blade3.Name = "Blade3"
    blade3.Size = Vector3.new(0.3, 0.08, 0.04)
    blade3.Position = Vector3.new(0.15, 1.4, 0)
    blade3.Rotation = Vector3.new(0, 0, 15)
    blade3.Anchored = true
    blade3.CanCollide = false
    blade3.Material = Enum.Material.Metal
    blade3.Color = Color3.fromRGB(128, 128, 128)
    blade3.Parent = model
    
    -- Декоративные элементы
    local decoration = Instance.new("Part")
    decoration.Name = "Decoration"
    decoration.Shape = Enum.PartType.Cylinder
    decoration.Size = Vector3.new(0.08, 0.4, 0.4)
    decoration.Position = Vector3.new(0, 0.8, 0)
    decoration.Rotation = Vector3.new(0, 0, 90)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
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
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 0, 0)
    glow.Range = 3
    glow.Brightness = 0.6
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
    particles.Size = NumberSequence.new(0.15, 0)
    particles.Transparency = NumberSequence.new(0.3, 1)
    particles.Rate = 15
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(20, 20)
    particles.Parent = blade
    
    -- Дополнительные частицы для древка
    local handleParticles = Instance.new("ParticleEmitter")
    handleParticles.Name = "HandleParticles"
    handleParticles.Texture = "rbxassetid://241629877"
    handleParticles.Color = ColorSequence.new(Color3.fromRGB(139, 69, 19))
    handleParticles.Size = NumberSequence.new(0.08, 0)
    handleParticles.Transparency = NumberSequence.new(0.7, 1)
    handleParticles.Rate = 5
    handleParticles.Lifetime = NumberRange.new(0.5, 1)
    handleParticles.Speed = NumberRange.new(0.3, 0.8)
    handleParticles.SpreadAngle = Vector2.new(10, 10)
    handleParticles.Parent = handle
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_scythe")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "legendary")
    model:SetAttribute("WeaponDamage", 85)
    model:SetAttribute("WeaponSpeed", 0.7)
    model:SetAttribute("WeaponRange", 20)
    model:SetAttribute("WeaponWeight", 8)
    model:SetAttribute("WeaponDurability", 120)
    model:SetAttribute("WeaponLevel", 23)
    model:SetAttribute("WeaponRarity", "legendary")
    model:SetAttribute("WeaponClass", "warrior")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 3000)
    model:SetAttribute("WeaponDescription", "Метательная коса смерти")
    
    return model
end

return CreateThrowingScythe