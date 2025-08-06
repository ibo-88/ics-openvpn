-- HealthPotion.lua
-- Модель зелья здоровья

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateHealthPotion()
    local model = Instance.new("Model")
    model.Name = "HealthPotion"
    
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
    potion.Color = Color3.fromRGB(255, 0, 0) -- Красный
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(255, 0, 0)
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
    
    -- Пузырьки в зелье
    for i = 1, 8 do
        local bubble = Instance.new("Part")
        bubble.Name = "Bubble" .. i
        bubble.Size = Vector3.new(0.05, 0.05, 0.05)
        bubble.Material = Enum.Material.Neon
        bubble.Color = Color3.fromRGB(255, 255, 255) -- Белый
        bubble.Transparency = 0.6
        bubble.Anchored = true
        bubble.CanCollide = false
        bubble.Parent = model
        
        -- Случайное позиционирование пузырьков
        local xPos = math.random(-0.1, 0.1)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.1, 0.1)
        bubble.Position = potion.Position + Vector3.new(xPos, yPos, zPos)
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
    
    -- Символ здоровья на этикетке
    local healthSymbol = Instance.new("Part")
    healthSymbol.Name = "HealthSymbol"
    healthSymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    healthSymbol.Material = Enum.Material.Neon
    healthSymbol.Color = Color3.fromRGB(255, 0, 0) -- Красный
    healthSymbol.Anchored = true
    healthSymbol.CanCollide = false
    healthSymbol.Parent = model
    
    healthSymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(255, 0, 0)
    symbolLight.Range = 1
    symbolLight.Brightness = 0.8
    symbolLight.Parent = healthSymbol
    
    -- Декоративные элементы на бутылке
    for i = 1, 4 do
        local decoration = Instance.new("Part")
        decoration.Name = "BottleDecoration" .. i
        decoration.Size = Vector3.new(0.02, 0.1, 0.02)
        decoration.Material = Enum.Material.Glass
        decoration.Color = Color3.fromRGB(255, 255, 255) -- Белый
        decoration.Transparency = 0.5
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local angle = (i - 1) * 90
        local radius = 0.16
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Магические частицы вокруг зелья
    for i = 1, 15 do
        local particle = Instance.new("Part")
        particle.Name = "HealthParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 0, 0) -- Красный
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
        particleLight.Color = Color3.fromRGB(255, 0, 0)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.4
        particleLight.Parent = particle
    end
    
    -- Магическая аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "HealthAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 0, 0) -- Красный
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 0, 0)
    auraLight.Range = 2.5
    auraLight.Brightness = 0.6
    auraLight.Parent = aura
    
    -- Магические искры
    for i = 1, 8 do
        local spark = Instance.new("Part")
        spark.Name = "HealthSpark" .. i
        spark.Size = Vector3.new(0.01, 0.01, 0.01)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.4, 0.4)
        local zPos = math.random(-0.3, 0.3)
        spark.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 0)
        sparkLight.Range = 0.2
        sparkLight.Brightness = 0.6
        sparkLight.Parent = spark
    end
    
    -- Магические кольца вокруг зелья
    for i = 1, 3 do
        local ring = Instance.new("Part")
        ring.Name = "HealthRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.02, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(255, 0, 0) -- Красный
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 0, 0)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.4
        ringLight.Parent = ring
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
    model:SetAttribute("ItemValue", 15)
    model:SetAttribute("ItemCraftable", true)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", true)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 10)
    model:SetAttribute("ItemConsumable", true)
    model:SetAttribute("ItemUsable", true)
    model:SetAttribute("HealthRestore", 50)
    model:SetAttribute("HealingTime", 3)
    model:SetAttribute("Cooldown", 10)
    model:SetAttribute("PotionType", "health")
    model:SetAttribute("PotionStrength", "medium")
    model:SetAttribute("PotionDuration", 0)
    model:SetAttribute("PotionEffect", "instant_heal")
    
    return model
end

return CreateHealthPotion