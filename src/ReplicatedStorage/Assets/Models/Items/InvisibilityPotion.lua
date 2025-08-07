-- InvisibilityPotion.lua
-- Модель зелья невидимости

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateInvisibilityPotion()
    local model = Instance.new("Model")
    model.Name = "InvisibilityPotion"
    
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
    potion.Color = Color3.fromRGB(255, 255, 255) -- Белый
    potion.Transparency = 0.3
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(255, 255, 255)
    potionLight.Range = 2
    potionLight.Brightness = 1.0
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
    
    -- Невидимые искры в зелье
    for i = 1, 15 do
        local spark = Instance.new("Part")
        spark.Name = "InvisibleSpark" .. i
        spark.Size = Vector3.new(0.015, 0.015, 0.015)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 255) -- Белый
        spark.Transparency = 0.5
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
        sparkLight.Range = 0.15
        sparkLight.Brightness = 0.6
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
    
    -- Символ невидимости на этикетке
    local invisibilitySymbol = Instance.new("Part")
    invisibilitySymbol.Name = "InvisibilitySymbol"
    invisibilitySymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    invisibilitySymbol.Material = Enum.Material.Neon
    invisibilitySymbol.Color = Color3.fromRGB(255, 255, 255) -- Белый
    invisibilitySymbol.Transparency = 0.3
    invisibilitySymbol.Anchored = true
    invisibilitySymbol.CanCollide = false
    invisibilitySymbol.Parent = model
    
    invisibilitySymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(255, 255, 255)
    symbolLight.Range = 0.8
    symbolLight.Brightness = 0.6
    symbolLight.Parent = invisibilitySymbol
    
    -- Невидимые руны на бутылке
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "InvisibilityRune" .. i
        rune.Size = Vector3.new(0.03, 0.03, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 255) -- Белый
        rune.Transparency = 0.4
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
        runeLight.Color = Color3.fromRGB(255, 255, 255)
        runeLight.Range = 0.3
        runeLight.Brightness = 0.4
        runeLight.Parent = rune
    end
    
    -- Невидимые частицы вокруг зелья
    for i = 1, 30 do
        local particle = Instance.new("Part")
        particle.Name = "InvisibleParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        particle.Transparency = 0.6
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
        particleLight.Color = Color3.fromRGB(255, 255, 255)
        particleLight.Range = 0.2
        particleLight.Brightness = 0.3
        particleLight.Parent = particle
    end
    
    -- Невидимая аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "InvisibilityAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 255, 255) -- Белый
    aura.Transparency = 0.95
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 255, 255)
    auraLight.Range = 2.5
    auraLight.Brightness = 0.4
    auraLight.Parent = aura
    
    -- Невидимые кольца вокруг зелья
    for i = 1, 5 do
        local ring = Instance.new("Part")
        ring.Name = "InvisibleRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.01, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(255, 255, 255) -- Белый
        ring.Transparency = 0.9
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 255, 255)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.3
        ringLight.Parent = ring
    end
    
    -- Невидимые спирали
    for i = 1, 4 do
        local spiral = Instance.new("Part")
        spiral.Name = "InvisibleSpiral" .. i
        spiral.Size = Vector3.new(0.3 + i * 0.1, 0.005, 0.3 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(255, 255, 255) -- Белый
        spiral.Transparency = 0.8
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(255, 255, 255)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.25
        spiralLight.Parent = spiral
    end
    
    -- Невидимые вспышки
    for i = 1, 6 do
        local flash = Instance.new("Part")
        flash.Name = "InvisibleFlash" .. i
        flash.Size = Vector3.new(0.03, 0.03, 0.03)
        flash.Material = Enum.Material.Neon
        flash.Color = Color3.fromRGB(255, 255, 255) -- Белый
        flash.Transparency = 0.7
        flash.Anchored = true
        flash.CanCollide = false
        flash.Parent = model
        
        -- Позиционирование вспышек
        local angle = (i - 1) * 60
        local radius = 0.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        flash.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение вспышек
        local flashLight = Instance.new("PointLight")
        flashLight.Color = Color3.fromRGB(255, 255, 255)
        flashLight.Range = 0.3
        flashLight.Brightness = 0.6
        flashLight.Parent = flash
    end
    
    -- Невидимые волны
    for i = 1, 3 do
        local wave = Instance.new("Part")
        wave.Name = "InvisibleWave" .. i
        wave.Size = Vector3.new(0.4 + i * 0.15, 0.005, 0.4 + i * 0.15)
        wave.Material = Enum.Material.Neon
        wave.Color = Color3.fromRGB(255, 255, 255) -- Белый
        wave.Transparency = 0.85
        wave.Anchored = true
        wave.CanCollide = false
        wave.Parent = model
        
        wave.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение волн
        local waveLight = Instance.new("PointLight")
        waveLight.Color = Color3.fromRGB(255, 255, 255)
        waveLight.Range = 1.2 + i * 0.3
        waveLight.Brightness = 0.2
        waveLight.Parent = wave
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
    model:SetAttribute("ItemValue", 75)
    model:SetAttribute("ItemCraftable", true)
    model:SetAttribute("ItemTradeable", true)
    model:SetAttribute("ItemDroppable", true)
    model:SetAttribute("ItemSellable", true)
    model:SetAttribute("ItemStackable", true)
    model:SetAttribute("ItemMaxStack", 3)
    model:SetAttribute("ItemConsumable", true)
    model:SetAttribute("ItemUsable", true)
    model:SetAttribute("InvisibilityDuration", 120)
    model:SetAttribute("EffectDuration", 120)
    model:SetAttribute("Cooldown", 600)
    model:SetAttribute("PotionType", "invisibility")
    model:SetAttribute("PotionStrength", "strong")
    model:SetAttribute("PotionDuration", 120)
    model:SetAttribute("PotionEffect", "temporary_invisibility")
    
    return model
end

return CreateInvisibilityPotion