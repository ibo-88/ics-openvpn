-- CraftingTable.lua
-- Модель верстака для крафтинга

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateCraftingTable()
    local model = Instance.new("Model")
    model.Name = "CraftingTable"
    
    -- Основная поверхность верстака
    local tableTop = Instance.new("Part")
    tableTop.Name = "TableTop"
    tableTop.Size = Vector3.new(4, 0.5, 3)
    tableTop.Material = Enum.Material.Wood
    tableTop.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет дерева
    tableTop.Anchored = true
    tableTop.CanCollide = true
    tableTop.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 2
    woodTexture.StudsPerTileV = 1.5
    woodTexture.Parent = tableTop
    
    -- Ножки верстака
    for i = 1, 4 do
        local leg = Instance.new("Part")
        leg.Name = "TableLeg" .. i
        leg.Size = Vector3.new(0.4, 2.5, 0.4)
        leg.Material = Enum.Material.Wood
        leg.Color = Color3.fromRGB(160, 82, 45) -- Более светлый коричневый
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ножек
        local xPos = (i <= 2) and 1.8 or -1.8
        local zPos = (i % 2 == 0) and 1.3 or -1.3
        leg.Position = tableTop.Position + Vector3.new(xPos, -1.5, zPos)
    end
    
    -- Рабочая поверхность
    local workSurface = Instance.new("Part")
    workSurface.Name = "WorkSurface"
    workSurface.Size = Vector3.new(3.5, 0.2, 2.5)
    workSurface.Material = Enum.Material.Wood
    workSurface.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
    workSurface.Anchored = true
    workSurface.CanCollide = false
    workSurface.Parent = model
    
    workSurface.Position = tableTop.Position + Vector3.new(0, 0.35, 0)
    
    -- Инструменты на верстаке
    local hammer = Instance.new("Part")
    hammer.Name = "Hammer"
    hammer.Size = Vector3.new(0.3, 0.8, 0.3)
    hammer.Material = Enum.Material.Metal
    hammer.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    hammer.Anchored = true
    hammer.CanCollide = false
    hammer.Parent = model
    
    hammer.Position = tableTop.Position + Vector3.new(-1.5, 0.65, 0.8)
    
    -- Рукоять молотка
    local hammerHandle = Instance.new("Part")
    hammerHandle.Name = "HammerHandle"
    hammerHandle.Size = Vector3.new(0.1, 0.6, 0.1)
    hammerHandle.Material = Enum.Material.Wood
    hammerHandle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    hammerHandle.Anchored = true
    hammerHandle.CanCollide = false
    hammerHandle.Parent = hammer
    
    hammerHandle.Position = hammer.Position + Vector3.new(0, -0.7, 0)
    
    -- Головка молотка
    local hammerHead = Instance.new("Part")
    hammerHead.Name = "HammerHead"
    hammerHead.Size = Vector3.new(0.4, 0.3, 0.4)
    hammerHead.Material = Enum.Material.Metal
    hammerHead.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    hammerHead.Anchored = true
    hammerHead.CanCollide = false
    hammerHead.Parent = hammer
    
    hammerHead.Position = hammer.Position + Vector3.new(0, 0.55, 0)
    
    -- Отвертка
    local screwdriver = Instance.new("Part")
    screwdriver.Name = "Screwdriver"
    screwdriver.Size = Vector3.new(0.1, 0.6, 0.1)
    screwdriver.Material = Enum.Material.Metal
    screwdriver.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    screwdriver.Anchored = true
    screwdriver.CanCollide = false
    screwdriver.Parent = model
    
    screwdriver.Position = tableTop.Position + Vector3.new(1.5, 0.65, 0.8)
    
    -- Рукоять отвертки
    local screwdriverHandle = Instance.new("Part")
    screwdriverHandle.Name = "ScrewdriverHandle"
    screwdriverHandle.Size = Vector3.new(0.15, 0.2, 0.15)
    screwdriverHandle.Material = Enum.Material.Wood
    screwdriverHandle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    screwdriverHandle.Anchored = true
    screwdriverHandle.CanCollide = false
    screwdriverHandle.Parent = screwdriver
    
    screwdriverHandle.Position = screwdriver.Position + Vector3.new(0, -0.4, 0)
    
    -- Нож
    local knife = Instance.new("Part")
    knife.Name = "Knife"
    knife.Size = Vector3.new(0.05, 0.4, 0.05)
    knife.Material = Enum.Material.Metal
    knife.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    knife.Anchored = true
    knife.CanCollide = false
    knife.Parent = model
    
    knife.Position = tableTop.Position + Vector3.new(-1.5, 0.65, -0.8)
    
    -- Рукоять ножа
    local knifeHandle = Instance.new("Part")
    knifeHandle.Name = "KnifeHandle"
    knifeHandle.Size = Vector3.new(0.1, 0.15, 0.1)
    knifeHandle.Material = Enum.Material.Wood
    knifeHandle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    knifeHandle.Anchored = true
    knifeHandle.CanCollide = false
    knifeHandle.Parent = knife
    
    knifeHandle.Position = knife.Position + Vector3.new(0, -0.275, 0)
    
    -- Ящики для инструментов
    for i = 1, 2 do
        local toolbox = Instance.new("Part")
        toolbox.Name = "Toolbox" .. i
        toolbox.Size = Vector3.new(0.8, 0.6, 0.6)
        toolbox.Material = Enum.Material.Metal
        toolbox.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        toolbox.Anchored = true
        toolbox.CanCollide = true
        toolbox.Parent = model
        
        -- Позиционирование ящиков
        local xPos = (i == 1) and -1.5 or 1.5
        toolbox.Position = tableTop.Position + Vector3.new(xPos, -1.3, 0)
        
        -- Ручки ящиков
        local handle = Instance.new("Part")
        handle.Name = "ToolboxHandle" .. i
        handle.Size = Vector3.new(0.6, 0.1, 0.1)
        handle.Material = Enum.Material.Metal
        handle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        handle.Anchored = true
        handle.CanCollide = false
        handle.Parent = toolbox
        
        handle.Position = toolbox.Position + Vector3.new(0, 0.35, 0)
    end
    
    -- Полки для материалов
    for i = 1, 3 do
        local shelf = Instance.new("Part")
        shelf.Name = "MaterialShelf" .. i
        shelf.Size = Vector3.new(3.5, 0.2, 0.8)
        shelf.Material = Enum.Material.Wood
        shelf.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        shelf.Anchored = true
        shelf.CanCollide = true
        shelf.Parent = model
        
        -- Позиционирование полок
        local yPos = -0.5 - (i - 1) * 0.4
        shelf.Position = tableTop.Position + Vector3.new(0, yPos, 1.5)
        
        -- Разделители на полках
        for j = 1, 4 do
            local divider = Instance.new("Part")
            divider.Name = "ShelfDivider" .. i .. "_" .. j
            divider.Size = Vector3.new(0.1, 0.3, 0.8)
            divider.Material = Enum.Material.Wood
            divider.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
            divider.Anchored = true
            divider.CanCollide = false
            divider.Parent = model
            
            -- Позиционирование разделителей
            local xPos = -1.5 + (j - 1) * 1
            divider.Position = shelf.Position + Vector3.new(xPos, 0.25, 0)
        end
    end
    
    -- Магический кристалл для крафтинга
    local craftingCrystal = Instance.new("Part")
    craftingCrystal.Name = "CraftingCrystal"
    craftingCrystal.Size = Vector3.new(0.8, 0.8, 0.8)
    craftingCrystal.Material = Enum.Material.Neon
    craftingCrystal.Color = Color3.fromRGB(0, 255, 255) -- Голубой
    craftingCrystal.Anchored = true
    craftingCrystal.CanCollide = false
    craftingCrystal.Parent = model
    
    craftingCrystal.Position = tableTop.Position + Vector3.new(0, 0.65, 0)
    
    -- Свечение кристалла
    local crystalLight = Instance.new("PointLight")
    crystalLight.Color = Color3.fromRGB(0, 255, 255)
    crystalLight.Range = 5
    crystalLight.Brightness = 2
    crystalLight.Parent = craftingCrystal
    
    -- Подставка для кристалла
    local crystalStand = Instance.new("Part")
    crystalStand.Name = "CrystalStand"
    crystalStand.Size = Vector3.new(1, 0.3, 1)
    crystalStand.Material = Enum.Material.Metal
    crystalStand.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    crystalStand.Anchored = true
    crystalStand.CanCollide = false
    crystalStand.Parent = model
    
    crystalStand.Position = tableTop.Position + Vector3.new(0, 0.4, 0)
    
    -- Магические руны вокруг кристалла
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "CraftingRune" .. i
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
        rune.Position = tableTop.Position + Vector3.new(xPos, 0.35, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 2
        runeLight.Brightness = 1
        runeLight.Parent = rune
    end
    
    -- Слоты для крафтинга
    for i = 1, 9 do
        local slot = Instance.new("Part")
        slot.Name = "CraftingSlot" .. i
        slot.Size = Vector3.new(0.6, 0.1, 0.6)
        slot.Material = Enum.Material.Metal
        slot.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        slot.Anchored = true
        slot.CanCollide = false
        slot.Parent = model
        
        -- Позиционирование слотов (3x3 сетка)
        local row = math.ceil(i / 3)
        local col = ((i - 1) % 3) + 1
        local xPos = (col - 2) * 0.8
        local zPos = (row - 2) * 0.8
        slot.Position = tableTop.Position + Vector3.new(xPos, 0.35, zPos)
        
        -- Обводка слотов
        local slotBorder = Instance.new("Part")
        slotBorder.Name = "SlotBorder" .. i
        slotBorder.Size = Vector3.new(0.7, 0.15, 0.7)
        slotBorder.Material = Enum.Material.Metal
        slotBorder.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        slotBorder.Anchored = true
        slotBorder.CanCollide = false
        slotBorder.Parent = model
        
        slotBorder.Position = slot.Position + Vector3.new(0, -0.025, 0)
    end
    
    -- UI для верстака
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 60)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = tableTop
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Верстак"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Нажмите E для крафтинга"
    statusLabel.TextColor3 = Color3.fromRGB(0, 255, 255) -- Голубой
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("CraftingType", "table")
    model:SetAttribute("CraftingLevel", 1)
    model:SetAttribute("MaxCraftingLevel", 5)
    model:SetAttribute("CraftingSlots", 9)
    model:SetAttribute("CraftingSpeed", 1.0)
    model:SetAttribute("CraftingQuality", 1.0)
    model:SetAttribute("CanCraft", true)
    model:SetAttribute("IsCraftingStation", true)
    model:SetAttribute("CraftingRunes", 6)
    model:SetAttribute("CraftingCrystal", true)
    model:SetAttribute("Toolboxes", 2)
    model:SetAttribute("MaterialShelves", 3)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateCraftingTable