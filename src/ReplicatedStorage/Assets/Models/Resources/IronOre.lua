-- IronOre.lua
-- Модель железной руды

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIronOre()
    local model = Instance.new("Model")
    model.Name = "IronOre"
    
    -- Основная руда
    local ore = Instance.new("Part")
    ore.Name = "IronOre"
    ore.Size = Vector3.new(2, 1.5, 2)
    ore.Material = Enum.Material.Rock
    ore.Color = Color3.fromRGB(105, 105, 105) -- Серый камень
    ore.Anchored = true
    ore.CanCollide = true
    ore.Parent = model
    
    -- Создание текстуры руды
    local oreTexture = Instance.new("Texture")
    oreTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    oreTexture.StudsPerTileU = 2
    oreTexture.StudsPerTileV = 1.5
    oreTexture.Parent = ore
    
    -- Железные прожилки в руде
    for i = 1, 8 do
        local vein = Instance.new("Part")
        vein.Name = "IronVein" .. i
        vein.Size = Vector3.new(0.1, 0.8, 0.1)
        vein.Material = Enum.Material.Metal
        vein.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        vein.Anchored = true
        vein.CanCollide = false
        vein.Parent = model
        
        -- Позиционирование прожилок
        local angle = (i - 1) * 45
        local radius = 0.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = math.random(-0.3, 0.3)
        vein.Position = ore.Position + Vector3.new(xPos, yPos, zPos)
        vein.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Железные вкрапления
    for i = 1, 12 do
        local speck = Instance.new("Part")
        speck.Name = "IronSpeck" .. i
        speck.Size = Vector3.new(0.2, 0.2, 0.2)
        speck.Material = Enum.Material.Metal
        speck.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        speck.Anchored = true
        speck.CanCollide = false
        speck.Parent = model
        
        -- Случайное позиционирование вкраплений
        local xPos = math.random(-0.8, 0.8)
        local yPos = math.random(-0.5, 0.5)
        local zPos = math.random(-0.8, 0.8)
        speck.Position = ore.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Кристаллы железа
    for i = 1, 6 do
        local crystal = Instance.new("Part")
        crystal.Name = "IronCrystal" .. i
        crystal.Size = Vector3.new(0.3, 0.4, 0.3)
        crystal.Material = Enum.Material.Metal
        crystal.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        crystal.Anchored = true
        crystal.CanCollide = false
        crystal.Parent = model
        
        -- Позиционирование кристаллов
        local angle = (i - 1) * 60
        local radius = 0.9
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crystal.Position = ore.Position + Vector3.new(xPos, 0.95, zPos)
        crystal.Orientation = Vector3.new(0, angle, 0)
        
        -- Свечение кристаллов
        local crystalLight = Instance.new("PointLight")
        crystalLight.Color = Color3.fromRGB(192, 192, 192)
        crystalLight.Range = 1.5
        crystalLight.Brightness = 0.8
        crystalLight.Parent = crystal
    end
    
    -- Трещины в руде
    for i = 1, 5 do
        local crack = Instance.new("Part")
        crack.Name = "OreCrack" .. i
        crack.Size = Vector3.new(0.05, 0.8, 0.05)
        crack.Material = Enum.Material.Rock
        crack.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
        crack.Anchored = true
        crack.CanCollide = false
        crack.Parent = model
        
        -- Позиционирование трещин
        local angle = (i - 1) * 72
        local radius = 0.6
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crack.Position = ore.Position + Vector3.new(xPos, 0, zPos)
        crack.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Железные самородки
    for i = 1, 4 do
        local nugget = Instance.new("Part")
        nugget.Name = "IronNugget" .. i
        nugget.Size = Vector3.new(0.4, 0.3, 0.4)
        nugget.Material = Enum.Material.Metal
        nugget.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        nugget.Anchored = true
        nugget.CanCollide = false
        nugget.Parent = model
        
        -- Позиционирование самородков
        local angle = (i - 1) * 90
        local radius = 0.7
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        nugget.Position = ore.Position + Vector3.new(xPos, 0.9, zPos)
        
        -- Свечение самородков
        local nuggetLight = Instance.new("PointLight")
        nuggetLight.Color = Color3.fromRGB(192, 192, 192)
        nuggetLight.Range = 1
        nuggetLight.Brightness = 0.6
        nuggetLight.Parent = nugget
    end
    
    -- Ржавые пятна
    for i = 1, 8 do
        local rust = Instance.new("Part")
        rust.Name = "RustSpot" .. i
        rust.Size = Vector3.new(0.3, 0.1, 0.3)
        rust.Material = Enum.Material.Rock
        rust.Color = Color3.fromRGB(139, 69, 19) -- Коричневый ржавчина
        rust.Anchored = true
        rust.CanCollide = false
        rust.Parent = model
        
        -- Случайное позиционирование ржавых пятен
        local xPos = math.random(-0.7, 0.7)
        local yPos = math.random(-0.6, 0.6)
        local zPos = math.random(-0.7, 0.7)
        rust.Position = ore.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Минеральные включения
    for i = 1, 10 do
        local inclusion = Instance.new("Part")
        inclusion.Name = "MineralInclusion" .. i
        inclusion.Size = Vector3.new(0.15, 0.15, 0.15)
        inclusion.Material = Enum.Material.Neon
        inclusion.Color = Color3.fromRGB(255, 255, 0) -- Желтый минерал
        inclusion.Anchored = true
        inclusion.CanCollide = false
        inclusion.Parent = model
        
        -- Случайное позиционирование включений
        local xPos = math.random(-0.8, 0.8)
        local yPos = math.random(-0.5, 0.5)
        local zPos = math.random(-0.8, 0.8)
        inclusion.Position = ore.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение включений
        local inclusionLight = Instance.new("PointLight")
        inclusionLight.Color = Color3.fromRGB(255, 255, 0)
        inclusionLight.Range = 0.8
        inclusionLight.Brightness = 0.5
        inclusionLight.Parent = inclusion
    end
    
    -- Основание руды
    local base = Instance.new("Part")
    base.Name = "OreBase"
    base.Size = Vector3.new(2.5, 0.5, 2.5)
    base.Material = Enum.Material.Rock
    base.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    base.Position = ore.Position + Vector3.new(0, -1, 0)
    
    -- Осколки руды вокруг
    for i = 1, 6 do
        local fragment = Instance.new("Part")
        fragment.Name = "OreFragment" .. i
        fragment.Size = Vector3.new(0.4, 0.3, 0.4)
        fragment.Material = Enum.Material.Rock
        fragment.Color = Color3.fromRGB(105, 105, 105) -- Серый
        fragment.Anchored = true
        fragment.CanCollide = true
        fragment.Parent = model
        
        -- Позиционирование осколков
        local angle = (i - 1) * 60
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        fragment.Position = ore.Position + Vector3.new(xPos, -0.85, zPos)
    end
    
    -- Магические частицы железа
    for i = 1, 15 do
        local particle = Instance.new("Part")
        particle.Name = "IronParticle" .. i
        particle.Size = Vector3.new(0.05, 0.05, 0.05)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-1.5, 1.5)
        local yPos = math.random(0, 2)
        local zPos = math.random(-1.5, 1.5)
        particle.Position = ore.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.5
        particleLight.Brightness = 0.4
        particleLight.Parent = particle
    end
    
    -- UI для железной руды
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = ore
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Железная руда"
    nameLabel.TextColor3 = Color3.fromRGB(192, 192, 192) -- Серебряный текст
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
    resourceFill.BackgroundColor3 = Color3.fromRGB(192, 192, 192) -- Серебряный
    resourceFill.BorderSizePixel = 0
    resourceFill.Parent = resourceBar
    
    -- Установка атрибутов
    model:SetAttribute("ResourceType", "iron")
    model:SetAttribute("ResourceAmount", 150)
    model:SetAttribute("MaxResourceAmount", 150)
    model:SetAttribute("RespawnTime", 60)
    model:SetAttribute("ResourceQuality", "uncommon")
    model:SetAttribute("LootTable", "resource_loot.iron_ore")
    model:SetAttribute("MiningDifficulty", 2)
    model:SetAttribute("IronVeins", 8)
    model:SetAttribute("IronSpecks", 12)
    model:SetAttribute("IronCrystals", 6)
    model:SetAttribute("OreCracks", 5)
    model:SetAttribute("IronNuggets", 4)
    model:SetAttribute("RustSpots", 8)
    model:SetAttribute("MineralInclusions", 10)
    model:SetAttribute("OreFragments", 6)
    model:SetAttribute("IronParticles", 15)
    model:SetAttribute("IronContent", 75)
    model:SetAttribute("Purity", 85)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("ResourceBar", resourceBar)
    model:SetAttribute("ResourceFill", resourceFill)
    
    return model
end

return CreateIronOre