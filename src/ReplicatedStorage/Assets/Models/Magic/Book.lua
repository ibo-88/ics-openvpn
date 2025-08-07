-- Book.lua
-- Модель магической книги
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBook()
    local model = Instance.new("Model")
    model.Name = "Book"
    
    -- Основная обложка
    local cover = Instance.new("Part")
    cover.Name = "Cover"
    cover.Size = Vector3.new(0.8, 1.2, 0.1)
    cover.Position = Vector3.new(0, 0, 0)
    cover.Anchored = true
    cover.CanCollide = false
    cover.Material = Enum.Material.Fabric
    cover.Color = Color3.fromRGB(139, 69, 19)
    cover.Parent = model
    
    -- Страницы
    local pages = Instance.new("Part")
    pages.Name = "Pages"
    pages.Size = Vector3.new(0.75, 1.15, 0.05)
    pages.Position = Vector3.new(0, 0, 0.025)
    pages.Anchored = true
    pages.CanCollide = false
    pages.Material = Enum.Material.Fabric
    pages.Color = Color3.fromRGB(255, 248, 220)
    pages.Parent = model
    
    -- Застежка
    local clasp = Instance.new("Part")
    clasp.Name = "Clasp"
    clasp.Size = Vector3.new(0.2, 0.1, 0.05)
    clasp.Position = Vector3.new(0, 0.5, 0.075)
    clasp.Anchored = true
    clasp.CanCollide = false
    clasp.Material = Enum.Material.Metal
    clasp.Color = Color3.fromRGB(255, 215, 0)
    clasp.Parent = model
    
    -- Магические символы на обложке
    local symbol1 = Instance.new("Part")
    symbol1.Name = "Symbol1"
    symbol1.Size = Vector3.new(0.1, 0.1, 0.02)
    symbol1.Position = Vector3.new(-0.2, 0.3, 0.06)
    symbol1.Anchored = true
    symbol1.CanCollide = false
    symbol1.Material = Enum.Material.Neon
    symbol1.Color = Color3.fromRGB(0, 255, 255)
    symbol1.Parent = model
    
    local symbol2 = Instance.new("Part")
    symbol2.Name = "Symbol2"
    symbol2.Size = Vector3.new(0.1, 0.1, 0.02)
    symbol2.Position = Vector3.new(0.2, 0.3, 0.06)
    symbol2.Anchored = true
    symbol2.CanCollide = false
    symbol2.Material = Enum.Material.Neon
    symbol2.Color = Color3.fromRGB(255, 0, 255)
    symbol2.Parent = model
    
    local symbol3 = Instance.new("Part")
    symbol3.Name = "Symbol3"
    symbol3.Size = Vector3.new(0.1, 0.1, 0.02)
    symbol3.Position = Vector3.new(0, -0.3, 0.06)
    symbol3.Anchored = true
    symbol3.CanCollide = false
    symbol3.Material = Enum.Material.Neon
    symbol3.Color = Color3.fromRGB(255, 255, 0)
    symbol3.Parent = model
    
    -- Декоративные углы
    local corner1 = Instance.new("Part")
    corner1.Name = "Corner1"
    corner1.Size = Vector3.new(0.05, 0.05, 0.02)
    corner1.Position = Vector3.new(-0.35, 0.55, 0.06)
    corner1.Anchored = true
    corner1.CanCollide = false
    corner1.Material = Enum.Material.Metal
    corner1.Color = Color3.fromRGB(255, 215, 0)
    corner1.Parent = model
    
    local corner2 = Instance.new("Part")
    corner2.Name = "Corner2"
    corner2.Size = Vector3.new(0.05, 0.05, 0.02)
    corner2.Position = Vector3.new(0.35, 0.55, 0.06)
    corner2.Anchored = true
    corner2.CanCollide = false
    corner2.Material = Enum.Material.Metal
    corner2.Color = Color3.fromRGB(255, 215, 0)
    corner2.Parent = model
    
    local corner3 = Instance.new("Part")
    corner3.Name = "Corner3"
    corner3.Size = Vector3.new(0.05, 0.05, 0.02)
    corner3.Position = Vector3.new(-0.35, -0.55, 0.06)
    corner3.Anchored = true
    corner3.CanCollide = false
    corner3.Material = Enum.Material.Metal
    corner3.Color = Color3.fromRGB(255, 215, 0)
    corner3.Parent = model
    
    local corner4 = Instance.new("Part")
    corner4.Name = "Corner4"
    corner4.Size = Vector3.new(0.05, 0.05, 0.02)
    corner4.Position = Vector3.new(0.35, -0.55, 0.06)
    corner4.Anchored = true
    corner4.CanCollide = false
    corner4.Material = Enum.Material.Metal
    corner4.Color = Color3.fromRGB(255, 215, 0)
    corner4.Parent = model
    
    -- Визуальные эффекты
    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 3
    glow.Brightness = 0.6
    glow.Parent = cover
    
    local particles = Instance.new("ParticleEmitter")
    particles.Name = "Particles"
    particles.Texture = "rbxassetid://241629877"
    particles.Color = ColorSequence.new(Color3.fromRGB(0, 255, 255))
    particles.Size = NumberSequence.new(0.1, 0)
    particles.Transparency = NumberSequence.new(0.4, 1)
    particles.Rate = 12
    particles.Lifetime = NumberRange.new(1, 2)
    particles.Speed = NumberRange.new(1, 2)
    particles.SpreadAngle = Vector2.new(20, 20)
    particles.Parent = cover
    
    -- Дополнительные частицы для символов
    local symbolParticles = Instance.new("ParticleEmitter")
    symbolParticles.Name = "SymbolParticles"
    symbolParticles.Texture = "rbxassetid://241629877"
    symbolParticles.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
    symbolParticles.Size = NumberSequence.new(0.05, 0)
    symbolParticles.Transparency = NumberSequence.new(0.8, 1)
    symbolParticles.Rate = 15
    symbolParticles.Lifetime = NumberRange.new(0.5, 1)
    symbolParticles.Speed = NumberRange.new(0.3, 0.8)
    symbolParticles.SpreadAngle = Vector2.new(5, 5)
    symbolParticles.Parent = symbol1
    
    -- Атрибуты
    model:SetAttribute("MagicType", "book")
    model:SetAttribute("MagicMaterial", "paper")
    model:SetAttribute("MagicQuality", "epic")
    model:SetAttribute("MagicPower", 80)
    model:SetAttribute("MagicManaCost", 40)
    model:SetAttribute("MagicCooldown", 90)
    model:SetAttribute("MagicRange", 25)
    model:SetAttribute("MagicWeight", 2)
    model:SetAttribute("MagicDurability", 60)
    model:SetAttribute("MagicLevel", 20)
    model:SetAttribute("MagicRarity", "epic")
    model:SetAttribute("MagicClass", "mage")
    model:SetAttribute("MagicSubclass", "spellbook")
    model:SetAttribute("MagicCraftable", true)
    model:SetAttribute("MagicRepairable", false)
    model:SetAttribute("MagicEnchantable", true)
    model:SetAttribute("MagicUpgradeable", true)
    model:SetAttribute("MagicTradeable", true)
    model:SetAttribute("MagicDroppable", true)
    model:SetAttribute("MagicSellable", true)
    model:SetAttribute("MagicValue", 2500)
    model:SetAttribute("MagicDescription", "Древняя книга с запретными заклинаниями")
    
    return model
end

return CreateBook