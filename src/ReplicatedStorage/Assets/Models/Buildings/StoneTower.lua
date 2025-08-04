-- StoneTower.lua
-- Модель каменной башни

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateStoneTower()
    local model = Instance.new("Model")
    model.Name = "StoneTower"
    
    -- Основание башни
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(5, 1.5, 5)
    base.Material = Enum.Material.Rock
    base.Color = Color3.fromRGB(128, 128, 128) -- Серый камень
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры камня
    local stoneTexture = Instance.new("Texture")
    stoneTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    stoneTexture.StudsPerTileU = 2
    stoneTexture.StudsPerTileV = 1
    stoneTexture.Parent = base
    
    -- Основная башня
    local tower = Instance.new("Part")
    tower.Name = "Tower"
    tower.Size = Vector3.new(4, 10, 4)
    tower.Material = Enum.Material.Rock
    tower.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    tower.Anchored = true
    tower.CanCollide = true
    tower.Parent = model
    
    tower.Position = base.Position + Vector3.new(0, 5.75, 0)
    
    -- Каменные блоки башни
    for i = 1, 5 do
        for j = 1, 4 do
            local block = Instance.new("Part")
            block.Name = "StoneBlock_" .. i .. "_" .. j
            block.Size = Vector3.new(1.5, 1.8, 1.5)
            block.Material = Enum.Material.Rock
            block.Color = Color3.fromRGB(105, 105, 105)
            block.Anchored = true
            block.CanCollide = false
            block.Parent = model
            
            -- Позиционирование блоков
            local angle = (j - 1) * 90
            local radius = 1.4
            local xPos = math.cos(math.rad(angle)) * radius
            local zPos = math.sin(math.rad(angle)) * radius
            local yPos = 1.5 + (i - 1) * 1.9
            block.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        end
    end
    
    -- Раствор между блоками
    local mortar = Instance.new("Part")
    mortar.Name = "Mortar"
    mortar.Size = Vector3.new(4.2, 10.2, 4.2)
    mortar.Position = tower.Position
    mortar.Material = Enum.Material.Concrete
    mortar.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    mortar.Anchored = true
    mortar.CanCollide = false
    mortar.Parent = model
    
    -- Платформа для лучников
    local platform = Instance.new("Part")
    platform.Name = "Platform"
    platform.Size = Vector3.new(4.5, 0.8, 4.5)
    platform.Material = Enum.Material.Rock
    platform.Color = Color3.fromRGB(128, 128, 128)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Parent = model
    
    platform.Position = base.Position + Vector3.new(0, 11.25, 0)
    
    -- Зубцы на платформе
    for i = 1, 8 do
        local crenellation = Instance.new("Part")
        crenellation.Name = "Crenellation" .. i
        crenellation.Size = Vector3.new(0.8, 1.5, 0.8)
        crenellation.Material = Enum.Material.Rock
        crenellation.Color = Color3.fromRGB(105, 105, 105)
        crenellation.Anchored = true
        crenellation.CanCollide = true
        crenellation.Parent = model
        
        -- Позиционирование зубцов
        local angle = (i - 1) * 45
        local radius = 2.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crenellation.Position = base.Position + Vector3.new(xPos, 12, zPos)
    end
    
    -- Бойницы для стрельбы
    for i = 1, 4 do
        local arrowSlit = Instance.new("Part")
        arrowSlit.Name = "ArrowSlit" .. i
        arrowSlit.Size = Vector3.new(0.3, 1, 0.3)
        arrowSlit.Material = Enum.Material.Rock
        arrowSlit.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        arrowSlit.Anchored = true
        arrowSlit.CanCollide = false
        arrowSlit.Parent = model
        
        -- Позиционирование бойниц
        local angle = (i - 1) * 90
        local radius = 2.1
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        arrowSlit.Position = base.Position + Vector3.new(xPos, 7, zPos)
    end
    
    -- Винтовая лестница внутри башни
    for i = 1, 8 do
        local step = Instance.new("Part")
        step.Name = "Step" .. i
        step.Size = Vector3.new(1, 0.3, 2.5)
        step.Material = Enum.Material.Rock
        step.Color = Color3.fromRGB(128, 128, 128)
        step.Anchored = true
        step.CanCollide = true
        step.Parent = model
        
        -- Позиционирование ступеней
        local angle = i * 45
        local radius = 1.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 1.5 + (i - 1) * 1.2
        step.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        step.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Крыша башни
    local roof = Instance.new("Part")
    roof.Name = "Roof"
    roof.Size = Vector3.new(5, 0.8, 5)
    roof.Material = Enum.Material.Rock
    roof.Color = Color3.fromRGB(101, 67, 33) -- Коричневый
    roof.Anchored = true
    roof.CanCollide = true
    roof.Parent = model
    
    roof.Position = base.Position + Vector3.new(0, 13.25, 0)
    
    -- Флагшток на башне
    local flagPole = Instance.new("Part")
    flagPole.Name = "FlagPole"
    flagPole.Size = Vector3.new(0.2, 3, 0.2)
    flagPole.Material = Enum.Material.Metal
    flagPole.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    flagPole.Anchored = true
    flagPole.CanCollide = false
    flagPole.Parent = model
    
    flagPole.Position = base.Position + Vector3.new(0, 15, 0)
    
    local flag = Instance.new("Part")
    flag.Name = "Flag"
    flag.Size = Vector3.new(1.5, 0.8, 0.1)
    flag.Material = Enum.Material.Neon
    flag.Color = Color3.fromRGB(0, 0, 255) -- Синий флаг
    flag.Anchored = true
    flag.CanCollide = false
    flag.Parent = model
    
    flag.Position = base.Position + Vector3.new(0.8, 14.6, 0)
    
    -- Укрепляющие колонны
    for i = 1, 4 do
        local column = Instance.new("Part")
        column.Name = "Column" .. i
        column.Size = Vector3.new(0.8, 10, 0.8)
        column.Material = Enum.Material.Rock
        column.Color = Color3.fromRGB(105, 105, 105)
        column.Anchored = true
        column.CanCollide = true
        column.Parent = model
        
        -- Позиционирование колонн
        local angle = (i - 1) * 90
        local radius = 2.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        column.Position = base.Position + Vector3.new(xPos, 5.75, zPos)
    end
    
    -- UI для башни
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 15, 0)
    billboardGui.Parent = roof
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Каменная башня"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(0.8, 0, 0.3, 0)
    healthBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    healthBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = billboardGui
    
    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.Position = UDim2.new(0, 0, 0, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("BuildType", "tower")
    model:SetAttribute("Material", "stone")
    model:SetAttribute("Health", 400)
    model:SetAttribute("MaxHealth", 400)
    model:SetAttribute("Cost", 100)
    model:SetAttribute("BuildTime", 12)
    model:SetAttribute("AttackRange", 20)
    model:SetAttribute("AttackDamage", 35)
    model:SetAttribute("AttackSpeed", 1.5)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateStoneTower