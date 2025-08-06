-- Gem.lua
-- Модель драгоценного камня

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGem()
    local model = Instance.new("Model")
    model.Name = "Gem"
    
    -- Основной камень
    local gem = Instance.new("Part")
    gem.Name = "Gem"
    gem.Size = Vector3.new(0.4, 0.6, 0.4)
    gem.Material = Enum.Material.Glass
    gem.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    gem.Transparency = 0.3
    gem.Anchored = true
    gem.CanCollide = false
    gem.Parent = model
    
    -- Создание текстуры камня
    local gemTexture = Instance.new("Texture")
    gemTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    gemTexture.StudsPerTileU = 1
    gemTexture.StudsPerTileV = 1
    gemTexture.Parent = gem
    
    -- Свечение камня
    local gemLight = Instance.new("PointLight")
    gemLight.Color = Color3.fromRGB(255, 0, 255)
    gemLight.Range = 3
    gemLight.Brightness = 2
    gemLight.Parent = gem
    
    -- Грани камня
    for i = 1, 8 do
        local facet = Instance.new("Part")
        facet.Name = "GemFacet" .. i
        facet.Size = Vector3.new(0.35, 0.55, 0.35)
        facet.Material = Enum.Material.Glass
        facet.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        facet.Transparency = 0.4
        facet.Anchored = true
        facet.CanCollide = false
        facet.Parent = model
        
        -- Позиционирование граней
        local angle = (i - 1) * 45
        local radius = 0.02
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        facet.Position = gem.Position + Vector3.new(xPos, 0, zPos)
        facet.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Магические руны на камне
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "GemRune" .. i
        rune.Size = Vector3.new(0.05, 0.05, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 0.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = gem.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 0.5
        runeLight.Brightness = 0.8
        runeLight.Parent = rune
    end
    
    -- Магические частицы вокруг камня
    for i = 1, 30 do
        local particle = Instance.new("Part")
        particle.Name = "GemParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.5, 0.5)
        local yPos = math.random(-0.4, 0.4)
        local zPos = math.random(-0.5, 0.5)
        particle.Position = gem.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 0, 255)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.5
        particleLight.Parent = particle
    end
    
    -- Магическая аура вокруг камня
    local aura = Instance.new("Part")
    aura.Name = "GemAura"
    aura.Size = Vector3.new(0.8, 1, 0.8)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = gem.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 0, 255)
    auraLight.Range = 3.5
    auraLight.Brightness = 0.8
    auraLight.Parent = aura
    
    -- Магические кольца вокруг камня
    for i = 1, 5 do
        local ring = Instance.new("Part")
        ring.Name = "GemRing" .. i
        ring.Size = Vector3.new(0.6 + i * 0.1, 0.02, 0.6 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = gem.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 0, 255)
        ringLight.Range = 2 + i * 0.3
        ringLight.Brightness = 0.5
        ringLight.Parent = ring
    end
    
    -- Магические искры
    for i = 1, 15 do
        local spark = Instance.new("Part")
        spark.Name = "GemSpark" .. i
        spark.Size = Vector3.new(0.01, 0.01, 0.01)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 255) -- Белый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-0.3, 0.3)
        local zPos = math.random(-0.4, 0.4)
        spark.Position = gem.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 255)
        sparkLight.Range = 0.2
        sparkLight.Brightness = 0.8
        sparkLight.Parent = spark
    end
    
    -- Магические волны
    for i = 1, 6 do
        local wave = Instance.new("Part")
        wave.Name = "GemWave" .. i
        wave.Size = Vector3.new(0.5 + i * 0.1, 0.01, 0.5 + i * 0.1)
        wave.Material = Enum.Material.Neon
        wave.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        wave.Transparency = 0.7
        wave.Anchored = true
        wave.CanCollide = false
        wave.Parent = model
        
        wave.Position = gem.Position + Vector3.new(0, 0, 0)
        
        -- Свечение волн
        local waveLight = Instance.new("PointLight")
        waveLight.Color = Color3.fromRGB(0, 255, 255)
        waveLight.Range = 1.5 + i * 0.2
        waveLight.Brightness = 0.4
        waveLight.Parent = wave
    end
    
    -- Магические символы
    for i = 1, 4 do
        local symbol = Instance.new("Part")
        symbol.Name = "GemSymbol" .. i
        symbol.Size = Vector3.new(0.08, 0.08, 0.05)
        symbol.Material = Enum.Material.Neon
        symbol.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        symbol.Anchored = true
        symbol.CanCollide = false
        symbol.Parent = model
        
        -- Позиционирование символов
        local angle = (i - 1) * 90
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        symbol.Position = gem.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение символов
        local symbolLight = Instance.new("PointLight")
        symbolLight.Color = Color3.fromRGB(0, 255, 255)
        symbolLight.Range = 0.8
        symbolLight.Brightness = 0.6
        symbolLight.Parent = symbol
    end
    
    -- Магические кристаллы вокруг основного камня
    for i = 1, 8 do
        local crystal = Instance.new("Part")
        crystal.Name = "GemCrystal" .. i
        crystal.Size = Vector3.new(0.1, 0.15, 0.1)
        crystal.Material = Enum.Material.Glass
        crystal.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        crystal.Transparency = 0.5
        crystal.Anchored = true
        crystal.CanCollide = false
        crystal.Parent = model
        
        -- Позиционирование кристаллов
        local angle = (i - 1) * 45
        local radius = 0.3
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crystal.Position = gem.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение кристаллов
        local crystalLight = Instance.new("PointLight")
        crystalLight.Color = Color3.fromRGB(255, 0, 255)
        crystalLight.Range = 0.8
        crystalLight.Brightness = 0.7
        crystalLight.Parent = crystal
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "currency")
    model:SetAttribute("ItemMaterial", "gem")
    model:SetAttribute("ItemQuality", "rare")
    model:SetAttribute("ItemLevel", 5)
    model:SetAttribute("ItemRarity", "rare")
    model:SetAttribute("ItemClass", "currency")
    model:SetAttribute("ItemSubclass", "gem")
    model:SetAttribute("ItemWeight", 0.2)
    model:SetAttribute("ItemValue", 100)
    model:SetAttribute("ItemCraftable", false)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", false)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 100)
    model:SetAttribute("ItemConsumable", false)
    model:SetAttribute("ItemUsable", false)
    model:SetAttribute("CurrencyType", "gem")
    model:SetAttribute("CurrencyAmount", 1)
    model:SetAttribute("CurrencyDenomination", "gem")
    model:SetAttribute("CurrencyWeight", 0.2)
    model:SetAttribute("CurrencyValue", 100)
    model:SetAttribute("CurrencyRarity", "rare")
    model:SetAttribute("GemType", "magic")
    model:SetAttribute("GemPower", 50)
    model:SetAttribute("GemQuality", "excellent")
    
    return model
end

return CreateGem