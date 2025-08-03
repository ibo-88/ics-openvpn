-- DragonModel.lua
-- Модель дракона

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateDragonModel()
    local model = Instance.new("Model")
    model.Name = "DragonModel"
    
    -- Тело дракона
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(3, 2, 1.5)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(255, 0, 0) -- Красный цвет дракона
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Голова дракона
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.5, 1.2, 1)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(220, 20, 60) -- Темно-красный
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    -- Позиционирование головы
    head.Position = body.Position + Vector3.new(2, 0.5, 0)
    
    -- Глаза дракона
    for i = 1, 2 do
        local eye = Instance.new("Part")
        eye.Name = "Eye" .. i
        eye.Size = Vector3.new(0.2, 0.2, 0.2)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 255, 0) -- Желтые глаза
        eye.Anchored = true
        eye.CanCollide = false
        eye.Parent = head
        
        -- Позиционирование глаз
        local xPos = (i == 1) and 0.4 or -0.4
        eye.Position = head.Position + Vector3.new(0.6, 0.2, xPos)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 255, 0)
        pointLight.Range = 5
        pointLight.Brightness = 2
        pointLight.Parent = eye
    end
    
    -- Рога дракона
    for i = 1, 2 do
        local horn = Instance.new("Part")
        horn.Name = "Horn" .. i
        horn.Size = Vector3.new(0.1, 0.8, 0.1)
        horn.Material = Enum.Material.Neon
        horn.Color = Color3.fromRGB(255, 215, 0) -- Золотые рога
        horn.Anchored = true
        horn.CanCollide = false
        horn.Parent = head
        
        -- Позиционирование рогов
        local xPos = (i == 1) and 0.5 or -0.5
        horn.Position = head.Position + Vector3.new(0.3, 0.6, xPos)
    end
    
    -- Клыки дракона
    for i = 1, 4 do
        local fang = Instance.new("Part")
        fang.Name = "Fang" .. i
        fang.Size = Vector3.new(0.05, 0.3, 0.05)
        fang.Material = Enum.Material.Neon
        fang.Color = Color3.fromRGB(255, 255, 255) -- Белые клыки
        fang.Anchored = true
        fang.CanCollide = false
        fang.Parent = head
        
        -- Позиционирование клыков
        local xPos = (i <= 2) and 0.2 or -0.2
        local yPos = (i % 2 == 0) and 0.1 or -0.1
        fang.Position = head.Position + Vector3.new(0.7, yPos, xPos)
    end
    
    -- Крылья дракона
    for i = 1, 2 do
        local wing = Instance.new("Part")
        wing.Name = "Wing" .. i
        wing.Size = Vector3.new(2, 1.5, 0.1)
        wing.Material = Enum.Material.Neon
        wing.Color = Color3.fromRGB(139, 0, 0) -- Темно-красный
        wing.Transparency = 0.3
        wing.Anchored = true
        wing.CanCollide = false
        wing.Parent = model
        
        -- Позиционирование крыльев
        local xPos = (i == 1) and 1.5 or -1.5
        wing.Position = body.Position + Vector3.new(0, 0.5, xPos)
    end
    
    -- Хвост дракона
    local tail = Instance.new("Part")
    tail.Name = "Tail"
    tail.Size = Vector3.new(2, 0.8, 0.8)
    tail.Material = Enum.Material.Neon
    tail.Color = Color3.fromRGB(255, 0, 0)
    tail.Anchored = true
    tail.CanCollide = true
    tail.Parent = model
    
    tail.Position = body.Position + Vector3.new(-2.5, 0, 0)
    
    -- Ноги дракона
    for i = 1, 4 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.6, 1.2, 0.6)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(255, 0, 0)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i <= 2) and 0.8 or -0.8
        local zPos = (i % 2 == 0) and 0.8 or -0.8
        leg.Position = body.Position + Vector3.new(xPos, -1.6, zPos)
    end
    
    -- Когти дракона
    for i = 1, 8 do
        local claw = Instance.new("Part")
        claw.Name = "Claw" .. i
        claw.Size = Vector3.new(0.1, 0.3, 0.1)
        claw.Material = Enum.Material.Neon
        claw.Color = Color3.fromRGB(255, 215, 0) -- Золотые когти
        claw.Anchored = true
        claw.CanCollide = false
        claw.Parent = model
        
        -- Позиционирование когтей
        local legIndex = math.ceil(i / 2)
        local xPos = (legIndex <= 2) and 0.8 or -0.8
        local zPos = (legIndex % 2 == 0) and 0.8 or -0.8
        local clawOffset = (i % 2 == 0) and 0.2 or -0.2
        claw.Position = body.Position + Vector3.new(xPos + clawOffset, -2.2, zPos)
    end
    
    -- Огненное дыхание
    local fireBreath = Instance.new("Part")
    fireBreath.Name = "FireBreath"
    fireBreath.Size = Vector3.new(0.1, 0.1, 0.1)
    fireBreath.Material = Enum.Material.Neon
    fireBreath.Color = Color3.fromRGB(255, 165, 0) -- Оранжевый огонь
    fireBreath.Anchored = true
    fireBreath.CanCollide = false
    fireBreath.Parent = head
    
    fireBreath.Position = head.Position + Vector3.new(0.8, 0, 0)
    
    -- Создание огня
    local fire = Instance.new("Fire")
    fire.Heat = 15
    fire.Size = 3
    fire.Parent = fireBreath
    
    -- Частицы огня
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 165, 0))
    particleEmitter.Size = NumberSequence.new(0.5, 0)
    particleEmitter.Speed = NumberRange.new(5, 15)
    particleEmitter.Rate = 20
    particleEmitter.Lifetime = NumberRange.new(1, 3)
    particleEmitter.Parent = fireBreath
    
    -- UI для дракона
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 300, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Дракон"
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
    model:SetAttribute("EnemyType", "dragon")
    model:SetAttribute("Health", 1000)
    model:SetAttribute("MaxHealth", 1000)
    model:SetAttribute("Damage", 80)
    model:SetAttribute("Speed", 3)
    model:SetAttribute("AttackRange", 8)
    model:SetAttribute("AttackCooldown", 3)
    model:SetAttribute("LootTable", "enemy_loot.dragon")
    model:SetAttribute("IsSpecificEnemy", true)
    model:SetAttribute("IsBoss", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateDragonModel