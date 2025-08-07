-- RegenerationPotion.lua
-- Модель зелья регенерации

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateRegenerationPotion()
    local model = Instance.new("Model")
    model.Name = "RegenerationPotion"
    
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
    potion.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(0, 255, 0)
    potionLight.Range = 3.0
    potionLight.Brightness = 2.5
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
    
    -- Исцеляющие искры в зелье
    for i = 1, 30 do
        local spark = Instance.new("Part")
        spark.Name = "HealingSpark" .. i
        spark.Size = Vector3.new(0.02, 0.02, 0.02)
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
        sparkLight.Range = 0.4
        sparkLight.Brightness = 1.2
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
    
    -- Символ исцеления на этикетке
    local healingSymbol = Instance.new("Part")
    healingSymbol.Name = "HealingSymbol"
    healingSymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    healingSymbol.Material = Enum.Material.Neon
    healingSymbol.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
    healingSymbol.Anchored = true
    healingSymbol.CanCollide = false
    healingSymbol.Parent = model
    
    healingSymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(0, 255, 0)
    symbolLight.Range = 1.5
    symbolLight.Brightness = 1.0
    symbolLight.Parent = healingSymbol
    
    -- Исцеляющие руны на бутылке
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "HealingRune" .. i
        rune.Size = Vector3.new(0.04, 0.04, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 45
        local radius = 0.16
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(0, 255, 0)
        runeLight.Range = 0.6
        runeLight.Brightness = 1.0
        runeLight.Parent = rune
    end
    
    -- Исцеляющие частицы вокруг зелья
    for i = 1, 45 do
        local particle = Instance.new("Part")
        particle.Name = "HealingParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
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
        particleLight.Color = Color3.fromRGB(0, 255, 0)
        particleLight.Range = 0.5
        particleLight.Brightness = 0.8
        particleLight.Parent = particle
    end
    
    -- Исцеляющая аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "HealingAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(0, 255, 0)
    auraLight.Range = 3.5
    auraLight.Brightness = 1.0
    auraLight.Parent = aura
    
    -- Исцеляющие кольца вокруг зелья
    for i = 1, 6 do
        local ring = Instance.new("Part")
        ring.Name = "HealingRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.01, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(0, 255, 0)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.6
        ringLight.Parent = ring
    end
    
    -- Исцеляющие спирали
    for i = 1, 5 do
        local spiral = Instance.new("Part")
        spiral.Name = "HealingSpiral" .. i
        spiral.Size = Vector3.new(0.3 + i * 0.1, 0.005, 0.3 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
        spiral.Transparency = 0.7
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(0, 255, 0)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.5
        spiralLight.Parent = spiral
    end
    
    -- Исцеляющие волны
    for i = 1, 8 do
        local wave = Instance.new("Part")
        wave.Name = "HealingWave" .. i
        wave.Size = Vector3.new(0.05, 0.05, 0.05)
        wave.Material = Enum.Material.Neon
        wave.Color = Color3.fromRGB(255, 255, 255) -- Белый
        wave.Anchored = true
        wave.CanCollide = false
        wave.Parent = model
        
        -- Позиционирование волн
        local angle = (i - 1) * 45
        local radius = 0.3
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        wave.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение волн
        local waveLight = Instance.new("PointLight")
        waveLight.Color = Color3.fromRGB(255, 255, 255)
        waveLight.Range = 0.8
        waveLight.Brightness = 1.5
        waveLight.Parent = wave
    end
    
    -- Исцеляющие лучи
    for i = 1, 6 do
        local ray = Instance.new("Part")
        ray.Name = "HealingRay" .. i
        ray.Size = Vector3.new(0.02, 0.15, 0.02)
        ray.Material = Enum.Material.Neon
        ray.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
        ray.Anchored = true
        ray.CanCollide = false
        ray.Parent = model
        
        -- Позиционирование лучей
        local angle = (i - 1) * 60
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        ray.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение лучей
        local rayLight = Instance.new("PointLight")
        rayLight.Color = Color3.fromRGB(0, 255, 0)
        rayLight.Range = 1.2
        rayLight.Brightness = 1.1
        rayLight.Parent = ray
    end
    
    -- Исцеляющие капли
    for i = 1, 15 do
        local drop = Instance.new("Part")
        drop.Name = "HealingDrop" .. i
        drop.Size = Vector3.new(0.03, 0.03, 0.03)
        drop.Material = Enum.Material.Neon
        drop.Color = Color3.fromRGB(0, 200, 0) -- Темно-зеленый
        drop.Anchored = true
        drop.CanCollide = false
        drop.Parent = model
        
        -- Случайное позиционирование капель
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.4, 0.4)
        local zPos = math.random(-0.3, 0.3)
        drop.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение капель
        local dropLight = Instance.new("PointLight")
        dropLight.Color = Color3.fromRGB(0, 200, 0)
        dropLight.Range = 0.6
        dropLight.Brightness = 0.9
        dropLight.Parent = drop
    end
    
    -- Исцеляющие звезды
    for i = 1, 12 do
        local star = Instance.new("Part")
        star.Name = "HealingStar" .. i
        star.Size = Vector3.new(0.02, 0.02, 0.02)
        star.Material = Enum.Material.Neon
        star.Color = Color3.fromRGB(255, 255, 255) -- Белый
        star.Anchored = true
        star.CanCollide = false
        star.Parent = model
        
        -- Случайное позиционирование звезд
        local xPos = math.random(-0.35, 0.35)
        local yPos = math.random(-0.45, 0.45)
        local zPos = math.random(-0.35, 0.35)
        star.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение звезд
        local starLight = Instance.new("PointLight")
        starLight.Color = Color3.fromRGB(255, 255, 255)
        starLight.Range = 0.4
        starLight.Brightness = 1.3
        starLight.Parent = star
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "potion")
    model:SetAttribute("ItemMaterial", "magic")
    model:SetAttribute("ItemQuality", "rare")
    model:SetAttribute("ItemLevel", 5)
    model:SetAttribute("ItemRarity", "rare")
    model:SetAttribute("ItemClass", "consumable")
    model:SetAttribute("ItemSubclass", "potion")
    model:SetAttribute("ItemWeight", 0.5)
    model:SetAttribute("ItemValue", 80)
    model:SetAttribute("ItemCraftable", true)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", true)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 3)
    model:SetAttribute("ItemConsumable", true)
    model:SetAttribute("ItemUsable", true)
    model:SetAttribute("RegenerationRate", 25)
    model:SetAttribute("EffectDuration", 600)
    model:SetAttribute("Cooldown", 300)
    model:SetAttribute("PotionType", "regeneration")
    model:SetAttribute("PotionStrength", "rare")
    model:SetAttribute("PotionDuration", 600)
    model:SetAttribute("PotionEffect", "health_regeneration")
    
    return model
end

return CreateRegenerationPotion