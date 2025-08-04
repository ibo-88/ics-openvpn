-- GraniteRock.lua
-- Модель гранитной скалы

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGraniteRock()
    local model = Instance.new("Model")
    model.Name = "GraniteRock"
    
    -- Основание скалы
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(3, 1, 3)
    base.Material = Enum.Material.Rock
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый гранит
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры гранита
    local graniteTexture = Instance.new("Texture")
    graniteTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    graniteTexture.StudsPerTileU = 2
    graniteTexture.StudsPerTileV = 2
    graniteTexture.Parent = base
    
    -- Основная масса скалы
    local mainRock = Instance.new("Part")
    mainRock.Name = "MainRock"
    mainRock.Size = Vector3.new(2.5, 4, 2.5)
    mainRock.Material = Enum.Material.Rock
    mainRock.Color = Color3.fromRGB(128, 128, 128) -- Серый гранит
    mainRock.Anchored = true
    mainRock.CanCollide = true
    mainRock.Parent = model
    
    mainRock.Position = base.Position + Vector3.new(0, 2.5, 0)
    
    -- Гранитные блоки
    for i = 1, 6 do
        local block = Instance.new("Part")
        block.Name = "GraniteBlock" .. i
        block.Size = Vector3.new(1.2, 1.5, 1.2)
        block.Material = Enum.Material.Rock
        block.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        block.Anchored = true
        block.CanCollide = false
        block.Parent = model
        
        -- Позиционирование блоков
        local angle = (i - 1) * 60
        local radius = 1.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 1 + (i - 1) * 0.8
        block.Position = base.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Вершина скалы
    local peak = Instance.new("Part")
    peak.Name = "Peak"
    peak.Size = Vector3.new(1.5, 2, 1.5)
    peak.Material = Enum.Material.Rock
    peak.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    peak.Anchored = true
    peak.CanCollide = true
    peak.Parent = model
    
    peak.Position = base.Position + Vector3.new(0, 6.5, 0)
    
    -- Каменные осколки
    for i = 1, 8 do
        local shard = Instance.new("Part")
        shard.Name = "RockShard" .. i
        shard.Size = Vector3.new(0.3, 0.8, 0.3)
        shard.Material = Enum.Material.Rock
        shard.Color = Color3.fromRGB(128, 128, 128) -- Серый
        shard.Anchored = true
        shard.CanCollide = false
        shard.Parent = model
        
        -- Позиционирование осколков
        local angle = (i - 1) * 45
        local radius = 1.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 0.5 + (i % 3) * 0.5
        shard.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        shard.Orientation = Vector3.new(math.random(-30, 30), angle, math.random(-30, 30))
    end
    
    -- Трещины в скале
    for i = 1, 4 do
        local crack = Instance.new("Part")
        crack.Name = "Crack" .. i
        crack.Size = Vector3.new(0.1, 3, 0.1)
        crack.Material = Enum.Material.Rock
        crack.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        crack.Anchored = true
        crack.CanCollide = false
        crack.Parent = model
        
        -- Позиционирование трещин
        local angle = (i - 1) * 90
        local radius = 0.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crack.Position = base.Position + Vector3.new(xPos, 2.5, zPos)
        crack.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Минеральные жилы
    for i = 1, 3 do
        local vein = Instance.new("Part")
        vein.Name = "MineralVein" .. i
        vein.Size = Vector3.new(0.2, 2, 0.2)
        vein.Material = Enum.Material.Metal
        vein.Color = Color3.fromRGB(255, 215, 0) -- Золотистый
        vein.Anchored = true
        vein.CanCollide = false
        vein.Parent = model
        
        -- Позиционирование жил
        local angle = (i - 1) * 120
        local radius = 0.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        vein.Position = base.Position + Vector3.new(xPos, 2.5, zPos)
        vein.Orientation = Vector3.new(0, angle, 0)
        
        -- Свечение жил
        local veinLight = Instance.new("PointLight")
        veinLight.Color = Color3.fromRGB(255, 215, 0)
        veinLight.Range = 1
        veinLight.Brightness = 0.5
        veinLight.Parent = vein
    end
    
    -- Мхи и лишайники
    for i = 1, 5 do
        local moss = Instance.new("Part")
        moss.Name = "Moss" .. i
        moss.Size = Vector3.new(0.8, 0.2, 0.8)
        moss.Material = Enum.Material.Grass
        moss.Color = Color3.fromRGB(34, 139, 34) -- Темно-зеленый
        moss.Anchored = true
        moss.CanCollide = false
        moss.Parent = model
        
        -- Позиционирование мхов
        local angle = (i - 1) * 72
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 0.5 + (i % 2) * 1.5
        moss.Position = base.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Корни деревьев (если есть)
    for i = 1, 3 do
        local root = Instance.new("Part")
        root.Name = "TreeRoot" .. i
        root.Size = Vector3.new(0.4, 1, 0.4)
        root.Material = Enum.Material.Wood
        root.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        root.Anchored = true
        root.CanCollide = false
        root.Parent = model
        
        -- Позиционирование корней
        local angle = (i - 1) * 120
        local radius = 2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        root.Position = base.Position + Vector3.new(xPos, -0.5, zPos)
        root.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- UI для гранитной скалы
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 8, 0)
    billboardGui.Parent = peak
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Гранитная скала"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local resourceBar = Instance.new("Frame")
    resourceBar.Size = UDim2.new(0.8, 0, 0.3, 0)
    resourceBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    resourceBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    resourceBar.BorderSizePixel = 0
    resourceBar.Parent = billboardGui
    
    local resourceFill = Instance.new("Frame")
    resourceFill.Size = UDim2.new(1, 0, 1, 0)
    resourceFill.Position = UDim2.new(0, 0, 0, 0)
    resourceFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    resourceFill.BorderSizePixel = 0
    resourceFill.Parent = resourceBar
    
    -- Установка атрибутов
    model:SetAttribute("ResourceType", "stone")
    model:SetAttribute("ResourceAmount", 200)
    model:SetAttribute("MaxResourceAmount", 200)
    model:SetAttribute("RespawnTime", 45)
    model:SetAttribute("ResourceQuality", "uncommon")
    model:SetAttribute("LootTable", "resource_loot.granite_rock")
    model:SetAttribute("MiningDifficulty", 2)
    model:SetAttribute("MineralVeins", 3)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("ResourceBar", resourceBar)
    model:SetAttribute("ResourceFill", resourceFill)
    
    return model
end

return CreateGraniteRock