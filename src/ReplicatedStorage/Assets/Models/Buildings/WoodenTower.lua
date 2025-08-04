-- WoodenTower.lua
-- Модель деревянной башни

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateWoodenTower()
    local model = Instance.new("Model")
    model.Name = "WoodenTower"
    
    -- Основание башни
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(4, 1, 4)
    base.Material = Enum.Material.Wood
    base.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет дерева
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 2
    woodTexture.StudsPerTileV = 1
    woodTexture.Parent = base
    
    -- Основная башня
    local tower = Instance.new("Part")
    tower.Name = "Tower"
    tower.Size = Vector3.new(3, 8, 3)
    tower.Material = Enum.Material.Wood
    tower.Color = Color3.fromRGB(160, 82, 45) -- Более светлый коричневый
    tower.Anchored = true
    tower.CanCollide = true
    tower.Parent = model
    
    tower.Position = base.Position + Vector3.new(0, 4.5, 0)
    
    -- Балки поддержки
    for i = 1, 4 do
        local beam = Instance.new("Part")
        beam.Name = "SupportBeam" .. i
        beam.Size = Vector3.new(0.3, 8, 0.3)
        beam.Material = Enum.Material.Wood
        beam.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        beam.Anchored = true
        beam.CanCollide = true
        beam.Parent = model
        
        -- Позиционирование балок
        local angle = (i - 1) * 90
        local radius = 1.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        beam.Position = base.Position + Vector3.new(xPos, 4.5, zPos)
    end
    
    -- Платформа для лучников
    local platform = Instance.new("Part")
    platform.Name = "Platform"
    platform.Size = Vector3.new(3.5, 0.5, 3.5)
    platform.Material = Enum.Material.Wood
    platform.Color = Color3.fromRGB(139, 69, 19)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Parent = model
    
    platform.Position = base.Position + Vector3.new(0, 8.75, 0)
    
    -- Перила платформы
    for i = 1, 4 do
        local railing = Instance.new("Part")
        railing.Name = "Railing" .. i
        railing.Size = Vector3.new(3.5, 1, 0.2)
        railing.Material = Enum.Material.Wood
        railing.Color = Color3.fromRGB(160, 82, 45)
        railing.Anchored = true
        railing.CanCollide = true
        railing.Parent = model
        
        -- Позиционирование перил
        local angle = (i - 1) * 90
        local radius = 1.75
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        railing.Position = base.Position + Vector3.new(xPos, 9.25, zPos)
        railing.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Бойницы для стрельбы
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
        local angle = (i - 1) * 90
        local radius = 1.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        arrowSlit.Position = base.Position + Vector3.new(xPos, 6, zPos)
    end
    
    -- Лестница внутри башни
    for i = 1, 6 do
        local step = Instance.new("Part")
        step.Name = "Step" .. i
        step.Size = Vector3.new(0.8, 0.2, 2)
        step.Material = Enum.Material.Wood
        step.Color = Color3.fromRGB(139, 69, 19)
        step.Anchored = true
        step.CanCollide = true
        step.Parent = model
        
        -- Позиционирование ступеней
        local yPos = 1 + (i - 1) * 1.2
        local xOffset = (i % 2 == 0) and 0.5 or -0.5
        step.Position = base.Position + Vector3.new(xOffset, yPos, 0)
    end
    
    -- Крыша башни
    local roof = Instance.new("Part")
    roof.Name = "Roof"
    roof.Size = Vector3.new(4, 0.5, 4)
    roof.Material = Enum.Material.Wood
    roof.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
    roof.Anchored = true
    roof.CanCollide = true
    roof.Parent = model
    
    roof.Position = base.Position + Vector3.new(0, 10.25, 0)
    
    -- Флаг на башне
    local flagPole = Instance.new("Part")
    flagPole.Name = "FlagPole"
    flagPole.Size = Vector3.new(0.1, 2, 0.1)
    flagPole.Material = Enum.Material.Wood
    flagPole.Color = Color3.fromRGB(139, 69, 19)
    flagPole.Anchored = true
    flagPole.CanCollide = false
    flagPole.Parent = model
    
    flagPole.Position = base.Position + Vector3.new(0, 11.5, 0)
    
    local flag = Instance.new("Part")
    flag.Name = "Flag"
    flag.Size = Vector3.new(1, 0.6, 0.1)
    flag.Material = Enum.Material.Neon
    flag.Color = Color3.fromRGB(255, 0, 0) -- Красный флаг
    flag.Anchored = true
    flag.CanCollide = false
    flag.Parent = model
    
    flag.Position = base.Position + Vector3.new(0.6, 11.2, 0)
    
    -- UI для башни
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 12, 0)
    billboardGui.Parent = roof
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Деревянная башня"
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
    model:SetAttribute("Material", "wood")
    model:SetAttribute("Health", 200)
    model:SetAttribute("MaxHealth", 200)
    model:SetAttribute("Cost", 50)
    model:SetAttribute("BuildTime", 8)
    model:SetAttribute("AttackRange", 15)
    model:SetAttribute("AttackDamage", 25)
    model:SetAttribute("AttackSpeed", 2)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateWoodenTower