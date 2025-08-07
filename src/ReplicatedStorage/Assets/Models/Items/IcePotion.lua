-- IcePotion.lua
-- Модель ледяного зелья

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIcePotion()
    local model = Instance.new("Model")
    model.Name = "IcePotion"
    
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
    potion.Color = Color3.fromRGB(135, 206, 235) -- Светло-голубой
    potion.Transparency = 0.2
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = bottle.Position + Vector3.new(0, 0.05, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(135, 206, 235)
    potionLight.Range = 2.5
    potionLight.Brightness = 1.8
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
    
    -- Ледяные кристаллы в зелье
    for i = 1, 12 do
        local crystal = Instance.new("Part")
        crystal.Name = "IceCrystal" .. i
        crystal.Size = Vector3.new(0.015, 0.015, 0.015)
        crystal.Material = Enum.Material.Neon
        crystal.Color = Color3.fromRGB(255, 255, 255) -- Белый
        crystal.Anchored = true
        crystal.CanCollide = false
        crystal.Parent = model
        
        -- Случайное позиционирование кристаллов
        local xPos = math.random(-0.1, 0.1)
        local yPos = math.random(-0.2, 0.2)
        local zPos = math.random(-0.1, 0.1)
        crystal.Position = potion.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение кристаллов
        local crystalLight = Instance.new("PointLight")
        crystalLight.Color = Color3.fromRGB(255, 255, 255)
        crystalLight.Range = 0.2
        crystalLight.Brightness = 0.8
        crystalLight.Parent = crystal
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
    
    -- Символ льда на этикетке
    local iceSymbol = Instance.new("Part")
    iceSymbol.Name = "IceSymbol"
    iceSymbol.Size = Vector3.new(0.1, 0.1, 0.05)
    iceSymbol.Material = Enum.Material.Neon
    iceSymbol.Color = Color3.fromRGB(135, 206, 235) -- Светло-голубой
    iceSymbol.Anchored = true
    iceSymbol.CanCollide = false
    iceSymbol.Parent = model
    
    iceSymbol.Position = label.Position + Vector3.new(0, 0, 0.025)
    
    -- Свечение символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(135, 206, 235)
    symbolLight.Range = 1.0
    symbolLight.Brightness = 0.8
    symbolLight.Parent = iceSymbol
    
    -- Ледяные руны на бутылке
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "IceRune" .. i
        rune.Size = Vector3.new(0.04, 0.04, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(173, 216, 230) -- Светло-голубой
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
        runeLight.Color = Color3.fromRGB(173, 216, 230)
        runeLight.Range = 0.4
        runeLight.Brightness = 0.6
        runeLight.Parent = rune
    end
    
    -- Ледяные частицы вокруг зелья
    for i = 1, 30 do
        local particle = Instance.new("Part")
        particle.Name = "IceParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(135, 206, 235) -- Светло-голубой
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
        particleLight.Color = Color3.fromRGB(135, 206, 235)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.5
        particleLight.Parent = particle
    end
    
    -- Ледяная аура вокруг зелья
    local aura = Instance.new("Part")
    aura.Name = "IceAura"
    aura.Size = Vector3.new(0.5, 0.8, 0.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(135, 206, 235) -- Светло-голубой
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = bottle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(135, 206, 235)
    auraLight.Range = 2.8
    auraLight.Brightness = 0.7
    auraLight.Parent = aura
    
    -- Ледяные кольца вокруг зелья
    for i = 1, 4 do
        local ring = Instance.new("Part")
        ring.Name = "IceRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.01, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(135, 206, 235) -- Светло-голубой
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(135, 206, 235)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.4
        ringLight.Parent = ring
    end
    
    -- Ледяные спирали
    for i = 1, 3 do
        local spiral = Instance.new("Part")
        spiral.Name = "IceSpiral" .. i
        spiral.Size = Vector3.new(0.3 + i * 0.1, 0.005, 0.3 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(173, 216, 230) -- Светло-голубой
        spiral.Transparency = 0.7
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = bottle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(173, 216, 230)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.3
        spiralLight.Parent = spiral
    end
    
    -- Ледяные вспышки
    for i = 1, 6 do
        local flash = Instance.new("Part")
        flash.Name = "IceFlash" .. i
        flash.Size = Vector3.new(0.03, 0.03, 0.03)
        flash.Material = Enum.Material.Neon
        flash.Color = Color3.fromRGB(255, 255, 255) -- Белый
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
        flashLight.Range = 0.4
        flashLight.Brightness = 0.8
        flashLight.Parent = flash
    end
    
    -- Ледяные сосульки
    for i = 1, 4 do
        local icicle = Instance.new("Part")
        icicle.Name = "IceIcicle" .. i
        icicle.Size = Vector3.new(0.01, 0.12, 0.01)
        icicle.Material = Enum.Material.Neon
        icicle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        icicle.Anchored = true
        icicle.CanCollide = false
        icicle.Parent = model
        
        -- Позиционирование сосулек
        local angle = (i - 1) * 90
        local radius = 0.18
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        icicle.Position = bottle.Position + Vector3.new(xPos, 0.06, zPos)
        
        -- Свечение сосулек
        local icicleLight = Instance.new("PointLight")
        icicleLight.Color = Color3.fromRGB(255, 255, 255)
        icicleLight.Range = 0.6
        icicleLight.Brightness = 0.6
        icicleLight.Parent = icicle
    end
    
    -- Снежинки
    for i = 1, 8 do
        local snowflake = Instance.new("Part")
        snowflake.Name = "Snowflake" .. i
        snowflake.Size = Vector3.new(0.02, 0.02, 0.02)
        snowflake.Material = Enum.Material.Neon
        snowflake.Color = Color3.fromRGB(255, 255, 255) -- Белый
        snowflake.Anchored = true
        snowflake.CanCollide = false
        snowflake.Parent = model
        
        -- Случайное позиционирование снежинок
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.4, 0.4)
        local zPos = math.random(-0.3, 0.3)
        snowflake.Position = bottle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение снежинок
        local snowflakeLight = Instance.new("PointLight")
        snowflakeLight.Color = Color3.fromRGB(255, 255, 255)
        snowflakeLight.Range = 0.2
        snowflakeLight.Brightness = 0.5
        snowflakeLight.Parent = snowflake
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
    model:SetAttribute("IceDamage", 70)
    model:SetAttribute("EffectDuration", 240)
    model:SetAttribute("Cooldown", 600)
    model:SetAttribute("PotionType", "ice")
    model:SetAttribute("PotionStrength", "strong")
    model:SetAttribute("PotionDuration", 240)
    model:SetAttribute("PotionEffect", "ice_damage")
    
    return model
end

return CreateIcePotion