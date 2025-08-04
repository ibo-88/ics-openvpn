-- TrollModel.lua
-- Модель тролля

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateTrollModel()
    local model = Instance.new("Model")
    model.Name = "TrollModel"
    
    -- Тело тролля
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(2, 3.5, 1.2)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет кожи
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Создание текстуры кожи
    local skinTexture = Instance.new("Texture")
    skinTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    skinTexture.StudsPerTileU = 1
    skinTexture.StudsPerTileV = 1
    skinTexture.Parent = body
    
    -- Голова тролля
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.8, 1.8, 1.8)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    head.Position = body.Position + Vector3.new(0, 2.65, 0)
    
    -- Глаза тролля (желтые)
    for i = 1, 2 do
        local eye = Instance.new("Part")
        eye.Name = "Eye" .. i
        eye.Size = Vector3.new(0.3, 0.3, 0.3)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 255, 0) -- Желтые глаза
        eye.Anchored = true
        eye.CanCollide = false
        eye.Parent = head
        
        -- Позиционирование глаз
        local xPos = (i == 1) and 0.4 or -0.4
        eye.Position = head.Position + Vector3.new(xPos, 0.2, 0.8)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 255, 0)
        pointLight.Range = 3
        pointLight.Brightness = 2
        pointLight.Parent = eye
    end
    
    -- Большие клыки тролля
    for i = 1, 6 do
        local tusk = Instance.new("Part")
        tusk.Name = "Tusk" .. i
        tusk.Size = Vector3.new(0.2, 0.6, 0.2)
        tusk.Material = Enum.Material.Metal
        tusk.Color = Color3.fromRGB(255, 255, 255) -- Белые клыки
        tusk.Anchored = true
        tusk.CanCollide = false
        tusk.Parent = head
        
        -- Позиционирование клыков
        local xPos = (i <= 3) and 0.5 or -0.5
        local zPos = (i % 2 == 0) and 0.4 or -0.4
        local yPos = (i <= 2) and -0.3 or ((i <= 4) and -0.6 or -0.9)
        tusk.Position = head.Position + Vector3.new(xPos, yPos, zPos)
        tusk.Orientation = Vector3.new(0, 0, (i <= 3) and 20 or -20)
    end
    
    -- Рога тролля
    for i = 1, 2 do
        local horn = Instance.new("Part")
        horn.Name = "Horn" .. i
        horn.Size = Vector3.new(0.3, 1, 0.3)
        horn.Material = Enum.Material.Metal
        horn.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        horn.Anchored = true
        horn.CanCollide = false
        horn.Parent = head
        
        -- Позиционирование рогов
        local xPos = (i == 1) and 0.6 or -0.6
        horn.Position = head.Position + Vector3.new(xPos, 1.2, 0)
        horn.Orientation = Vector3.new(0, 0, (i == 1) and 25 or -25)
    end
    
    -- Руки тролля
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.8, 1.8, 0.8)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(139, 69, 19)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 1.4 or -1.4
        arm.Position = body.Position + Vector3.new(xPos, 0.5, 0)
    end
    
    -- Ноги тролля
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(1, 2, 1)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(139, 69, 19)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.5 or -0.5
        leg.Position = body.Position + Vector3.new(xPos, -2.75, 0)
    end
    
    -- Оружие тролля (огромная дубина)
    local weapon = Instance.new("Part")
    weapon.Name = "Weapon"
    weapon.Size = Vector3.new(0.5, 2.5, 0.5)
    weapon.Material = Enum.Material.Wood
    weapon.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
    weapon.Anchored = true
    weapon.CanCollide = false
    weapon.Parent = model
    
    weapon.Position = body.Position + Vector3.new(2.2, 0.5, 0)
    
    -- Рукоять дубины
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.4, 0.8, 0.4)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = weapon
    
    handle.Position = weapon.Position + Vector3.new(0, -1.65, 0)
    
    -- Головка дубины
    local clubHead = Instance.new("Part")
    clubHead.Name = "ClubHead"
    clubHead.Size = Vector3.new(1.2, 1.2, 1.2)
    clubHead.Material = Enum.Material.Wood
    clubHead.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
    clubHead.Anchored = true
    clubHead.CanCollide = false
    clubHead.Parent = weapon
    
    clubHead.Position = weapon.Position + Vector3.new(0, 1.35, 0)
    
    -- Шипы на дубине
    for i = 1, 8 do
        local spike = Instance.new("Part")
        spike.Name = "Spike" .. i
        spike.Size = Vector3.new(0.2, 0.4, 0.2)
        spike.Material = Enum.Material.Metal
        spike.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        spike.Anchored = true
        spike.CanCollide = false
        spike.Parent = clubHead
        
        -- Позиционирование шипов
        local angle = (i - 1) * 45
        local radius = 0.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        spike.Position = clubHead.Position + Vector3.new(xPos, 0.8, zPos)
        spike.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Броня тролля
    for i = 1, 8 do
        local armorPlate = Instance.new("Part")
        armorPlate.Name = "TrollArmorPlate" .. i
        armorPlate.Size = Vector3.new(1.5, 0.5, 0.2)
        armorPlate.Material = Enum.Material.Metal
        armorPlate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        armorPlate.Anchored = true
        armorPlate.CanCollide = false
        armorPlate.Parent = model
        
        -- Позиционирование брони
        local yPos = 0.5 + (i - 1) * 0.4
        local zPos = (i % 2 == 0) and 0.7 or -0.7
        armorPlate.Position = body.Position + Vector3.new(0, yPos, zPos)
    end
    
    -- Нагрудник тролля
    local chestplate = Instance.new("Part")
    chestplate.Name = "TrollChestplate"
    chestplate.Size = Vector3.new(1.8, 1.5, 0.4)
    chestplate.Material = Enum.Material.Metal
    chestplate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    chestplate.Anchored = true
    chestplate.CanCollide = false
    chestplate.Parent = model
    
    chestplate.Position = body.Position + Vector3.new(0, 0.8, 0.8)
    
    -- Шлем тролля
    local helmet = Instance.new("Part")
    helmet.Name = "TrollHelmet"
    helmet.Size = Vector3.new(1.9, 1, 1.9)
    helmet.Material = Enum.Material.Metal
    helmet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    helmet.Anchored = true
    helmet.CanCollide = false
    helmet.Parent = model
    
    helmet.Position = head.Position + Vector3.new(0, 0.4, 0)
    
    -- Декоративные элементы на шлеме
    for i = 1, 4 do
        local decoration = Instance.new("Part")
        decoration.Name = "HelmetDecoration" .. i
        decoration.Size = Vector3.new(0.2, 0.4, 0.2)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = helmet
        
        -- Позиционирование декораций
        local angle = (i - 1) * 90
        local radius = 0.7
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = helmet.Position + Vector3.new(xPos, 0.7, zPos)
    end
    
    -- Наплечники тролля
    for i = 1, 2 do
        local pauldron = Instance.new("Part")
        pauldron.Name = "Pauldron" .. i
        pauldron.Size = Vector3.new(1.2, 0.8, 1.2)
        pauldron.Material = Enum.Material.Metal
        pauldron.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        pauldron.Anchored = true
        pauldron.CanCollide = false
        pauldron.Parent = model
        
        -- Позиционирование наплечников
        local xPos = (i == 1) and 1.1 or -1.1
        pauldron.Position = body.Position + Vector3.new(xPos, 1.2, 0)
    end
    
    -- Эффекты тролля
    local aura = Instance.new("Part")
    aura.Name = "TrollAura"
    aura.Size = Vector3.new(4, 4, 4)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 165, 0) -- Оранжевая аура
    aura.Transparency = 0.8
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = body.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 165, 0)
    auraLight.Range = 7
    auraLight.Brightness = 1.5
    auraLight.Parent = aura
    
    -- UI для тролля
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 5, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Тролль"
    nameLabel.TextColor3 = Color3.fromRGB(255, 165, 0) -- Оранжевый текст
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
    healthFill.BackgroundColor3 = Color3.fromRGB(255, 165, 0) -- Оранжевый
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("EnemyType", "troll")
    model:SetAttribute("Health", 300)
    model:SetAttribute("MaxHealth", 300)
    model:SetAttribute("Damage", 55)
    model:SetAttribute("Speed", 4)
    model:SetAttribute("AttackRange", 7)
    model:SetAttribute("AttackCooldown", 2.5)
    model:SetAttribute("LootTable", "enemy_loot.troll")
    model:SetAttribute("IsSpecificEnemy", true)
    model:SetAttribute("IsElite", true)
    model:SetAttribute("ExperienceReward", 100)
    model:SetAttribute("GoldReward", 50)
    model:SetAttribute("SpecialAbility", "ground_slam")
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateTrollModel