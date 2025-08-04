-- CrystalTower.lua
-- Модель кристальной башни

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateCrystalTower()
    local model = Instance.new("Model")
    model.Name = "CrystalTower"
    
    -- Основание башни
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(7, 2.5, 7)
    base.Material = Enum.Material.Glass
    base.Color = Color3.fromRGB(135, 206, 235) -- Голубой кристалл
    base.Transparency = 0.2
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры кристалла
    local crystalTexture = Instance.new("Texture")
    crystalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    crystalTexture.StudsPerTileU = 3
    crystalTexture.StudsPerTileV = 1
    crystalTexture.Parent = base
    
    -- Основная башня
    local tower = Instance.new("Part")
    tower.Name = "Tower"
    tower.Size = Vector3.new(6, 15, 6)
    tower.Material = Enum.Material.Glass
    tower.Color = Color3.fromRGB(135, 206, 235) -- Голубой кристалл
    tower.Transparency = 0.3
    tower.Anchored = true
    tower.CanCollide = true
    tower.Parent = model
    
    tower.Position = base.Position + Vector3.new(0, 8.75, 0)
    
    -- Кристаллические сегменты башни
    for i = 1, 8 do
        for j = 1, 4 do
            local segment = Instance.new("Part")
            segment.Name = "CrystalSegment_" .. i .. "_" .. j
            segment.Size = Vector3.new(2.5, 2, 2.5)
            segment.Material = Enum.Material.Glass
            segment.Color = Color3.fromRGB(135, 206, 235) -- Голубой кристалл
            segment.Transparency = 0.4
            segment.Anchored = true
            segment.CanCollide = false
            segment.Parent = model
            
            -- Позиционирование сегментов
            local angle = (j - 1) * 90
            local radius = 2.5
            local xPos = math.cos(math.rad(angle)) * radius
            local zPos = math.sin(math.rad(angle)) * radius
            local yPos = 2.5 + (i - 1) * 2
            segment.Position = base.Position + Vector3.new(xPos, yPos, zPos)
            segment.Orientation = Vector3.new(0, angle, 0)
        end
    end
    
    -- Магические руны на башне
    for i = 1, 12 do
        local rune = Instance.new("Part")
        rune.Name = "MagicRune" .. i
        rune.Size = Vector3.new(0.8, 0.8, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 30
        local radius = 3.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 2.5 + (i % 6) * 2.5
        rune.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 0, 255)
        runeLight.Range = 3
        runeLight.Brightness = 1.5
        runeLight.Parent = rune
    end
    
    -- Платформа для магов
    local platform = Instance.new("Part")
    platform.Name = "Platform"
    platform.Size = Vector3.new(6.5, 1.2, 6.5)
    platform.Material = Enum.Material.Glass
    platform.Color = Color3.fromRGB(135, 206, 235)
    platform.Transparency = 0.2
    platform.Anchored = true
    platform.CanCollide = true
    platform.Parent = model
    
    platform.Position = base.Position + Vector3.new(0, 17, 0)
    
    -- Кристаллические зубцы на платформе
    for i = 1, 16 do
        local crenellation = Instance.new("Part")
        crenellation.Name = "CrystalCrenellation" .. i
        crenellation.Size = Vector3.new(1.2, 2.5, 1.2)
        crenellation.Material = Enum.Material.Glass
        crenellation.Color = Color3.fromRGB(135, 206, 235)
        crenellation.Transparency = 0.3
        crenellation.Anchored = true
        crenellation.CanCollide = true
        crenellation.Parent = model
        
        -- Позиционирование зубцов
        local angle = (i - 1) * 22.5
        local radius = 3.85
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crenellation.Position = base.Position + Vector3.new(xPos, 18.25, zPos)
    end
    
    -- Магические бойницы
    for i = 1, 4 do
        local arrowSlit = Instance.new("Part")
        arrowSlit.Name = "MagicArrowSlit" .. i
        arrowSlit.Size = Vector3.new(0.5, 1.5, 0.5)
        arrowSlit.Material = Enum.Material.Glass
        arrowSlit.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        arrowSlit.Transparency = 0.5
        arrowSlit.Anchored = true
        arrowSlit.CanCollide = false
        arrowSlit.Parent = model
        
        -- Позиционирование бойниц
        local angle = (i - 1) * 90
        local radius = 3.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        arrowSlit.Position = base.Position + Vector3.new(xPos, 10, zPos)
        
        -- Свечение бойниц
        local slitLight = Instance.new("PointLight")
        slitLight.Color = Color3.fromRGB(255, 0, 255)
        slitLight.Range = 2
        slitLight.Brightness = 1
        slitLight.Parent = arrowSlit
    end
    
    -- Магическая лестница внутри башни
    for i = 1, 12 do
        local step = Instance.new("Part")
        step.Name = "MagicStep" .. i
        step.Size = Vector3.new(1.5, 0.3, 3.5)
        step.Material = Enum.Material.Glass
        step.Color = Color3.fromRGB(135, 206, 235)
        step.Transparency = 0.4
        step.Anchored = true
        step.CanCollide = true
        step.Parent = model
        
        -- Позиционирование ступеней
        local angle = i * 30
        local radius = 1.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 2.5 + (i - 1) * 1.2
        step.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        step.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Крыша башни
    local roof = Instance.new("Part")
    roof.Name = "CrystalRoof"
    roof.Size = Vector3.new(7, 1.5, 7)
    roof.Material = Enum.Material.Glass
    roof.Color = Color3.fromRGB(135, 206, 235)
    roof.Transparency = 0.2
    roof.Anchored = true
    roof.CanCollide = true
    roof.Parent = model
    
    roof.Position = base.Position + Vector3.new(0, 20.75, 0)
    
    -- Кристаллический шпиль
    local spire = Instance.new("Part")
    spire.Name = "CrystalSpire"
    spire.Size = Vector3.new(1, 4, 1)
    spire.Material = Enum.Material.Glass
    spire.Color = Color3.fromRGB(135, 206, 235)
    spire.Transparency = 0.1
    spire.Anchored = true
    spire.CanCollide = false
    spire.Parent = model
    
    spire.Position = base.Position + Vector3.new(0, 23.5, 0)
    
    -- Магический кристалл на шпиле
    local magicCrystal = Instance.new("Part")
    magicCrystal.Name = "MagicCrystal"
    magicCrystal.Size = Vector3.new(1.5, 1.5, 1.5)
    magicCrystal.Material = Enum.Material.Neon
    magicCrystal.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    magicCrystal.Anchored = true
    magicCrystal.CanCollide = false
    magicCrystal.Parent = model
    
    magicCrystal.Position = base.Position + Vector3.new(0, 25.75, 0)
    
    -- Свечение магического кристалла
    local crystalLight = Instance.new("PointLight")
    crystalLight.Color = Color3.fromRGB(255, 0, 255)
    crystalLight.Range = 10
    crystalLight.Brightness = 3
    crystalLight.Parent = magicCrystal
    
    -- Магическая сила башни
    local forceField = Instance.new("Part")
    forceField.Name = "ForceField"
    forceField.Size = Vector3.new(8, 15, 8)
    forceField.Material = Enum.Material.Glass
    forceField.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    forceField.Transparency = 0.8
    forceField.Anchored = true
    forceField.CanCollide = false
    forceField.Parent = model
    
    forceField.Position = base.Position + Vector3.new(0, 8.75, 0)
    
    -- Свечение силового поля
    local fieldLight = Instance.new("PointLight")
    fieldLight.Color = Color3.fromRGB(255, 0, 255)
    fieldLight.Range = 8
    fieldLight.Brightness = 1
    fieldLight.Parent = forceField
    
    -- Кристаллические украшения
    for i = 1, 8 do
        local decoration = Instance.new("Part")
        decoration.Name = "CrystalDecoration" .. i
        decoration.Size = Vector3.new(0.5, 1, 0.5)
        decoration.Material = Enum.Material.Neon
        decoration.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование украшений
        local angle = (i - 1) * 45
        local radius = 3.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 2.5 + (i % 4) * 4
        decoration.Position = base.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение украшений
        local decorationLight = Instance.new("PointLight")
        decorationLight.Color = Color3.fromRGB(0, 255, 255)
        decorationLight.Range = 2
        decorationLight.Brightness = 0.8
        decorationLight.Parent = decoration
    end
    
    -- UI для кристальной башни
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 25, 0)
    billboardGui.Parent = roof
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Кристальная башня"
    nameLabel.TextColor3 = Color3.fromRGB(255, 0, 255) -- Пурпурный текст
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
    healthFill.BackgroundColor3 = Color3.fromRGB(255, 0, 255) -- Пурпурный
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    model:SetAttribute("BuildType", "tower")
    model:SetAttribute("Material", "crystal")
    model:SetAttribute("Health", 1200)
    model:SetAttribute("MaxHealth", 1200)
    model:SetAttribute("Cost", 300)
    model:SetAttribute("BuildTime", 20)
    model:SetAttribute("AttackRange", 30)
    model:SetAttribute("AttackDamage", 75)
    model:SetAttribute("AttackSpeed", 0.8)
    model:SetAttribute("MagicResistance", 50)
    model:SetAttribute("ForceFieldActive", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("HealthBar", healthBar)
    model:SetAttribute("HealthFill", healthFill)
    
    return model
end

return CreateCrystalTower