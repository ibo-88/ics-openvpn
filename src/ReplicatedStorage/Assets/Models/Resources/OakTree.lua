-- OakTree.lua
-- Модель дуба

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateOakTree()
    local model = Instance.new("Model")
    model.Name = "OakTree"
    
    -- Ствол дуба
    local trunk = Instance.new("Part")
    trunk.Name = "Trunk"
    trunk.Size = Vector3.new(1.5, 8, 1.5)
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет дерева
    trunk.Anchored = true
    trunk.CanCollide = true
    trunk.Parent = model
    
    -- Создание текстуры коры
    local barkTexture = Instance.new("Texture")
    barkTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    barkTexture.StudsPerTileU = 2
    barkTexture.StudsPerTileV = 4
    barkTexture.Parent = trunk
    
    -- Основные ветви
    for i = 1, 4 do
        local branch = Instance.new("Part")
        branch.Name = "Branch" .. i
        branch.Size = Vector3.new(0.8, 3, 0.8)
        branch.Material = Enum.Material.Wood
        branch.Color = Color3.fromRGB(160, 82, 45) -- Более светлый коричневый
        branch.Anchored = true
        branch.CanCollide = true
        branch.Parent = model
        
        -- Позиционирование ветвей
        local angle = (i - 1) * 90
        local radius = 2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        branch.Position = trunk.Position + Vector3.new(xPos, 3, zPos)
        
        -- Поворот ветвей
        branch.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Листва дуба
    for i = 1, 6 do
        local foliage = Instance.new("Part")
        foliage.Name = "Foliage" .. i
        foliage.Size = Vector3.new(4, 3, 4)
        foliage.Material = Enum.Material.Grass
        foliage.Color = Color3.fromRGB(34, 139, 34) -- Темно-зеленый
        foliage.Anchored = true
        foliage.CanCollide = true
        foliage.Parent = model
        
        -- Позиционирование листвы
        local yPos = 4 + (i - 1) * 1.5
        local radius = (i <= 3) and 0 or 1
        local angle = (i - 1) * 60
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        foliage.Position = trunk.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Корни дуба
    for i = 1, 3 do
        local root = Instance.new("Part")
        root.Name = "Root" .. i
        root.Size = Vector3.new(0.6, 1, 0.6)
        root.Material = Enum.Material.Wood
        root.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        root.Anchored = true
        root.CanCollide = true
        root.Parent = model
        
        -- Позиционирование корней
        local angle = (i - 1) * 120
        local radius = 1.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        root.Position = trunk.Position + Vector3.new(xPos, -4, zPos)
        
        -- Поворот корней
        root.Orientation = Vector3.new(0, angle, 0)
    end
    
    -- Плоды дуба (желуди)
    for i = 1, 8 do
        local acorn = Instance.new("Part")
        acorn.Name = "Acorn" .. i
        acorn.Size = Vector3.new(0.2, 0.4, 0.2)
        acorn.Material = Enum.Material.Wood
        acorn.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        acorn.Anchored = true
        acorn.CanCollide = false
        acorn.Parent = model
        
        -- Позиционирование желудей
        local angle = (i - 1) * 45
        local radius = 2.5
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        acorn.Position = trunk.Position + Vector3.new(xPos, 5, zPos)
    end
    
    -- UI для дуба
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 6, 0)
    billboardGui.Parent = trunk
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Дуб"
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
    resourceFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    resourceFill.BorderSizePixel = 0
    resourceFill.Parent = resourceBar
    
    -- Установка атрибутов
    model:SetAttribute("ResourceType", "wood")
    model:SetAttribute("ResourceAmount", 100)
    model:SetAttribute("MaxResourceAmount", 100)
    model:SetAttribute("RespawnTime", 30)
    model:SetAttribute("ResourceQuality", "common")
    model:SetAttribute("LootTable", "resource_loot.oak_tree")
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("ResourceBar", resourceBar)
    model:SetAttribute("ResourceFill", resourceFill)
    
    return model
end

return CreateOakTree