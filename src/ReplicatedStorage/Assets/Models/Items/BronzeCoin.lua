-- BronzeCoin.lua
-- Модель бронзовой монеты

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBronzeCoin()
    local model = Instance.new("Model")
    model.Name = "BronzeCoin"
    
    -- Основная монета
    local coin = Instance.new("Part")
    coin.Name = "Coin"
    coin.Size = Vector3.new(0.8, 0.1, 0.8)
    coin.Material = Enum.Material.Metal
    coin.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
    coin.Anchored = true
    coin.CanCollide = false
    coin.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = coin
    
    -- Свечение монеты
    local coinLight = Instance.new("PointLight")
    coinLight.Color = Color3.fromRGB(205, 127, 50)
    coinLight.Range = 1.0
    coinLight.Brightness = 0.6
    coinLight.Parent = coin
    
    -- Герб на аверсе
    local emblem = Instance.new("Part")
    emblem.Name = "Emblem"
    emblem.Size = Vector3.new(0.3, 0.05, 0.3)
    emblem.Material = Enum.Material.Metal
    emblem.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
    emblem.Anchored = true
    emblem.CanCollide = false
    emblem.Parent = model
    
    emblem.Position = coin.Position + Vector3.new(0, 0.075, 0)
    
    -- Детали герба
    for i = 1, 4 do
        local detail = Instance.new("Part")
        detail.Name = "EmblemDetail" .. i
        detail.Size = Vector3.new(0.06, 0.06, 0.06)
        detail.Material = Enum.Material.Metal
        detail.Color = Color3.fromRGB(184, 115, 51) -- Темно-бронзовый
        detail.Anchored = true
        detail.CanCollide = false
        detail.Parent = model
        
        -- Позиционирование деталей
        local angle = (i - 1) * 90
        local radius = 0.12
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        detail.Position = emblem.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Номинал на реверсе
    local denomination = Instance.new("Part")
    denomination.Name = "Denomination"
    denomination.Size = Vector3.new(0.25, 0.05, 0.25)
    denomination.Material = Enum.Material.Metal
    denomination.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
    denomination.Anchored = true
    denomination.CanCollide = false
    denomination.Parent = model
    
    denomination.Position = coin.Position + Vector3.new(0, -0.075, 0)
    
    -- Цифра номинала
    local number = Instance.new("Part")
    number.Name = "Number"
    number.Size = Vector3.new(0.12, 0.08, 0.12)
    number.Material = Enum.Material.Metal
    number.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
    number.Anchored = true
    number.CanCollide = false
    number.Parent = model
    
    number.Position = denomination.Position + Vector3.new(0, -0.065, 0)
    
    -- Декоративные элементы по краю монеты
    for i = 1, 10 do
        local decoration = Instance.new("Part")
        decoration.Name = "EdgeDecoration" .. i
        decoration.Size = Vector3.new(0.04, 0.08, 0.04)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local angle = (i - 1) * 36
        local radius = 0.42
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = coin.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Бронзовые руны на монете
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "CoinRune" .. i
        rune.Size = Vector3.new(0.025, 0.02, 0.025)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = coin.Position + Vector3.new(xPos, 0.06, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(205, 127, 50)
        runeLight.Range = 0.15
        runeLight.Brightness = 0.4
        runeLight.Parent = rune
    end
    
    -- Бронзовые частицы вокруг монеты
    for i = 1, 12 do
        local particle = Instance.new("Part")
        particle.Name = "BronzeParticle" .. i
        particle.Size = Vector3.new(0.008, 0.008, 0.008)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.5, 0.5)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.5, 0.5)
        particle.Position = coin.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(205, 127, 50)
        particleLight.Range = 0.15
        particleLight.Brightness = 0.25
        particleLight.Parent = particle
    end
    
    -- Бронзовая аура вокруг монеты
    local aura = Instance.new("Part")
    aura.Name = "BronzeAura"
    aura.Size = Vector3.new(1.0, 0.3, 1.0)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = coin.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(205, 127, 50)
    auraLight.Range = 1.5
    auraLight.Brightness = 0.3
    auraLight.Parent = aura
    
    -- Бронзовые кольца вокруг монеты
    for i = 1, 2 do
        local ring = Instance.new("Part")
        ring.Name = "BronzeRing" .. i
        ring.Size = Vector3.new(0.8 + i * 0.15, 0.02, 0.8 + i * 0.15)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = coin.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(205, 127, 50)
        ringLight.Range = 0.8 + i * 0.2
        ringLight.Brightness = 0.2
        ringLight.Parent = ring
    end
    
    -- Бронзовые искры
    for i = 1, 6 do
        local spark = Instance.new("Part")
        spark.Name = "BronzeSpark" .. i
        spark.Size = Vector3.new(0.004, 0.004, 0.004)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 215, 0) -- Золотистый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-0.15, 0.15)
        local zPos = math.random(-0.4, 0.4)
        spark.Position = coin.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 215, 0)
        sparkLight.Range = 0.08
        sparkLight.Brightness = 0.5
        sparkLight.Parent = spark
    end
    
    -- Декоративные узоры на монете
    for i = 1, 4 do
        local pattern = Instance.new("Part")
        pattern.Name = "CoinPattern" .. i
        pattern.Size = Vector3.new(0.08, 0.02, 0.08)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(205, 127, 50) -- Бронзовый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local angle = (i - 1) * 90
        local radius = 0.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        pattern.Position = coin.Position + Vector3.new(xPos, 0.06, zPos)
    end
    
    -- Патина на монете
    for i = 1, 8 do
        local patina = Instance.new("Part")
        patina.Name = "Patina" .. i
        patina.Size = Vector3.new(0.02, 0.02, 0.02)
        patina.Material = Enum.Material.Metal
        patina.Color = Color3.fromRGB(34, 139, 34) -- Зеленоватый
        patina.Anchored = true
        patina.CanCollide = false
        patina.Parent = model
        
        -- Случайное позиционирование патины
        local xPos = math.random(-0.3, 0.3)
        local zPos = math.random(-0.3, 0.3)
        patina.Position = coin.Position + Vector3.new(xPos, 0.06, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "currency")
    model:SetAttribute("ItemMaterial", "bronze")
    model:SetAttribute("ItemQuality", "common")
    model:SetAttribute("ItemLevel", 1)
    model:SetAttribute("ItemRarity", "common")
    model:SetAttribute("ItemClass", "currency")
    model:SetAttribute("ItemSubclass", "coin")
    model:SetAttribute("ItemWeight", 0.1)
    model:SetAttribute("ItemValue", 0.01)
    model:SetAttribute("ItemCraftable", false)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", false)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 1000)
    model:SetAttribute("ItemConsumable", false)
    model:SetAttribute("ItemUsable", false)
    model:SetAttribute("CurrencyType", "bronze")
    model:SetAttribute("CurrencyAmount", 1)
    model:SetAttribute("CurrencyDenomination", "coin")
    model:SetAttribute("CurrencyWeight", 0.1)
    model:SetAttribute("CurrencyValue", 0.01)
    model:SetAttribute("CurrencyRarity", "common")
    
    return model
end

return CreateBronzeCoin