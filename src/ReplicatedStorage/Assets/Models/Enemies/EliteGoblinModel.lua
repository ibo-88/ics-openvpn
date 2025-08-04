-- EliteGoblinModel.lua
-- Модель элитного гоблина

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateEliteGoblinModel()
    local model = Instance.new("Model")
    model.Name = "EliteGoblinModel"
    
    -- Тело элитного гоблина
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(1.2, 1.8, 0.6)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(0, 200, 0) -- Темно-зеленый цвет
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Создание текстуры кожи
    local skinTexture = Instance.new("Texture")
    skinTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    skinTexture.StudsPerTileU = 1
    skinTexture.StudsPerTileV = 1
    skinTexture.Parent = body
    
    -- Голова элитного гоблина
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1, 1, 1)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(0, 150, 0) -- Очень темно-зеленый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    head.Position = body.Position + Vector3.new(0, 1.4, 0)
    
    -- Глаза элитного гоблина (горящие)
    for i = 1, 2 do
        local eye = Instance.new("Part")
        eye.Name = "Eye" .. i
        eye.Size = Vector3.new(0.15, 0.15, 0.15)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 100, 0) -- Оранжевые глаза
        eye.Anchored = true
        eye.CanCollide = false
        eye.Parent = head
        
        -- Позиционирование глаз
        local xPos = (i == 1) and 0.25 or -0.25
        eye.Position = head.Position + Vector3.new(xPos, 0.1, 0.45)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 100, 0)
        pointLight.Range = 3
        pointLight.Brightness = 2
        pointLight.Parent = eye
    end
    
    -- Рога элитного гоблина
    for i = 1, 2 do
        local horn = Instance.new("Part")
        horn.Name = "Horn" .. i
        horn.Size = Vector3.new(0.1, 0.4, 0.1)
        horn.Material = Enum.Material.Metal
        horn.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        horn.Anchored = true
        horn.CanCollide = false
        horn.Parent = head
        
        -- Позиционирование рогов
        local xPos = (i == 1) and 0.3 or -0.3
        horn.Position = head.Position + Vector3.new(xPos, 0.6, 0)
        horn.Orientation = Vector3.new(0, 0, (i == 1) and 15 or -15)
    end
    
    -- Руки элитного гоблина
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.4, 1, 0.4)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(0, 200, 0)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 0.8 or -0.8
        arm.Position = body.Position + Vector3.new(xPos, 0.2, 0)
    end
    
    -- Ноги элитного гоблина
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.5, 1, 0.5)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(0, 200, 0)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.3 or -0.3
        leg.Position = body.Position + Vector3.new(xPos, -1.4, 0)
    end
    
    -- Элитное оружие (двуручный меч)
    local weapon = Instance.new("Part")
    weapon.Name = "Weapon"
    weapon.Size = Vector3.new(0.2, 1.2, 0.2)
    weapon.Material = Enum.Material.Metal
    weapon.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    weapon.Anchored = true
    weapon.CanCollide = false
    weapon.Parent = model
    
    weapon.Position = body.Position + Vector3.new(1.2, 0.2, 0)
    
    -- Рукоять меча
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.25, 0.4, 0.25)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = weapon
    
    handle.Position = weapon.Position + Vector3.new(0, -0.8, 0)
    
    -- Гарда меча
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.6, 0.1, 0.1)
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    guard.Anchored = true
    guard.CanCollide = false
    guard.Parent = weapon
    
    guard.Position = weapon.Position + Vector3.new(0, -0.6, 0)
    
    -- Клинок меча
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.15, 0.8, 0.15)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = weapon
    
    blade.Position = weapon.Position + Vector3.new(0, 0.2, 0)
    
    -- Элитная броня
    for i = 1, 4 do
        local armorPlate = Instance.new("Part")
        armorPlate.Name = "ArmorPlate" .. i
        armorPlate.Size = Vector3.new(0.8, 0.3, 0.1)
        armorPlate.Material = Enum.Material.Metal
        armorPlate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        armorPlate.Anchored = true
        armorPlate.CanCollide = false
        armorPlate.Parent = model
        
        -- Позиционирование брони
        local yPos = 0.2 + (i - 1) * 0.4
        local zPos = (i % 2 == 0) and 0.35 or -0.35
        armorPlate.Position = body.Position + Vector3.new(0, yPos, zPos)
    end
    
    -- Нагрудник
    local chestplate = Instance.new("Part")
    chestplate.Name = "Chestplate"
    chestplate.Size = Vector3.new(1.1, 0.8, 0.2)
    chestplate.Material = Enum.Material.Metal
    chestplate.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    chestplate.Anchored = true
    chestplate.CanCollide = false
    chestplate.Parent = model
    
    chestplate.Position = body.Position + Vector3.new(0, 0.4, 0.4)
    
    -- Шлем
    local helmet = Instance.new("Part")
    helmet.Name = "Helmet"
    helmet.Size = Vector3.new(1.1, 0.6, 1.1)
    helmet.Material = Enum.Material.Metal
    helmet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    helmet.Anchored = true
    helmet.CanCollide = false
    helmet.Parent = model
    
    helmet.Position = head.Position + Vector3.new(0, 0.3, 0)
    
    -- Декоративные элементы на шлеме
    for i = 1, 3 do
        local decoration = Instance.new("Part")
        decoration.Name = "HelmetDecoration" .. i
        decoration.Size = Vector3.new(0.1, 0.2, 0.1)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = helmet
        
        -- Позиционирование декораций
        local angle = (i - 1) * 120
        local radius = 0.4
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = helmet.Position + Vector3.new(xPos, 0.4, zPos)
    end
    
    -- Эффекты элитного гоблина
    local aura = Instance.new("Part")
    aura.Name = "Aura"
    aura.Size = Vector3.new(3, 3, 3)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 100, 0) -- Оранжевая аура
    aura.Transparency = 0.8
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = body.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 100, 0)
    auraLight.Range = 5
    auraLight.Brightness = 1
    auraLight.Parent = aura
    
    -- UI для элитного гоблина
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Элитный Гоблин"
    nameLabel.TextColor3 = Color3.fromRGB(255, 100, 0) -- Оранжевый текст
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
    healthFill.BackgroundColor3 = Color3.fromRGB(255, 100, 0) -- Оранжевый
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("EnemyType", "elite_goblin")
    model:SetAttribute("Health", 150)
    model:SetAttribute("MaxHealth", 150)
    model:SetAttribute("Damage", 35)
    model:SetAttribute("Speed", 10)
    model:SetAttribute("AttackRange", 4)
    model:SetAttribute("AttackCooldown", 1.5)
    model:SetAttribute("LootTable", "enemy_loot.elite_goblin")
    model:SetAttribute("IsSpecificEnemy", true)
    model:SetAttribute("IsElite", true)
    model:SetAttribute("ExperienceReward", 50)
    model:SetAttribute("GoldReward", 25)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateEliteGoblinModel