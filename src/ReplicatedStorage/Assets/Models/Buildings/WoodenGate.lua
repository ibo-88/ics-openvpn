-- WoodenGate.lua
-- Модель деревянных ворот

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateWoodenGate()
    local model = Instance.new("Model")
    model.Name = "WoodenGate"
    
    -- Основание ворот
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(6, 1, 2)
    base.Material = Enum.Material.Wood
    base.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет дерева
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 3
    woodTexture.StudsPerTileV = 1
    woodTexture.Parent = base
    
    -- Левая башня
    local leftTower = Instance.new("Part")
    leftTower.Name = "LeftTower"
    leftTower.Size = Vector3.new(2, 6, 2)
    leftTower.Material = Enum.Material.Wood
    leftTower.Color = Color3.fromRGB(160, 82, 45) -- Более светлый коричневый
    leftTower.Anchored = true
    leftTower.CanCollide = true
    leftTower.Parent = model
    
    leftTower.Position = base.Position + Vector3.new(-2, 3.5, 0)
    
    -- Правая башня
    local rightTower = Instance.new("Part")
    rightTower.Name = "RightTower"
    rightTower.Size = Vector3.new(2, 6, 2)
    rightTower.Material = Enum.Material.Wood
    rightTower.Color = Color3.fromRGB(160, 82, 45)
    rightTower.Anchored = true
    rightTower.CanCollide = true
    rightTower.Parent = model
    
    rightTower.Position = base.Position + Vector3.new(2, 3.5, 0)
    
    -- Левая створка ворот
    local leftGate = Instance.new("Part")
    leftGate.Name = "LeftGate"
    leftGate.Size = Vector3.new(1.5, 5, 0.3)
    leftGate.Material = Enum.Material.Wood
    leftGate.Color = Color3.fromRGB(139, 69, 19)
    leftGate.Anchored = true
    leftGate.CanCollide = true
    leftGate.Parent = model
    
    leftGate.Position = base.Position + Vector3.new(-0.75, 3.5, 0)
    
    -- Правая створка ворот
    local rightGate = Instance.new("Part")
    rightGate.Name = "RightGate"
    rightGate.Size = Vector3.new(1.5, 5, 0.3)
    rightGate.Material = Enum.Material.Wood
    rightGate.Color = Color3.fromRGB(139, 69, 19)
    rightGate.Anchored = true
    rightGate.CanCollide = true
    rightGate.Parent = model
    
    rightGate.Position = base.Position + Vector3.new(0.75, 3.5, 0)
    
    -- Деревянные планки на створках
    for i = 1, 3 do
        -- Левая створка
        local leftPlank = Instance.new("Part")
        leftPlank.Name = "LeftPlank" .. i
        leftPlank.Size = Vector3.new(1.4, 0.2, 0.1)
        leftPlank.Material = Enum.Material.Wood
        leftPlank.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        leftPlank.Anchored = true
        leftPlank.CanCollide = false
        leftPlank.Parent = model
        
        local yPos = 1.5 + (i - 1) * 1.5
        leftPlank.Position = base.Position + Vector3.new(-0.75, yPos, 0.2)
        
        -- Правая створка
        local rightPlank = Instance.new("Part")
        rightPlank.Name = "RightPlank" .. i
        rightPlank.Size = Vector3.new(1.4, 0.2, 0.1)
        rightPlank.Material = Enum.Material.Wood
        rightPlank.Color = Color3.fromRGB(101, 67, 33)
        rightPlank.Anchored = true
        rightPlank.CanCollide = false
        rightPlank.Parent = model
        
        rightPlank.Position = base.Position + Vector3.new(0.75, yPos, 0.2)
    end
    
    -- Петли для створок
    for i = 1, 4 do
        local hinge = Instance.new("Part")
        hinge.Name = "Hinge" .. i
        hinge.Size = Vector3.new(0.2, 0.2, 0.4)
        hinge.Material = Enum.Material.Metal
        hinge.Color = Color3.fromRGB(105, 105, 105) -- Серый металл
        hinge.Anchored = true
        hinge.CanCollide = false
        hinge.Parent = model
        
        -- Позиционирование петель
        local tower = (i <= 2) and -2 or 2
        local gate = (i % 2 == 0) and -0.75 or 0.75
        local yPos = (i <= 2) and 1.5 or 5.5
        hinge.Position = base.Position + Vector3.new((tower + gate) / 2, yPos, 0)
    end
    
    -- Замок ворот
    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.4, 0.6, 0.3)
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    lock.Anchored = true
    lock.CanCollide = false
    lock.Parent = model
    
    lock.Position = base.Position + Vector3.new(0, 3.5, 0.2)
    
    -- Ключевое отверстие
    local keyhole = Instance.new("Part")
    keyhole.Name = "Keyhole"
    keyhole.Size = Vector3.new(0.1, 0.2, 0.1)
    keyhole.Material = Enum.Material.Metal
    keyhole.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
    keyhole.Anchored = true
    keyhole.CanCollide = false
    keyhole.Parent = lock
    
    keyhole.Position = lock.Position + Vector3.new(0, 0, 0.2)
    
    -- Балки поддержки башен
    for i = 1, 2 do
        local beam = Instance.new("Part")
        beam.Name = "SupportBeam" .. i
        beam.Size = Vector3.new(0.3, 6, 0.3)
        beam.Material = Enum.Material.Wood
        beam.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        beam.Anchored = true
        beam.CanCollide = true
        beam.Parent = model
        
        -- Позиционирование балок
        local xPos = (i == 1) and -2 or 2
        beam.Position = base.Position + Vector3.new(xPos, 3.5, 1.15)
    end
    
    -- Крыши башен
    for i = 1, 2 do
        local roof = Instance.new("Part")
        roof.Name = "Roof" .. i
        roof.Size = Vector3.new(2.5, 0.5, 2.5)
        roof.Material = Enum.Material.Wood
        roof.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        roof.Anchored = true
        roof.CanCollide = true
        roof.Parent = model
        
        -- Позиционирование крыш
        local xPos = (i == 1) and -2 or 2
        roof.Position = base.Position + Vector3.new(xPos, 6.75, 0)
    end
    
    -- Флаги на башнях
    for i = 1, 2 do
        local flagPole = Instance.new("Part")
        flagPole.Name = "FlagPole" .. i
        flagPole.Size = Vector3.new(0.1, 1.5, 0.1)
        flagPole.Material = Enum.Material.Wood
        flagPole.Color = Color3.fromRGB(139, 69, 19)
        flagPole.Anchored = true
        flagPole.CanCollide = false
        flagPole.Parent = model
        
        -- Позиционирование флагштоков
        local xPos = (i == 1) and -2 or 2
        flagPole.Position = base.Position + Vector3.new(xPos, 7.5, 0)
        
        local flag = Instance.new("Part")
        flag.Name = "Flag" .. i
        flag.Size = Vector3.new(0.8, 0.5, 0.1)
        flag.Material = Enum.Material.Neon
        flag.Color = Color3.fromRGB(255, 255, 0) -- Желтый флаг
        flag.Anchored = true
        flag.CanCollide = false
        flag.Parent = model
        
        flag.Position = base.Position + Vector3.new(xPos + 0.4, 7.25, 0)
    end
    
    -- Бойницы в башнях
    for i = 1, 4 do
        local arrowSlit = Instance.new("Part")
        arrowSlit.Name = "ArrowSlit" .. i
        arrowSlit.Size = Vector3.new(0.2, 0.8, 0.2)
        arrowSlit.Material = Enum.Material.Wood
        arrowSlit.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        arrowSlit.Anchored = true
        arrowSlit.CanCollide = false
        arrowSlit.Parent = model
        
        -- Позиционирование бойниц
        local tower = (i <= 2) and -2 or 2
        local side = (i % 2 == 0) and 1 or -1
        local yPos = (i <= 2) and 4 or 5
        arrowSlit.Position = base.Position + Vector3.new(tower, yPos, side * 1.1)
    end
    
    -- UI для ворот
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 8, 0)
    billboardGui.Parent = leftTower
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Деревянные ворота"
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
    model:SetAttribute("Material", "wood")
    model:SetAttribute("Health", 300)
    model:SetAttribute("MaxHealth", 300)
    model:SetAttribute("Cost", 75)
    model:SetAttribute("BuildTime", 10)
    model:SetAttribute("IsOpen", false)
    model:SetAttribute("CanBeOpened", true)
    model:SetAttribute("RequiresKey", false)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateWoodenGate