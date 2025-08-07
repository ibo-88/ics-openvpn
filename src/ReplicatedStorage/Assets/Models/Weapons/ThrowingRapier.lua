-- ThrowingRapier.lua
-- Модель метательной рапиры
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingRapier()
    local model = Instance.new("Model")
    model.Name = "ThrowingRapier"
    
    -- Лезвие
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.06, 1.6, 0.06)
    blade.Position = Vector3.new(0, 0.8, 0)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(240, 240, 240)
    blade.Parent = model
    
    -- Острие лезвия
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Shape = Enum.PartType.Wedge
    tip.Size = Vector3.new(0.06, 0.25, 0.06)
    tip.Position = Vector3.new(0, 1.625, 0)
    tip.Rotation = Vector3.new(0, 0, 180)
    tip.Anchored = true
    tip.CanCollide = false
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(240, 240, 240)
    tip.Parent = model
    
    -- Рукоять
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 0.5, 0.08)
    handle.Position = Vector3.new(0, -0.25, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Fabric
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Гарда (сложная форма)
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.4, 0.08, 0.25)
    guard.Position = Vector3.new(0, 0, 0)
    guard.Anchored = true
    guard.CanCollide = false
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(192, 192, 192)
    guard.Parent = model
    
    -- Дополнительные элементы гарды
    local guardLeft = Instance.new("Part")
    guardLeft.Name = "GuardLeft"
    guardLeft.Size = Vector3.new(0.08, 0.15, 0.08)
    guardLeft.Position = Vector3.new(-0.2, 0, 0)
    guardLeft.Anchored = true
    guardLeft.CanCollide = false
    guardLeft.Material = Enum.Material.Metal
    guardLeft.Color = Color3.fromRGB(192, 192, 192)
    guardLeft.Parent = model
    
    local guardRight = Instance.new("Part")
    guardRight.Name = "GuardRight"
    guardRight.Size = Vector3.new(0.08, 0.15, 0.08)
    guardRight.Position = Vector3.new(0.2, 0, 0)
    guardRight.Anchored = true
    guardRight.CanCollide = false
    guardRight.Material = Enum.Material.Metal
    guardRight.Color = Color3.fromRGB(192, 192, 192)
    guardRight.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.12, 0.12, 0.12)
    pommel.Position = Vector3.new(0, -0.5, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Дол (канавка на лезвии)
    local fuller = Instance.new("Part")
    fuller.Name = "Fuller"
    fuller.Size = Vector3.new(0.015, 1.3, 0.015)
    fuller.Position = Vector3.new(0, 0.8, 0)
    fuller.Anchored = true
    fuller.CanCollide = false
    fuller.Material = Enum.Material.Metal
    fuller.Color = Color3.fromRGB(169, 169, 169)
    fuller.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.03, 0.06, 0.03)
    decoration1.Position = Vector3.new(0, 0.3, 0)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.03, 0.06, 0.03)
    decoration2.Position = Vector3.new(0, 1.3, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 255)
    glow.Range = 2
    glow.Brightness = 0.4
    glow.Parent = blade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    particles.Size = NumberSequence.new(0.08, 0)
    particles.Transparency = NumberSequence.new(0.6, 1)
    particles.Rate = 8
    particles.Lifetime = NumberRange.new(0.8, 1.2)
    particles.Speed = NumberRange.new(0.6, 1.2)
    particles.SpreadAngle = Vector2.new(10, 10)
    particles.Parent = blade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_rapier")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 55)
    model:SetAttribute("WeaponSpeed", 1.5)
    model:SetAttribute("WeaponRange", 14)
    model:SetAttribute("WeaponWeight", 2)
    model:SetAttribute("WeaponDurability", 80)
    model:SetAttribute("WeaponLevel", 16)
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
    model:SetAttribute("WeaponValue", 1200)
    model:SetAttribute("WeaponDescription", "Элегантная метательная рапира")
    
    return model
end

return CreateThrowingRapier