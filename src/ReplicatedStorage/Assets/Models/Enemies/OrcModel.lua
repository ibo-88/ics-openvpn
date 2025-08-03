-- OrcModel.lua
-- Модель орка

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateOrcModel()
    local model = Instance.new("Model")
    model.Name = "OrcModel"
    
    -- Тело орка
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(1.2, 2, 0.6)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(255, 100, 0) -- Оранжевый цвет орка
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Голова орка
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1, 1, 1)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(255, 69, 0) -- Темно-оранжевый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    -- Позиционирование головы
    head.Position = body.Position + Vector3.new(0, 1.5, 0)
    
    -- Глаза орка
    for i = 1, 2 do
        local eye = Instance.new("Part")
        eye.Name = "Eye" .. i
        eye.Size = Vector3.new(0.15, 0.15, 0.15)
        eye.Material = Enum.Material.Neon
        eye.Color = Color3.fromRGB(255, 0, 0) -- Красные глаза
        eye.Anchored = true
        eye.CanCollide = false
        eye.Parent = head
        
        -- Позиционирование глаз
        local xPos = (i == 1) and 0.25 or -0.25
        eye.Position = head.Position + Vector3.new(xPos, 0.1, 0.4)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 0, 0)
        pointLight.Range = 3
        pointLight.Brightness = 1.5
        pointLight.Parent = eye
    end
    
    -- Клыки орка
    for i = 1, 2 do
        local tusk = Instance.new("Part")
        tusk.Name = "Tusk" .. i
        tusk.Size = Vector3.new(0.1, 0.3, 0.1)
        tusk.Material = Enum.Material.Neon
        tusk.Color = Color3.fromRGB(255, 255, 255) -- Белые клыки
        tusk.Anchored = true
        tusk.CanCollide = false
        tusk.Parent = head
        
        -- Позиционирование клыков
        local xPos = (i == 1) and 0.3 or -0.3
        tusk.Position = head.Position + Vector3.new(xPos, -0.2, 0.4)
    end
    
    -- Руки орка
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.4, 1, 0.4)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(255, 100, 0)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 0.8 or -0.8
        arm.Position = body.Position + Vector3.new(xPos, 0.3, 0)
    end
    
    -- Ноги орка
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.5, 1, 0.5)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(255, 100, 0)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.3 or -0.3
        leg.Position = body.Position + Vector3.new(xPos, -1.5, 0)
    end
    
    -- Оружие орка (топор)
    local weapon = Instance.new("Part")
    weapon.Name = "Weapon"
    weapon.Size = Vector3.new(0.2, 0.8, 0.1)
    weapon.Material = Enum.Material.Metal
    weapon.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    weapon.Anchored = true
    weapon.CanCollide = false
    weapon.Parent = model
    
    -- Позиционирование оружия
    weapon.Position = body.Position + Vector3.new(1.2, 0.3, 0)
    
    -- Лезвие топора
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.4, 0.6, 0.05)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192)
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = weapon
    
    blade.Position = weapon.Position + Vector3.new(0.3, 0.2, 0)
    
    -- Рукоять топора
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.1, 0.8, 0.1)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = weapon
    
    handle.Position = weapon.Position + Vector3.new(0, -0.4, 0)
    
    -- Броня орка
    local armor = Instance.new("Part")
    armor.Name = "Armor"
    armor.Size = Vector3.new(1.4, 2.2, 0.8)
    armor.Material = Enum.Material.Metal
    armor.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    armor.Transparency = 0.3
    armor.Anchored = true
    armor.CanCollide = false
    armor.Parent = model
    
    armor.Position = body.Position
    
    -- UI для орка
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3.5, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Орк"
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
    model:SetAttribute("EnemyType", "orc")
    model:SetAttribute("Health", 80)
    model:SetAttribute("MaxHealth", 80)
    model:SetAttribute("Damage", 25)
    model:SetAttribute("Speed", 6)
    model:SetAttribute("AttackRange", 4)
    model:SetAttribute("AttackCooldown", 2.5)
    model:SetAttribute("LootTable", "enemy_loot.orc")
    model:SetAttribute("IsSpecificEnemy", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateOrcModel