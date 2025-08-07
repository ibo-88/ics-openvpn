-- EmeraldCoin.lua
-- Модель изумрудной монеты

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateEmeraldCoin()
    local model = Instance.new("Model")
    model.Name = "EmeraldCoin"
    
    -- Основная часть монеты
    local coin = Instance.new("Part")
    coin.Name = "Coin"
    coin.Size = Vector3.new(0.15, 0.15, 0.02)
    coin.Material = Enum.Material.Metal
    coin.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
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
    coinLight.Color = Color3.fromRGB(0, 255, 127)
    coinLight.Range = 2.2
    coinLight.Brightness = 1.6
    coinLight.Parent = coin
    
    -- Корона на монете
    local crown = Instance.new("Part")
    crown.Name = "Crown"
    crown.Size = Vector3.new(0.08, 0.06, 0.01)
    crown.Material = Enum.Material.Metal
    crown.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    crown.Anchored = true
    crown.CanCollide = false
    crown.Parent = model
    
    crown.Position = coin.Position + Vector3.new(0, 0.02, 0.015)
    
    -- Свечение короны
    local crownLight = Instance.new("PointLight")
    crownLight.Color = Color3.fromRGB(255, 215, 0)
    crownLight.Range = 0.8
    crownLight.Brightness = 1.0
    crownLight.Parent = crown
    
    -- Изумрудные камни на короне
    for i = 1, 5 do
        local gem = Instance.new("Part")
        gem.Name = "CrownGem" .. i
        gem.Size = Vector3.new(0.015, 0.015, 0.01)
        gem.Material = Enum.Material.Neon
        gem.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
        gem.Anchored = true
        gem.CanCollide = false
        gem.Parent = model
        
        -- Позиционирование камней
        local xPos = -0.03 + (i - 1) * 0.015
        gem.Position = crown.Position + Vector3.new(xPos, 0, 0.01)
        
        -- Свечение камней
        local gemLight = Instance.new("PointLight")
        gemLight.Color = Color3.fromRGB(0, 255, 127)
        gemLight.Range = 0.4
        gemLight.Brightness = 1.8
        gemLight.Parent = gem
    end
    
    -- Номинал монеты
    local denomination = Instance.new("Part")
    denomination.Name = "Denomination"
    denomination.Size = Vector3.new(0.06, 0.04, 0.01)
    denomination.Material = Enum.Material.Metal
    denomination.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    denomination.Anchored = true
    denomination.CanCollide = false
    denomination.Parent = model
    
    denomination.Position = coin.Position + Vector3.new(0, -0.04, 0.015)
    
    -- Свечение номинала
    local denominationLight = Instance.new("PointLight")
    denominationLight.Color = Color3.fromRGB(255, 215, 0)
    denominationLight.Range = 0.6
    denominationLight.Brightness = 0.8
    denominationLight.Parent = denomination
    
    -- Декоративные узоры на краю монеты
    for i = 1, 12 do
        local edgePattern = Instance.new("Part")
        edgePattern.Name = "EdgePattern" .. i
        edgePattern.Size = Vector3.new(0.02, 0.01, 0.02)
        edgePattern.Material = Enum.Material.Metal
        edgePattern.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        edgePattern.Anchored = true
        edgePattern.CanCollide = false
        edgePattern.Parent = model
        
        -- Позиционирование узоров по краю
        local angle = (i - 1) * 30
        local radius = 0.075
        local xPos = math.cos(math.rad(angle)) * radius
        local yPos = math.sin(math.rad(angle)) * radius
        edgePattern.Position = coin.Position + Vector3.new(xPos, yPos, 0.015)
        
        -- Свечение узоров
        local edgeLight = Instance.new("PointLight")
        edgeLight.Color = Color3.fromRGB(255, 215, 0)
        edgeLight.Range = 0.2
        edgeLight.Brightness = 0.6
        edgeLight.Parent = edgePattern
    end
    
    -- Магические руны на монете
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "EmeraldRune" .. i
        rune.Size = Vector3.new(0.02, 0.02, 0.01)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 0.05
        local xPos = math.cos(math.rad(angle)) * radius
        local yPos = math.sin(math.rad(angle)) * radius
        rune.Position = coin.Position + Vector3.new(xPos, yPos, 0.015)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(0, 255, 127)
        runeLight.Range = 0.5
        runeLight.Brightness = 1.5
        runeLight.Parent = rune
    end
    
    -- Изумрудные частицы вокруг монеты
    for i = 1, 45 do
        local particle = Instance.new("Part")
        particle.Name = "EmeraldParticle" .. i
        particle.Size = Vector3.new(0.008, 0.008, 0.008)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.2, 0.2)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.1, 0.1)
        particle.Position = coin.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(0, 255, 127)
        particleLight.Range = 0.4
        particleLight.Brightness = 1.0
        particleLight.Parent = particle
    end
    
    -- Золотые частицы от короны
    for i = 1, 25 do
        local goldParticle = Instance.new("Part")
        goldParticle.Name = "GoldParticle" .. i
        goldParticle.Size = Vector3.new(0.006, 0.006, 0.006)
        goldParticle.Material = Enum.Material.Neon
        goldParticle.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        goldParticle.Anchored = true
        goldParticle.CanCollide = false
        goldParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.15, 0.15)
        local yPos = math.random(-0.15, 0.15)
        local zPos = math.random(0.02, 0.1)
        goldParticle.Position = crown.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local goldParticleLight = Instance.new("PointLight")
        goldParticleLight.Color = Color3.fromRGB(255, 215, 0)
        goldParticleLight.Range = 0.3
        goldParticleLight.Brightness = 0.8
        goldParticleLight.Parent = goldParticle
    end
    
    -- Изумрудные частицы от камней
    for i = 1, 20 do
        local emeraldParticle = Instance.new("Part")
        emeraldParticle.Name = "EmeraldGemParticle" .. i
        emeraldParticle.Size = Vector3.new(0.005, 0.005, 0.005)
        emeraldParticle.Material = Enum.Material.Neon
        emeraldParticle.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
        emeraldParticle.Anchored = true
        emeraldParticle.CanCollide = false
        emeraldParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.1, 0.1)
        local yPos = math.random(-0.1, 0.1)
        local zPos = math.random(0.01, 0.08)
        emeraldParticle.Position = crown.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local emeraldParticleLight = Instance.new("PointLight")
        emeraldParticleLight.Color = Color3.fromRGB(0, 255, 127)
        emeraldParticleLight.Range = 0.25
        emeraldParticleLight.Brightness = 1.2
        emeraldParticleLight.Parent = emeraldParticle
    end
    
    -- Изумрудные частицы от рун
    for i = 1, 15 do
        local emeraldRuneParticle = Instance.new("Part")
        emeraldRuneParticle.Name = "EmeraldRuneParticle" .. i
        emeraldRuneParticle.Size = Vector3.new(0.007, 0.007, 0.007)
        emeraldRuneParticle.Material = Enum.Material.Neon
        emeraldRuneParticle.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
        emeraldRuneParticle.Anchored = true
        emeraldRuneParticle.CanCollide = false
        emeraldRuneParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.12, 0.12)
        local yPos = math.random(-0.12, 0.12)
        local zPos = math.random(0.015, 0.06)
        emeraldRuneParticle.Position = coin.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local emeraldRuneParticleLight = Instance.new("PointLight")
        emeraldRuneParticleLight.Color = Color3.fromRGB(0, 255, 127)
        emeraldRuneParticleLight.Range = 0.3
        emeraldRuneParticleLight.Brightness = 1.0
        emeraldRuneParticleLight.Parent = emeraldRuneParticle
    end
    
    -- Изумрудная аура вокруг монеты
    local aura = Instance.new("Part")
    aura.Name = "EmeraldAura"
    aura.Size = Vector3.new(0.3, 0.3, 0.1)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = coin.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(0, 255, 127)
    auraLight.Range = 2.5
    auraLight.Brightness = 0.5
    auraLight.Parent = aura
    
    -- Изумрудные кольца вокруг монеты
    for i = 1, 5 do
        local ring = Instance.new("Part")
        ring.Name = "EmeraldRing" .. i
        ring.Size = Vector3.new(0.2 + i * 0.05, 0.01, 0.2 + i * 0.05)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(0, 255, 127) -- Изумрудный
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = coin.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(0, 255, 127)
        ringLight.Range = 1.0 + i * 0.2
        ringLight.Brightness = 0.4
        ringLight.Parent = ring
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "currency")
    model:SetAttribute("ItemMaterial", "emerald")
    model:SetAttribute("ItemQuality", "epic")
    model:SetAttribute("ItemLevel", 8)
    model:SetAttribute("ItemRarity", "epic")
    model:SetAttribute("ItemClass", "currency")
    model:SetAttribute("ItemSubclass", "coin")
    model:SetAttribute("ItemWeight", 0.1)
    model:SetAttribute("ItemValue", 5000)
    model:SetAttribute("ItemCraftable", false)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", true)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 50)
    model:SetAttribute("ItemConsumable", false)
    model:SetAttribute("ItemUsable", false)
    model:SetAttribute("CoinType", "emerald")
    model:SetAttribute("CoinValue", 5000)
    model:SetAttribute("CoinWeight", 0.1)
    model:SetAttribute("CoinRarity", "epic")
    model:SetAttribute("CoinLevel", 8)
    model:SetAttribute("CoinMaterial", "emerald")
    
    return model
end

return CreateEmeraldCoin