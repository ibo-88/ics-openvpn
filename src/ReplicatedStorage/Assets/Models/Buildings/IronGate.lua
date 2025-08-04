-- IronGate.lua
-- Модель железных ворот

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIronGate()
    local model = Instance.new("Model")
    model.Name = "IronGate"
    
    -- Основание ворот
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(10, 3, 4)
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 5
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = base
    
    -- Левая башня
    local leftTower = Instance.new("Part")
    leftTower.Name = "LeftTower"
    leftTower.Size = Vector3.new(4, 10, 4)
    leftTower.Material = Enum.Material.Metal
    leftTower.Color = Color3.fromRGB(128, 128, 128) -- Серый металл
    leftTower.Anchored = true
    leftTower.CanCollide = true
    leftTower.Parent = model
    
    leftTower.Position = base.Position + Vector3.new(-3, 6.5, 0)
    
    -- Правая башня
    local rightTower = Instance.new("Part")
    rightTower.Name = "RightTower"
    rightTower.Size = Vector3.new(4, 10, 4)
    rightTower.Material = Enum.Material.Metal
    rightTower.Color = Color3.fromRGB(128, 128, 128)
    rightTower.Anchored = true
    rightTower.CanCollide = true
    rightTower.Parent = model
    
    rightTower.Position = base.Position + Vector3.new(3, 6.5, 0)
    
    -- Левая створка ворот
    local leftGate = Instance.new("Part")
    leftGate.Name = "LeftGate"
    leftGate.Size = Vector3.new(2.5, 8, 0.8)
    leftGate.Material = Enum.Material.Metal
    leftGate.Color = Color3.fromRGB(105, 105, 105)
    leftGate.Anchored = true
    leftGate.CanCollide = true
    leftGate.Parent = model
    
    leftGate.Position = base.Position + Vector3.new(-1.25, 7, 0)
    
    -- Правая створка ворот
    local rightGate = Instance.new("Part")
    rightGate.Name = "RightGate"
    rightGate.Size = Vector3.new(2.5, 8, 0.8)
    rightGate.Material = Enum.Material.Metal
    rightGate.Color = Color3.fromRGB(105, 105, 105)
    rightGate.Anchored = true
    rightGate.CanCollide = true
    rightGate.Parent = model
    
    rightGate.Position = base.Position + Vector3.new(1.25, 7, 0)
    
    -- Железные пластины на створках
    for i = 1, 6 do
        for j = 1, 2 do
            -- Левая створка
            local leftPlate = Instance.new("Part")
            leftPlate.Name = "LeftPlate_" .. i .. "_" .. j
            leftPlate.Size = Vector3.new(2.3, 1.2, 0.2)
            leftPlate.Material = Enum.Material.Metal
            leftPlate.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
            leftPlate.Anchored = true
            leftPlate.CanCollide = false
            leftPlate.Parent = model
            
            local yPos = 1.5 + (i - 1) * 1.2
            local zPos = (j == 1) and 0.4 or -0.4
            leftPlate.Position = base.Position + Vector3.new(-1.25, yPos, zPos)
            
            -- Правая створка
            local rightPlate = Instance.new("Part")
            rightPlate.Name = "RightPlate_" .. i .. "_" .. j
            rightPlate.Size = Vector3.new(2.3, 1.2, 0.2)
            rightPlate.Material = Enum.Material.Metal
            rightPlate.Color = Color3.fromRGB(64, 64, 64)
            rightPlate.Anchored = true
            rightPlate.CanCollide = false
            rightPlate.Parent = model
            
            rightPlate.Position = base.Position + Vector3.new(1.25, yPos, zPos)
        end
    end
    
    -- Петли для створок
    for i = 1, 8 do
        local hinge = Instance.new("Part")
        hinge.Name = "Hinge" .. i
        hinge.Size = Vector3.new(0.4, 0.4, 0.8)
        hinge.Material = Enum.Material.Metal
        hinge.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        hinge.Anchored = true
        hinge.CanCollide = false
        hinge.Parent = model
        
        -- Позиционирование петель
        local tower = (i <= 4) and -3 or 3
        local gate = (i % 2 == 0) and -1.25 or 1.25
        local yPos = 1.5 + (i % 4) * 2
        hinge.Position = base.Position + Vector3.new((tower + gate) / 2, yPos, 0)
    end
    
    -- Замок ворот
    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.8, 1, 0.6)
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    lock.Anchored = true
    lock.CanCollide = false
    lock.Parent = model
    
    lock.Position = base.Position + Vector3.new(0, 7, 1.2)
    
    -- Ключевое отверстие
    local keyhole = Instance.new("Part")
    keyhole.Name = "Keyhole"
    keyhole.Size = Vector3.new(0.15, 0.4, 0.15)
    keyhole.Material = Enum.Material.Metal
    keyhole.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
    keyhole.Anchored = true
    keyhole.CanCollide = false
    keyhole.Parent = lock
    
    keyhole.Position = lock.Position + Vector3.new(0, 0, 0.35)
    
    -- Железные заклепки
    for i = 1, 20 do
        local rivet = Instance.new("Part")
        rivet.Name = "Rivet" .. i
        rivet.Size = Vector3.new(0.2, 0.2, 0.2)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 18
        local radius = 1.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 1.5 + (i % 6) * 1.2
        rivet.Position = base.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Укрепляющие балки башен
    for i = 1, 6 do
        local beam = Instance.new("Part")
        beam.Name = "SupportBeam" .. i
        beam.Size = Vector3.new(1.5, 10, 1.5)
        beam.Material = Enum.Material.Metal
        beam.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        beam.Anchored = true
        beam.CanCollide = true
        beam.Parent = model
        
        -- Позиционирование балок
        local tower = (i <= 3) and -3 or 3
        local side = (i % 2 == 0) and 1.5 or -1.5
        beam.Position = base.Position + Vector3.new(tower + side, 6.5, 0)
    end
    
    -- Крыши башен
    for i = 1, 2 do
        local roof = Instance.new("Part")
        roof.Name = "Roof" .. i
        roof.Size = Vector3.new(4.5, 1.5, 4.5)
        roof.Material = Enum.Material.Metal
        roof.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        roof.Anchored = true
        roof.CanCollide = true
        roof.Parent = model
        
        -- Позиционирование крыш
        local xPos = (i == 1) and -3 or 3
        roof.Position = base.Position + Vector3.new(xPos, 12.25, 0)
    end
    
    -- Флаги на башнях
    for i = 1, 2 do
        local flagPole = Instance.new("Part")
        flagPole.Name = "FlagPole" .. i
        flagPole.Size = Vector3.new(0.3, 3, 0.3)
        flagPole.Material = Enum.Material.Metal
        flagPole.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        flagPole.Anchored = true
        flagPole.CanCollide = false
        flagPole.Parent = model
        
        -- Позиционирование флагштоков
        local xPos = (i == 1) and -3 or 3
        flagPole.Position = base.Position + Vector3.new(xPos, 14, 0)
        
        local flag = Instance.new("Part")
        flag.Name = "Flag" .. i
        flag.Size = Vector3.new(1.8, 1, 0.1)
        flag.Material = Enum.Material.Neon
        flag.Color = Color3.fromRGB(0, 255, 0) -- Зеленый флаг
        flag.Anchored = true
        flag.CanCollide = false
        flag.Parent = model
        
        flag.Position = base.Position + Vector3.new(xPos + 0.9, 13.5, 0)
    end
    
    -- Бойницы в башнях
    for i = 1, 12 do
        local arrowSlit = Instance.new("Part")
        arrowSlit.Name = "ArrowSlit" .. i
        arrowSlit.Size = Vector3.new(0.4, 1.5, 0.4)
        arrowSlit.Material = Enum.Material.Metal
        arrowSlit.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        arrowSlit.Anchored = true
        arrowSlit.CanCollide = false
        arrowSlit.Parent = model
        
        -- Позиционирование бойниц
        local tower = (i <= 6) and -3 or 3
        local side = (i % 2 == 0) and 1.5 or -1.5
        local yPos = 3 + (i % 6) * 1.5
        arrowSlit.Position = base.Position + Vector3.new(tower + side, yPos, 0)
    end
    
    -- Железные зубцы на башнях
    for i = 1, 8 do
        for j = 1, 2 do
            local crenellation = Instance.new("Part")
            crenellation.Name = "IronCrenellation_" .. i .. "_" .. j
            crenellation.Size = Vector3.new(1.5, 2, 1.5)
            crenellation.Material = Enum.Material.Metal
            crenellation.Color = Color3.fromRGB(105, 105, 105)
            crenellation.Anchored = true
            crenellation.CanCollide = true
            crenellation.Parent = model
            
            -- Позиционирование зубцов
            local tower = (j == 1) and -3 or 3
            local angle = (i - 1) * 45
            local radius = 2.25
            local xPos = math.cos(math.rad(angle)) * radius
            local zPos = math.sin(math.rad(angle)) * radius
            crenellation.Position = base.Position + Vector3.new(tower + xPos, 12, zPos)
        end
    end
    
    -- Железные ступени
    for i = 1, 4 do
        local step = Instance.new("Part")
        step.Name = "IronStep" .. i
        step.Size = Vector3.new(10, 0.4, 1.5)
        step.Material = Enum.Material.Metal
        step.Color = Color3.fromRGB(128, 128, 128)
        step.Anchored = true
        step.CanCollide = true
        step.Parent = model
        
        -- Позиционирование ступеней
        local yPos = 1.5 + (i - 1) * 0.4
        local zPos = 3 + (i - 1) * 0.5
        step.Position = base.Position + Vector3.new(0, yPos, zPos)
    end
    
    -- Защитные щиты
    for i = 1, 4 do
        local shield = Instance.new("Part")
        shield.Name = "ProtectionShield" .. i
        shield.Size = Vector3.new(1.5, 2, 0.2)
        shield.Material = Enum.Material.Metal
        shield.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        shield.Anchored = true
        shield.CanCollide = false
        shield.Parent = model
        
        -- Позиционирование щитов
        local angle = (i - 1) * 90
        local radius = 3.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        shield.Position = base.Position + Vector3.new(xPos, 7, zPos)
        shield.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- UI для железных ворот
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 350, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 12, 0)
    billboardGui.Parent = leftTower
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Железные ворота"
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
    model:SetAttribute("Material", "iron")
    model:SetAttribute("Health", 1000)
    model:SetAttribute("MaxHealth", 1000)
    model:SetAttribute("Cost", 250)
    model:SetAttribute("BuildTime", 18)
    model:SetAttribute("IsOpen", false)
    model:SetAttribute("CanBeOpened", true)
    model:SetAttribute("RequiresKey", false)
    model:SetAttribute("IronRivets", 20)
    model:SetAttribute("ProtectionShields", 4)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateIronGate