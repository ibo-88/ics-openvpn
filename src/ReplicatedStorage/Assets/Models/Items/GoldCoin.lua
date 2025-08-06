-- GoldCoin.lua
-- Модель золотой монеты

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGoldCoin()
    local model = Instance.new("Model")
    model.Name = "GoldCoin"
    
    -- Основная монета
    local coin = Instance.new("Part")
    coin.Name = "Coin"
    coin.Size = Vector3.new(0.8, 0.1, 0.8)
    coin.Material = Enum.Material.Metal
    coin.Color = Color3.fromRGB(255, 215, 0) -- Золотой
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
    coinLight.Color = Color3.fromRGB(255, 215, 0)
    coinLight.Range = 1.5
    coinLight.Brightness = 1
    coinLight.Parent = coin
    
    -- Корона на аверсе
    local crown = Instance.new("Part")
    crown.Name = "Crown"
    crown.Size = Vector3.new(0.4, 0.05, 0.4)
    crown.Material = Enum.Material.Metal
    crown.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    crown.Anchored = true
    crown.CanCollide = false
    crown.Parent = model
    
    crown.Position = coin.Position + Vector3.new(0, 0.075, 0)
    
    -- Детали короны
    for i = 1, 5 do
        local jewel = Instance.new("Part")
        jewel.Name = "CrownJewel" .. i
        jewel.Size = Vector3.new(0.08, 0.08, 0.08)
        jewel.Material = Enum.Material.Neon
        jewel.Color = Color3.fromRGB(255, 0, 0) -- Красный
        jewel.Anchored = true
        jewel.CanCollide = false
        jewel.Parent = model
        
        -- Позиционирование драгоценных камней
        local angle = (i - 1) * 72
        local radius = 0.15
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        jewel.Position = crown.Position + Vector3.new(xPos, 0.065, zPos)
        
        -- Свечение камней
        local jewelLight = Instance.new("PointLight")
        jewelLight.Color = Color3.fromRGB(255, 0, 0)
        jewelLight.Range = 0.3
        jewelLight.Brightness = 0.8
        jewelLight.Parent = jewel
    end
    
    -- Номинал на реверсе
    local denomination = Instance.new("Part")
    denomination.Name = "Denomination"
    denomination.Size = Vector3.new(0.3, 0.05, 0.3)
    denomination.Material = Enum.Material.Metal
    denomination.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    denomination.Anchored = true
    denomination.CanCollide = false
    denomination.Parent = model
    
    denomination.Position = coin.Position + Vector3.new(0, -0.075, 0)
    
    -- Цифра номинала
    local number = Instance.new("Part")
    number.Name = "Number"
    number.Size = Vector3.new(0.15, 0.08, 0.15)
    number.Material = Enum.Material.Metal
    number.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    number.Anchored = true
    number.CanCollide = false
    number.Parent = model
    
    number.Position = denomination.Position + Vector3.new(0, -0.065, 0)
    
    -- Декоративные элементы по краю монеты
    for i = 1, 12 do
        local decoration = Instance.new("Part")
        decoration.Name = "EdgeDecoration" .. i
        decoration.Size = Vector3.new(0.05, 0.08, 0.05)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local angle = (i - 1) * 30
        local radius = 0.425
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = coin.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Магические руны на монете
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "CoinRune" .. i
        rune.Size = Vector3.new(0.03, 0.02, 0.03)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 45
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = coin.Position + Vector3.new(xPos, 0.06, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 0.2
        runeLight.Brightness = 0.6
        runeLight.Parent = rune
    end
    
    -- Золотые частицы вокруг монеты
    for i = 1, 20 do
        local particle = Instance.new("Part")
        particle.Name = "GoldParticle" .. i
        particle.Size = Vector3.new(0.01, 0.01, 0.01)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.6, 0.6)
        local yPos = math.random(-0.3, 0.3)
        local zPos = math.random(-0.6, 0.6)
        particle.Position = coin.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 215, 0)
        particleLight.Range = 0.2
        particleLight.Brightness = 0.4
        particleLight.Parent = particle
    end
    
    -- Золотая аура вокруг монеты
    local aura = Instance.new("Part")
    aura.Name = "GoldAura"
    aura.Size = Vector3.new(1.2, 0.3, 1.2)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = coin.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 215, 0)
    auraLight.Range = 2
    auraLight.Brightness = 0.5
    auraLight.Parent = aura
    
    -- Золотые кольца вокруг монеты
    for i = 1, 3 do
        local ring = Instance.new("Part")
        ring.Name = "GoldRing" .. i
        ring.Size = Vector3.new(0.8 + i * 0.2, 0.02, 0.8 + i * 0.2)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = coin.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 215, 0)
        ringLight.Range = 1 + i * 0.3
        ringLight.Brightness = 0.3
        ringLight.Parent = ring
    end
    
    -- Золотые искры
    for i = 1, 10 do
        local spark = Instance.new("Part")
        spark.Name = "GoldSpark" .. i
        spark.Size = Vector3.new(0.005, 0.005, 0.005)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 255) -- Белый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.5, 0.5)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.5, 0.5)
        spark.Position = coin.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 255)
        sparkLight.Range = 0.1
        sparkLight.Brightness = 0.8
        sparkLight.Parent = spark
    end
    
    -- Декоративные узоры на монете
    for i = 1, 6 do
        local pattern = Instance.new("Part")
        pattern.Name = "CoinPattern" .. i
        pattern.Size = Vector3.new(0.1, 0.02, 0.1)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local angle = (i - 1) * 60
        local radius = 0.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        pattern.Position = coin.Position + Vector3.new(xPos, 0.06, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "currency")
    model:SetAttribute("ItemMaterial", "gold")
    model:SetAttribute("ItemQuality", "common")
    model:SetAttribute("ItemLevel", 1)
    model:SetAttribute("ItemRarity", "common")
    model:SetAttribute("ItemClass", "currency")
    model:SetAttribute("ItemSubclass", "coin")
    model:SetAttribute("ItemWeight", 0.1)
    model:SetAttribute("ItemValue", 1)
    model:SetAttribute("ItemCraftable", false)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", false)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 1000)
    model:SetAttribute("ItemConsumable", false)
    model:SetAttribute("ItemUsable", false)
    model:SetAttribute("CurrencyType", "gold")
    model:SetAttribute("CurrencyAmount", 1)
    model:SetAttribute("CurrencyDenomination", "coin")
    model:SetAttribute("CurrencyWeight", 0.1)
    model:SetAttribute("CurrencyValue", 1)
    model:SetAttribute("CurrencyRarity", "common")
    
    return model
end

return CreateGoldCoin