-- IronWall.lua
-- Модель железной стены

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIronWall()
    local wall = Instance.new("Part")
    wall.Name = "IronWall"
    wall.Size = Vector3.new(4, 6, 0.6)
    wall.Material = Enum.Material.Metal
    wall.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый металл
    wall.Anchored = true
    wall.CanCollide = true
    
    -- Создание текстуры металла
    local texture = Instance.new("Texture")
    texture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    texture.StudsPerTileU = 2
    texture.StudsPerTileV = 2
    texture.Parent = wall
    
    -- Создание металлических пластин
    for i = 1, 3 do
        for j = 1, 4 do
            local plate = Instance.new("Part")
            plate.Name = "IronPlate_" .. i .. "_" .. j
            plate.Size = Vector3.new(0.9, 1.8, 0.4)
            plate.Material = Enum.Material.Metal
            plate.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый металл
            plate.Anchored = true
            plate.CanCollide = false
            plate.Parent = wall
            
            -- Позиционирование пластин
            local xPos = (j - 2.5) * 1.0
            local yPos = (i - 2) * 1.9
            plate.Position = wall.Position + Vector3.new(xPos, yPos, 0.1)
        end
    end
    
    -- Создание заклепок
    for i = 1, 6 do
        local rivet = Instance.new("Part")
        rivet.Name = "Rivet" .. i
        rivet.Size = Vector3.new(0.2, 0.2, 0.3)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(64, 64, 64) -- Очень темный серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = wall
        
        -- Позиционирование заклепок
        local xPos = (i % 2 == 0) and 1.5 or -1.5
        local yPos = math.floor((i - 1) / 2) * 2 - 2
        rivet.Position = wall.Position + Vector3.new(xPos, yPos, 0.35)
    end
    
    -- Создание усиливающих балок
    for i = 1, 2 do
        local beam = Instance.new("Part")
        beam.Name = "SupportBeam" .. i
        beam.Size = Vector3.new(4.2, 0.3, 0.4)
        beam.Material = Enum.Material.Metal
        beam.Color = Color3.fromRGB(128, 128, 128) -- Средний серый
        beam.Anchored = true
        beam.CanCollide = false
        beam.Parent = wall
        
        -- Позиционирование балок
        local yPos = (i == 1) and 2 or -2
        beam.Position = wall.Position + Vector3.new(0, yPos, 0.1)
    end
    
    -- Создание модели
    local model = Instance.new("Model")
    model.Name = "IronWall"
    wall.Parent = model
    
    -- Установка атрибутов
    model:SetAttribute("BuildType", "wall")
    model:SetAttribute("Material", "iron")
    model:SetAttribute("Health", 400)
    model:SetAttribute("MaxHealth", 400)
    model:SetAttribute("Cost", 50)
    model:SetAttribute("BuildTime", 8)
    
    return model
end

return CreateIronWall