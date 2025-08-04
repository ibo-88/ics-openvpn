-- GoldVein.lua
-- Модель золотой жилы

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateGoldVein()
    local model = Instance.new("Model")
    model.Name = "GoldVein"
    
    -- Основание жилы
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(2.5, 1, 2.5)
    base.Material = Enum.Material.Rock
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый камень
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры камня
    local stoneTexture = Instance.new("Texture")
    stoneTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    stoneTexture.StudsPerTileU = 2
    stoneTexture.StudsPerTileV = 1
    stoneTexture.Parent = base
    
    -- Основная масса жилы
    local mainVein = Instance.new("Part")
    mainVein.Name = "MainVein"
    mainVein.Size = Vector3.new(2, 3, 2)
    mainVein.Material = Enum.Material.Rock
    mainVein.Color = Color3.fromRGB(128, 128, 128) -- Серый камень
    mainVein.Anchored = true
    mainVein.CanCollide = true
    mainVein.Parent = model
    
    mainVein.Position = base.Position + Vector3.new(0, 2, 0)
    
    -- Золотые прожилки
    for i = 1, 8 do
        local vein = Instance.new("Part")
        vein.Name = "GoldVein" .. i
        vein.Size = Vector3.new(0.3, 2.5, 0.3)
        vein.Material = Enum.Material.Metal
        vein.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        vein.Anchored = true
        vein.CanCollide = false
        vein.Parent = model
        
        -- Позиционирование прожилок
        local angle = (i - 1) * 45
        local radius = 0.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        vein.Position = base.Position + Vector3.new(xPos, 2, zPos)
        vein.Orientation = Vector3.new(0, angle, 0)
        
        -- Свечение золотых прожилок
        local veinLight = Instance.new("PointLight")
        veinLight.Color = Color3.fromRGB(255, 215, 0)
        veinLight.Range = 2
        veinLight.Brightness = 1
        veinLight.Parent = vein
    end
    
    -- Золотые самородки
    for i = 1, 6 do
        local nugget = Instance.new("Part")
        nugget.Name = "GoldNugget" .. i
        nugget.Size = Vector3.new(0.4, 0.4, 0.4)
        nugget.Material = Enum.Material.Metal
        nugget.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        nugget.Anchored = true
        nugget.CanCollide = false
        nugget.Parent = model
        
        -- Позиционирование самородков
        local angle = (i - 1) * 60
        local radius = 0.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 1 + (i % 3) * 0.8
        nugget.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение самородков
        local nuggetLight = Instance.new("PointLight")
        nuggetLight.Color = Color3.fromRGB(255, 215, 0)
        nuggetLight.Range = 1.5
        nuggetLight.Brightness = 0.8
        nuggetLight.Parent = nugget
    end
    
    -- Золотые кристаллы
    for i = 1, 4 do
        local crystal = Instance.new("Part")
        crystal.Name = "GoldCrystal" .. i
        crystal.Size = Vector3.new(0.2, 0.6, 0.2)
        crystal.Material = Enum.Material.Metal
        crystal.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        crystal.Anchored = true
        crystal.CanCollide = false
        crystal.Parent = model
        
        -- Позиционирование кристаллов
        local angle = (i - 1) * 90
        local radius = 0.7
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crystal.Position = base.Position + Vector3.new(xPos, 3.5, zPos)
        crystal.Orientation = Vector3.new(0, angle, 0)
        
        -- Свечение кристаллов
        local crystalLight = Instance.new("PointLight")
        crystalLight.Color = Color3.fromRGB(255, 215, 0)
        crystalLight.Range = 1
        crystalLight.Brightness = 0.6
        crystalLight.Parent = crystal
    end
    
    -- Каменные осколки
    for i = 1, 10 do
        local shard = Instance.new("Part")
        shard.Name = "RockShard" .. i
        shard.Size = Vector3.new(0.3, 0.6, 0.3)
        shard.Material = Enum.Material.Rock
        shard.Color = Color3.fromRGB(128, 128, 128) -- Серый
        shard.Anchored = true
        shard.CanCollide = false
        shard.Parent = model
        
        -- Позиционирование осколков
        local angle = (i - 1) * 36
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 0.3 + (i % 4) * 0.4
        shard.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        shard.Orientation = Vector3.new(math.random(-30, 30), angle, math.random(-30, 30))
    end
    
    -- Трещины в камне
    for i = 1, 3 do
        local crack = Instance.new("Part")
        crack.Name = "Crack" .. i
        crack.Size = Vector3.new(0.1, 2.5, 0.1)
        crack.Material = Enum.Material.Rock
        crack.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        crack.Anchored = true
        crack.CanCollide = false
        crack.Parent = model
        
        -- Позиционирование трещин
        local angle = (i - 1) * 120
        local radius = 0.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crack.Position = base.Position + Vector3.new(xPos, 2, zPos)
        crack.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Золотая пыль (частицы)
    for i = 1, 12 do
        local dust = Instance.new("Part")
        dust.Name = "GoldDust" .. i
        dust.Size = Vector3.new(0.1, 0.1, 0.1)
        dust.Material = Enum.Material.Metal
        dust.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        dust.Anchored = true
        dust.CanCollide = false
        dust.Parent = model
        
        -- Позиционирование пыли
        local angle = (i - 1) * 30
        local radius = 1.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 0.1 + (i % 3) * 0.2
        dust.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Слабое свечение пыли
        local dustLight = Instance.new("PointLight")
        dustLight.Color = Color3.fromRGB(255, 215, 0)
        dustLight.Range = 0.5
        dustLight.Brightness = 0.3
        dustLight.Parent = dust
    end
    
    -- Минеральные включения
    for i = 1, 5 do
        local inclusion = Instance.new("Part")
        inclusion.Name = "MineralInclusion" .. i
        inclusion.Size = Vector3.new(0.2, 0.2, 0.2)
        inclusion.Material = Enum.Material.Metal
        inclusion.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        inclusion.Anchored = true
        inclusion.CanCollide = false
        inclusion.Parent = model
        
        -- Позиционирование включений
        local angle = (i - 1) * 72
        local radius = 0.9
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 1.5 + (i % 2) * 1.2
        inclusion.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение включений
        local inclusionLight = Instance.new("PointLight")
        inclusionLight.Color = Color3.fromRGB(192, 192, 192)
        inclusionLight.Range = 0.8
        inclusionLight.Brightness = 0.4
        inclusionLight.Parent = inclusion
    end
    
    -- UI для золотой жилы
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 4, 0)
    billboardGui.Parent = mainVein
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Золотая жила"
    nameLabel.TextColor3 = Color3.fromRGB(255, 215, 0) -- Золотой текст
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
    resourceFill.BackgroundColor3 = Color3.fromRGB(255, 215, 0) -- Золотой
    resourceFill.BorderSizePixel = 0
    resourceFill.Parent = resourceBar
    
    -- Установка атрибутов
    model:SetAttribute("ResourceType", "gold")
    model:SetAttribute("ResourceAmount", 75)
    model:SetAttribute("MaxResourceAmount", 75)
    model:SetAttribute("RespawnTime", 90)
    model:SetAttribute("ResourceQuality", "rare")
    model:SetAttribute("LootTable", "resource_loot.gold_vein")
    model:SetAttribute("MiningDifficulty", 3)
    model:SetAttribute("GoldVeins", 8)
    model:SetAttribute("GoldNuggets", 6)
    model:SetAttribute("GoldCrystals", 4)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("ResourceBar", resourceBar)
    model:SetAttribute("ResourceFill", resourceFill)
    
    return model
end

return CreateGoldVein