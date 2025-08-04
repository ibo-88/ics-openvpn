-- IronChest.lua
-- Модель железного сундука

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIronChest()
    local model = Instance.new("Model")
    model.Name = "IronChest"
    
    -- Основание сундука
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(2.2, 0.6, 1.7)
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    base.Anchored = true
    base.CanCollide = true
    base.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = base
    
    -- Боковые стенки сундука
    for i = 1, 2 do
        local side = Instance.new("Part")
        side.Name = "Side" .. i
        side.Size = Vector3.new(0.3, 1.2, 1.7)
        side.Material = Enum.Material.Metal
        side.Color = Color3.fromRGB(128, 128, 128) -- Серый металл
        side.Anchored = true
        side.CanCollide = true
        side.Parent = model
        
        -- Позиционирование стенок
        local xPos = (i == 1) and 1.25 or -1.25
        side.Position = base.Position + Vector3.new(xPos, 0.3, 0)
    end
    
    -- Передняя и задняя стенки
    for i = 1, 2 do
        local wall = Instance.new("Part")
        wall.Name = "Wall" .. i
        wall.Size = Vector3.new(2.2, 1.2, 0.3)
        wall.Material = Enum.Material.Metal
        wall.Color = Color3.fromRGB(128, 128, 128)
        wall.Anchored = true
        wall.CanCollide = true
        wall.Parent = model
        
        -- Позиционирование стенок
        local zPos = (i == 1) and 1 or -1
        wall.Position = base.Position + Vector3.new(0, 0.3, zPos)
    end
    
    -- Крышка сундука
    local lid = Instance.new("Part")
    lid.Name = "Lid"
    lid.Size = Vector3.new(2.4, 0.4, 1.9)
    lid.Material = Enum.Material.Metal
    lid.Color = Color3.fromRGB(105, 105, 105)
    lid.Anchored = true
    lid.CanCollide = true
    lid.Parent = model
    
    lid.Position = base.Position + Vector3.new(0, 0.8, 0)
    
    -- Петли крышки
    for i = 1, 4 do
        local hinge = Instance.new("Part")
        hinge.Name = "Hinge" .. i
        hinge.Size = Vector3.new(0.2, 0.2, 0.5)
        hinge.Material = Enum.Material.Metal
        hinge.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        hinge.Anchored = true
        hinge.CanCollide = false
        hinge.Parent = model
        
        -- Позиционирование петель
        local tower = (i <= 2) and 1.25 or -1.25
        local gate = (i % 2 == 0) and -0.85 or 0.85
        local yPos = (i <= 2) and 0.6 or 1
        hinge.Position = base.Position + Vector3.new(tower, yPos, gate)
    end
    
    -- Замок сундука
    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.5, 0.7, 0.4)
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    lock.Anchored = true
    lock.CanCollide = false
    lock.Parent = model
    
    lock.Position = base.Position + Vector3.new(0, 0.6, 1.05)
    
    -- Ключевое отверстие
    local keyhole = Instance.new("Part")
    keyhole.Name = "Keyhole"
    keyhole.Size = Vector3.new(0.1, 0.2, 0.1)
    keyhole.Material = Enum.Material.Metal
    keyhole.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
    keyhole.Anchored = true
    keyhole.CanCollide = false
    keyhole.Parent = lock
    
    keyhole.Position = lock.Position + Vector3.new(0, 0, 0.25)
    
    -- Декоративные полосы на сундуке
    for i = 1, 4 do
        local stripe = Instance.new("Part")
        stripe.Name = "Stripe" .. i
        stripe.Size = Vector3.new(2, 0.1, 0.1)
        stripe.Material = Enum.Material.Metal
        stripe.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        stripe.Anchored = true
        stripe.CanCollide = false
        stripe.Parent = model
        
        -- Позиционирование полос
        local yPos = 0.3 + (i - 1) * 0.3
        stripe.Position = base.Position + Vector3.new(0, yPos, 1.05)
    end
    
    -- Угловые украшения
    for i = 1, 4 do
        local corner = Instance.new("Part")
        corner.Name = "Corner" .. i
        corner.Size = Vector3.new(0.3, 0.3, 0.3)
        corner.Material = Enum.Material.Metal
        corner.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        corner.Anchored = true
        corner.CanCollide = false
        corner.Parent = model
        
        -- Позиционирование углов
        local xPos = (i <= 2) and 1.25 or -1.25
        local zPos = (i % 2 == 0) and 1 or -1
        corner.Position = base.Position + Vector3.new(xPos, 0.3, zPos)
    end
    
    -- Железные заклепки
    for i = 1, 8 do
        local rivet = Instance.new("Part")
        rivet.Name = "Rivet" .. i
        rivet.Size = Vector3.new(0.1, 0.1, 0.1)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 45
        local radius = 0.8
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = 0.3 + (i % 2) * 0.6
        rivet.Position = base.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Железные ручки
    for i = 1, 2 do
        local handle = Instance.new("Part")
        handle.Name = "Handle" .. i
        handle.Size = Vector3.new(0.3, 0.1, 0.1)
        handle.Material = Enum.Material.Metal
        handle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        handle.Anchored = true
        handle.CanCollide = false
        handle.Parent = model
        
        -- Позиционирование ручек
        local xPos = (i == 1) and 0.5 or -0.5
        handle.Position = base.Position + Vector3.new(xPos, 0.8, 1.05)
    end
    
    -- Железные ножки
    for i = 1, 4 do
        local leg = Instance.new("Part")
        leg.Name = "Leg" .. i
        leg.Size = Vector3.new(0.2, 0.3, 0.2)
        leg.Material = Enum.Material.Metal
        leg.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        leg.Anchored = true
        leg.CanCollide = true
        leg.Parent = model
        
        -- Позиционирование ножек
        local xPos = (i <= 2) and 0.8 or -0.8
        local zPos = (i % 2 == 0) and 0.6 or -0.6
        leg.Position = base.Position + Vector3.new(xPos, -0.45, zPos)
    end
    
    -- Защитные пластины
    for i = 1, 2 do
        local plate = Instance.new("Part")
        plate.Name = "ProtectionPlate" .. i
        plate.Size = Vector3.new(2.2, 0.1, 0.1)
        plate.Material = Enum.Material.Metal
        plate.Color = Color3.fromRGB(64, 64, 64) -- Темно-серый
        plate.Anchored = true
        plate.CanCollide = false
        plate.Parent = model
        
        -- Позиционирование пластин
        local yPos = 0.2 + (i - 1) * 0.8
        plate.Position = base.Position + Vector3.new(0, yPos, 1.05)
    end
    
    -- UI для железного сундука
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 250, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2.5, 0)
    billboardGui.Parent = lid
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Железный сундук"
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
    model:SetAttribute("ChestType", "iron")
    model:SetAttribute("ChestQuality", "uncommon")
    model:SetAttribute("LootTable", "chest.iron_chest")
    model:SetAttribute("IsLocked", false)
    model:SetAttribute("RequiresKey", false)
    model:SetAttribute("CanBeOpened", true)
    model:SetAttribute("LootMultiplier", 1.5)
    model:SetAttribute("Durability", 200)
    model:SetAttribute("MaxDurability", 200)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("StatusLabel", statusLabel)
    
    return model
end

return CreateIronChest