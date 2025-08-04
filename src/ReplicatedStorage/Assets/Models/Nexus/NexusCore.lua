-- NexusCore.lua
-- Модель ядра Nexus

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateNexusCore()
    local model = Instance.new("Model")
    model.Name = "NexusCore"
    
    -- Основное ядро Nexus
    local core = Instance.new("Part")
    core.Name = "Core"
    core.Size = Vector3.new(4, 6, 4)
    core.Material = Enum.Material.Neon
    core.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    core.Anchored = true
    core.CanCollide = true
    core.Parent = model
    
    -- Создание текстуры ядра
    local coreTexture = Instance.new("Texture")
    coreTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    coreTexture.StudsPerTileU = 2
    coreTexture.StudsPerTileV = 3
    coreTexture.Parent = core
    
    -- Центральное ядро
    local centerCore = Instance.new("Part")
    centerCore.Name = "CenterCore"
    centerCore.Size = Vector3.new(2, 4, 2)
    centerCore.Material = Enum.Material.Neon
    centerCore.Color = Color3.fromRGB(255, 255, 0) -- Золотой
    centerCore.Anchored = true
    centerCore.CanCollide = false
    centerCore.Parent = model
    
    centerCore.Position = core.Position + Vector3.new(0, 0, 0)
    
    -- Свечение центрального ядра
    local centerLight = Instance.new("PointLight")
    centerLight.Color = Color3.fromRGB(255, 255, 0)
    centerLight.Range = 15
    centerLight.Brightness = 5
    centerLight.Parent = centerCore
    
    -- Вращающиеся кольца энергии
    for i = 1, 5 do
        local energyRing = Instance.new("Part")
        energyRing.Name = "EnergyRing" .. i
        energyRing.Size = Vector3.new(6 + i * 0.5, 0.3, 6 + i * 0.5)
        energyRing.Material = Enum.Material.Neon
        energyRing.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        energyRing.Transparency = 0.3
        energyRing.Anchored = true
        energyRing.CanCollide = false
        energyRing.Parent = model
        
        -- Позиционирование колец
        local yPos = -2 + (i - 1) * 1.5
        energyRing.Position = core.Position + Vector3.new(0, yPos, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(0, 255, 255)
        ringLight.Range = 8 + i
        ringLight.Brightness = 2
        ringLight.Parent = energyRing
    end
    
    -- Магические кристаллы вокруг ядра
    for i = 1, 8 do
        local crystal = Instance.new("Part")
        crystal.Name = "MagicCrystal" .. i
        crystal.Size = Vector3.new(0.8, 1.5, 0.8)
        crystal.Material = Enum.Material.Neon
        crystal.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        crystal.Anchored = true
        crystal.CanCollide = false
        crystal.Parent = model
        
        -- Позиционирование кристаллов
        local angle = (i - 1) * 45
        local radius = 4
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = -1 + (i % 3) * 2
        crystal.Position = core.Position + Vector3.new(xPos, yPos, zPos)
        crystal.Orientation = Vector3.new(0, angle, 0)
        
        -- Свечение кристаллов
        local crystalLight = Instance.new("PointLight")
        crystalLight.Color = Color3.fromRGB(255, 0, 255)
        crystalLight.Range = 4
        crystalLight.Brightness = 3
        crystalLight.Parent = crystal
    end
    
    -- Защитные руны
    for i = 1, 12 do
        local rune = Instance.new("Part")
        rune.Name = "ProtectionRune" .. i
        rune.Size = Vector3.new(1, 1, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 30
        local radius = 3.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = -2 + (i % 4) * 2
        rune.Position = core.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 3
        runeLight.Brightness = 2
        runeLight.Parent = rune
    end
    
    -- Энергетические столбы
    for i = 1, 4 do
        local pillar = Instance.new("Part")
        pillar.Name = "EnergyPillar" .. i
        pillar.Size = Vector3.new(0.8, 8, 0.8)
        pillar.Material = Enum.Material.Neon
        pillar.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
        pillar.Anchored = true
        pillar.CanCollide = true
        pillar.Parent = model
        
        -- Позиционирование столбов
        local angle = (i - 1) * 90
        local radius = 5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        pillar.Position = core.Position + Vector3.new(xPos, 1, zPos)
        
        -- Свечение столбов
        local pillarLight = Instance.new("PointLight")
        pillarLight.Color = Color3.fromRGB(0, 255, 0)
        pillarLight.Range = 6
        pillarLight.Brightness = 2
        pillarLight.Parent = pillar
    end
    
    -- Защитный купол
    local shield = Instance.new("Part")
    shield.Name = "ProtectionShield"
    shield.Size = Vector3.new(12, 10, 12)
    shield.Material = Enum.Material.Glass
    shield.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    shield.Transparency = 0.7
    shield.Anchored = true
    shield.CanCollide = false
    shield.Parent = model
    
    shield.Position = core.Position + Vector3.new(0, 0, 0)
    
    -- Свечение купола
    local shieldLight = Instance.new("PointLight")
    shieldLight.Color = Color3.fromRGB(255, 0, 255)
    shieldLight.Range = 12
    shieldLight.Brightness = 1
    shieldLight.Parent = shield
    
    -- Парящие частицы энергии
    for i = 1, 20 do
        local particle = Instance.new("Part")
        particle.Name = "EnergyParticle" .. i
        particle.Size = Vector3.new(0.2, 0.2, 0.2)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-6, 6)
        local yPos = math.random(-3, 5)
        local zPos = math.random(-6, 6)
        particle.Position = core.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 255, 255)
        particleLight.Range = 1
        particleLight.Brightness = 1
        particleLight.Parent = particle
    end
    
    -- Основание Nexus
    local base = Instance.new("Part")
    base.Name = "NexusBase"
    base.Size = Vector3.new(8, 2, 8)
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    base.Position = core.Position + Vector3.new(0, -4, 0)
    
    -- Декоративные элементы основания
    for i = 1, 8 do
        local decoration = Instance.new("Part")
        decoration.Name = "BaseDecoration" .. i
        decoration.Size = Vector3.new(1, 0.5, 1)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local angle = (i - 1) * 45
        local radius = 3.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        decoration.Position = base.Position + Vector3.new(xPos, 1.25, zPos)
    end
    
    -- UI для Nexus Core
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 300, 0, 80)
    billboardGui.StudsOffset = Vector3.new(0, 8, 0)
    billboardGui.Parent = core
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.4, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "NEXUS CORE"
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
    statusLabel.Text = "ЗАЩИЩЕН"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("NexusType", "core")
    model:SetAttribute("Health", 5000)
    model:SetAttribute("MaxHealth", 5000)
    model:SetAttribute("EnergyLevel", 100)
    model:SetAttribute("MaxEnergyLevel", 100)
    model:SetAttribute("ShieldActive", true)
    model:SetAttribute("ProtectionLevel", 100)
    model:SetAttribute("IsNexus", true)
    model:SetAttribute("CoreActive", true)
    model:SetAttribute("EnergyRings", 5)
    model:SetAttribute("MagicCrystals", 8)
    model:SetAttribute("ProtectionRunes", 12)
    model:SetAttribute("EnergyPillars", 4)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateNexusCore