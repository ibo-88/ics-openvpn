-- FirePotion.lua
-- Модель огненного зелья

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateFirePotion()
    local model = Instance.new("Model")
    model.Name = "FirePotion"
    
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
    potion.Color = Color3.fromRGB(255, 69, 0) -- Оранжево-красный
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(255, 69, 0)
    potionLight.Range = 2.5
    potionLight.Brightness = 2.0
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
    
    -- Огненные искры в зелье
    for i = 1, 15 do
        local spark = Instance.new("Part")
        spark.Name = "FireSpark" .. i
        spark.Size = Vector3.new(0.02, 0.02, 0.02)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 0) -- Желтый
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
        sparkLight.Color = Color3.fromRGB(255, 255, 0)
        sparkLight.Range = 0.3
        sparkLight.Brightness = 1.0
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
    
    -- Символ огня на этикетке
    local fireSymbol = Instance.new("Part")
    fireSymbol.Name = "FireSymbol"
    fireSymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    fireSymbol.Material = Enum.Material.Neon
    fireSymbol.Color = Color3.fromRGB(255, 69, 0) -- Оранжево-красный
    fireSymbol.Anchored = true
    fireSymbol.CanCollide = false
    fireSymbol.Parent = model
    
    fireSymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(255, 69, 0)
    symbolLight.Range = 1.2
    symbolLight.Brightness = 1.0
    symbolLight.Parent = fireSymbol
    
    -- Огненные руны на бутылке
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "FireRune" .. i
        rune.Size = Vector3.new(0.04, 0.04, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 140, 0) -- Темно-оранжевый
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
        runeLight.Color = Color3.fromRGB(255, 140, 0)
        runeLight.Range = 0.5
        runeLight.Brightness = 0.8
        runeLight.Parent = rune
    end
    
    -- Огненные частицы вокруг зелья
    for i = 1, 35 do
        local particle = Instance.new("Part")
        particle.Name = "FireParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 69, 0) -- Оранжево-красный
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
        particleLight.Color = Color3.fromRGB(255, 69, 0)
        particleLight.Range = 0.4
        particleLight.Brightness = 0.6
        particleLight.Parent = particle
    end
    
    -- Огненная аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "FireAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 69, 0) -- Оранжево-красный
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 69, 0)
    auraLight.Range = 3.0
    auraLight.Brightness = 0.8
    auraLight.Parent = aura
    
    -- Огненные кольца вокруг зелья
    for i = 1, 4 do
        local ring = Instance.new("Part")
        ring.Name = "FireRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.02, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(255, 69, 0) -- Оранжево-красный
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 69, 0)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.5
        ringLight.Parent = ring
    end
    
    -- Огненные спирали
    for i = 1, 3 do
        local spiral = Instance.new("Part")
        spiral.Name = "FireSpiral" .. i
        spiral.Size = Vector3.new(0.3 + i * 0.1, 0.01, 0.3 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(255, 140, 0) -- Темно-оранжевый
        spiral.Transparency = 0.7
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(255, 140, 0)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.4
        spiralLight.Parent = spiral
    end
    
    -- Огненные вспышки
    for i = 1, 8 do
        local flash = Instance.new("Part")
        flash.Name = "FireFlash" .. i
        flash.Size = Vector3.new(0.04, 0.04, 0.04)
        flash.Material = Enum.Material.Neon
        flash.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        flash.Anchored = true
        flash.CanCollide = false
        flash.Parent = model
        
        -- Позиционирование вспышек
        local angle = (i - 1) * 45
        local radius = 0.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        flash.Position = bottle.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение вспышек
        local flashLight = Instance.new("PointLight")
        flashLight.Color = Color3.fromRGB(255, 255, 0)
        flashLight.Range = 0.5
        flashLight.Brightness = 1.0
        flashLight.Parent = flash
    end
    
    -- Огненные языки
    for i = 1, 5 do
        local flame = Instance.new("Part")
        flame.Name = "FireFlame" .. i
        flame.Size = Vector3.new(0.02, 0.15, 0.02)
        flame.Material = Enum.Material.Neon
        flame.Color = Color3.fromRGB(255, 69, 0) -- Оранжево-красный
        flame.Anchored = true
        flame.CanCollide = false
        flame.Parent = model
        
        -- Позиционирование языков пламени
        local angle = (i - 1) * 72
        local radius = 0.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        flame.Position = bottle.Position + Vector3.new(xPos, 0.1, zPos)
        
        -- Свечение языков
        local flameLight = Instance.new("PointLight")
        flameLight.Color = Color3.fromRGB(255, 69, 0)
        flameLight.Range = 0.8
        flameLight.Brightness = 0.7
        flameLight.Parent = flame
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
    model:SetAttribute("FireDamage", 75)
    model:SetAttribute("EffectDuration", 240)
    model:SetAttribute("Cooldown", 600)
    model:SetAttribute("PotionType", "fire")
    model:SetAttribute("PotionStrength", "strong")
    model:SetAttribute("PotionDuration", 240)
    model:SetAttribute("PotionEffect", "fire_damage")
    
    return model
end

return CreateFirePotion