-- IronTower.lua
-- Модель железной башни

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIronTower()
    local model = Instance.new("Model")
    model.Name = "IronTower"
    
    -- Основание башни
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(6, 2, 6)
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 3
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = base
    
    -- Основная башня
    local tower = Instance.new("Part")
    tower.Name = "Tower"
    tower.Size = Vector3.new(5, 12, 5)
    tower.Material = Enum.Material.Metal
    tower.Color = Color3.fromRGB(128, 128, 128) -- Серый металл
    tower.Anchored = true
    tower.CanCollide = true
    tower.Parent = model
    
    tower.Position = base.Position + Vector3.new(0, 7, 0)
    
    -- Железные пластины башни
    for i = 1, 6 do
        for j = 1, 4 do
            local plate = Instance.new("Part")
            plate.Name = "IronPlate_" .. i .. "_" .. j
            plate.Size = Vector3.new(2, 2, 0.2)
            plate.Material = Enum.Material.Metal
            plate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
            plate.Anchored = true
            plate.CanCollide = false
            plate.Parent = model
            
            -- Позиционирование пластин
            local angle = (j - 1) * 90
            local radius = 2.6
            local xPos = math.cos(math.rad(angle)) * radius
            local zPos = math.sin(math.rad(angle)) * radius
            local yPos = 2 + (i - 1) * 2
            plate.Position = base.Position + Vector3.new(xPos, yPos, zPos)
            plate.Orientation = Vector3.new(0, angle, 0)
        end
    end
    
    -- Укрепляющие балки
    for i = 1, 4 do
        local beam = Instance.new("Part")
        beam.Name = "SupportBeam" .. i
        beam.Size = Vector3.new(0.5, 12, 0.5)
        beam.Material = Enum.Material.Metal
        beam.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        beam.Anchored = true
        beam.CanCollide = true
        beam.Parent = model
        
        -- Позиционирование балок
        local angle = (i - 1) * 90
        local radius = 2.75
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        beam.Position = base.Position + Vector3.new(xPos, 7, zPos)
    end
    
    -- Платформа для лучников
    local platform = Instance.new("Part")
    platform.Name = "Platform"
    platform.Size = Vector3.new(5.5, 1, 5.5)
    platform.Material = Enum.Material.Metal
    platform.Color = Color3.fromRGB(128, 128, 128)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Parent = model
    
    platform.Position = base.Position + Vector3.new(0, 13.5, 0)
    
    -- Зубцы на платформе
    for i = 1, 12 do
        local crenellation = Instance.new("Part")
        crenellation.Name = "Crenellation" .. i
        crenellation.Size = Vector3.new(1, 2, 1)
        crenellation.Material = Enum.Material.Metal
        crenellation.Color = Color3.fromRGB(105, 105, 105)
        crenellation.Anchored = true
        crenellation.CanCollide = true
        crenellation.Parent = model
        
        -- Позиционирование зубцов
        local angle = (i - 1) * 30
        local radius = 3.25
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crenellation.Position = base.Position + Vector3.new(xPos, 14.5, zPos)
    end
    
    -- Бойницы для стрельбы
    for i = 1, 4 do
        local arrowSlit = Instance.new("Part")
        arrowSlit.Name = "ArrowSlit" .. i
        arrowSlit.Size = Vector3.new(0.4, 1.2, 0.4)
        arrowSlit.Material = Enum.Material.Metal
        arrowSlit.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        arrowSlit.Anchored = true
        arrowSlit.CanCollide = false
        arrowSlit.Parent = model
        
        -- Позиционирование бойниц
        local angle = (i - 1) * 90
        local radius = 2.7
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        arrowSlit.Position = base.Position + Vector3.new(xPos, 8, zPos)
    end
    
    -- Винтовая лестница внутри башни
    for i = 1, 10 do
        local step = Instance.new("Part")
        step.Name = "Step" .. i
        step.Size = Vector3.new(1.2, 0.3, 3)
        step.Material = Enum.Material.Metal
        step.Color = Color3.fromRGB(128, 128, 128)
        step.Anchored = true
        step.CanCollide = true
        step.Parent = model
        
        -- Позиционирование ступеней
        local angle = i * 36
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 2 + (i - 1) * 1.2
        step.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        step.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Крыша башни
    local roof = Instance.new("Part")
    roof.Name = "Roof"
    roof.Size = Vector3.new(6, 1, 6)
    roof.Material = Enum.Material.Metal
    roof.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    roof.Anchored = true
    roof.CanCollide = true
    roof.Parent = model
    
    roof.Position = base.Position + Vector3.new(0, 16, 0)
    
    -- Флагшток на башне
    local flagPole = Instance.new("Part")
    flagPole.Name = "FlagPole"
    flagPole.Size = Vector3.new(0.3, 4, 0.3)
    flagPole.Material = Enum.Material.Metal
    flagPole.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    flagPole.Anchored = true
    flagPole.CanCollide = false
    flagPole.Parent = model
    
    flagPole.Position = base.Position + Vector3.new(0, 18, 0)
    
    local flag = Instance.new("Part")
    flag.Name = "Flag"
    flag.Size = Vector3.new(2, 1, 0.1)
    flag.Material = Enum.Material.Neon
    flag.Color = Color3.fromRGB(0, 255, 0) -- Зеленый флаг
    flag.Anchored = true
    flag.CanCollide = false
    flag.Parent = model
    
    flag.Position = base.Position + Vector3.new(1.2, 17.5, 0)
    
    -- Железные заклепки
    for i = 1, 16 do
        local rivet = Instance.new("Part")
        rivet.Name = "Rivet" .. i
        rivet.Size = Vector3.new(0.2, 0.2, 0.2)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 22.5
        local radius = 2.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 2 + (i % 6) * 2
        rivet.Position = base.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Железные ручки для подъема
    for i = 1, 8 do
        local handle = Instance.new("Part")
        handle.Name = "Handle" .. i
        handle.Size = Vector3.new(0.3, 0.1, 0.1)
        handle.Material = Enum.Material.Metal
        handle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        handle.Anchored = true
        handle.CanCollide = false
        handle.Parent = model
        
        -- Позиционирование ручек
        local angle = (i - 1) * 45
        local radius = 2.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 3 + (i % 4) * 2.5
        handle.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        handle.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Защитные щиты
    for i = 1, 4 do
        local shield = Instance.new("Part")
        shield.Name = "Shield" .. i
        shield.Size = Vector3.new(1, 1.5, 0.1)
        shield.Material = Enum.Material.Metal
        shield.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        shield.Anchored = true
        shield.CanCollide = false
        shield.Parent = model
        
        -- Позиционирование щитов
        local angle = (i - 1) * 90
        local radius = 2.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        shield.Position = base.Position + Vector3.new(xPos, 8, zPos)
        shield.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- UI для железной башни
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 18, 0)
    billboardGui.Parent = roof
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Железная башня"
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
    model:SetAttribute("Material", "iron")
    model:SetAttribute("Health", 800)
    model:SetAttribute("MaxHealth", 800)
    model:SetAttribute("Cost", 200)
    model:SetAttribute("BuildTime", 15)
    model:SetAttribute("AttackRange", 25)
    model:SetAttribute("AttackDamage", 50)
    model:SetAttribute("AttackSpeed", 1)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateIronTower