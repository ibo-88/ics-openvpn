-- ManaPotion.lua
-- Модель зелья маны

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateManaPotion()
    local model = Instance.new("Model")
    model.Name = "ManaPotion"
    
    -- Бутылка зелья
    local bottle = Instance.new("Part")
    bottle.Name = "Bottle"
    bottle.Size = Vector3.new(0.3, 0.6, 0.3)
    bottle.Material = Enum.Material.Glass
    bottle.Color = Color3.fromRGB(255, 255, 255) -- Белый
    bottle.Transparency = 0.3
    bottle.Anchored = true
    bottle.CanCollide = false
    bottle.Parent = model
    
    -- Создание текстуры стекла
    local glassTexture = Instance.new("Texture")
    glassTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    glassTexture.StudsPerTileU = 1
    glassTexture.StudsPerTileV = 1
    glassTexture.Parent = bottle
    
    -- Зелье внутри бутылки
    local potion = Instance.new("Part")
    potion.Name = "Potion"
    potion.Size = Vector3.new(0.25, 0.5, 0.25)
    potion.Material = Enum.Material.Neon
    potion.Color = Color3.fromRGB(0, 0, 255) -- Синий
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(0, 0, 255)
    potionLight.Range = 2
    potionLight.Brightness = 1.5
    potionLight.Parent = potion
    
    -- Горлышко бутылки
    local neck = Instance.new("Part")
    neck.Name = "BottleNeck"
    neck.Size = Vector3.new(0.15, 0.2, 0.15)
    neck.Material = Enum.Material.Glass
    neck.Color = Color3.fromRGB(255, 255, 255) -- Белый
    neck.Transparency = 0.3
    neck.Anchored = true
    neck.CanCollide = false
    neck.Parent = model
    
    neck.Position = bottle.Position + Vector3.new(0, 0.4, 0)
    
    -- Пробка бутылки
    local cork = Instance.new("Part")
    cork.Name = "Cork"
    cork.Size = Vector3.new(0.12, 0.1, 0.12)
    cork.Material = Enum.Material.Wood
    cork.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    cork.Anchored = true
    cork.CanCollide = false
    cork.Parent = model
    
    cork.Position = neck.Position + Vector3.new(0, 0.15, 0)
    
    -- Магические искры в зелье
    for i = 1, 12 do
        local spark = Instance.new("Part")
        spark.Name = "ManaSpark" .. i
        spark.Size = Vector3.new(0.03, 0.03, 0.03)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 255) -- Белый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.1, 0.1)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.1, 0.1)
        spark.Position = potion.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 255)
        sparkLight.Range = 0.2
        sparkLight.Brightness = 0.8
        sparkLight.Parent = spark
    end
    
    -- Этикетка на бутылке
    local label = Instance.new("Part")
    label.Name = "Label"
    label.Size = Vector3.new(0.28, 0.3, 0.02)
    label.Material = Enum.Material.Paper
    label.Color = Color3.fromRGB(255, 255, 255) -- Белый
    label.Anchored = true
    label.CanCollide = false
    label.Parent = model
    
    label.Position = bottle.Position + Vector3.new(0, 0, 0.16)
    
    -- Символ маны на этикетке
    local manaSymbol = Instance.new("Part")
    manaSymbol.Name = "ManaSymbol"
    manaSymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    manaSymbol.Material = Enum.Material.Neon
    manaSymbol.Color = Color3.fromRGB(0, 0, 255) -- Синий
    manaSymbol.Anchored = true
    manaSymbol.CanCollide = false
    manaSymbol.Parent = model
    
    manaSymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(0, 0, 255)
    symbolLight.Range = 1
    symbolLight.Brightness = 0.8
    symbolLight.Parent = manaSymbol
    
    -- Магические руны на бутылке
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "BottleRune" .. i
        rune.Size = Vector3.new(0.05, 0.05, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 0.16
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(0, 255, 255)
        runeLight.Range = 0.5
        runeLight.Brightness = 0.6
        runeLight.Parent = rune
    end
    
    -- Магические частицы вокруг зелья
    for i = 1, 20 do
        local particle = Instance.new("Part")
        particle.Name = "ManaParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(0, 0, 255) -- Синий
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-0.5, 0.5)
        local zPos = math.random(-0.4, 0.4)
        particle.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(0, 0, 255)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.4
        particleLight.Parent = particle
    end
    
    -- Магическая аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "ManaAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(0, 0, 255) -- Синий
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(0, 0, 255)
    auraLight.Range = 2.5
    auraLight.Brightness = 0.6
    auraLight.Parent = aura
    
    -- Магические кольца вокруг зелья
    for i = 1, 4 do
        local ring = Instance.new("Part")
        ring.Name = "ManaRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.02, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(0, 0, 255) -- Синий
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(0, 0, 255)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.4
        ringLight.Parent = ring
    end
    
    -- Магические волны
    for i = 1, 5 do
        local wave = Instance.new("Part")
        wave.Name = "ManaWave" .. i
        wave.Size = Vector3.new(0.3 + i * 0.1, 0.01, 0.3 + i * 0.1)
        wave.Material = Enum.Material.Neon
        wave.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        wave.Transparency = 0.7
        wave.Anchored = true
        wave.CanCollide = false
        wave.Parent = model
        
        wave.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение волн
        local waveLight = Instance.new("PointLight")
        waveLight.Color = Color3.fromRGB(0, 255, 255)
        waveLight.Range = 1 + i * 0.2
        waveLight.Brightness = 0.3
        waveLight.Parent = wave
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "potion")
    model:SetAttribute("ItemMaterial", "magic")
    model:SetAttribute("ItemQuality", "common")
    model:SetAttribute("ItemLevel", 1)
    model:SetAttribute("ItemRarity", "common")
    model:SetAttribute("ItemClass", "consumable")
    model:SetAttribute("ItemSubclass", "potion")
    model:SetAttribute("ItemWeight", 0.5)
    model:SetAttribute("ItemValue", 20)
    model:SetAttribute("ItemCraftable", true)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", true)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 10)
    model:SetAttribute("ItemConsumable", true)
    model:SetAttribute("ItemUsable", true)
    model:SetAttribute("ManaRestore", 75)
    model:SetAttribute("RestorationTime", 2)
    model:SetAttribute("Cooldown", 8)
    model:SetAttribute("PotionType", "mana")
    model:SetAttribute("PotionStrength", "medium")
    model:SetAttribute("PotionDuration", 0)
    model:SetAttribute("PotionEffect", "instant_mana")
    
    return model
end

return CreateManaPotion