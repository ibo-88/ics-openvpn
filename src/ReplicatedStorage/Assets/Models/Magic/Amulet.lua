-- Amulet.lua
-- Модель магического амулета
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateAmulet()
    local model = Instance.new("Model")
    model.Name = "Amulet"
    
    -- Основной камень
    local gem = Instance.new("Part")
    gem.Name = "Gem"
    gem.Shape = Enum.PartType.Ball
    gem.Size = Vector3.new(0.4, 0.4, 0.4)
    gem.Position = Vector3.new(0, 0, 0)
    gem.Anchored = true
    gem.CanCollide = false
    gem.Material = Enum.Material.Glass
    gem.Color = Color3.fromRGB(0, 255, 255)
    gem.Transparency = 0.2
    gem.Parent = model
    
    -- Оправка
    local setting = Instance.new("Part")
    setting.Name = "Setting"
    setting.Size = Vector3.new(0.5, 0.5, 0.1)
    setting.Position = Vector3.new(0, 0, 0)
    setting.Anchored = true
    setting.CanCollide = false
    setting.Material = Enum.Material.Metal
    setting.Color = Color3.fromRGB(255, 215, 0)
    setting.Parent = model
    
    -- Цепочка
    local chain = Instance.new("Part")
    chain.Name = "Chain"
    chain.Size = Vector3.new(0.1, 1.5, 0.1)
    chain.Position = Vector3.new(0, -0.75, 0)
    chain.Anchored = true
    chain.CanCollide = false
    chain.Material = Enum.Material.Metal
    chain.Color = Color3.fromRGB(192, 192, 192)
    chain.Parent = model
    
    -- Звенья цепочки
    local link1 = Instance.new("Part")
    link1.Name = "Link1"
    link1.Shape = Enum.PartType.Cylinder
    link1.Size = Vector3.new(0.05, 0.2, 0.2)
    link1.Position = Vector3.new(0, -0.3, 0)
    link1.Rotation = Vector3.new(0, 0, 90)
    link1.Anchored = true
    link1.CanCollide = false
    link1.Material = Enum.Material.Metal
    link1.Color = Color3.fromRGB(192, 192, 192)
    link1.Parent = model
    
    local link2 = Instance.new("Part")
    link2.Name = "Link2"
    link2.Shape = Enum.PartType.Cylinder
    link2.Size = Vector3.new(0.05, 0.2, 0.2)
    link2.Position = Vector3.new(0, -0.6, 0)
    link2.Rotation = Vector3.new(0, 0, 90)
    link2.Anchored = true
    link2.CanCollide = false
    link2.Material = Enum.Material.Metal
    link2.Color = Color3.fromRGB(192, 192, 192)
    link2.Parent = model
    
    local link3 = Instance.new("Part")
    link3.Name = "Link3"
    link3.Shape = Enum.PartType.Cylinder
    link3.Size = Vector3.new(0.05, 0.2, 0.2)
    link3.Position = Vector3.new(0, -0.9, 0)
    link3.Rotation = Vector3.new(0, 0, 90)
    link3.Anchored = true
    link3.CanCollide = false
    link3.Material = Enum.Material.Metal
    link3.Color = Color3.fromRGB(192, 192, 192)
    link3.Parent = model
    
    local link4 = Instance.new("Part")
    link4.Name = "Link4"
    link4.Shape = Enum.PartType.Cylinder
    link4.Size = Vector3.new(0.05, 0.2, 0.2)
    link4.Position = Vector3.new(0, -1.2, 0)
    link4.Rotation = Vector3.new(0, 0, 90)
    link4.Anchored = true
    link4.CanCollide = false
    link4.Material = Enum.Material.Metal
    link4.Color = Color3.fromRGB(192, 192, 192)
    link4.Parent = model
    
    -- Декоративные элементы
    local decoration1 = Instance.new("Part")
    decoration1.Name = "Decoration1"
    decoration1.Size = Vector3.new(0.1, 0.1, 0.05)
    decoration1.Position = Vector3.new(-0.2, 0, 0.075)
    decoration1.Anchored = true
    decoration1.CanCollide = false
    decoration1.Material = Enum.Material.Metal
    decoration1.Color = Color3.fromRGB(255, 215, 0)
    decoration1.Parent = model
    
    local decoration2 = Instance.new("Part")
    decoration2.Name = "Decoration2"
    decoration2.Size = Vector3.new(0.1, 0.1, 0.05)
    decoration2.Position = Vector3.new(0.2, 0, 0.075)
    decoration2.Anchored = true
    decoration2.CanCollide = false
    decoration2.Material = Enum.Material.Metal
    decoration2.Color = Color3.fromRGB(255, 215, 0)
    decoration2.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 4
    glow.Brightness = 0.8
    glow.Parent = gem
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.15, 0)
    particles.Transparency = NumberSequence.new(0.3, 1)
    particles.Rate = 20
    particles.Lifetime = NumberRange.new(1.5, 2.5)
    particles.Speed = NumberRange.new(1.5, 3)
    particles.SpreadAngle = Vector2.new(25, 25)
    particles.Parent = gem
    
    -- Дополнительные частицы для оправки
    local settingParticles = Instance.new("ParticleEmitter")
    settingParticles.Name = "SettingParticles"
    settingParticles.Texture = "rbxassetid://241629877"
    settingParticles.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
    settingParticles.Size = NumberSequence.new(0.08, 0)
    settingParticles.Transparency = NumberSequence.new(0.6, 1)
    settingParticles.Rate = 10
    settingParticles.Lifetime = NumberRange.new(0.8, 1.2)
    settingParticles.Speed = NumberRange.new(0.5, 1)
    settingParticles.SpreadAngle = Vector2.new(10, 10)
    settingParticles.Parent = setting
    
    -- Атрибуты
    model:SetAttribute("MagicType", "amulet")
    model:SetAttribute("MagicMaterial", "crystal")
    model:SetAttribute("MagicQuality", "legendary")
    model:SetAttribute("MagicPower", 100)
    model:SetAttribute("MagicManaCost", 20)
    model:SetAttribute("MagicCooldown", 30)
    model:SetAttribute("MagicRange", 15)
    model:SetAttribute("MagicWeight", 1)
    model:SetAttribute("MagicDurability", 200)
    model:SetAttribute("MagicLevel", 25)
    model:SetAttribute("MagicRarity", "legendary")
    model:SetAttribute("MagicClass", "mage")
    model:SetAttribute("MagicSubclass", "accessory")
    model:SetAttribute("MagicCraftable", true)
    model:SetAttribute("MagicRepairable", true)
    model:SetAttribute("MagicEnchantable", true)
    model:SetAttribute("MagicUpgradeable", true)
    model:SetAttribute("MagicTradeable", true)
    model:SetAttribute("MagicDroppable", true)
    model:SetAttribute("MagicSellable", true)
    model:SetAttribute("MagicValue", 5000)
    model:SetAttribute("MagicDescription", "Древний амулет с кристаллом силы")
    
    return model
end

return CreateAmulet