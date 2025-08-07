-- ThrowingHalberd.lua
-- Модель метательной алебарды
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingHalberd()
    local model = Instance.new("Model")
    model.Name = "ThrowingHalberd"
    
    -- Древко
    local shaft = Instance.new("Part")
    shaft.Name = "Shaft"
    shaft.Size = Vector3.new(0.08, 2.4, 0.08)
    shaft.Position = Vector3.new(0, 1.2, 0)
    shaft.Anchored = true
    shaft.CanCollide = false
    shaft.Material = Enum.Material.Wood
    shaft.Color = Color3.fromRGB(139, 69, 19)
    shaft.Parent = model
    
    -- Лезвие топора
    local axeBlade = Instance.new("Part")
    axeBlade.Name = "AxeBlade"
    axeBlade.Size = Vector3.new(0.5, 0.15, 0.3)
    axeBlade.Position = Vector3.new(0.25, 2.2, 0)
    axeBlade.Anchored = true
    axeBlade.CanCollide = false
    axeBlade.Material = Enum.Material.Metal
    axeBlade.Color = Color3.fromRGB(192, 192, 192)
    axeBlade.Parent = model
    
    -- Копье
    local spearTip = Instance.new("Part")
    spearTip.Name = "SpearTip"
    spearTip.Shape = Enum.PartType.Wedge
    spearTip.Size = Vector3.new(0.12, 0.5, 0.12)
    spearTip.Position = Vector3.new(0, 2.65, 0)
    spearTip.Rotation = Vector3.new(0, 0, 180)
    spearTip.Anchored = true
    spearTip.CanCollide = false
    spearTip.Material = Enum.Material.Metal
    spearTip.Color = Color3.fromRGB(192, 192, 192)
    spearTip.Parent = model
    
    -- Крюк
    local hook = Instance.new("Part")
    hook.Name = "Hook"
    hook.Size = Vector3.new(0.2, 0.08, 0.2)
    hook.Position = Vector3.new(-0.2, 2.3, 0)
    hook.Anchored = true
    hook.CanCollide = false
    hook.Material = Enum.Material.Metal
    hook.Color = Color3.fromRGB(105, 105, 105)
    hook.Parent = model
    
    -- Крепление
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.12, 0.15, 0.12)
    mount.Position = Vector3.new(0, 2.1, 0)
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
    decoration2.Position = Vector3.new(0, 1.2, 0)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 3
    glow.Brightness = 0.5
    glow.Parent = axeBlade
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    particles.Size = NumberSequence.new(0.12, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(15, 15)
    particles.Parent = axeBlade
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_halberd")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 90)
    model:SetAttribute("WeaponSpeed", 0.7)
    model:SetAttribute("WeaponRange", 24)
    model:SetAttribute("WeaponWeight", 8)
    model:SetAttribute("WeaponDurability", 120)
    model:SetAttribute("WeaponLevel", 24)
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
    model:SetAttribute("WeaponValue", 3200)
    model:SetAttribute("WeaponDescription", "Метательная алебарда с острым лезвием и копьем")
    
    return model
end

return CreateThrowingHalberd