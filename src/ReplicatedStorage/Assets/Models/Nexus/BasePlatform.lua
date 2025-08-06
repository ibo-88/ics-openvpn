-- BasePlatform.lua
-- Модель платформы базы

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBasePlatform()
    local model = Instance.new("Model")
    model.Name = "BasePlatform"
    
    -- Основная платформа
    local platform = Instance.new("Part")
    platform.Name = "MainPlatform"
    platform.Size = Vector3.new(20, 2, 20)
    platform.Material = Enum.Material.Metal
    platform.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    platform.Anchored = true
    platform.CanCollide = true
    platform.Parent = model
    
    -- Создание текстуры платформы
    local platformTexture = Instance.new("Texture")
    platformTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    platformTexture.StudsPerTileU = 10
    platformTexture.StudsPerTileV = 10
    platformTexture.Parent = platform
    
    -- Верхний слой платформы
    local topLayer = Instance.new("Part")
    topLayer.Name = "PlatformTop"
    topLayer.Size = Vector3.new(19, 0.5, 19)
    topLayer.Material = Enum.Material.Metal
    topLayer.Color = Color3.fromRGB(128, 128, 128) -- Серый
    topLayer.Anchored = true
    topLayer.CanCollide = false
    topLayer.Parent = model
    
    topLayer.Position = platform.Position + Vector3.new(0, 1.25, 0)
    
    -- Декоративные плиты на платформе
    for i = 1, 16 do
        for j = 1, 16 do
            local tile = Instance.new("Part")
            tile.Name = "PlatformTile_" .. i .. "_" .. j
            tile.Size = Vector3.new(1.1, 0.1, 1.1)
            tile.Material = Enum.Material.Metal
            tile.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
            tile.Anchored = true
            tile.CanCollide = false
            tile.Parent = model
            
            -- Позиционирование плит
            local xPos = -7.5 + (i - 1) * 1
            local zPos = -7.5 + (j - 1) * 1
            tile.Position = platform.Position + Vector3.new(xPos, 1.3, zPos)
        end
    end
    
    -- Опорные колонны платформы
    for i = 1, 8 do
        local column = Instance.new("Part")
        column.Name = "SupportColumn" .. i
        column.Size = Vector3.new(1, 8, 1)
        column.Material = Enum.Material.Metal
        column.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
        column.Anchored = true
        column.CanCollide = true
        column.Parent = model
        
        -- Позиционирование колонн
        local angle = (i - 1) * 45
        local radius = 8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        column.Position = platform.Position + Vector3.new(xPos, -3, zPos)
    end
    
    -- Укрепляющие балки
    for i = 1, 12 do
        local beam = Instance.new("Part")
        beam.Name = "SupportBeam" .. i
        beam.Size = Vector3.new(2, 0.5, 0.5)
        beam.Material = Enum.Material.Metal
        beam.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        beam.Anchored = true
        beam.CanCollide = true
        beam.Parent = model
        
        -- Позиционирование балок
        local angle = (i - 1) * 30
        local radius = 6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        beam.Position = platform.Position + Vector3.new(xPos, -1, zPos)
        beam.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Лестницы на платформу
    for i = 1, 4 do
        local stairs = Instance.new("Part")
        stairs.Name = "Stairs" .. i
        stairs.Size = Vector3.new(3, 0.3, 4)
        stairs.Material = Enum.Material.Metal
        stairs.Color = Color3.fromRGB(128, 128, 128) -- Серый
        stairs.Anchored = true
        stairs.CanCollide = true
        stairs.Parent = model
        
        -- Позиционирование лестниц
        local angle = (i - 1) * 90
        local radius = 10
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        stairs.Position = platform.Position + Vector3.new(xPos, 0.15, zPos)
        stairs.Orientation = Vector3.new(0, angle, 0)
        
        -- Ступени лестниц
        for j = 1, 6 do
            local step = Instance.new("Part")
            step.Name = "Step" .. i .. "_" .. j
            step.Size = Vector3.new(2.8, 0.2, 0.6)
            step.Material = Enum.Material.Metal
            step.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
            step.Anchored = true
            step.CanCollide = true
            step.Parent = model
            
            -- Позиционирование ступеней
            local stepAngle = angle
            local stepRadius = 10 + j * 0.3
            local stepXPos = math.cos(math.rad(stepAngle)) * stepRadius
            local stepZPos = math.sin(math.rad(stepAngle)) * stepRadius
            local stepYPos = j * 0.25
            step.Position = platform.Position + Vector3.new(stepXPos, stepYPos, stepZPos)
            step.Orientation = Vector3.new(0, stepAngle, 0)
        end
    end
    
    -- Защитные перила
    for i = 1, 32 do
        local railing = Instance.new("Part")
        railing.Name = "Railing" .. i
        railing.Size = Vector3.new(0.2, 1.5, 0.2)
        railing.Material = Enum.Material.Metal
        railing.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        railing.Anchored = true
        railing.CanCollide = true
        railing.Parent = model
        
        -- Позиционирование перил
        local angle = (i - 1) * 11.25
        local radius = 9.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        railing.Position = platform.Position + Vector3.new(xPos, 2.25, zPos)
    end
    
    -- Соединительные элементы перил
    for i = 1, 16 do
        local connector = Instance.new("Part")
        connector.Name = "RailingConnector" .. i
        connector.Size = Vector3.new(1.5, 0.2, 0.2)
        connector.Material = Enum.Material.Metal
        connector.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        connector.Anchored = true
        connector.CanCollide = false
        connector.Parent = model
        
        -- Позиционирование соединителей
        local angle = (i - 1) * 22.5
        local radius = 9.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        connector.Position = platform.Position + Vector3.new(xPos, 2.5, zPos)
        connector.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Осветительные столбы
    for i = 1, 8 do
        local lightPole = Instance.new("Part")
        lightPole.Name = "LightPole" .. i
        lightPole.Size = Vector3.new(0.5, 4, 0.5)
        lightPole.Material = Enum.Material.Metal
        lightPole.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        lightPole.Anchored = true
        lightPole.CanCollide = true
        lightPole.Parent = model
        
        -- Позиционирование столбов
        local angle = (i - 1) * 45
        local radius = 8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        lightPole.Position = platform.Position + Vector3.new(xPos, 4, zPos)
        
        -- Фонари на столбах
        local light = Instance.new("Part")
        light.Name = "Light" .. i
        light.Size = Vector3.new(1, 0.5, 1)
        light.Material = Enum.Material.Neon
        light.Color = Color3.fromRGB(255, 255, 255) -- Белый
        light.Anchored = true
        light.CanCollide = false
        light.Parent = model
        
        light.Position = lightPole.Position + Vector3.new(0, 2.25, 0)
        
        -- Свечение фонарей
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 255, 255)
        pointLight.Range = 8
        pointLight.Brightness = 2
        pointLight.Parent = light
    end
    
    -- Декоративные элементы
    for i = 1, 12 do
        local decoration = Instance.new("Part")
        decoration.Name = "PlatformDecoration" .. i
        decoration.Size = Vector3.new(1, 0.5, 1)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local angle = (i - 1) * 30
        local radius = 7
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = platform.Position + Vector3.new(xPos, 1.25, zPos)
    end
    
    -- Магические руны на платформе
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "PlatformRune" .. i
        rune.Size = Vector3.new(1, 1, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 45
        local radius = 5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = platform.Position + Vector3.new(xPos, 1.35, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 3
        runeLight.Brightness = 1.5
        runeLight.Parent = rune
    end
    
    -- Центральный символ платформы
    local centerSymbol = Instance.new("Part")
    centerSymbol.Name = "CenterSymbol"
    centerSymbol.Size = Vector3.new(3, 0.2, 3)
    centerSymbol.Material = Enum.Material.Neon
    centerSymbol.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    centerSymbol.Anchored = true
    centerSymbol.CanCollide = false
    centerSymbol.Parent = model
    
    centerSymbol.Position = platform.Position + Vector3.new(0, 1.35, 0)
    
    -- Свечение центрального символа
    local symbolLight = Instance.new("PointLight")
    symbolLight.Color = Color3.fromRGB(255, 0, 255)
    symbolLight.Range = 6
    symbolLight.Brightness = 2
    symbolLight.Parent = centerSymbol
    
    -- UI для платформы базы
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 400, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 6, 0)
    billboardGui.Parent = platform
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "БАЗОВАЯ ПЛАТФОРМА"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Главная база игроков"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("PlatformType", "base")
    model:SetAttribute("Health", 10000)
    model:SetAttribute("MaxHealth", 10000)
    model:SetAttribute("PlatformSize", "large")
    model:SetAttribute("IsBase", true)
    model:SetAttribute("SupportColumns", 8)
    model:SetAttribute("SupportBeams", 12)
    model:SetAttribute("Stairs", 4)
    model:SetAttribute("Railings", 32)
    model:SetAttribute("LightPoles", 8)
    model:SetAttribute("PlatformRunes", 8)
    model:SetAttribute("CenterSymbol", true)
    model:SetAttribute("PlatformTiles", 256)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateBasePlatform