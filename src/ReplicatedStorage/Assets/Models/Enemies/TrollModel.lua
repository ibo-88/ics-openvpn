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
    body.Size = Vector3.new(1.5, 2.5, 0.8)
    body.Material = Enum.Material.Neon
    body.Color = Color3.fromRGB(128, 128, 128) -- Серый цвет тролля
    body.Anchored = true
    body.CanCollide = true
    body.Parent = model
    
    -- Голова тролля
    local head = Instance.new("Part")
    head.Name = "Head"
    head.Size = Vector3.new(1.2, 1.2, 1.2)
    head.Material = Enum.Material.Neon
    head.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    head.Anchored = true
    head.CanCollide = true
    head.Parent = model
    
    head.Position = body.Position + Vector3.new(0, 1.85, 0)
    
    -- Глаза тролля
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
        local xPos = (i == 1) and 0.3 or -0.3
        eye.Position = head.Position + Vector3.new(xPos, 0.2, 0.55)
        
        -- Свечение глаз
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 0, 0)
        pointLight.Range = 3
        pointLight.Brightness = 1.5
        pointLight.Parent = eye
    end
    
    -- Рот тролля
    local mouth = Instance.new("Part")
    mouth.Name = "Mouth"
    mouth.Size = Vector3.new(0.8, 0.3, 0.2)
    mouth.Material = Enum.Material.Neon
    mouth.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
    mouth.Anchored = true
    mouth.CanCollide = false
    mouth.Parent = head
    
    mouth.Position = head.Position + Vector3.new(0, -0.3, 0.55)
    
    -- Клыки тролля
    for i = 1, 4 do
        local fang = Instance.new("Part")
        fang.Name = "Fang" .. i
        fang.Size = Vector3.new(0.1, 0.2, 0.1)
        fang.Material = Enum.Material.Neon
        fang.Color = Color3.fromRGB(255, 255, 255) -- Белые клыки
        fang.Anchored = true
        fang.CanCollide = false
        fang.Parent = head
        
        -- Позиционирование клыков
        local xPos = (i <= 2) and 0.2 or -0.2
        local yPos = (i % 2 == 0) and -0.1 or -0.2
        fang.Position = mouth.Position + Vector3.new(xPos, yPos, 0.15)
    end
    
    -- Нос тролля
    local nose = Instance.new("Part")
    nose.Name = "Nose"
    nose.Size = Vector3.new(0.3, 0.2, 0.3)
    nose.Material = Enum.Material.Neon
    nose.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    nose.Anchored = true
    nose.CanCollide = false
    nose.Parent = head
    
    nose.Position = head.Position + Vector3.new(0, 0, 0.75)
    
    -- Уши тролля
    for i = 1, 2 do
        local ear = Instance.new("Part")
        ear.Name = "Ear" .. i
        ear.Size = Vector3.new(0.2, 0.4, 0.2)
        ear.Material = Enum.Material.Neon
        ear.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        ear.Anchored = true
        ear.CanCollide = false
        ear.Parent = head
        
        -- Позиционирование ушей
        local xPos = (i == 1) and 0.7 or -0.7
        ear.Position = head.Position + Vector3.new(xPos, 0.3, 0)
    end
    
    -- Руки тролля
    for i = 1, 2 do
        local arm = Instance.new("Part")
        arm.Name = "Arm" .. i
        arm.Size = Vector3.new(0.5, 1.5, 0.5)
        arm.Material = Enum.Material.Neon
        arm.Color = Color3.fromRGB(128, 128, 128)
        arm.Anchored = true
        arm.CanCollide = true
        arm.Parent = model
        
        -- Позиционирование рук
        local xPos = (i == 1) and 1 or -1
        arm.Position = body.Position + Vector3.new(xPos, 0.5, 0)
        
        -- Кисти тролля
        local hand = Instance.new("Part")
        hand.Name = "Hand" .. i
        hand.Size = Vector3.new(0.4, 0.4, 0.4)
        hand.Material = Enum.Material.Neon
        hand.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        hand.Anchored = true
        hand.CanCollide = true
        hand.Parent = model
        
        hand.Position = arm.Position + Vector3.new(0, -0.95, 0)
        
        -- Когти тролля
        for j = 1, 3 do
            local claw = Instance.new("Part")
            claw.Name = "Claw" .. i .. "_" .. j
            claw.Size = Vector3.new(0.05, 0.2, 0.05)
            claw.Material = Enum.Material.Neon
            claw.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
            claw.Anchored = true
            claw.CanCollide = false
            claw.Parent = model
            
            -- Позиционирование когтей
            local angle = (j - 2) * 30
            local radius = 0.2
            local xPos = math.cos(math.rad(angle)) * radius
            local zPos = math.sin(math.rad(angle)) * radius
            claw.Position = hand.Position + Vector3.new(xPos, -0.3, zPos)
        end
    end
    
    -- Ноги тролля
    for i = 1, 2 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.6, 1.2, 0.6)
        leg.Material = Enum.Material.Neon
        leg.Color = Color3.fromRGB(128, 128, 128)
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ног
        local xPos = (i == 1) and 0.4 or -0.4
        leg.Position = body.Position + Vector3.new(xPos, -1.85, 0)
        
        -- Стопы тролля
        local foot = Instance.new("Part")
        foot.Name = "Foot" .. i
        foot.Size = Vector3.new(0.8, 0.3, 0.8)
        foot.Material = Enum.Material.Neon
        foot.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        foot.Anchored = true
        foot.CanCollide = true
        foot.Parent = model
        
        foot.Position = leg.Position + Vector3.new(0, -0.75, 0)
    end
    
    -- Оружие тролля (дубина)
    local club = Instance.new("Part")
    club.Name = "Club"
    club.Size = Vector3.new(0.3, 2.5, 0.3)
    club.Material = Enum.Material.Wood
    club.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    club.Anchored = true
    club.CanCollide = false
    club.Parent = model
    
    club.Position = body.Position + Vector3.new(1.5, 0.5, 0)
    
    -- Голова дубины
    local clubHead = Instance.new("Part")
    clubHead.Name = "ClubHead"
    clubHead.Size = Vector3.new(0.8, 0.8, 0.8)
    clubHead.Material = Enum.Material.Rock
    clubHead.Color = Color3.fromRGB(105, 105, 105) -- Серый камень
    clubHead.Anchored = true
    clubHead.CanCollide = false
    clubHead.Parent = model
    
    clubHead.Position = club.Position + Vector3.new(0, 1.65, 0)
    
    -- Шипы на дубине
    for i = 1, 6 do
        local spike = Instance.new("Part")
        spike.Name = "ClubSpike" .. i
        spike.Size = Vector3.new(0.1, 0.3, 0.1)
        spike.Material = Enum.Material.Metal
        spike.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        spike.Anchored = true
        spike.CanCollide = false
        spike.Parent = model
        
        -- Позиционирование шипов
        local angle = (i - 1) * 60
        local radius = 0.4
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        spike.Position = clubHead.Position + Vector3.new(xPos, 0.55, zPos)
    end
    
    -- Броня тролля
    for i = 1, 4 do
        local armor = Instance.new("Part")
        armor.Name = "Armor" .. i
        armor.Size = Vector3.new(1.3, 0.4, 0.6)
        armor.Material = Enum.Material.Metal
        armor.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
        armor.Anchored = true
        armor.CanCollide = false
        armor.Parent = model
        
        -- Позиционирование брони
        local yPos = -0.5 + (i - 1) * 0.5
        armor.Position = body.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Наплечники тролля
    for i = 1, 2 do
        local pauldron = Instance.new("Part")
        pauldron.Name = "Pauldron" .. i
        pauldron.Size = Vector3.new(0.8, 0.6, 0.8)
        pauldron.Material = Enum.Material.Metal
        pauldron.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
        pauldron.Anchored = true
        pauldron.CanCollide = false
        pauldron.Parent = model
        
        -- Позиционирование наплечников
        local xPos = (i == 1) and 0.8 or -0.8
        pauldron.Position = body.Position + Vector3.new(xPos, 0.5, 0)
        
        -- Шипы на наплечниках
        for j = 1, 3 do
            local pauldronSpike = Instance.new("Part")
            pauldronSpike.Name = "PauldronSpike" .. i .. "_" .. j
            pauldronSpike.Size = Vector3.new(0.1, 0.2, 0.1)
            pauldronSpike.Material = Enum.Material.Metal
            pauldronSpike.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
            pauldronSpike.Anchored = true
            pauldronSpike.CanCollide = false
            pauldronSpike.Parent = model
            
            -- Позиционирование шипов наплечников
            local angle = (j - 2) * 45
            local radius = 0.3
            local spikeXPos = math.cos(math.rad(angle)) * radius
            local spikeZPos = math.sin(math.rad(angle)) * radius
            pauldronSpike.Position = pauldron.Position + Vector3.new(spikeXPos, 0.4, spikeZPos)
        end
    end
    
    -- Пояс тролля
    local belt = Instance.new("Part")
    belt.Name = "Belt"
    belt.Size = Vector3.new(1.6, 0.3, 0.8)
    belt.Material = Enum.Material.Leather
    belt.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    belt.Anchored = true
    belt.CanCollide = false
    belt.Parent = model
    
    belt.Position = body.Position + Vector3.new(0, -0.2, 0)
    
    -- Пряжка пояса
    local buckle = Instance.new("Part")
    buckle.Name = "BeltBuckle"
    buckle.Size = Vector3.new(0.3, 0.3, 0.1)
    buckle.Material = Enum.Material.Metal
    buckle.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    buckle.Anchored = true
    buckle.CanCollide = false
    buckle.Parent = model
    
    buckle.Position = belt.Position + Vector3.new(0, 0, 0.45)
    
    -- UI для тролля
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = head
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Тролль"
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
    healthFill.BackgroundColor3 = Color3.fromRGB(128, 128, 128) -- Серый
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("EnemyType", "troll")
    model:SetAttribute("Health", 120)
    model:SetAttribute("MaxHealth", 120)
    model:SetAttribute("Damage", 35)
    model:SetAttribute("Speed", 4)
    model:SetAttribute("AttackRange", 5)
    model:SetAttribute("AttackCooldown", 3)
    model:SetAttribute("LootTable", "enemy_loot.troll")
    model:SetAttribute("IsSpecificEnemy", true)
    model:SetAttribute("IsElite", false)
    model:SetAttribute("ExperienceReward", 40)
    model:SetAttribute("GoldReward", 20)
    model:SetAttribute("ClubDamage", 45)
    model:SetAttribute("ArmorValue", 15)
    model:SetAttribute("Regeneration", 2)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateTrollModel