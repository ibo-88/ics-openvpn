-- WoodenWall.lua
-- Модель деревянной стены

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateWoodenWall()
    local wall = Instance.new("Part")
    wall.Name = "WoodenWall"
    wall.Size = Vector3.new(4, 6, 0.5)
    wall.Material = Enum.Material.Wood
    wall.Color = Color3.fromRGB(139, 69, 19) -- Коричневый цвет дерева
    wall.Anchored = true
    wall.CanCollide = true
    
    -- Создание текстуры дерева
    local texture = Instance.new("Texture")
    texture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    texture.StudsPerTileU = 2
    texture.StudsPerTileV = 2
    texture.Parent = wall
    
    -- Создание деталей стены
    local details = Instance.new("Part")
    details.Name = "WallDetails"
    details.Size = Vector3.new(3.8, 5.8, 0.1)
    details.Position = wall.Position
    details.Material = Enum.Material.Wood
    details.Color = Color3.fromRGB(160, 82, 45) -- Более темный коричневый
    details.Anchored = true
    details.CanCollide = false
    details.Parent = wall
    
    -- Создание гвоздей
    for i = 1, 4 do
        local nail = Instance.new("Part")
        nail.Name = "Nail" .. i
        nail.Size = Vector3.new(0.1, 0.1, 0.2)
        nail.Material = Enum.Material.Metal
        nail.Color = Color3.fromRGB(105, 105, 105) -- Серый металл
        nail.Anchored = true
        nail.CanCollide = false
        nail.Parent = wall
        
        -- Позиционирование гвоздей
        local xPos = (i % 2 == 0) and 1.5 or -1.5
        local yPos = (i <= 2) and 2 or -2
        nail.Position = wall.Position + Vector3.new(xPos, yPos, 0.3)
    end
    
    -- Создание модели
    local model = Instance.new("Model")
    model.Name = "WoodenWall"
    wall.Parent = model
    
    -- Установка атрибутов
    model:SetAttribute("BuildType", "wall")
    model:SetAttribute("Material", "wood")
    model:SetAttribute("Health", 100)
    model:SetAttribute("MaxHealth", 100)
    model:SetAttribute("Cost", 10)
    model:SetAttribute("BuildTime", 3)
    
    return model
end

return CreateWoodenWall