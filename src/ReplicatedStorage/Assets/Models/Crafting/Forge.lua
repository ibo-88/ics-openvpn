-- Forge.lua
-- Модель кузни

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateForge()
    local model = Instance.new("Model")
    model.Name = "Forge"
    
    -- Основная кузня
    local forge = Instance.new("Part")
    forge.Name = "ForgeBase"
    forge.Size = Vector3.new(3, 2, 3)
    forge.Material = Enum.Material.Metal
    forge.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    forge.Anchored = true
    forge.CanCollide = true
    forge.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 2
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = forge
    
    -- Очаг кузни
    local hearth = Instance.new("Part")
    hearth.Name = "ForgeHearth"
    hearth.Size = Vector3.new(2, 1, 2)
    hearth.Material = Enum.Material.Metal
    hearth.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
    hearth.Anchored = true
    hearth.CanCollide = true
    hearth.Parent = model
    
    hearth.Position = forge.Position + Vector3.new(0, 1.5, 0)
    
    -- Огонь в очаге
    local fire = Instance.new("Part")
    fire.Name = "ForgeFire"
    fire.Size = Vector3.new(1.8, 0.8, 1.8)
    fire.Material = Enum.Material.Neon
    fire.Color = Color3.fromRGB(255, 100, 0) -- Оранжевый огонь
    fire.Anchored = true
    fire.CanCollide = false
    fire.Parent = model
    
    fire.Position = hearth.Position + Vector3.new(0, 0.4, 0)
    
    -- Свечение огня
    local fireLight = Instance.new("PointLight")
    fireLight.Color = Color3.fromRGB(255, 100, 0)
    fireLight.Range = 8
    fireLight.Brightness = 3
    fireLight.Parent = fire
    
    -- Угли в очаге
    for i = 1, 12 do
        local coal = Instance.new("Part")
        coal.Name = "Coal" .. i
        coal.Size = Vector3.new(0.3, 0.2, 0.3)
        coal.Material = Enum.Material.Metal
        coal.Color = Color3.fromRGB(32, 32, 32) -- Черный уголь
        coal.Anchored = true
        coal.CanCollide = false
        coal.Parent = model
        
        -- Случайное позиционирование углей
        local xPos = math.random(-0.7, 0.7)
        local zPos = math.random(-0.7, 0.7)
        coal.Position = hearth.Position + Vector3.new(xPos, 0.1, zPos)
        
        -- Свечение углей
        local coalLight = Instance.new("PointLight")
        coalLight.Color = Color3.fromRGB(255, 50, 0)
        coalLight.Range = 1
        coalLight.Brightness = 0.5
        coalLight.Parent = coal
    end
    
    -- Дымоход кузни
    local chimney = Instance.new("Part")
    chimney.Name = "Chimney"
    chimney.Size = Vector3.new(1, 4, 1)
    chimney.Material = Enum.Material.Metal
    chimney.Color = Color3.fromRGB(128, 128, 128) -- Серый
    chimney.Anchored = true
    chimney.CanCollide = true
    chimney.Parent = model
    
    chimney.Position = forge.Position + Vector3.new(0, 4, 0)
    
    -- Дым из дымохода
    for i = 1, 8 do
        local smoke = Instance.new("Part")
        smoke.Name = "Smoke" .. i
        smoke.Size = Vector3.new(0.5, 0.5, 0.5)
        smoke.Material = Enum.Material.Neon
        smoke.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый дым
        smoke.Transparency = 0.7
        smoke.Anchored = true
        smoke.CanCollide = false
        smoke.Parent = model
        
        -- Случайное позиционирование дыма
        local xPos = math.random(-0.3, 0.3)
        local yPos = 2 + math.random(0, 3)
        local zPos = math.random(-0.3, 0.3)
        smoke.Position = chimney.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Наковальня
    local anvil = Instance.new("Part")
    anvil.Name = "Anvil"
    anvil.Size = Vector3.new(1.5, 1, 2)
    anvil.Material = Enum.Material.Metal
    anvil.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    anvil.Anchored = true
    anvil.CanCollide = true
    anvil.Parent = model
    
    anvil.Position = forge.Position + Vector3.new(2.5, 1.5, 0)
    
    -- Рог наковальни
    local anvilHorn = Instance.new("Part")
    anvilHorn.Name = "AnvilHorn"
    anvilHorn.Size = Vector3.new(0.3, 0.8, 0.3)
    anvilHorn.Material = Enum.Material.Metal
    anvilHorn.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    anvilHorn.Anchored = true
    anvilHorn.CanCollide = false
    anvilHorn.Parent = model
    
    anvilHorn.Position = anvil.Position + Vector3.new(0.6, 0.9, 0)
    
    -- Молот кузнеца
    local hammer = Instance.new("Part")
    hammer.Name = "BlacksmithHammer"
    hammer.Size = Vector3.new(0.4, 1.2, 0.4)
    hammer.Material = Enum.Material.Metal
    hammer.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    hammer.Anchored = true
    hammer.CanCollide = false
    hammer.Parent = model
    
    hammer.Position = anvil.Position + Vector3.new(0, 1.6, 0.8)
    
    -- Рукоять молота
    local hammerHandle = Instance.new("Part")
    hammerHandle.Name = "HammerHandle"
    hammerHandle.Size = Vector3.new(0.1, 0.8, 0.1)
    hammerHandle.Material = Enum.Material.Wood
    hammerHandle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    hammerHandle.Anchored = true
    hammerHandle.CanCollide = false
    hammerHandle.Parent = hammer
    
    hammerHandle.Position = hammer.Position + Vector3.new(0, -1, 0)
    
    -- Головка молота
    local hammerHead = Instance.new("Part")
    hammerHead.Name = "HammerHead"
    hammerHead.Size = Vector3.new(0.6, 0.4, 0.6)
    hammerHead.Material = Enum.Material.Metal
    hammerHead.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
    hammerHead.Anchored = true
    hammerHead.CanCollide = false
    hammerHead.Parent = hammer
    
    hammerHead.Position = hammer.Position + Vector3.new(0, 0.8, 0)
    
    -- Клещи
    local tongs = Instance.new("Part")
    tongs.Name = "Tongs"
    tongs.Size = Vector3.new(0.1, 1, 0.1)
    tongs.Material = Enum.Material.Metal
    tongs.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    tongs.Anchored = true
    tongs.CanCollide = false
    tongs.Parent = model
    
    tongs.Position = anvil.Position + Vector3.new(0, 1.6, -0.8)
    
    -- Рукоять клещей
    local tongsHandle = Instance.new("Part")
    tongsHandle.Name = "TongsHandle"
    tongsHandle.Size = Vector3.new(0.3, 0.2, 0.1)
    tongsHandle.Material = Enum.Material.Metal
    tongsHandle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    tongsHandle.Anchored = true
    tongsHandle.CanCollide = false
    tongsHandle.Parent = tongs
    
    tongsHandle.Position = tongs.Position + Vector3.new(0, -0.6, 0)
    
    -- Ведро с водой
    local waterBucket = Instance.new("Part")
    waterBucket.Name = "WaterBucket"
    waterBucket.Size = Vector3.new(0.8, 1, 0.8)
    waterBucket.Material = Enum.Material.Metal
    waterBucket.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    waterBucket.Anchored = true
    waterBucket.CanCollide = true
    waterBucket.Parent = model
    
    waterBucket.Position = forge.Position + Vector3.new(-2.5, 0.5, 0)
    
    -- Вода в ведре
    local water = Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(0.7, 0.8, 0.7)
    water.Material = Enum.Material.Glass
    water.Color = Color3.fromRGB(0, 150, 255) -- Синий
    water.Transparency = 0.3
    water.Anchored = true
    water.CanCollide = false
    water.Parent = model
    
    water.Position = waterBucket.Position + Vector3.new(0, 0.1, 0)
    
    -- Инструменты на стене
    for i = 1, 6 do
        local tool = Instance.new("Part")
        tool.Name = "WallTool" .. i
        tool.Size = Vector3.new(0.2, 0.8, 0.2)
        tool.Material = Enum.Material.Metal
        tool.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        tool.Anchored = true
        tool.CanCollide = false
        tool.Parent = model
        
        -- Позиционирование инструментов
        local angle = (i - 1) * 60
        local radius = 4
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        tool.Position = forge.Position + Vector3.new(xPos, 2, zPos)
        tool.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Магические руны кузни
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "ForgeRune" .. i
        rune.Size = Vector3.new(0.4, 0.4, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 45
        local radius = 2.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = forge.Position + Vector3.new(xPos, 1.5, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 2
        runeLight.Brightness = 1
        runeLight.Parent = rune
    end
    
    -- Искры от огня
    for i = 1, 15 do
        local spark = Instance.new("Part")
        spark.Name = "Spark" .. i
        spark.Size = Vector3.new(0.1, 0.1, 0.1)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-1, 1)
        local yPos = math.random(0, 2)
        local zPos = math.random(-1, 1)
        spark.Position = fire.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 0)
        sparkLight.Range = 0.5
        sparkLight.Brightness = 1
        sparkLight.Parent = spark
    end
    
    -- UI для кузни
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.Parent = forge
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Кузня"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Нажмите E для ковки"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 0) -- Оранжевый
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("CraftingType", "forge")
    model:SetAttribute("CraftingLevel", 2)
    model:SetAttribute("MaxCraftingLevel", 5)
    model:SetAttribute("CraftingSpeed", 1.5)
    model:SetAttribute("CraftingQuality", 1.2)
    model:SetAttribute("CanCraft", true)
    model:SetAttribute("IsCraftingStation", true)
    model:SetAttribute("ForgeRunes", 8)
    model:SetAttribute("ForgeFire", true)
    model:SetAttribute("Anvil", true)
    model:SetAttribute("WaterBucket", true)
    model:SetAttribute("WallTools", 6)
    model:SetAttribute("CoalPieces", 12)
    model:SetAttribute("SmokeParticles", 8)
    model:SetAttribute("SparkParticles", 15)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateForge