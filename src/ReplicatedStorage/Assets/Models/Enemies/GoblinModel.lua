-- GoblinModel.lua
-- Модель гоблина

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGoblinModel()
    local model = Instance.new("Model")
    model.Name = "GoblinModel"
    
    -- Тело гоблина
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(1, 1.5, 0.5)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(0, 255, 0) -- Зеленый цвет гоблина
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Голова гоблина
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(0.8, 0.8, 0.8)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(0, 200, 0) -- Темно-зеленый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    -- Позиционирование головы
    head.Position = body.Position + Vector3.new(0, 1.15, 0)
    
    -- Глаза гоблина
    for i = 1, 2 do
        local eye = Instance.new("Part")
        eye.Name = "Eye" .. i
        eye.Size = Vector3.new(0.1, 0.1, 0.1)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 0, 0) -- Красные глаза
        eye.Anchored = true
        eye.CanCollide = false
        eye.Parent = head
        
        -- Позиционирование глаз
        local xPos = (i == 1) and 0.2 or -0.2
        eye.Position = head.Position + Vector3.new(xPos, 0.1, 0.35)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 0, 0)
        pointLight.Range = 2
        pointLight.Brightness = 1
        pointLight.Parent = eye
    end
    
    -- Руки гоблина
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.3, 0.8, 0.3)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(0, 255, 0)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 0.65 or -0.65
        arm.Position = body.Position + Vector3.new(xPos, 0.2, 0)
    end
    
    -- Ноги гоблина
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.4, 0.8, 0.4)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(0, 255, 0)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.25 or -0.25
        leg.Position = body.Position + Vector3.new(xPos, -1.15, 0)
    end
    
    -- Оружие гоблина (кинжал)
    local weapon = Instance.new("Part")
    weapon.Name = "Weapon"
    weapon.Size = Vector3.new(0.1, 0.6, 0.1)
    weapon.Material = Enum.Material.Metal
    weapon.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    weapon.Anchored = true
    weapon.CanCollide = false
    weapon.Parent = model
    
    -- Позиционирование оружия
    weapon.Position = body.Position + Vector3.new(0.8, 0.2, 0)
    
    -- Рукоять кинжала
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.15, 0.2, 0.15)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = weapon
    
    handle.Position = weapon.Position + Vector3.new(0, -0.4, 0)
    
    -- UI для гоблина
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Гоблин"
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
    model:SetAttribute("EnemyType", "goblin")
    model:SetAttribute("Health", 50)
    model:SetAttribute("MaxHealth", 50)
    model:SetAttribute("Damage", 15)
    model:SetAttribute("Speed", 8)
    model:SetAttribute("AttackRange", 3)
    model:SetAttribute("AttackCooldown", 2)
    model:SetAttribute("LootTable", "enemy_loot.goblin")
    model:SetAttribute("IsSpecificEnemy", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateGoblinModel