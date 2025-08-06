-- AlchemyLab.lua
-- Модель алхимической лаборатории

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateAlchemyLab()
    local model = Instance.new("Model")
    model.Name = "AlchemyLab"
    
    -- Основной стол алхимика
    local table = Instance.new("Part")
    table.Name = "AlchemyTable"
    table.Size = Vector3.new(4, 1.5, 3)
    table.Material = Enum.Material.Metal
    table.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    table.Anchored = true
    table.CanCollide = true
    table.Parent = model
    
    -- Создание текстуры стола
    local tableTexture = Instance.new("Texture")
    tableTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    tableTexture.StudsPerTileU = 2
    tableTexture.StudsPerTileV = 1.5
    tableTexture.Parent = table
    
    -- Рабочая поверхность
    local workSurface = Instance.new("Part")
    workSurface.Name = "WorkSurface"
    workSurface.Size = Vector3.new(3.5, 0.2, 2.5)
    workSurface.Material = Enum.Material.Metal
    workSurface.Color = Color3.fromRGB(128, 128, 128) -- Серый
    workSurface.Anchored = true
    workSurface.CanCollide = false
    workSurface.Parent = model
    
    workSurface.Position = table.Position + Vector3.new(0, 0.85, 0)
    
    -- Алхимический котел
    local cauldron = Instance.new("Part")
    cauldron.Name = "Cauldron"
    cauldron.Size = Vector3.new(2, 1.5, 2)
    cauldron.Material = Enum.Material.Metal
    cauldron.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
    cauldron.Anchored = true
    cauldron.CanCollide = true
    cauldron.Parent = model
    
    cauldron.Position = table.Position + Vector3.new(0, 1.25, 0)
    
    -- Зелье в котле
    local potion = Instance.new("Part")
    potion.Name = "Potion"
    potion.Size = Vector3.new(1.8, 1.3, 1.8)
    potion.Material = Enum.Material.Neon
    potion.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
    potion.Transparency = 0.3
    potion.Anchored = true
    potion.CanCollide = false
    potion.Parent = model
    
    potion.Position = cauldron.Position + Vector3.new(0, 0.1, 0)
    
    -- Свечение зелья
    local potionLight = Instance.new("PointLight")
    potionLight.Color = Color3.fromRGB(0, 255, 0)
    potionLight.Range = 4
    potionLight.Brightness = 2
    potionLight.Parent = potion
    
    -- Пузырьки в зелье
    for i = 1, 12 do
        local bubble = Instance.new("Part")
        bubble.Name = "Bubble" .. i
        bubble.Size = Vector3.new(0.1, 0.1, 0.1)
        bubble.Material = Enum.Material.Neon
        bubble.Color = Color3.fromRGB(255, 255, 255) -- Белый
        bubble.Transparency = 0.5
        bubble.Anchored = true
        bubble.CanCollide = false
        bubble.Parent = model
        
        -- Случайное позиционирование пузырьков
        local xPos = math.random(-0.8, 0.8)
        local yPos = math.random(0, 0.6)
        local zPos = math.random(-0.8, 0.8)
        bubble.Position = potion.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Алхимические колбы
    for i = 1, 6 do
        local flask = Instance.new("Part")
        flask.Name = "Flask" .. i
        flask.Size = Vector3.new(0.4, 0.8, 0.4)
        flask.Material = Enum.Material.Glass
        flask.Color = Color3.fromRGB(255, 255, 255) -- Белый
        flask.Transparency = 0.3
        flask.Anchored = true
        flask.CanCollide = false
        flask.Parent = model
        
        -- Позиционирование колб
        local angle = (i - 1) * 60
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        flask.Position = table.Position + Vector3.new(xPos, 1.3, zPos)
        
        -- Жидкость в колбе
        local liquid = Instance.new("Part")
        liquid.Name = "Liquid" .. i
        liquid.Size = Vector3.new(0.35, 0.6, 0.35)
        liquid.Material = Enum.Material.Neon
        liquid.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) -- Случайный цвет
        liquid.Transparency = 0.2
        liquid.Anchored = true
        liquid.CanCollide = false
        liquid.Parent = model
        
        liquid.Position = flask.Position + Vector3.new(0, 0.1, 0)
        
        -- Свечение жидкости
        local liquidLight = Instance.new("PointLight")
        liquidLight.Color = liquid.Color
        liquidLight.Range = 1.5
        liquidLight.Brightness = 1
        liquidLight.Parent = liquid
    end
    
    -- Магические кристаллы
    for i = 1, 8 do
        local crystal = Instance.new("Part")
        crystal.Name = "MagicCrystal" .. i
        crystal.Size = Vector3.new(0.3, 0.6, 0.3)
        crystal.Material = Enum.Material.Neon
        crystal.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        crystal.Anchored = true
        crystal.CanCollide = false
        crystal.Parent = model
        
        -- Позиционирование кристаллов
        local angle = (i - 1) * 45
        local radius = 2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        crystal.Position = table.Position + Vector3.new(xPos, 1.2, zPos)
        
        -- Свечение кристаллов
        local crystalLight = Instance.new("PointLight")
        crystalLight.Color = Color3.fromRGB(255, 0, 255)
        crystalLight.Range = 2
        crystalLight.Brightness = 1.5
        crystalLight.Parent = crystal
    end
    
    -- Алхимические ингредиенты
    for i = 1, 10 do
        local ingredient = Instance.new("Part")
        ingredient.Name = "Ingredient" .. i
        ingredient.Size = Vector3.new(0.2, 0.2, 0.2)
        ingredient.Material = Enum.Material.Neon
        ingredient.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        ingredient.Anchored = true
        ingredient.CanCollide = false
        ingredient.Parent = model
        
        -- Позиционирование ингредиентов
        local xPos = math.random(-1.5, 1.5)
        local zPos = math.random(-1, 1)
        ingredient.Position = table.Position + Vector3.new(xPos, 0.85, zPos)
        
        -- Свечение ингредиентов
        local ingredientLight = Instance.new("PointLight")
        ingredientLight.Color = Color3.fromRGB(255, 255, 0)
        ingredientLight.Range = 1
        ingredientLight.Brightness = 0.8
        ingredientLight.Parent = ingredient
    end
    
    -- Магические руны на столе
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "AlchemyRune" .. i
        rune.Size = Vector3.new(0.4, 0.4, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 1.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = table.Position + Vector3.new(xPos, 0.85, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 1.5
        runeLight.Brightness = 1
        runeLight.Parent = rune
    end
    
    -- Алхимические книги
    for i = 1, 4 do
        local book = Instance.new("Part")
        book.Name = "AlchemyBook" .. i
        book.Size = Vector3.new(0.5, 0.7, 0.3)
        book.Material = Enum.Material.Fabric
        book.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        book.Anchored = true
        book.CanCollide = false
        book.Parent = model
        
        -- Позиционирование книг
        local xPos = (i - 2.5) * 0.6
        book.Position = table.Position + Vector3.new(xPos, 1.1, -1.2)
        book.Orientation = Vector3.new(0, (i - 2.5) * 10, 0)
        
        -- Обложка книги
        local cover = Instance.new("Part")
        cover.Name = "BookCover" .. i
        cover.Size = Vector3.new(0.5, 0.7, 0.05)
        cover.Material = Enum.Material.Fabric
        cover.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        cover.Anchored = true
        cover.CanCollide = false
        cover.Parent = model
        
        cover.Position = book.Position + Vector3.new(0, 0, 0.175)
        
        -- Алхимический символ на обложке
        local symbol = Instance.new("Part")
        symbol.Name = "AlchemySymbol" .. i
        symbol.Size = Vector3.new(0.25, 0.25, 0.1)
        symbol.Material = Enum.Material.Neon
        symbol.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        symbol.Anchored = true
        symbol.CanCollide = false
        symbol.Parent = model
        
        symbol.Position = cover.Position + Vector3.new(0, 0, 0.075)
        
        -- Свечение символа
        local symbolLight = Instance.new("PointLight")
        symbolLight.Color = Color3.fromRGB(255, 255, 0)
        symbolLight.Range = 0.8
        symbolLight.Brightness = 0.6
        symbolLight.Parent = symbol
    end
    
    -- Магические свитки
    for i = 1, 5 do
        local scroll = Instance.new("Part")
        scroll.Name = "AlchemyScroll" .. i
        scroll.Size = Vector3.new(0.08, 0.5, 0.08)
        scroll.Material = Enum.Material.Paper
        scroll.Color = Color3.fromRGB(255, 255, 255) -- Белый
        scroll.Anchored = true
        scroll.CanCollide = false
        scroll.Parent = model
        
        -- Позиционирование свитков
        local angle = (i - 1) * 72
        local radius = 2.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        scroll.Position = table.Position + Vector3.new(xPos, 1.1, zPos)
        
        -- Рукоять свитка
        local handle = Instance.new("Part")
        handle.Name = "ScrollHandle" .. i
        handle.Size = Vector3.new(0.12, 0.15, 0.12)
        handle.Material = Enum.Material.Wood
        handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        handle.Anchored = true
        handle.CanCollide = false
        handle.Parent = model
        
        handle.Position = scroll.Position + Vector3.new(0, -0.325, 0)
    end
    
    -- Магические частицы
    for i = 1, 25 do
        local particle = Instance.new("Part")
        particle.Name = "AlchemyParticle" .. i
        particle.Size = Vector3.new(0.08, 0.08, 0.08)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-2, 2)
        local yPos = math.random(0, 3)
        local zPos = math.random(-1.5, 1.5)
        particle.Position = table.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 255, 255)
        particleLight.Range = 0.6
        particleLight.Brightness = 0.5
        particleLight.Parent = particle
    end
    
    -- Магическая аура лаборатории
    local aura = Instance.new("Part")
    aura.Name = "AlchemyAura"
    aura.Size = Vector3.new(5, 3, 4)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(0, 255, 0) -- Зеленый
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = table.Position + Vector3.new(0, 1.5, 0)
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(0, 255, 0)
    auraLight.Range = 6
    auraLight.Brightness = 1
    auraLight.Parent = aura
    
    -- Ножки стола
    for i = 1, 4 do
        local leg = Instance.new("Part")
        leg.Name = "TableLeg" .. i
        leg.Size = Vector3.new(0.3, 1.5, 0.3)
        leg.Material = Enum.Material.Metal
        leg.Color = Color3.fromRGB(64, 64, 64) -- Очень темно-серый
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ножек
        local xPos = (i <= 2) and 1.85 or -1.85
        local zPos = (i % 2 == 0) and 1.35 or -1.35
        leg.Position = table.Position + Vector3.new(xPos, -0.75, zPos)
    end
    
    -- UI для алхимической лаборатории
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 350, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = table
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Алхимическая лаборатория"
    nameLabel.TextColor3 = Color3.fromRGB(0, 255, 0) -- Зеленый текст
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Нажмите E для алхимии"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Золотой
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("CraftingType", "alchemy")
    model:SetAttribute("CraftingLevel", 4)
    model:SetAttribute("MaxCraftingLevel", 5)
    model:SetAttribute("CraftingSpeed", 2.5)
    model:SetAttribute("CraftingQuality", 2.0)
    model:SetAttribute("CanCraft", true)
    model:SetAttribute("IsCraftingStation", true)
    model:SetAttribute("CauldronActive", true)
    model:SetAttribute("PotionBrewing", true)
    model:SetAttribute("AlchemyFlasks", 6)
    model:SetAttribute("MagicCrystals", 8)
    model:SetAttribute("AlchemyIngredients", 10)
    model:SetAttribute("AlchemyRunes", 6)
    model:SetAttribute("AlchemyBooks", 4)
    model:SetAttribute("AlchemyScrolls", 5)
    model:SetAttribute("AlchemyParticles", 25)
    model:SetAttribute("AlchemyAura", true)
    model:SetAttribute("Bubbles", 12)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateAlchemyLab