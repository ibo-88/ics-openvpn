-- GoblinKingModel.lua
-- Модель короля гоблинов

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGoblinKingModel()
    local model = Instance.new("Model")
    model.Name = "GoblinKingModel"
    
    -- Тело короля гоблинов
    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(1.5, 2.2, 0.8)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(0, 100, 0) -- Очень темно-зеленый цвет
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Создание текстуры кожи
    local skinTexture = Instance.new("Texture")
    skinTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    skinTexture.StudsPerTileU = 1
    skinTexture.StudsPerTileV = 1
    skinTexture.Parent = body
    
    -- Голова короля гоблинов
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.2, 1.2, 1.2)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(0, 80, 0) -- Почти черный зеленый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    head.Position = body.Position + Vector3.new(0, 1.7, 0)
    
    -- Глаза короля (горящие красным)
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
        pointLight.Brightness = 3
        pointLight.Parent = eye
    end
    
    -- Корона короля
    local crown = Instance.new("Part")
    crown.Name = "Crown"
    crown.Size = Vector3.new(1.4, 0.6, 1.4)
    crown.Material = Enum.Material.Metal
    crown.Color = Color3.fromRGB(255, 215, 0) -- Золотая корона
    crown.Anchored = true
    crown.CanCollide = false
    crown.Parent = model
    
    crown.Position = head.Position + Vector3.new(0, 0.9, 0)
    
    -- Драгоценные камни на короне
    for i = 1, 5 do
        local gem = Instance.new("Part")
        gem.Name = "CrownGem" .. i
        gem.Size = Vector3.new(0.15, 0.15, 0.15)
        gem.Material = Enum.Material.Neon
        gem.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        gem.Anchored = true
        gem.CanCollide = false
        gem.Parent = crown
        
        -- Позиционирование камней
        local angle = (i - 1) * 72
        local radius = 0.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        gem.Position = crown.Position + Vector3.new(xPos, 0.4, zPos)
        
        -- Свечение камней
        local gemLight = Instance.new("PointLight")
        gemLight.Color = Color3.fromRGB(255, 0, 255)
        gemLight.Range = 2
        gemLight.Brightness = 1
        gemLight.Parent = gem
    end
    
    -- Большие рога короля
    for i = 1, 2 do
        local horn = Instance.new("Part")
        horn.Name = "Horn" .. i
        horn.Size = Vector3.new(0.15, 0.8, 0.15)
        horn.Material = Enum.Material.Metal
        horn.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        horn.Anchored = true
        horn.CanCollide = false
        horn.Parent = head
        
        -- Позиционирование рогов
        local xPos = (i == 1) and 0.4 or -0.4
        horn.Position = head.Position + Vector3.new(xPos, 0.8, 0)
        horn.Orientation = Vector3.new(0, 0, (i == 1) and 20 or -20)
    end
    
    -- Руки короля
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.5, 1.2, 0.5)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(0, 100, 0)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 1 or -1
        arm.Position = body.Position + Vector3.new(xPos, 0.2, 0)
    end
    
    -- Ноги короля
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.6, 1.2, 0.6)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(0, 100, 0)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.4 or -0.4
        leg.Position = body.Position + Vector3.new(xPos, -1.7, 0)
    end
    
    -- Королевский скипетр
    local scepter = Instance.new("Part")
    scepter.Name = "Scepter"
    scepter.Size = Vector3.new(0.15, 1.5, 0.15)
    scepter.Material = Enum.Material.Metal
    scepter.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    scepter.Anchored = true
    scepter.CanCollide = false
    scepter.Parent = model
    
    scepter.Position = body.Position + Vector3.new(1.5, 0.2, 0)
    
    -- Рукоять скипетра
    local scepterHandle = Instance.new("Part")
    scepterHandle.Name = "ScepterHandle"
    scepterHandle.Size = Vector3.new(0.2, 0.4, 0.2)
    scepterHandle.Material = Enum.Material.Metal
    scepterHandle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    scepterHandle.Anchored = true
    scepterHandle.CanCollide = false
    scepterHandle.Parent = scepter
    
    scepterHandle.Position = scepter.Position + Vector3.new(0, -0.95, 0)
    
    -- Драгоценный камень на скипетре
    local scepterGem = Instance.new("Part")
    scepterGem.Name = "ScepterGem"
    scepterGem.Size = Vector3.new(0.3, 0.3, 0.3)
    scepterGem.Material = Enum.Material.Neon
    scepterGem.Color = Color3.fromRGB(0, 255, 255) -- Голубой
    scepterGem.Anchored = true
    scepterGem.CanCollide = false
    scepterGem.Parent = scepter
    
    scepterGem.Position = scepter.Position + Vector3.new(0, 0.6, 0)
    
    -- Свечение камня скипетра
    local scepterGemLight = Instance.new("PointLight")
    scepterGemLight.Color = Color3.fromRGB(0, 255, 255)
    scepterGemLight.Range = 3
    scepterGemLight.Brightness = 2
    scepterGemLight.Parent = scepterGem
    
    -- Королевская броня
    for i = 1, 6 do
        local armorPlate = Instance.new("Part")
        armorPlate.Name = "RoyalArmorPlate" .. i
        armorPlate.Size = Vector3.new(1, 0.4, 0.15)
        armorPlate.Material = Enum.Material.Metal
        armorPlate.Color = Color3.fromRGB(255, 215, 0) -- Золотая броня
        armorPlate.Anchored = true
        armorPlate.CanCollide = false
        armorPlate.Parent = model
        
        -- Позиционирование брони
        local yPos = 0.2 + (i - 1) * 0.35
        local zPos = (i % 2 == 0) and 0.5 or -0.5
        armorPlate.Position = body.Position + Vector3.new(0, yPos, zPos)
    end
    
    -- Королевский нагрудник
    local royalChestplate = Instance.new("Part")
    royalChestplate.Name = "RoyalChestplate"
    royalChestplate.Size = Vector3.new(1.4, 1, 0.3)
    royalChestplate.Material = Enum.Material.Metal
    royalChestplate.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    royalChestplate.Anchored = true
    royalChestplate.CanCollide = false
    royalChestplate.Parent = model
    
    royalChestplate.Position = body.Position + Vector3.new(0, 0.4, 0.55)
    
    -- Королевский шлем
    local royalHelmet = Instance.new("Part")
    royalHelmet.Name = "RoyalHelmet"
    royalHelmet.Size = Vector3.new(1.3, 0.8, 1.3)
    royalHelmet.Material = Enum.Material.Metal
    royalHelmet.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    royalHelmet.Anchored = true
    royalHelmet.CanCollide = false
    royalHelmet.Parent = model
    
    royalHelmet.Position = head.Position + Vector3.new(0, 0.3, 0)
    
    -- Королевская мантия
    local cape = Instance.new("Part")
    cape.Name = "Cape"
    cape.Size = Vector3.new(2, 2.5, 0.1)
    cape.Material = Enum.Material.Neon
    cape.Color = Color3.fromRGB(128, 0, 128) -- Пурпурная мантия
    cape.Transparency = 0.3
    cape.Anchored = true
    cape.CanCollide = false
    cape.Parent = model
    
    cape.Position = body.Position + Vector3.new(0, 0.5, -0.9)
    
    -- Эффекты короля гоблинов
    local royalAura = Instance.new("Part")
    royalAura.Name = "RoyalAura"
    royalAura.Size = Vector3.new(4, 4, 4)
    royalAura.Material = Enum.Material.Neon
    royalAura.Color = Color3.fromRGB(255, 215, 0) -- Золотая аура
    royalAura.Transparency = 0.7
    royalAura.Anchored = true
    royalAura.CanCollide = false
    royalAura.Parent = model
    
    royalAura.Position = body.Position
    
    -- Свечение королевской ауры
    local royalAuraLight = Instance.new("PointLight")
    royalAuraLight.Color = Color3.fromRGB(255, 215, 0)
    royalAuraLight.Range = 8
    royalAuraLight.Brightness = 2
    royalAuraLight.Parent = royalAura
    
    -- UI для короля гоблинов
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 300, 0, 70)
    billboardGui.StudsOffset = Vector3.new(0, 5, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Король Гоблинов"
    nameLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Золотой текст
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
    healthFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Золотой
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("EnemyType", "goblin_king")
    model:SetAttribute("Health", 500)
    model:SetAttribute("MaxHealth", 500)
    model:SetAttribute("Damage", 60)
    model:SetAttribute("Speed", 5)
    model:SetAttribute("AttackRange", 6)
    model:SetAttribute("AttackCooldown", 2)
    model:SetAttribute("LootTable", "enemy_loot.goblin_king")
    model:SetAttribute("IsSpecificEnemy", true)
    model:SetAttribute("IsBoss", true)
    model:SetAttribute("IsElite", true)
    model:SetAttribute("ExperienceReward", 200)
    model:SetAttribute("GoldReward", 100)
    model:SetAttribute("SpecialAbility", "royal_command")
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateGoblinKingModel