-- ThrowingStaff.lua
-- Модель метательного посоха
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateThrowingStaff()
    local model = Instance.new("Model")
    model.Name = "ThrowingStaff"
    
    -- Основная часть посоха
    local staff = Instance.new("Part")
    staff.Name = "Staff"
    staff.Size = Vector3.new(0.08, 2.2, 0.08)
    staff.Position = Vector3.new(0, 1.1, 0)
    staff.Anchored = true
    staff.CanCollide = false
    staff.Material = Enum.Material.Wood
    staff.Color = Color3.fromRGB(139, 69, 19)
    staff.Parent = model
    
    -- Магический кристалл
    local crystal = Instance.new("Part")
    crystal.Name = "Crystal"
    crystal.Shape = Enum.PartType.Ball
    crystal.Size = Vector3.new(0.2, 0.2, 0.2)
    crystal.Position = Vector3.new(0, 2.3, 0)
    crystal.Anchored = true
    crystal.CanCollide = false
    crystal.Material = Enum.Material.Glass
    crystal.Color = Color3.fromRGB(0, 255, 255)
    crystal.Transparency = 0.3
    crystal.Parent = model
    
    -- Опора кристалла
    local crystalMount = Instance.new("Part")
    crystalMount.Name = "CrystalMount"
    crystalMount.Size = Vector3.new(0.1, 0.15, 0.1)
    crystalMount.Position = Vector3.new(0, 2.2, 0)
    crystalMount.Anchored = true
    crystalMount.CanCollide = false
    crystalMount.Material = Enum.Material.Metal
    crystalMount.Color = Color3.fromRGB(255, 215, 0)
    crystalMount.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.15, 0.15, 0.15)
    pommel.Position = Vector3.new(0, 0.075, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Декоративные кольца
    local ring1 = Instance.new("Part")
    ring1.Name = "Ring1"
    ring1.Shape = Enum.PartType.Cylinder
    ring1.Size = Vector3.new(0.05, 0.15, 0.15)
    ring1.Position = Vector3.new(0, 1.8, 0)
    ring1.Rotation = Vector3.new(0, 0, 90)
    ring1.Anchored = true
    ring1.CanCollide = false
    ring1.Material = Enum.Material.Metal
    ring1.Color = Color3.fromRGB(255, 215, 0)
    ring1.Parent = model
    
    local ring2 = Instance.new("Part")
    ring2.Name = "Ring2"
    ring2.Shape = Enum.PartType.Cylinder
    ring2.Size = Vector3.new(0.05, 0.15, 0.15)
    ring2.Position = Vector3.new(0, 1.4, 0)
    ring2.Rotation = Vector3.new(0, 0, 90)
    ring2.Anchored = true
    ring2.CanCollide = false
    ring2.Material = Enum.Material.Metal
    ring2.Color = Color3.fromRGB(255, 215, 0)
    ring2.Parent = model
    
    local ring3 = Instance.new("Part")
    ring3.Name = "Ring3"
    ring3.Shape = Enum.PartType.Cylinder
    ring3.Size = Vector3.new(0.05, 0.15, 0.15)
    ring3.Position = Vector3.new(0, 1, 0)
    ring3.Rotation = Vector3.new(0, 0, 90)
    ring3.Anchored = true
    ring3.CanCollide = false
    ring3.Material = Enum.Material.Metal
    ring3.Color = Color3.fromRGB(255, 215, 0)
    ring3.Parent = model
    
    local ring4 = Instance.new("Part")
    ring4.Name = "Ring4"
    ring4.Shape = Enum.PartType.Cylinder
    ring4.Size = Vector3.new(0.05, 0.15, 0.15)
    ring4.Position = Vector3.new(0, 0.6, 0)
    ring4.Rotation = Vector3.new(0, 0, 90)
    ring4.Anchored = true
    ring4.CanCollide = false
    ring4.Material = Enum.Material.Metal
    ring4.Color = Color3.fromRGB(255, 215, 0)
    ring4.Parent = model
    
    local ring5 = Instance.new("Part")
    ring5.Name = "Ring5"
    ring5.Shape = Enum.PartType.Cylinder
    ring5.Size = Vector3.new(0.05, 0.15, 0.15)
    ring5.Position = Vector3.new(0, 0.2, 0)
    ring5.Rotation = Vector3.new(0, 0, 90)
    ring5.Anchored = true
    ring5.CanCollide = false
    ring5.Material = Enum.Material.Metal
    ring5.Color = Color3.fromRGB(255, 215, 0)
    ring5.Parent = model
    
    -- Визуальные эффекты
    local crystalGlow = Instance.new("PointLight")
    crystalGlow.Name = "CrystalGlow"
    crystalGlow.Color = Color3.fromRGB(0, 255, 255)
    crystalGlow.Range = 3
    crystalGlow.Brightness = 0.6
    crystalGlow.Parent = crystal
    
    local staffGlow = Instance.new("PointLight")
    staffGlow.Name = "StaffGlow"
    staffGlow.Color = Color3.fromRGB(255, 255, 200)
    staffGlow.Range = 2
    staffGlow.Brightness = 0.3
    staffGlow.Parent = staff
    
    local crystalParticles = Instance.new("ParticleEmitter")
    crystalParticles.Name = "CrystalParticles"
    crystalParticles.Texture = "rbxassetid://241629877"
    crystalParticles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    crystalParticles.Size = NumberSequence.new(0.12, 0)
    crystalParticles.Transparency = NumberSequence.new(0.4, 1)
    crystalParticles.Rate = 15
    crystalParticles.Lifetime = NumberRange.new(1.5, 2.5)
    crystalParticles.Speed = NumberRange.new(1.5, 3)
    crystalParticles.SpreadAngle = Vector2.new(20, 20)
    crystalParticles.Parent = crystal
    
    local staffParticles = Instance.new("ParticleEmitter")
    staffParticles.Name = "StaffParticles"
    staffParticles.Texture = "rbxassetid://241629877"
    staffParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    staffParticles.Size = NumberSequence.new(0.08, 0)
    staffParticles.Transparency = NumberSequence.new(0.6, 1)
    staffParticles.Rate = 8
    staffParticles.Lifetime = NumberRange.new(0.8, 1.2)
    staffParticles.Speed = NumberRange.new(0.5, 1)
    staffParticles.SpreadAngle = Vector2.new(10, 10)
    staffParticles.Parent = staff
    
    -- Атрибуты
    model:SetAttribute("WeaponType", "throwing_staff")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "epic")
    model:SetAttribute("WeaponDamage", 55)
    model:SetAttribute("WeaponSpeed", 1.2)
    model:SetAttribute("WeaponRange", 22)
    model:SetAttribute("WeaponWeight", 4)
    model:SetAttribute("WeaponDurability", 85)
    model:SetAttribute("WeaponLevel", 17)
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
    model:SetAttribute("WeaponValue", 1200)
    model:SetAttribute("WeaponDescription", "Метательный посох с магическим кристаллом")
    
    return model
end

return CreateThrowingStaff