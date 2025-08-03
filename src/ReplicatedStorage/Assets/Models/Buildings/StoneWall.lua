-- StoneWall.lua
-- Модель каменной стены

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateStoneWall()
    local wall = Instance.new("Part")
    wall.Name = "StoneWall"
    wall.Size = Vector3.new(4, 6, 0.8)
    wall.Material = Enum.Material.Rock
    wall.Color = Color3.fromRGB(128, 128, 128) -- Серый камень
    wall.Anchored = true
    wall.CanCollide = true
    
    -- Создание текстуры камня
    local texture = Instance.new("Texture")
    texture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    texture.StudsPerTileU = 1
    texture.StudsPerTileV = 1
    texture.Parent = wall
    
    -- Создание каменных блоков
    for i = 1, 3 do
        for j = 1, 4 do
            local block = Instance.new("Part")
            block.Name = "StoneBlock_" .. i .. "_" .. j
            block.Size = Vector3.new(1.2, 1.4, 0.6)
            block.Material = Enum.Material.Rock
            block.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
            block.Anchored = true
            block.CanCollide = false
            block.Parent = wall
            
            -- Позиционирование блоков
            local xPos = (j - 2.5) * 1.3
            local yPos = (i - 2) * 1.6
            block.Position = wall.Position + Vector3.new(xPos, yPos, 0.1)
        end
    end
    
    -- Создание раствора между блоками
    local mortar = Instance.new("Part")
    mortar.Name = "Mortar"
    mortar.Size = Vector3.new(4.2, 6.2, 0.1)
    mortar.Position = wall.Position
    mortar.Material = Enum.Material.Concrete
    mortar.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    mortar.Anchored = true
    mortar.CanCollide = false
    mortar.Parent = wall
    
    -- Создание модели
    local model = Instance.new("Model")
    model.Name = "StoneWall"
    wall.Parent = model
    
    -- Установка атрибутов
    model:SetAttribute("BuildType", "wall")
    model:SetAttribute("Material", "stone")
    model:SetAttribute("Health", 200)
    model:SetAttribute("MaxHealth", 200)
    model:SetAttribute("Cost", 25)
    model:SetAttribute("BuildTime", 5)
    
    return model
end

return CreateStoneWall