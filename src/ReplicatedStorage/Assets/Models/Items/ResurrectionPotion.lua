-- ResurrectionPotion.lua
-- Модель зелья воскрешения

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateResurrectionPotion()
    local model = Instance.new("Model")
    model.Name = "ResurrectionPotion"
    
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
    potion.Color = Color3.fromRGB(255, 255, 0) -- Золотой
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(255, 255, 0)
    potionLight.Range = 3.5
    potionLight.Brightness = 3.0
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
    
    -- Воскрешающие искры в зелье
    for i = 1, 35 do
        local spark = Instance.new("Part")
        spark.Name = "ResurrectionSpark" .. i
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
        sparkLight.Range = 0.5
        sparkLight.Brightness = 1.5
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
    
    -- Символ воскрешения на этикетке
    local resurrectionSymbol = Instance.new("Part")
    resurrectionSymbol.Name = "ResurrectionSymbol"
    resurrectionSymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    resurrectionSymbol.Material = Enum.Material.Neon
    resurrectionSymbol.Color = Color3.fromRGB(255, 255, 0) -- Золотой
    resurrectionSymbol.Anchored = true
    resurrectionSymbol.CanCollide = false
    resurrectionSymbol.Parent = model
    
    resurrectionSymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(255, 255, 0)
    symbolLight.Range = 1.8
    symbolLight.Brightness = 1.2
    symbolLight.Parent = resurrectionSymbol
    
    -- Воскрешающие руны на бутылке
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "ResurrectionRune" .. i
        rune.Size = Vector3.new(0.04, 0.04, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
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
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 0.7
        runeLight.Brightness = 1.2
        runeLight.Parent = rune
    end
    
    -- Воскрешающие частицы вокруг зелья
    for i = 1, 60 do
        local particle = Instance.new("Part")
        particle.Name = "ResurrectionParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 0) -- Золотой
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
        particleLight.Color = Color3.fromRGB(255, 255, 0)
        particleLight.Range = 0.6
        particleLight.Brightness = 1.0
        particleLight.Parent = particle
    end
    
    -- Воскрешающая аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "ResurrectionAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 255, 0) -- Золотой
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 255, 0)
    auraLight.Range = 4.0
    auraLight.Brightness = 1.2
    auraLight.Parent = aura
    
    -- Воскрешающие кольца вокруг зелья
    for i = 1, 7 do
        local ring = Instance.new("Part")
        ring.Name = "ResurrectionRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.01, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 255, 0)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.7
        ringLight.Parent = ring
    end
    
    -- Воскрешающие спирали
    for i = 1, 6 do
        local spiral = Instance.new("Part")
        spiral.Name = "ResurrectionSpiral" .. i
        spiral.Size = Vector3.new(0.3 + i * 0.1, 0.005, 0.3 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        spiral.Transparency = 0.7
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(255, 255, 0)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.6
        spiralLight.Parent = spiral
    end
    
    -- Воскрешающие порталы
    for i = 1, 10 do
        local portal = Instance.new("Part")
        portal.Name = "ResurrectionPortal" .. i
        portal.Size = Vector3.new(0.06, 0.06, 0.06)
        portal.Material = Enum.Material.Neon
        portal.Color = Color3.fromRGB(255, 255, 255) -- Белый
        portal.Anchored = true
        portal.CanCollide = false
        portal.Parent = model
        
        -- Позиционирование порталов
        local angle = (i - 1) * 36
        local radius = 0.35
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        portal.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение порталов
        local portalLight = Instance.new("PointLight")
        portalLight.Color = Color3.fromRGB(255, 255, 255)
        portalLight.Range = 1.0
        portalLight.Brightness = 1.8
        portalLight.Parent = portal
    end
    
    -- Воскрешающие разрывы
    for i = 1, 5 do
        local rift = Instance.new("Part")
        rift.Name = "ResurrectionRift" .. i
        rift.Size = Vector3.new(0.02, 0.18, 0.02)
        rift.Material = Enum.Material.Neon
        rift.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rift.Anchored = true
        rift.CanCollide = false
        rift.Parent = model
        
        -- Позиционирование разрывов
        local angle = (i - 1) * 72
        local radius = 0.3
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rift.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение разрывов
        local riftLight = Instance.new("PointLight")
        riftLight.Color = Color3.fromRGB(255, 255, 0)
        riftLight.Range = 1.4
        riftLight.Brightness = 1.3
        riftLight.Parent = rift
    end
    
    -- Воскрешающие искажения
    for i = 1, 15 do
        local distortion = Instance.new("Part")
        distortion.Name = "ResurrectionDistortion" .. i
        distortion.Size = Vector3.new(0.035, 0.035, 0.035)
        distortion.Material = Enum.Material.Neon
        distortion.Color = Color3.fromRGB(255, 215, 0) -- Темно-золотой
        distortion.Anchored = true
        distortion.CanCollide = false
        distortion.Parent = model
        
        -- Случайное позиционирование искажений
        local xPos = math.random(-0.35, 0.35)
        local yPos = math.random(-0.45, 0.45)
        local zPos = math.random(-0.35, 0.35)
        distortion.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искажений
        local distortionLight = Instance.new("PointLight")
        distortionLight.Color = Color3.fromRGB(255, 215, 0)
        distortionLight.Range = 0.7
        distortionLight.Brightness = 1.1
        distortionLight.Parent = distortion
    end
    
    -- Воскрешающие звезды
    for i = 1, 20 do
        local star = Instance.new("Part")
        star.Name = "ResurrectionStar" .. i
        star.Size = Vector3.new(0.025, 0.025, 0.025)
        star.Material = Enum.Material.Neon
        star.Color = Color3.fromRGB(255, 255, 255) -- Белый
        star.Anchored = true
        star.CanCollide = false
        star.Parent = model
        
        -- Случайное позиционирование звезд
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-0.5, 0.5)
        local zPos = math.random(-0.4, 0.4)
        star.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение звезд
        local starLight = Instance.new("PointLight")
        starLight.Color = Color3.fromRGB(255, 255, 255)
        starLight.Range = 0.5
        starLight.Brightness = 1.5
        starLight.Parent = star
    end
    
    -- Воскрешающие лучи
    for i = 1, 8 do
        local ray = Instance.new("Part")
        ray.Name = "ResurrectionRay" .. i
        ray.Size = Vector3.new(0.025, 0.2, 0.025)
        ray.Material = Enum.Material.Neon
        ray.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        ray.Anchored = true
        ray.CanCollide = false
        ray.Parent = model
        
        -- Позиционирование лучей
        local angle = (i - 1) * 45
        local radius = 0.28
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        ray.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение лучей
        local rayLight = Instance.new("PointLight")
        rayLight.Color = Color3.fromRGB(255, 255, 0)
        rayLight.Range = 1.5
        rayLight.Brightness = 1.4
        rayLight.Parent = ray
    end
    
    -- Установка атрибутов
    model:SetAttribute("ItemType", "potion")
    model:SetAttribute("ItemMaterial", "magic")
    model:SetAttribute("ItemQuality", "legendary")
    model:SetAttribute("ItemLevel", 10)
    model:SetAttribute("ItemRarity", "legendary")
    model:SetAttribute("ItemClass", "consumable")
    model:SetAttribute("ItemSubclass", "potion")
    model:SetAttribute("ItemWeight", 0.5)
    model:SetAttribute("ItemValue", 500)
    model:SetAttribute("ItemCraftable", true)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", true)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 1)
    model:SetAttribute("ItemConsumable", true)
    model:SetAttribute("ItemUsable", true)
    model:SetAttribute("ResurrectionHealth", 100)
    model:SetAttribute("EffectDuration", 0)
    model:SetAttribute("Cooldown", 3600)
    model:SetAttribute("PotionType", "resurrection")
    model:SetAttribute("PotionStrength", "legendary")
    model:SetAttribute("PotionDuration", 0)
    model:SetAttribute("PotionEffect", "resurrection")
    
    return model
end

return CreateResurrectionPotion