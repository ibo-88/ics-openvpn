-- WoodenChest.lua
-- Модель деревянного сундука

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateWoodenChest()
    local model = Instance.new("Model")
    model.Name = "WoodenChest"
    
    -- Основание сундука
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(2, 0.5, 1.5)
    base.Material = Enum.Material.Wood
    base.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет дерева
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 1
    woodTexture.Parent = base
    
    -- Боковые стенки сундука
    for i = 1, 2 do
        local side = Instance.new("Part")
        side.Name = "Side" .. i
        side.Size = Vector3.new(0.2, 1, 1.5)
        side.Material = Enum.Material.Wood
        side.Color = Color3.fromRGB(160, 82, 45) -- Более светлый коричневый
        side.Anchored = true
        side.CanCollide = true
        side.Parent = model
        
        -- Позиционирование стенок
        local xPos = (i == 1) and 1.1 or -1.1
        side.Position = base.Position + Vector3.new(xPos, 0.25, 0)
    end
    
    -- Передняя и задняя стенки
    for i = 1, 2 do
        local wall = Instance.new("Part")
        wall.Name = "Wall" .. i
        wall.Size = Vector3.new(2, 1, 0.2)
        wall.Material = Enum.Material.Wood
        wall.Color = Color3.fromRGB(160, 82, 45)
        wall.Anchored = true
        wall.CanCollide = true
        wall.Parent = model
        
        -- Позиционирование стенок
        local zPos = (i == 1) and 0.85 or -0.85
        wall.Position = base.Position + Vector3.new(0, 0.25, zPos)
    end
    
    -- Крышка сундука
    local lid = Instance.new("Part")
    lid.Name = "Lid"
    lid.Size = Vector3.new(2.2, 0.3, 1.7)
    lid.Material = Enum.Material.Wood
    lid.Color = Color3.fromRGB(139, 69, 19)
    lid.Anchored = true
    lid.CanCollide = true
    lid.Parent = model
    
    lid.Position = base.Position + Vector3.new(0, 0.65, 0)
    
    -- Петли крышки
    for i = 1, 2 do
        local hinge = Instance.new("Part")
        hinge.Name = "Hinge" .. i
        hinge.Size = Vector3.new(0.1, 0.1, 0.3)
        hinge.Material = Enum.Material.Metal
        hinge.Color = Color3.fromRGB(105, 105, 105) -- Серый металл
        hinge.Anchored = true
        hinge.CanCollide = false
        hinge.Parent = model
        
        -- Позиционирование петель
        local xPos = (i == 1) and 0.8 or -0.8
        hinge.Position = base.Position + Vector3.new(xPos, 0.5, -0.75)
    end
    
    -- Замок сундука
    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.3, 0.4, 0.2)
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    lock.Anchored = true
    lock.CanCollide = false
    lock.Parent = model
    
    lock.Position = base.Position + Vector3.new(0, 0.5, 0.75)
    
    -- Ключевое отверстие
    local keyhole = Instance.new("Part")
    keyhole.Name = "Keyhole"
    keyhole.Size = Vector3.new(0.05, 0.1, 0.1)
    keyhole.Material = Enum.Material.Metal
    keyhole.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
    keyhole.Anchored = true
    keyhole.CanCollide = false
    keyhole.Parent = lock
    
    keyhole.Position = lock.Position + Vector3.new(0, 0, 0.15)
    
    -- Декоративные полосы на сундуке
    for i = 1, 3 do
        local stripe = Instance.new("Part")
        stripe.Name = "Stripe" .. i
        stripe.Size = Vector3.new(1.8, 0.1, 0.1)
        stripe.Material = Enum.Material.Wood
        stripe.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        stripe.Anchored = true
        stripe.CanCollide = false
        stripe.Parent = model
        
        -- Позиционирование полос
        local yPos = 0.2 + (i - 1) * 0.3
        stripe.Position = base.Position + Vector3.new(0, yPos, 0.75)
    end
    
    -- Угловые украшения
    for i = 1, 4 do
        local corner = Instance.new("Part")
        corner.Name = "Corner" .. i
        corner.Size = Vector3.new(0.2, 0.2, 0.2)
        corner.Material = Enum.Material.Metal
        corner.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        corner.Anchored = true
        corner.CanCollide = false
        corner.Parent = model
        
        -- Позиционирование углов
        local xPos = (i <= 2) and 0.9 or -0.9
        local zPos = (i % 2 == 0) and 0.65 or -0.65
        corner.Position = base.Position + Vector3.new(xPos, 0.25, zPos)
    end
    
    -- UI для сундука
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = lid
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Деревянный сундук"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 0.5, 0)
    statusLabel.Position = UDim2.new(0, 0, 0.5, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Нажмите E для открытия"
    statusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("ChestType", "wooden")
    model:SetAttribute("ChestQuality", "common")
    model:SetAttribute("LootTable", "chest.wooden_chest")
    model:SetAttribute("IsLocked", false)
    model:SetAttribute("RequiresKey", false)
    model:SetAttribute("CanBeOpened", true)
    model:SetAttribute("LootMultiplier", 1.0)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateWoodenChest