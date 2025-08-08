-- ThrowingStaff.lua
-- Модель метательного посоха
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingStaff()
    local model = Instance.new("Model")
    model.Name = "ThrowingStaff"
    
    -- Основная часть
    local staff = Instance.new("Part")
    staff.Name = "Staff"
    staff.Size = Vector3.new(0.12, 2.2, 0.12)
    staff.Position = Vector3.new(0, 1.1, 0)
    staff.Anchored = true
    staff.CanCollide = false
    staff.Material = Enum.Material.Wood
    staff.Color = Color3.fromRGB(101, 67, 33)
    staff.Parent = model
    
    -- Кристалл на конце
    local crystal = Instance.new("Part")
    crystal.Name = "Crystal"
    crystal.Shape = Enum.PartType.Ball
    crystal.Size = Vector3.new(0.3, 0.3, 0.3)
    crystal.Position = Vector3.new(0, 2.2, 0)
    crystal.Anchored = true
    crystal.CanCollide = false
    crystal.Material = Enum.Material.Neon
    crystal.Color = Color3.fromRGB(0, 255, 255)
    crystal.Parent = model
    
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
    decoration.Size = Vector3.new(0.08, 0.16, 0.08)
    decoration.Position = Vector3.new(0, 1.7, 0)
    decoration.Anchored = true
    decoration.CanCollide = false
    decoration.Material = Enum.Material.Metal
    decoration.Color = Color3.fromRGB(255, 215, 0)
    decoration.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 3
    glow.Brightness = 0.7
    glow.Parent = crystal
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.12, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 10
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = crystal
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_staff")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 60)
    model:SetAttribute("WeaponSpeed", 1.1)
    model:SetAttribute("WeaponRange", 18)
    model:SetAttribute("WeaponWeight", 3)
    model:SetAttribute("WeaponDurability", 80)
    model:SetAttribute("WeaponLevel", 15)
    model:SetAttribute("WeaponRarity", "epic")
    model:SetAttribute("WeaponClass", "mage")
    model:SetAttribute("WeaponSubclass", "throwing")
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponValue", 1300)
    model:SetAttribute("WeaponDescription", "Метательный магический посох с кристаллом")
    
    return model
end

return CreateThrowingStaff