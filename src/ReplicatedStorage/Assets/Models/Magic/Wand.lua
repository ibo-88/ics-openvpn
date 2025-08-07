-- Wand.lua
-- Модель волшебной палочки
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateWand()
    local model = Instance.new("Model")
    model.Name = "Wand"
    
    -- Основная часть палочки
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.1, 2.5, 0.1)
    handle.Position = Vector3.new(0, 1.25, 0)
    handle.Anchored = true
    handle.CanCollide = false
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19)
    handle.Parent = model
    
    -- Магический кристалл
    local crystal = Instance.new("Part")
    crystal.Name = "Crystal"
    crystal.Shape = Enum.PartType.Ball
    crystal.Size = Vector3.new(0.3, 0.3, 0.3)
    crystal.Position = Vector3.new(0, 2.65, 0)
    crystal.Anchored = true
    crystal.CanCollide = false
    crystal.Material = Enum.Material.Glass
    crystal.Color = Color3.fromRGB(0, 255, 255)
    crystal.Transparency = 0.3
    crystal.Parent = model
    
    -- Опора кристалла
    local crystalMount = Instance.new("Part")
    crystalMount.Name = "CrystalMount"
    crystalMount.Size = Vector3.new(0.15, 0.2, 0.15)
    crystalMount.Position = Vector3.new(0, 2.5, 0)
    crystalMount.Anchored = true
    crystalMount.CanCollide = false
    crystalMount.Material = Enum.Material.Metal
    crystalMount.Color = Color3.fromRGB(255, 215, 0)
    crystalMount.Parent = model
    
    -- Декоративные кольца
    local ring1 = Instance.new("Part")
    ring1.Name = "Ring1"
    ring1.Shape = Enum.PartType.Cylinder
    ring1.Size = Vector3.new(0.05, 0.2, 0.2)
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
    ring2.Size = Vector3.new(0.05, 0.2, 0.2)
    ring2.Position = Vector3.new(0, 1.2, 0)
    ring2.Rotation = Vector3.new(0, 0, 90)
    ring2.Anchored = true
    ring2.CanCollide = false
    ring2.Material = Enum.Material.Metal
    ring2.Color = Color3.fromRGB(255, 215, 0)
    ring2.Parent = model
    
    local ring3 = Instance.new("Part")
    ring3.Name = "Ring3"
    ring3.Shape = Enum.PartType.Cylinder
    ring3.Size = Vector3.new(0.05, 0.2, 0.2)
    ring3.Position = Vector3.new(0, 0.6, 0)
    ring3.Rotation = Vector3.new(0, 0, 90)
    ring3.Anchored = true
    ring3.CanCollide = false
    ring3.Material = Enum.Material.Metal
    ring3.Color = Color3.fromRGB(255, 215, 0)
    ring3.Parent = model
    
    -- Навершие
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Shape = Enum.PartType.Ball
    pommel.Size = Vector3.new(0.2, 0.2, 0.2)
    pommel.Position = Vector3.new(0, 0.1, 0)
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0)
    pommel.Parent = model
    
    -- Визуальные эффекты
    local crystalGlow = Instance.new("PointLight")
    crystalGlow.Name = "CrystalGlow"
    crystalGlow.Color = Color3.fromRGB(0, 255, 255)
    crystalGlow.Range = 4
    crystalGlow.Brightness = 0.8
    crystalGlow.Parent = crystal
    
    local handleGlow = Instance.new("PointLight")
    handleGlow.Name = "HandleGlow"
    handleGlow.Color = Color3.fromRGB(255, 255, 200)
    handleGlow.Range = 2
    handleGlow.Brightness = 0.3
    handleGlow.Parent = handle
    
    local crystalParticles = Instance.new("ParticleEmitter")
    crystalParticles.Name = "CrystalParticles"
    crystalParticles.Texture = "rbxassetid://241629877"
    crystalParticles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    crystalParticles.Size = NumberSequence.new(0.15, 0)
    crystalParticles.Transparency = NumberSequence.new(0.3, 1)
    crystalParticles.Rate = 20
    crystalParticles.Lifetime = NumberRange.new(1.5, 2.5)
    crystalParticles.Speed = NumberRange.new(1.5, 3)
    crystalParticles.SpreadAngle = Vector2.new(25, 25)
    crystalParticles.Parent = crystal
    
    local handleParticles = Instance.new("ParticleEmitter")
    handleParticles.Name = "HandleParticles"
    handleParticles.Texture = "rbxassetid://241629877"
    handleParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 200))
    handleParticles.Size = NumberSequence.new(0.08, 0)
    handleParticles.Transparency = NumberSequence.new(0.6, 1)
    handleParticles.Rate = 8
    handleParticles.Lifetime = NumberRange.new(0.8, 1.2)
    handleParticles.Speed = NumberRange.new(0.5, 1)
    handleParticles.SpreadAngle = Vector2.new(10, 10)
    handleParticles.Parent = handle
    
    -- Атрибуты
    model:SetAttribute("MagicType", "wand")
    model:SetAttribute("MagicMaterial", "wood")
    model:SetAttribute("MagicQuality", "epic")
    model:SetAttribute("MagicPower", 75)
    model:SetAttribute("MagicManaCost", 25)
    model:SetAttribute("MagicCooldown", 45)
    model:SetAttribute("MagicRange", 25)
    model:SetAttribute("MagicWeight", 2)
    model:SetAttribute("MagicDurability", 80)
    model:SetAttribute("MagicLevel", 18)
    model:SetAttribute("MagicRarity", "epic")
    model:SetAttribute("MagicClass", "mage")
    model:SetAttribute("MagicSubclass", "wand")
    model:SetAttribute("MagicCraftable", true)
    model:SetAttribute("MagicRepairable", true)
    model:SetAttribute("MagicEnchantable", true)
    model:SetAttribute("MagicUpgradeable", true)
    model:SetAttribute("MagicTradeable", true)
    model:SetAttribute("MagicDroppable", true)
    model:SetAttribute("MagicSellable", true)
    model:SetAttribute("MagicValue", 2000)
    model:SetAttribute("MagicDescription", "Волшебная палочка с кристаллом силы")
    
    return model
end

return CreateWand