-- BlacksmithForge.lua
-- Модель кузнечной печи

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBlacksmithForge()
    local model = Instance.new("Model")
    model.Name = "BlacksmithForge"
    
    -- Основная печь
    local forge = Instance.new("Part")
    forge.Name = "MainForge"
    forge.Size = Vector3.new(4, 3, 4)
    forge.Material = Enum.Material.Metal
    forge.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
    forge.Anchored = true
    forge.CanCollide = true
    forge.Parent = model
    
    -- Топка печи
    local firebox = Instance.new("Part")
    firebox.Name = "Firebox"
    firebox.Size = Vector3.new(2, 1.5, 2)
    firebox.Material = Enum.Material.Metal
    firebox.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    firebox.Anchored = true
    firebox.CanCollide = false
    firebox.Parent = model
    
    firebox.Position = forge.Position + Vector3.new(0, 0.75, 0)
    
    -- Огонь в печи
    local fire = Instance.new("Fire")
    fire.Heat = 15
    fire.Size = 8
    fire.Color = Color3.fromRGB(255, 100, 0) -- Оранжевый
    fire.SecondaryColor = Color3.fromRGB(255, 0, 0) -- Красный
    fire.Parent = firebox
    
    -- Свечение огня
    local fireLight = Instance.new("PointLight")
    fireLight.Color = Color3.fromRGB(255, 100, 0)
    fireLight.Range = 8
    fireLight.Brightness = 3
    fireLight.Parent = firebox
    
    -- Дымоход печи
    local chimney = Instance.new("Part")
    chimney.Name = "Chimney"
    chimney.Size = Vector3.new(1.5, 4, 1.5)
    chimney.Material = Enum.Material.Metal
    chimney.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    chimney.Anchored = true
    chimney.CanCollide = true
    chimney.Parent = model
    
    chimney.Position = forge.Position + Vector3.new(0, 3.5, 0)
    
    -- Дым из дымохода
    local smoke = Instance.new("Smoke")
    smoke.Color = Color3.fromRGB(128, 128, 128) -- Серый
    smoke.Size = 2
    smoke.RiseVelocity = 5
    smoke.Parent = chimney
    
    -- Наковальня
    local anvil = Instance.new("Part")
    anvil.Name = "Anvil"
    anvil.Size = Vector3.new(2, 1, 1.5)
    anvil.Material = Enum.Material.Metal
    anvil.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    anvil.Anchored = true
    anvil.CanCollide = true
    anvil.Parent = model
    
    anvil.Position = forge.Position + Vector3.new(3, 0.5, 0)
    
    -- Подставка наковальни
    local anvilStand = Instance.new("Part")
    anvilStand.Name = "AnvilStand"
    anvilStand.Size = Vector3.new(1.5, 1, 1.5)
    anvilStand.Material = Enum.Material.Wood
    anvilStand.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    anvilStand.Anchored = true
    anvilStand.CanCollide = true
    anvilStand.Parent = model
    
    anvilStand.Position = anvil.Position + Vector3.new(0, -0.75, 0)
    
    -- Кузнечные инструменты
    for i = 1, 6 do
        local tool = Instance.new("Part")
        tool.Name = "BlacksmithTool" .. i
        tool.Size = Vector3.new(0.2, 0.8, 0.2)
        tool.Material = Enum.Material.Metal
        tool.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        tool.Anchored = true
        tool.CanCollide = false
        tool.Parent = model
        
        -- Позиционирование инструментов
        local angle = (i - 1) * 60
        local radius = 2.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        tool.Position = forge.Position + Vector3.new(xPos, 1.5, zPos)
        tool.Orientation = Vector3.new(0, angle, 0)
        
        -- Рукоять инструмента
        local handle = Instance.new("Part")
        handle.Name = "ToolHandle" .. i
        handle.Size = Vector3.new(0.3, 0.3, 0.3)
        handle.Material = Enum.Material.Wood
        handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        handle.Anchored = true
        handle.CanCollide = false
        handle.Parent = model
        
        handle.Position = tool.Position + Vector3.new(0, -0.55, 0)
    end
    
    -- Кузнечные щипцы
    local tongs = Instance.new("Part")
    tongs.Name = "Tongs"
    tongs.Size = Vector3.new(0.1, 1.2, 0.1)
    tongs.Material = Enum.Material.Metal
    tongs.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    tongs.Anchored = true
    tongs.CanCollide = false
    tongs.Parent = model
    
    tongs.Position = forge.Position + Vector3.new(2, 1.5, 2)
    
    -- Молот
    local hammer = Instance.new("Part")
    hammer.Name = "Hammer"
    hammer.Size = Vector3.new(0.3, 1.5, 0.3)
    hammer.Material = Enum.Material.Metal
    hammer.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    hammer.Anchored = true
    hammer.CanCollide = false
    hammer.Parent = model
    
    hammer.Position = forge.Position + Vector3.new(-2, 1.5, 2)
    
    -- Рукоять молота
    local hammerHandle = Instance.new("Part")
    hammerHandle.Name = "HammerHandle"
    hammerHandle.Size = Vector3.new(0.4, 0.8, 0.4)
    hammerHandle.Material = Enum.Material.Wood
    hammerHandle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    hammerHandle.Anchored = true
    hammerHandle.CanCollide = false
    hammerHandle.Parent = model
    
    hammerHandle.Position = hammer.Position + Vector3.new(0, -1.15, 0)
    
    -- Уголь для печи
    for i = 1, 8 do
        local coal = Instance.new("Part")
        coal.Name = "Coal" .. i
        coal.Size = Vector3.new(0.3, 0.3, 0.3)
        coal.Material = Enum.Material.Rock
        coal.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
        coal.Anchored = true
        coal.CanCollide = false
        coal.Parent = model
        
        -- Позиционирование угля
        local xPos = math.random(-1, 1)
        local zPos = math.random(-1, 1)
        coal.Position = firebox.Position + Vector3.new(xPos, 0.9, zPos)
    end
    
    -- Железные слитки
    for i = 1, 5 do
        local ingot = Instance.new("Part")
        ingot.Name = "IronIngot" .. i
        ingot.Size = Vector3.new(0.8, 0.2, 0.3)
        ingot.Material = Enum.Material.Metal
        ingot.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        ingot.Anchored = true
        ingot.CanCollide = false
        ingot.Parent = model
        
        -- Позиционирование слитков
        local xPos = (i - 3) * 0.5
        ingot.Position = forge.Position + Vector3.new(xPos, 1.5, -2)
    end
    
    -- Водяной бак для закалки
    local waterTank = Instance.new("Part")
    waterTank.Name = "WaterTank"
    waterTank.Size = Vector3.new(1.5, 2, 1.5)
    waterTank.Material = Enum.Material.Metal
    waterTank.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    waterTank.Anchored = true
    waterTank.CanCollide = true
    waterTank.Parent = model
    
    waterTank.Position = forge.Position + Vector3.new(-3, 1, 0)
    
    -- Вода в баке
    local water = Instance.new("Part")
    water.Name = "Water"
    water.Size = Vector3.new(1.4, 1.8, 1.4)
    water.Material = Enum.Material.Water
    water.Color = Color3.fromRGB(0, 150, 255) -- Синий
    water.Transparency = 0.3
    water.Anchored = true
    water.CanCollide = false
    water.Parent = model
    
    water.Position = waterTank.Position + Vector3.new(0, 0.1, 0)
    
    -- Меха для печи
    local bellows = Instance.new("Part")
    bellows.Name = "Bellows"
    bellows.Size = Vector3.new(1.5, 1, 2)
    bellows.Material = Enum.Material.Fabric
    bellows.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    bellows.Anchored = true
    bellows.CanCollide = true
    bellows.Parent = model
    
    bellows.Position = forge.Position + Vector3.new(0, 0.5, 3)
    
    -- Ручка мехов
    local bellowsHandle = Instance.new("Part")
    bellowsHandle.Name = "BellowsHandle"
    bellowsHandle.Size = Vector3.new(0.2, 0.8, 0.2)
    bellowsHandle.Material = Enum.Material.Wood
    bellowsHandle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    bellowsHandle.Anchored = true
    bellowsHandle.CanCollide = false
    bellowsHandle.Parent = model
    
    bellowsHandle.Position = bellows.Position + Vector3.new(0, 0.9, 0)
    
    -- Искры от огня
    for i = 1, 15 do
        local spark = Instance.new("Part")
        spark.Name = "Spark" .. i
        spark.Size = Vector3.new(0.05, 0.05, 0.05)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-1, 1)
        local yPos = math.random(0, 2)
        local zPos = math.random(-1, 1)
        spark.Position = firebox.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 0)
        sparkLight.Range = 0.5
        sparkLight.Brightness = 1
        sparkLight.Parent = spark
    end
    
    -- Тепловые волны
    for i = 1, 10 do
        local heatWave = Instance.new("Part")
        heatWave.Name = "HeatWave" .. i
        heatWave.Size = Vector3.new(0.1, 0.1, 0.1)
        heatWave.Material = Enum.Material.Neon
        heatWave.Color = Color3.fromRGB(255, 100, 0) -- Оранжевый
        heatWave.Transparency = 0.7
        heatWave.Anchored = true
        heatWave.CanCollide = false
        heatWave.Parent = model
        
        -- Позиционирование тепловых волн
        local angle = (i - 1) * 36
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        heatWave.Position = firebox.Position + Vector3.new(xPos, 1.5, zPos)
        
        -- Свечение тепловых волн
        local heatLight = Instance.new("PointLight")
        heatLight.Color = Color3.fromRGB(255, 100, 0)
        heatLight.Range = 1
        heatLight.Brightness = 0.8
        heatLight.Parent = heatWave
    end
    
    -- UI для кузнечной печи
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 300, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.Parent = forge
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Кузнечная печь"
    nameLabel.TextColor3 = Color3.fromRGB(255, 100, 0) -- Оранжевый текст
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Нажмите E для ковки"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Желтый
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("CraftingType", "blacksmithing")
    model:SetAttribute("CraftingLevel", 2)
    model:SetAttribute("MaxCraftingLevel", 5)
    model:SetAttribute("CraftingSpeed", 1.5)
    model:SetAttribute("CraftingQuality", 1.2)
    model:SetAttribute("CanCraft", true)
    model:SetAttribute("IsCraftingStation", true)
    model:SetAttribute("ForgeActive", true)
    model:SetAttribute("FireHeat", 15)
    model:SetAttribute("AnvilPresent", true)
    model:SetAttribute("BlacksmithTools", 6)
    model:SetAttribute("IronIngots", 5)
    model:SetAttribute("CoalPieces", 8)
    model:SetAttribute("WaterTank", true)
    model:SetAttribute("Bellows", true)
    model:SetAttribute("Sparks", 15)
    model:SetAttribute("HeatWaves", 10)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateBlacksmithForge