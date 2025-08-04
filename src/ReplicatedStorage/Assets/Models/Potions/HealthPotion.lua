-- HealthPotion.lua
-- Модель зелья здоровья

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateHealthPotion()
    local model = Instance.new("Model")
    model.Name = "HealthPotion"
    
    -- Основная бутылка
    local bottle = Instance.new("Part")
    bottle.Name = "Bottle"
    bottle.Size = Vector3.new(0.4, 0.8, 0.4)
    bottle.Material = Enum.Material.Glass
    bottle.Color = Color3.fromRGB(255, 255, 255) -- Прозрачное стекло
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
    potion.Name = "PotionLiquid"
    potion.Size = Vector3.new(0.35, 0.7, 0.35)
    potion.Material = Enum.Material.Neon
    potion.Color = Color3.fromRGB(255, 0, 0) -- Красный цвет зелья
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, -0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(255, 0, 0)
    potionLight.Range = 3
    potionLight.Brightness = 2
    potionLight.Parent = potion
    
    -- Горлышко бутылки
    local neck = Instance.new("Part")
    neck.Name = "BottleNeck"
    neck.Size = Vector3.new(0.2, 0.3, 0.2)
    neck.Material = Enum.Material.Glass
    neck.Color = Color3.fromRGB(255, 255, 255) -- Прозрачное стекло
    neck.Transparency = 0.3
    neck.Anchored = true
    neck.CanCollide = false
    neck.Parent = model
    
    neck.Position = bottle.Position + Vector3.new(0, 0.55, 0)
    
    -- Пробка бутылки
    local cork = Instance.new("Part")
    cork.Name = "Cork"
    cork.Size = Vector3.new(0.25, 0.2, 0.25)
    cork.Material = Enum.Material.Wood
    cork.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    cork.Anchored = true
    cork.CanCollide = false
    cork.Parent = model
    
    cork.Position = neck.Position + Vector3.new(0, 0.25, 0)
    
    -- Декоративные кольца на бутылке
    for i = 1, 3 do
        local ring = Instance.new("Part")
        ring.Name = "BottleRing" .. i
        ring.Size = Vector3.new(0.45, 0.05, 0.45)
        ring.Material = Enum.Material.Metal
        ring.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.2 + (i - 1) * 0.3
        ring.Position = bottle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Этикетка на бутылке
    local label = Instance.new("Part")
    label.Name = "PotionLabel"
    label.Size = Vector3.new(0.4, 0.4, 0.05)
    label.Material = Enum.Material.Paper
    label.Color = Color3.fromRGB(255, 255, 255) -- Белый
    label.Anchored = true
    label.CanCollide = false
    label.Parent = model
    
    label.Position = bottle.Position + Vector3.new(0, 0.1, 0.225)
    
    -- Символ сердца на этикетке
    local heartSymbol = Instance.new("Part")
    heartSymbol.Name = "HeartSymbol"
    heartSymbol.Size = Vector3.new(0.2, 0.2, 0.1)
    heartSymbol.Material = Enum.Material.Neon
    heartSymbol.Color = Color3.fromRGB(255, 0, 0) -- Красный
    heartSymbol.Anchored = true
    heartSymbol.CanCollide = false
    heartSymbol.Parent = model
    
    heartSymbol.Position = label.Position + Vector3.new(0, 0, 0.075)
    
    -- Свечение символа
    local heartLight = Instance.new("PointLight")
    heartLight.Color = Color3.fromRGB(255, 0, 0)
    heartLight.Range = 2
    heartLight.Brightness = 1
    heartLight.Parent = heartSymbol
    
    -- Магические частицы вокруг бутылки
    for i = 1, 8 do
        local particle = Instance.new("Part")
        particle.Name = "HealthParticle" .. i
        particle.Size = Vector3.new(0.1, 0.1, 0.1)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 0, 0) -- Красный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local angle = (i - 1) * 45
        local radius = 0.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = math.random(-0.3, 0.3)
        particle.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 0, 0)
        particleLight.Range = 1
        particleLight.Brightness = 0.5
        particleLight.Parent = particle
    end
    
    -- Магические руны на бутылке
    for i = 1, 4 do
        local rune = Instance.new("Part")
        rune.Name = "HealthRune" .. i
        rune.Size = Vector3.new(0.15, 0.15, 0.05)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 90
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 1.5
        runeLight.Brightness = 0.8
        runeLight.Parent = rune
    end
    
    -- Подставка для зелья
    local stand = Instance.new("Part")
    stand.Name = "PotionStand"
    stand.Size = Vector3.new(0.6, 0.2, 0.6)
    stand.Material = Enum.Material.Metal
    stand.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    stand.Anchored = true
    stand.CanCollide = false
    stand.Parent = model
    
    stand.Position = bottle.Position + Vector3.new(0, -0.5, 0)
    
    -- Декоративные ножки подставки
    for i = 1, 4 do
        local leg = Instance.new("Part")
        leg.Name = "StandLeg" .. i
        leg.Size = Vector3.new(0.1, 0.3, 0.1)
        leg.Material = Enum.Material.Metal
        leg.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        leg.Anchored = true
        leg.CanCollide = false
        leg.Parent = model
        
        -- Позиционирование ножек
        local angle = (i - 1) * 90
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        leg.Position = stand.Position + Vector3.new(xPos, -0.25, zPos)
    end
    
    -- Эффект пузырьков в зелье
    for i = 1, 5 do
        local bubble = Instance.new("Part")
        bubble.Name = "PotionBubble" .. i
        bubble.Size = Vector3.new(0.05, 0.05, 0.05)
        bubble.Material = Enum.Material.Glass
        bubble.Color = Color3.fromRGB(255, 255, 255) -- Белый
        bubble.Transparency = 0.5
        bubble.Anchored = true
        bubble.CanCollide = false
        bubble.Parent = model
        
        -- Случайное позиционирование пузырьков
        local xPos = math.random(-0.15, 0.15)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.15, 0.15)
        bubble.Position = potion.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Магическая аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "HealthAura"
    aura.Size = Vector3.new(0.8, 1.2, 0.8)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 0, 0) -- Красный
    aura.Transparency = 0.8
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 0, 0)
    auraLight.Range = 4
    auraLight.Brightness = 0.5
    auraLight.Parent = aura
    
    -- UI для зелья здоровья
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 1.5, 0)
    billboardGui.Parent = bottle
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Зелье здоровья"
    nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Красный текст
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local effectLabel = Instance.new("TextLabel")
    effectLabel.Size = UDim2.new(1, 0, 0.3, 0)
    effectLabel.Position = UDim2.new(0, 0, 0.4, 0)
    effectLabel.BackgroundTransparency = 1
    effectLabel.Text = "Восстанавливает 50 HP"
    effectLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    effectLabel.TextScaled = true
    effectLabel.Font = Enum.Font.Gotham
    effectLabel.Parent = billboardGui
    
    local qualityLabel = Instance.new("TextLabel")
    qualityLabel.Size = UDim2.new(1, 0, 0.3, 0)
    qualityLabel.Position = UDim2.new(0, 0, 0.7, 0)
    qualityLabel.BackgroundTransparency = 1
    qualityLabel.Text = "Обычное"
    qualityLabel.TextColor3 = Color3.fromRGB(192, 192, 192) -- Серебряный
    qualityLabel.TextScaled = true
    qualityLabel.Font = Enum.Font.Gotham
    qualityLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("PotionType", "health")
    model:SetAttribute("PotionQuality", "common")
    model:SetAttribute("HealingAmount", 50)
    model:SetAttribute("MaxHealingAmount", 50)
    model:SetAttribute("Duration", 0)
    model:SetAttribute("Cooldown", 5)
    model:SetAttribute("IsPotion", true)
    model:SetAttribute("CanBeUsed", true)
    model:SetAttribute("IsConsumable", true)
    model:SetAttribute("StackSize", 10)
    model:SetAttribute("MaxStackSize", 10)
    model:SetAttribute("HealthRunes", 4)
    model:SetAttribute("HealthParticles", 8)
    model:SetAttribute("PotionBubbles", 5)
    model:SetAttribute("BottleRings", 3)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("EffectLabel", effectLabel)
    model:SetAttribute("QualityLabel", qualityLabel)
    
    return model
end

return CreateHealthPotion