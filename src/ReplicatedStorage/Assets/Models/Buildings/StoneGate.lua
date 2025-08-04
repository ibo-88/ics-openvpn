-- StoneGate.lua
-- Модель каменных ворот

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateStoneGate()
    local model = Instance.new("Model")
    model.Name = "StoneGate"
    
    -- Основание ворот
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(8, 2, 3)
    base.Material = Enum.Material.Rock
    base.Color = Color3.fromRGB(128, 128, 128) -- Серый камень
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры камня
    local stoneTexture = Instance.new("Texture")
    stoneTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    stoneTexture.StudsPerTileU = 4
    stoneTexture.StudsPerTileV = 1
    stoneTexture.Parent = base
    
    -- Левая башня
    local leftTower = Instance.new("Part")
    leftTower.Name = "LeftTower"
    leftTower.Size = Vector3.new(3, 8, 3)
    leftTower.Material = Enum.Material.Rock
    leftTower.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    leftTower.Anchored = true
    leftTower.CanCollide = true
    leftTower.Parent = model
    
    leftTower.Position = base.Position + Vector3.new(-2.5, 5, 0)
    
    -- Правая башня
    local rightTower = Instance.new("Part")
    rightTower.Name = "RightTower"
    rightTower.Size = Vector3.new(3, 8, 3)
    rightTower.Material = Enum.Material.Rock
    rightTower.Color = Color3.fromRGB(105, 105, 105)
    rightTower.Anchored = true
    rightTower.CanCollide = true
    rightTower.Parent = model
    
    rightTower.Position = base.Position + Vector3.new(2.5, 5, 0)
    
    -- Левая створка ворот
    local leftGate = Instance.new("Part")
    leftGate.Name = "LeftGate"
    leftGate.Size = Vector3.new(2, 7, 0.5)
    leftGate.Material = Enum.Material.Rock
    leftGate.Color = Color3.fromRGB(128, 128, 128)
    leftGate.Anchored = true
    leftGate.CanCollide = true
    leftGate.Parent = model
    
    leftGate.Position = base.Position + Vector3.new(-1, 5.5, 0)
    
    -- Правая створка ворот
    local rightGate = Instance.new("Part")
    rightGate.Name = "RightGate"
    rightGate.Size = Vector3.new(2, 7, 0.5)
    rightGate.Material = Enum.Material.Rock
    rightGate.Color = Color3.fromRGB(128, 128, 128)
    rightGate.Anchored = true
    rightGate.CanCollide = true
    rightGate.Parent = model
    
    rightGate.Position = base.Position + Vector3.new(1, 5.5, 0)
    
    -- Каменные блоки на створках
    for i = 1, 4 do
        for j = 1, 2 do
            -- Левая створка
            local leftBlock = Instance.new("Part")
            leftBlock.Name = "LeftBlock_" .. i .. "_" .. j
            leftBlock.Size = Vector3.new(1.8, 1.5, 0.3)
            leftBlock.Material = Enum.Material.Rock
            leftBlock.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
            leftBlock.Anchored = true
            leftBlock.CanCollide = false
            leftBlock.Parent = model
            
            local yPos = 1.5 + (i - 1) * 1.5
            local zPos = (j == 1) and 0.25 or -0.25
            leftBlock.Position = base.Position + Vector3.new(-1, yPos, zPos)
            
            -- Правая створка
            local rightBlock = Instance.new("Part")
            rightBlock.Name = "RightBlock_" .. i .. "_" .. j
            rightBlock.Size = Vector3.new(1.8, 1.5, 0.3)
            rightBlock.Material = Enum.Material.Rock
            rightBlock.Color = Color3.fromRGB(105, 105, 105)
            rightBlock.Anchored = true
            rightBlock.CanCollide = false
            rightBlock.Parent = model
            
            rightBlock.Position = base.Position + Vector3.new(1, yPos, zPos)
        end
    end
    
    -- Петли для створок
    for i = 1, 6 do
        local hinge = Instance.new("Part")
        hinge.Name = "Hinge" .. i
        hinge.Size = Vector3.new(0.3, 0.3, 0.6)
        hinge.Material = Enum.Material.Metal
        hinge.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        hinge.Anchored = true
        hinge.CanCollide = false
        hinge.Parent = model
        
        -- Позиционирование петель
        local tower = (i <= 3) and -2.5 or 2.5
        local gate = (i % 2 == 0) and -1 or 1
        local yPos = 1.5 + (i % 3) * 2
        hinge.Position = base.Position + Vector3.new((tower + gate) / 2, yPos, 0)
    end
    
    -- Замок ворот
    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.6, 0.8, 0.5)
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    lock.Anchored = true
    lock.CanCollide = false
    lock.Parent = model
    
    lock.Position = base.Position + Vector3.new(0, 5.5, 0.75)
    
    -- Ключевое отверстие
    local keyhole = Instance.new("Part")
    keyhole.Name = "Keyhole"
    keyhole.Size = Vector3.new(0.1, 0.3, 0.1)
    keyhole.Material = Enum.Material.Metal
    keyhole.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
    keyhole.Anchored = true
    keyhole.CanCollide = false
    keyhole.Parent = lock
    
    keyhole.Position = lock.Position + Vector3.new(0, 0, 0.3)
    
    -- Укрепляющие колонны башен
    for i = 1, 4 do
        local column = Instance.new("Part")
        column.Name = "Column" .. i
        column.Size = Vector3.new(1, 8, 1)
        column.Material = Enum.Material.Rock
        column.Color = Color3.fromRGB(105, 105, 105)
        column.Anchored = true
        column.CanCollide = true
        column.Parent = model
        
        -- Позиционирование колонн
        local tower = (i <= 2) and -2.5 or 2.5
        local side = (i % 2 == 0) and 1.5 or -1.5
        column.Position = base.Position + Vector3.new(tower + side, 5, 0)
    end
    
    -- Крыши башен
    for i = 1, 2 do
        local roof = Instance.new("Part")
        roof.Name = "Roof" .. i
        roof.Size = Vector3.new(3.5, 1, 3.5)
        roof.Material = Enum.Material.Rock
        roof.Color = Color3.fromRGB(101, 67, 33) -- Коричневый
        roof.Anchored = true
        roof.CanCollide = true
        roof.Parent = model
        
        -- Позиционирование крыш
        local xPos = (i == 1) and -2.5 or 2.5
        roof.Position = base.Position + Vector3.new(xPos, 9.5, 0)
    end
    
    -- Флаги на башнях
    for i = 1, 2 do
        local flagPole = Instance.new("Part")
        flagPole.Name = "FlagPole" .. i
        flagPole.Size = Vector3.new(0.2, 2, 0.2)
        flagPole.Material = Enum.Material.Metal
        flagPole.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        flagPole.Anchored = true
        flagPole.CanCollide = false
        flagPole.Parent = model
        
        -- Позиционирование флагштоков
        local xPos = (i == 1) and -2.5 or 2.5
        flagPole.Position = base.Position + Vector3.new(xPos, 10.5, 0)
        
        local flag = Instance.new("Part")
        flag.Name = "Flag" .. i
        flag.Size = Vector3.new(1.2, 0.7, 0.1)
        flag.Material = Enum.Material.Neon
        flag.Color = Color3.fromRGB(0, 0, 255) -- Синий флаг
        flag.Anchored = true
        flag.CanCollide = false
        flag.Parent = model
        
        flag.Position = base.Position + Vector3.new(xPos + 0.6, 10.15, 0)
    end
    
    -- Бойницы в башнях
    for i = 1, 8 do
        local arrowSlit = Instance.new("Part")
        arrowSlit.Name = "ArrowSlit" .. i
        arrowSlit.Size = Vector3.new(0.3, 1.2, 0.3)
        arrowSlit.Material = Enum.Material.Rock
        arrowSlit.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        arrowSlit.Anchored = true
        arrowSlit.CanCollide = false
        arrowSlit.Parent = model
        
        -- Позиционирование бойниц
        local tower = (i <= 4) and -2.5 or 2.5
        local side = (i % 2 == 0) and 1.5 or -1.5
        local yPos = 3 + (i % 4) * 1.5
        arrowSlit.Position = base.Position + Vector3.new(tower + side, yPos, 0)
    end
    
    -- Каменные зубцы на башнях
    for i = 1, 6 do
        for j = 1, 2 do
            local crenellation = Instance.new("Part")
            crenellation.Name = "Crenellation_" .. i .. "_" .. j
            crenellation.Size = Vector3.new(1, 1.5, 1)
            crenellation.Material = Enum.Material.Rock
            crenellation.Color = Color3.fromRGB(105, 105, 105)
            crenellation.Anchored = true
            crenellation.CanCollide = true
            crenellation.Parent = model
            
            -- Позиционирование зубцов
            local tower = (j == 1) and -2.5 or 2.5
            local angle = (i - 1) * 60
            local radius = 1.75
            local xPos = math.cos(math.rad(angle)) * radius
            local zPos = math.sin(math.rad(angle)) * radius
            crenellation.Position = base.Position + Vector3.new(tower + xPos, 9, zPos)
        end
    end
    
    -- Каменные ступени
    for i = 1, 3 do
        local step = Instance.new("Part")
        step.Name = "Step" .. i
        step.Size = Vector3.new(8, 0.3, 1)
        step.Material = Enum.Material.Rock
        step.Color = Color3.fromRGB(128, 128, 128)
        step.Anchored = true
        step.CanCollide = true
        step.Parent = model
        
        -- Позиционирование ступеней
        local yPos = 1 + (i - 1) * 0.3
        local zPos = 2 + (i - 1) * 0.5
        step.Position = base.Position + Vector3.new(0, yPos, zPos)
    end
    
    -- UI для каменных ворот
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 300, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 10, 0)
    billboardGui.Parent = leftTower
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Каменные ворота"
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
    model:SetAttribute("BuildType", "gate")
    model:SetAttribute("Material", "stone")
    model:SetAttribute("Health", 600)
    model:SetAttribute("MaxHealth", 600)
    model:SetAttribute("Cost", 150)
    model:SetAttribute("BuildTime", 15)
    model:SetAttribute("IsOpen", false)
    model:SetAttribute("CanBeOpened", true)
    model:SetAttribute("RequiresKey", false)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateStoneGate