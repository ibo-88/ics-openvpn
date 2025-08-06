-- EnchantingTable.lua
-- Модель стола зачарования

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateEnchantingTable()
    local model = Instance.new("Model")
    model.Name = "EnchantingTable"
    
    -- Основной стол зачарования
    local table = Instance.new("Part")
    table.Name = "EnchantingTable"
    table.Size = Vector3.new(3, 1.5, 3)
    table.Material = Enum.Material.Metal
    table.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    table.Anchored = true
    table.CanCollide = true
    table.Parent = model
    
    -- Создание текстуры стола
    local tableTexture = Instance.new("Texture")
    tableTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    tableTexture.StudsPerTileU = 2
    tableTexture.StudsPerTileV = 1
    tableTexture.Parent = table
    
    -- Рабочая поверхность стола
    local workSurface = Instance.new("Part")
    workSurface.Name = "WorkSurface"
    workSurface.Size = Vector3.new(2.5, 0.2, 2.5)
    workSurface.Material = Enum.Material.Metal
    workSurface.Color = Color3.fromRGB(128, 128, 128) -- Серый
    workSurface.Anchored = true
    workSurface.CanCollide = false
    workSurface.Parent = model
    
    workSurface.Position = table.Position + Vector3.new(0, 0.85, 0)
    
    -- Магический кристалл зачарования
    local crystal = Instance.new("Part")
    crystal.Name = "EnchantingCrystal"
    crystal.Size = Vector3.new(1, 1, 1)
    crystal.Material = Enum.Material.Neon
    crystal.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    crystal.Anchored = true
    crystal.CanCollide = false
    crystal.Parent = model
    
    crystal.Position = table.Position + Vector3.new(0, 1.25, 0)
    
    -- Свечение кристалла
    local crystalLight = Instance.new("PointLight")
    crystalLight.Color = Color3.fromRGB(255, 0, 255)
    crystalLight.Range = 6
    crystalLight.Brightness = 3
    crystalLight.Parent = crystal
    
    -- Подставка для кристалла
    local crystalStand = Instance.new("Part")
    crystalStand.Name = "CrystalStand"
    crystalStand.Size = Vector3.new(1.2, 0.3, 1.2)
    crystalStand.Material = Enum.Material.Metal
    crystalStand.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    crystalStand.Anchored = true
    crystalStand.CanCollide = false
    crystalStand.Parent = model
    
    crystalStand.Position = table.Position + Vector3.new(0, 1, 0)
    
    -- Магические руны вокруг кристалла
    for i = 1, 8 do
        local rune = Instance.new("Part")
        rune.Name = "EnchantingRune" .. i
        rune.Size = Vector3.new(0.5, 0.5, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 45
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = table.Position + Vector3.new(xPos, 0.85, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 2
        runeLight.Brightness = 1.5
        runeLight.Parent = rune
    end
    
    -- Слоты для зачарования
    for i = 1, 4 do
        local slot = Instance.new("Part")
        slot.Name = "EnchantingSlot" .. i
        slot.Size = Vector3.new(0.8, 0.1, 0.8)
        slot.Material = Enum.Material.Metal
        slot.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        slot.Anchored = true
        slot.CanCollide = false
        slot.Parent = model
        
        -- Позиционирование слотов
        local angle = (i - 1) * 90
        local radius = 1.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        slot.Position = table.Position + Vector3.new(xPos, 0.85, zPos)
        
        -- Обводка слотов
        local slotBorder = Instance.new("Part")
        slotBorder.Name = "SlotBorder" .. i
        slotBorder.Size = Vector3.new(0.9, 0.15, 0.9)
        slotBorder.Material = Enum.Material.Metal
        slotBorder.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        slotBorder.Anchored = true
        slotBorder.CanCollide = false
        slotBorder.Parent = model
        
        slotBorder.Position = slot.Position + Vector3.new(0, -0.025, 0)
    end
    
    -- Магические книги
    for i = 1, 3 do
        local book = Instance.new("Part")
        book.Name = "MagicBook" .. i
        book.Size = Vector3.new(0.6, 0.8, 0.4)
        book.Material = Enum.Material.Fabric
        book.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        book.Anchored = true
        book.CanCollide = false
        book.Parent = model
        
        -- Позиционирование книг
        local xPos = (i - 2) * 0.8
        book.Position = table.Position + Vector3.new(xPos, 1.1, 1.2)
        book.Orientation = Vector3.new(0, (i - 2) * 15, 0)
        
        -- Обложка книги
        local cover = Instance.new("Part")
        cover.Name = "BookCover" .. i
        cover.Size = Vector3.new(0.6, 0.8, 0.05)
        cover.Material = Enum.Material.Fabric
        cover.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        cover.Anchored = true
        cover.CanCollide = false
        cover.Parent = model
        
        cover.Position = book.Position + Vector3.new(0, 0, 0.225)
        
        -- Магический символ на обложке
        local symbol = Instance.new("Part")
        symbol.Name = "BookSymbol" .. i
        symbol.Size = Vector3.new(0.3, 0.3, 0.1)
        symbol.Material = Enum.Material.Neon
        symbol.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        symbol.Anchored = true
        symbol.CanCollide = false
        symbol.Parent = model
        
        symbol.Position = cover.Position + Vector3.new(0, 0, 0.075)
        
        -- Свечение символа
        local symbolLight = Instance.new("PointLight")
        symbolLight.Color = Color3.fromRGB(255, 255, 0)
        symbolLight.Range = 1
        symbolLight.Brightness = 0.8
        symbolLight.Parent = symbol
    end
    
    -- Магические свитки
    for i = 1, 4 do
        local scroll = Instance.new("Part")
        scroll.Name = "MagicScroll" .. i
        scroll.Size = Vector3.new(0.1, 0.6, 0.1)
        scroll.Material = Enum.Material.Paper
        scroll.Color = Color3.fromRGB(255, 255, 255) -- Белый
        scroll.Anchored = true
        scroll.CanCollide = false
        scroll.Parent = model
        
        -- Позиционирование свитков
        local angle = (i - 1) * 90
        local radius = 1.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        scroll.Position = table.Position + Vector3.new(xPos, 1.1, zPos)
        
        -- Рукоять свитка
        local handle = Instance.new("Part")
        handle.Name = "ScrollHandle" .. i
        handle.Size = Vector3.new(0.15, 0.2, 0.15)
        handle.Material = Enum.Material.Wood
        handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        handle.Anchored = true
        handle.CanCollide = false
        handle.Parent = model
        
        handle.Position = scroll.Position + Vector3.new(0, -0.4, 0)
    end
    
    -- Магические ингредиенты
    for i = 1, 6 do
        local ingredient = Instance.new("Part")
        ingredient.Name = "MagicIngredient" .. i
        ingredient.Size = Vector3.new(0.3, 0.3, 0.3)
        ingredient.Material = Enum.Material.Neon
        ingredient.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        ingredient.Anchored = true
        ingredient.CanCollide = false
        ingredient.Parent = model
        
        -- Позиционирование ингредиентов
        local angle = (i - 1) * 60
        local radius = 2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        ingredient.Position = table.Position + Vector3.new(xPos, 0.85, zPos)
        
        -- Свечение ингредиентов
        local ingredientLight = Instance.new("PointLight")
        ingredientLight.Color = Color3.fromRGB(0, 255, 255)
        ingredientLight.Range = 1.5
        ingredientLight.Brightness = 1
        ingredientLight.Parent = ingredient
    end
    
    -- Магические частицы
    for i = 1, 20 do
        local particle = Instance.new("Part")
        particle.Name = "EnchantingParticle" .. i
        particle.Size = Vector3.new(0.1, 0.1, 0.1)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-2, 2)
        local yPos = math.random(0, 3)
        local zPos = math.random(-2, 2)
        particle.Position = table.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 255, 255)
        particleLight.Range = 0.8
        particleLight.Brightness = 0.6
        particleLight.Parent = particle
    end
    
    -- Магическая аура стола
    local aura = Instance.new("Part")
    aura.Name = "EnchantingAura"
    aura.Size = Vector3.new(4, 3, 4)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    aura.Transparency = 0.8
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = table.Position + Vector3.new(0, 1.5, 0)
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 0, 255)
    auraLight.Range = 5
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
        local xPos = (i <= 2) and 1.35 or -1.35
        local zPos = (i % 2 == 0) and 1.35 or -1.35
        leg.Position = table.Position + Vector3.new(xPos, -0.75, zPos)
    end
    
    -- UI для стола зачарования
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 300, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = table
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Стол зачарования"
    nameLabel.TextColor3 = Color3.fromRGB(255, 0, 255) -- Пурпурный текст
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Нажмите E для зачарования"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Золотой
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("CraftingType", "enchanting")
    model:SetAttribute("CraftingLevel", 3)
    model:SetAttribute("MaxCraftingLevel", 5)
    model:SetAttribute("CraftingSpeed", 2.0)
    model:SetAttribute("CraftingQuality", 1.5)
    model:SetAttribute("CanCraft", true)
    model:SetAttribute("IsCraftingStation", true)
    model:SetAttribute("EnchantingRunes", 8)
    model:SetAttribute("EnchantingCrystal", true)
    model:SetAttribute("EnchantingSlots", 4)
    model:SetAttribute("MagicBooks", 3)
    model:SetAttribute("MagicScrolls", 4)
    model:SetAttribute("MagicIngredients", 6)
    model:SetAttribute("EnchantingParticles", 20)
    model:SetAttribute("EnchantingAura", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateEnchantingTable