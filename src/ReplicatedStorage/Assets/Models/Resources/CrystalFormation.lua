-- CrystalFormation.lua
-- Модель кристального образования

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateCrystalFormation()
    local model = Instance.new("Model")
    model.Name = "CrystalFormation"
    
    -- Основание кристалла
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(2, 1, 2)
    base.Material = Enum.Material.Rock
    base.Color = Color3.fromRGB(105, 105, 105) -- Серый камень
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Основной кристалл
    local mainCrystal = Instance.new("Part")
    mainCrystal.Name = "MainCrystal"
    mainCrystal.Size = Vector3.new(1, 4, 1)
    mainCrystal.Material = Enum.Material.Glass
    mainCrystal.Color = Color3.fromRGB(135, 206, 235) -- Голубой кристалл
    mainCrystal.Transparency = 0.2
    mainCrystal.Anchored = true
    mainCrystal.CanCollide = true
    mainCrystal.Parent = model
    
    mainCrystal.Position = base.Position + Vector3.new(0, 2.5, 0)
    
    -- Малые кристаллы вокруг основного
    for i = 1, 6 do
        local crystal = Instance.new("Part")
        crystal.Name = "Crystal" .. i
        crystal.Size = Vector3.new(0.5, 2, 0.5)
        crystal.Material = Enum.Material.Glass
        crystal.Color = Color3.fromRGB(100, 149, 237) -- Корнишон
        crystal.Transparency = 0.3
        crystal.Anchored = true
        crystal.CanCollide = true
        crystal.Parent = model
        
        -- Позиционирование кристаллов
        local angle = (i - 1) * 60
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crystal.Position = base.Position + Vector3.new(xPos, 1.5, zPos)
        
        -- Поворот кристаллов
        crystal.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Кристаллические осколки
    for i = 1, 12 do
        local shard = Instance.new("Part")
        shard.Name = "Shard" .. i
        shard.Size = Vector3.new(0.2, 0.8, 0.2)
        shard.Material = Enum.Material.Glass
        shard.Color = Color3.fromRGB(135, 206, 235)
        shard.Transparency = 0.4
        shard.Anchored = true
        shard.CanCollide = false
        shard.Parent = model
        
        -- Позиционирование осколков
        local angle = (i - 1) * 30
        local radius = 2.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        shard.Position = base.Position + Vector3.new(xPos, 0.5, zPos)
        
        -- Случайный поворот
        shard.Orientation = Vector3.new(math.random(-30, 30), angle, math.random(-30, 30))
    end
    
    -- Магические руны на основании
    for i = 1, 4 do
        local rune = Instance.new("Part")
        rune.Name = "Rune" .. i
        rune.Size = Vector3.new(0.3, 0.3, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 255) -- Белый свет
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = base
        
        -- Позиционирование рун
        local angle = (i - 1) * 90
        local radius = 0.7
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = base.Position + Vector3.new(xPos, 0.55, zPos)
        
        -- Свечение рун
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 255, 255)
        pointLight.Range = 2
        pointLight.Brightness = 1
        pointLight.Parent = rune
    end
    
    -- Магический барьер
    local barrier = Instance.new("Part")
    barrier.Name = "MagicBarrier"
    barrier.Size = Vector3.new(3, 6, 3)
    barrier.Position = base.Position + Vector3.new(0, 3, 0)
    barrier.Material = Enum.Material.ForceField
    barrier.Color = Color3.fromRGB(0, 191, 255) -- Глубокий небесно-голубой
    barrier.Transparency = 0.8
    barrier.Anchored = true
    barrier.CanCollide = false
    barrier.Parent = model
    
    -- Частицы магии
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(135, 206, 235))
    particleEmitter.Size = NumberSequence.new(0.2, 0)
    particleEmitter.Speed = NumberRange.new(2, 6)
    particleEmitter.Rate = 10
    particleEmitter.Lifetime = NumberRange.new(3, 6)
    particleEmitter.Parent = mainCrystal
    
    -- UI для кристального образования
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 5, 0)
    billboardGui.Parent = mainCrystal
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Кристальное образование"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local resourceBar = Instance.new("Frame")
    resourceBar.Size = UDim2.new(0.8, 0, 0.3, 0)
    resourceBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    resourceBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    resourceBar.BorderSizePixel = 0
    resourceBar.Parent = billboardGui
    
    local resourceFill = Instance.new("Frame")
    resourceFill.Size = UDim2.new(1, 0, 1, 0)
    resourceFill.Position = UDim2.new(0, 0, 0, 0)
    resourceFill.BackgroundColor3 = Color3.fromRGB(0, 191, 255) -- Голубой
    resourceFill.BorderSizePixel = 0
    resourceFill.Parent = resourceBar
    
    -- Установка атрибутов
    model:SetAttribute("ResourceType", "crystal")
    model:SetAttribute("ResourceAmount", 50)
    model:SetAttribute("MaxResourceAmount", 50)
    model:SetAttribute("RespawnTime", 60)
    model:SetAttribute("ResourceQuality", "rare")
    model:SetAttribute("LootTable", "resource_loot.crystal_formation")
    model:SetAttribute("MagicResistance", 25)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("ResourceBar", resourceBar)
    model:SetAttribute("ResourceFill", resourceFill)
    
    return model
end

return CreateCrystalFormation