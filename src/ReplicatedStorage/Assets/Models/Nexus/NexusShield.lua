-- NexusShield.lua
-- Модель щита Nexus

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateNexusShield()
    local model = Instance.new("Model")
    model.Name = "NexusShield"
    
    -- Основной щит
    local shield = Instance.new("Part")
    shield.Name = "Shield"
    shield.Size = Vector3.new(8, 12, 1)
    shield.Material = Enum.Material.Glass
    shield.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    shield.Transparency = 0.6
    shield.Anchored = true
    shield.CanCollide = false
    shield.Parent = model
    
    -- Создание текстуры щита
    local shieldTexture = Instance.new("Texture")
    shieldTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    shieldTexture.StudsPerTileU = 4
    shieldTexture.StudsPerTileV = 6
    shieldTexture.Parent = shield
    
    -- Внутренний слой щита
    local innerShield = Instance.new("Part")
    innerShield.Name = "InnerShield"
    innerShield.Size = Vector3.new(7.5, 11.5, 0.8)
    innerShield.Material = Enum.Material.Glass
    innerShield.Color = Color3.fromRGB(0, 255, 255) -- Голубой
    innerShield.Transparency = 0.7
    innerShield.Anchored = true
    innerShield.CanCollide = false
    innerShield.Parent = model
    
    innerShield.Position = shield.Position + Vector3.new(0, 0, 0.1)
    
    -- Защитные руны на щите
    for i = 1, 16 do
        local rune = Instance.new("Part")
        rune.Name = "ShieldRune" .. i
        rune.Size = Vector3.new(0.8, 0.8, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун по кругу
        local angle = (i - 1) * 22.5
        local radius = 3.5
        local xPos = math.cos(math.rad(angle)) * radius
        local yPos = math.sin(math.rad(angle)) * radius
        rune.Position = shield.Position + Vector3.new(xPos, yPos, 0.6)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 3
        runeLight.Brightness = 2
        runeLight.Parent = rune
    end
    
    -- Центральный кристалл щита
    local centerCrystal = Instance.new("Part")
    centerCrystal.Name = "CenterCrystal"
    centerCrystal.Size = Vector3.new(1.5, 1.5, 1.5)
    centerCrystal.Material = Enum.Material.Neon
    centerCrystal.Color = Color3.fromRGB(255, 255, 0) -- Золотой
    centerCrystal.Anchored = true
    centerCrystal.CanCollide = false
    centerCrystal.Parent = model
    
    centerCrystal.Position = shield.Position + Vector3.new(0, 0, 0.8)
    
    -- Свечение центрального кристалла
    local centerLight = Instance.new("PointLight")
    centerLight.Color = Color3.fromRGB(255, 255, 0)
    centerLight.Range = 8
    centerLight.Brightness = 4
    centerLight.Parent = centerCrystal
    
    -- Энергетические кольца щита
    for i = 1, 4 do
        local energyRing = Instance.new("Part")
        energyRing.Name = "EnergyRing" .. i
        energyRing.Size = Vector3.new(6 + i * 0.5, 0.2, 6 + i * 0.5)
        energyRing.Material = Enum.Material.Neon
        energyRing.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        energyRing.Transparency = 0.4
        energyRing.Anchored = true
        energyRing.CanCollide = false
        energyRing.Parent = model
        
        -- Позиционирование колец
        local yPos = -2 + (i - 1) * 2
        energyRing.Position = shield.Position + Vector3.new(0, yPos, 0.5)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(0, 255, 255)
        ringLight.Range = 6 + i
        ringLight.Brightness = 1.5
        ringLight.Parent = energyRing
    end
    
    -- Защитные столбы вокруг щита
    for i = 1, 8 do
        local pillar = Instance.new("Part")
        pillar.Name = "ShieldPillar" .. i
        pillar.Size = Vector3.new(0.6, 10, 0.6)
        pillar.Material = Enum.Material.Neon
        pillar.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
        pillar.Anchored = true
        pillar.CanCollide = true
        pillar.Parent = model
        
        -- Позиционирование столбов
        local angle = (i - 1) * 45
        local radius = 6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        pillar.Position = shield.Position + Vector3.new(xPos, 1, zPos)
        
        -- Свечение столбов
        local pillarLight = Instance.new("PointLight")
        pillarLight.Color = Color3.fromRGB(0, 255, 0)
        pillarLight.Range = 4
        pillarLight.Brightness = 1.5
        pillarLight.Parent = pillar
    end
    
    -- Магические частицы щита
    for i = 1, 30 do
        local particle = Instance.new("Part")
        particle.Name = "ShieldParticle" .. i
        particle.Size = Vector3.new(0.2, 0.2, 0.2)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local angle = math.random(0, 360)
        local radius = math.random(2, 7)
        local xPos = math.cos(math.rad(angle)) * radius
        local yPos = math.random(-5, 5)
        local zPos = math.sin(math.rad(angle)) * radius
        particle.Position = shield.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 255, 255)
        particleLight.Range = 1
        particleLight.Brightness = 0.8
        particleLight.Parent = particle
    end
    
    -- Основание щита
    local base = Instance.new("Part")
    base.Name = "ShieldBase"
    base.Size = Vector3.new(10, 2, 10)
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    base.Position = shield.Position + Vector3.new(0, -7, 0)
    
    -- Декоративные элементы основания
    for i = 1, 12 do
        local decoration = Instance.new("Part")
        decoration.Name = "BaseDecoration" .. i
        decoration.Size = Vector3.new(1, 0.5, 1)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local angle = (i - 1) * 30
        local radius = 4
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = base.Position + Vector3.new(xPos, 1.25, zPos)
    end
    
    -- Энергетические каналы
    for i = 1, 6 do
        local channel = Instance.new("Part")
        channel.Name = "EnergyChannel" .. i
        channel.Size = Vector3.new(0.3, 8, 0.3)
        channel.Material = Enum.Material.Neon
        channel.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        channel.Anchored = true
        channel.CanCollide = false
        channel.Parent = model
        
        -- Позиционирование каналов
        local angle = (i - 1) * 60
        local radius = 4.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        channel.Position = shield.Position + Vector3.new(xPos, -1, zPos)
        
        -- Свечение каналов
        local channelLight = Instance.new("PointLight")
        channelLight.Color = Color3.fromRGB(255, 0, 255)
        channelLight.Range = 3
        channelLight.Brightness = 1
        channelLight.Parent = channel
    end
    
    -- Защитные сферы
    for i = 1, 4 do
        local sphere = Instance.new("Part")
        sphere.Name = "ProtectionSphere" .. i
        sphere.Size = Vector3.new(2, 2, 2)
        sphere.Material = Enum.Material.Glass
        sphere.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        sphere.Transparency = 0.6
        sphere.Anchored = true
        sphere.CanCollide = false
        sphere.Parent = model
        
        -- Позиционирование сфер
        local angle = (i - 1) * 90
        local radius = 5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        sphere.Position = shield.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение сфер
        local sphereLight = Instance.new("PointLight")
        sphereLight.Color = Color3.fromRGB(0, 255, 255)
        sphereLight.Range = 4
        sphereLight.Brightness = 1.5
        sphereLight.Parent = sphere
    end
    
    -- UI для щита Nexus
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 400, 0, 80)
    billboardGui.StudsOffset = Vector3.new(0, 8, 0)
    billboardGui.Parent = shield
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "NEXUS SHIELD"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Золотой текст
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(0.8, 0, 0.3, 0)
    healthBar.Position = UDim2.new(0.1, 0, 0.5, 0)
    healthBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = billboardGui
    
    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.Position = UDim2.new(0, 0, 0, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Золотой
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.3, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.8, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "АКТИВЕН"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("NexusType", "shield")
    model:SetAttribute("Health", 3000)
    model:SetAttribute("MaxHealth", 3000)
    model:SetAttribute("ShieldActive", true)
    model:SetAttribute("ProtectionLevel", 100)
    model:SetAttribute("IsNexus", true)
    model:SetAttribute("ShieldRunes", 16)
    model:SetAttribute("EnergyRings", 4)
    model:SetAttribute("ShieldPillars", 8)
    model:SetAttribute("ShieldParticles", 30)
    model:SetAttribute("EnergyChannels", 6)
    model:SetAttribute("ProtectionSpheres", 4)
    model:SetAttribute("CenterCrystal", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateNexusShield