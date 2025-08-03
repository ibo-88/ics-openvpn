-- CrystalWall.lua
-- Модель кристальной стены

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateCrystalWall()
    local wall = Instance.new("Part")
    wall.Name = "CrystalWall"
    wall.Size = Vector3.new(4, 6, 0.4)
    wall.Material = Enum.Material.Glass
    wall.Color = Color3.fromRGB(135, 206, 235) -- Голубой кристалл
    wall.Transparency = 0.3
    wall.Anchored = true
    wall.CanCollide = true
    
    -- Создание текстуры кристалла
    local texture = Instance.new("Texture")
    texture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    texture.StudsPerTileU = 1
    texture.StudsPerTileV = 1
    texture.Parent = wall
    
    -- Создание кристаллических сегментов
    for i = 1, 3 do
        for j = 1, 4 do
            local crystal = Instance.new("Part")
            crystal.Name = "CrystalSegment_" .. i .. "_" .. j
            crystal.Size = Vector3.new(0.8, 1.6, 0.3)
            crystal.Material = Enum.Material.Glass
            crystal.Color = Color3.fromRGB(100, 149, 237) -- Корнишон
            crystal.Transparency = 0.2
            crystal.Anchored = true
            crystal.CanCollide = false
            crystal.Parent = wall
            
            -- Позиционирование кристаллов
            local xPos = (j - 2.5) * 0.9
            local yPos = (i - 2) * 1.7
            crystal.Position = wall.Position + Vector3.new(xPos, yPos, 0.05)
        end
    end
    
    -- Создание магических рун
    for i = 1, 4 do
        local rune = Instance.new("Part")
        rune.Name = "MagicRune" .. i
        rune.Size = Vector3.new(0.3, 0.3, 0.1)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 255) -- Белый свет
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = wall
        
        -- Позиционирование рун
        local xPos = (i % 2 == 0) and 1.2 or -1.2
        local yPos = (i <= 2) and 2.5 or -2.5
        rune.Position = wall.Position + Vector3.new(xPos, yPos, 0.25)
        
        -- Создание свечения для рун
        local pointLight = Instance.new("PointLight")
        pointLight.Color = Color3.fromRGB(255, 255, 255)
        pointLight.Range = 3
        pointLight.Brightness = 1
        pointLight.Parent = rune
    end
    
    -- Создание магического барьера
    local barrier = Instance.new("Part")
    barrier.Name = "MagicBarrier"
    barrier.Size = Vector3.new(4.2, 6.2, 0.05)
    barrier.Position = wall.Position
    barrier.Material = Enum.Material.ForceField
    barrier.Color = Color3.fromRGB(0, 191, 255) -- Глубокий небесно-голубой
    barrier.Transparency = 0.7
    barrier.Anchored = true
    barrier.CanCollide = false
    barrier.Parent = wall
    
    -- Создание частиц магии
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(135, 206, 235))
    particleEmitter.Size = NumberSequence.new(0.1, 0)
    particleEmitter.Speed = NumberRange.new(1, 3)
    particleEmitter.Rate = 5
    particleEmitter.Lifetime = NumberRange.new(2, 4)
    particleEmitter.Parent = wall
    
    -- Создание модели
    local model = Instance.new("Model")
    model.Name = "CrystalWall"
    wall.Parent = model
    
    -- Установка атрибутов
    model:SetAttribute("BuildType", "wall")
    model:SetAttribute("Material", "crystal")
    model:SetAttribute("Health", 600)
    model:SetAttribute("MaxHealth", 600)
    model:SetAttribute("Cost", 100)
    model:SetAttribute("BuildTime", 12)
    model:SetAttribute("MagicResistance", 50)
    
    return model
end

return CreateCrystalWall