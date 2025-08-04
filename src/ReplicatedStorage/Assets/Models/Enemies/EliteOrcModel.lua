-- EliteOrcModel.lua
-- Модель элитного орка

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateEliteOrcModel()
    local model = Instance.new("Model")
    model.Name = "EliteOrcModel"
    
    -- Тело элитного орка
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(1.4, 2.5, 0.8)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(255, 80, 0) -- Темно-оранжевый цвет
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Создание текстуры кожи
    local skinTexture = Instance.new("Texture")
    skinTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    skinTexture.StudsPerTileU = 1
    skinTexture.StudsPerTileV = 1
    skinTexture.Parent = body
    
    -- Голова элитного орка
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.2, 1.2, 1.2)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(255, 60, 0) -- Очень темно-оранжевый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    head.Position = body.Position + Vector3.new(0, 1.85, 0)
    
    -- Глаза элитного орка (горящие)
    for i = 1, 2 do
        local eye = Instance.new("Part")
        eye.Name = "Eye" .. i
        eye.Size = Vector3.new(0.2, 0.2, 0.2)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 0, 0) -- Красные глаза
        eye.Anchored = true
        eye.CanCollide = false
        eye.Parent = head
        
        -- Позиционирование глаз
        local xPos = (i == 1) and 0.3 or -0.3
        eye.Position = head.Position + Vector3.new(xPos, 0.1, 0.55)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 0, 0)
        pointLight.Range = 4
        pointLight.Brightness = 2.5
        pointLight.Parent = eye
    end
    
    -- Большие клыки элитного орка
    for i = 1, 4 do
        local tusk = Instance.new("Part")
        tusk.Name = "Tusk" .. i
        tusk.Size = Vector3.new(0.15, 0.4, 0.15)
        tusk.Material = Enum.Material.Metal
        tusk.Color = Color3.fromRGB(255, 255, 255) -- Белые клыки
        tusk.Anchored = true
        tusk.CanCollide = false
        tusk.Parent = head
        
        -- Позиционирование клыков
        local xPos = (i <= 2) and 0.4 or -0.4
        local zPos = (i % 2 == 0) and 0.3 or -0.3
        local yPos = (i <= 2) and -0.3 or -0.5
        tusk.Position = head.Position + Vector3.new(xPos, yPos, zPos)
        tusk.Orientation = Vector3.new(0, 0, (i <= 2) and 15 or -15)
    end
    
    -- Рога элитного орка
    for i = 1, 2 do
        local horn = Instance.new("Part")
        horn.Name = "Horn" .. i
        horn.Size = Vector3.new(0.2, 0.6, 0.2)
        horn.Material = Enum.Material.Metal
        horn.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        horn.Anchored = true
        horn.CanCollide = false
        horn.Parent = head
        
        -- Позиционирование рогов
        local xPos = (i == 1) and 0.4 or -0.4
        horn.Position = head.Position + Vector3.new(xPos, 0.8, 0)
        horn.Orientation = Vector3.new(0, 0, (i == 1) and 20 or -20)
    end
    
    -- Руки элитного орка
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.5, 1.3, 0.5)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(255, 80, 0)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 0.95 or -0.95
        arm.Position = body.Position + Vector3.new(xPos, 0.2, 0)
    end
    
    -- Ноги элитного орка
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.6, 1.3, 0.6)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(255, 80, 0)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.4 or -0.4
        leg.Position = body.Position + Vector3.new(xPos, -1.9, 0)
    end
    
    -- Элитное оружие (двуручная секира)
    local weapon = Instance.new("Part")
    weapon.Name = "Weapon"
    weapon.Size = Vector3.new(0.3, 1.5, 0.3)
    weapon.Material = Enum.Material.Metal
    weapon.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    weapon.Anchored = true
    weapon.CanCollide = false
    weapon.Parent = model
    
    weapon.Position = body.Position + Vector3.new(1.5, 0.2, 0)
    
    -- Рукоять секиры
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.3, 0.5, 0.3)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = weapon
    
    handle.Position = weapon.Position + Vector3.new(0, -1, 0)
    
    -- Лезвие секиры
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.8, 0.8, 0.1)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = weapon
    
    blade.Position = weapon.Position + Vector3.new(0, 0.4, 0)
    
    -- Второе лезвие секиры
    local blade2 = Instance.new("Part")
    blade2.Name = "Blade2"
    blade2.Size = Vector3.new(0.8, 0.8, 0.1)
    blade2.Material = Enum.Material.Metal
    blade2.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade2.Anchored = true
    blade2.CanCollide = false
    blade2.Parent = weapon
    
    blade2.Position = weapon.Position + Vector3.new(0, -0.4, 0)
    
    -- Элитная броня
    for i = 1, 6 do
        local armorPlate = Instance.new("Part")
        armorPlate.Name = "EliteArmorPlate" .. i
        armorPlate.Size = Vector3.new(1.2, 0.4, 0.15)
        armorPlate.Material = Enum.Material.Metal
        armorPlate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        armorPlate.Anchored = true
        armorPlate.CanCollide = false
        armorPlate.Parent = model
        
        -- Позиционирование брони
        local yPos = 0.2 + (i - 1) * 0.4
        local zPos = (i % 2 == 0) and 0.5 or -0.5
        armorPlate.Position = body.Position + Vector3.new(0, yPos, zPos)
    end
    
    -- Нагрудник элитного орка
    local chestplate = Instance.new("Part")
    chestplate.Name = "EliteChestplate"
    chestplate.Size = Vector3.new(1.3, 1.2, 0.3)
    chestplate.Material = Enum.Material.Metal
    chestplate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    chestplate.Anchored = true
    chestplate.CanCollide = false
    chestplate.Parent = model
    
    chestplate.Position = body.Position + Vector3.new(0, 0.4, 0.55)
    
    -- Шлем элитного орка
    local helmet = Instance.new("Part")
    helmet.Name = "EliteHelmet"
    helmet.Size = Vector3.new(1.3, 0.8, 1.3)
    helmet.Material = Enum.Material.Metal
    helmet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    helmet.Anchored = true
    helmet.CanCollide = false
    helmet.Parent = model
    
    helmet.Position = head.Position + Vector3.new(0, 0.3, 0)
    
    -- Декоративные элементы на шлеме
    for i = 1, 4 do
        local decoration = Instance.new("Part")
        decoration.Name = "HelmetDecoration" .. i
        decoration.Size = Vector3.new(0.15, 0.3, 0.15)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = helmet
        
        -- Позиционирование декораций
        local angle = (i - 1) * 90
        local radius = 0.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = helmet.Position + Vector3.new(xPos, 0.6, zPos)
    end
    
    -- Наплечники
    for i = 1, 2 do
        local pauldron = Instance.new("Part")
        pauldron.Name = "Pauldron" .. i
        pauldron.Size = Vector3.new(0.8, 0.6, 0.8)
        pauldron.Material = Enum.Material.Metal
        pauldron.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        pauldron.Anchored = true
        pauldron.CanCollide = false
        pauldron.Parent = model
        
        -- Позиционирование наплечников
        local xPos = (i == 1) and 0.7 or -0.7
        pauldron.Position = body.Position + Vector3.new(xPos, 0.8, 0)
    end
    
    -- Эффекты элитного орка
    local aura = Instance.new("Part")
    aura.Name = "EliteAura"
    aura.Size = Vector3.new(3.5, 3.5, 3.5)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 0, 0) -- Красная аура
    aura.Transparency = 0.8
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = body.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 0, 0)
    auraLight.Range = 6
    auraLight.Brightness = 1.5
    auraLight.Parent = aura
    
    -- UI для элитного орка
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 4.5, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Элитный Орк"
    nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Красный текст
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
    healthFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Красный
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("EnemyType", "elite_orc")
    model:SetAttribute("Health", 200)
    model:SetAttribute("MaxHealth", 200)
    model:SetAttribute("Damage", 45)
    model:SetAttribute("Speed", 7)
    model:SetAttribute("AttackRange", 5)
    model:SetAttribute("AttackCooldown", 1.8)
    model:SetAttribute("LootTable", "enemy_loot.elite_orc")
    model:SetAttribute("IsSpecificEnemy", true)
    model:SetAttribute("IsElite", true)
    model:SetAttribute("ExperienceReward", 75)
    model:SetAttribute("GoldReward", 35)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateEliteOrcModel