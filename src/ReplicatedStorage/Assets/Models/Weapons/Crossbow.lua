-- Crossbow.lua
-- Модель арбалета

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateCrossbow()
    local model = Instance.new("Model")
    model.Name = "Crossbow"
    
    -- Основная рама арбалета
    local frame = Instance.new("Part")
    frame.Name = "Frame"
    frame.Size = Vector3.new(0.1, 0.8, 0.4)
    frame.Material = Enum.Material.Metal
    frame.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    frame.Anchored = true
    frame.CanCollide = false
    frame.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = frame
    
    -- Свечение рамы
    local frameLight = Instance.new("PointLight")
    frameLight.Color = Color3.fromRGB(105, 105, 105)
    frameLight.Range = 0.8
    frameLight.Brightness = 0.4
    frameLight.Parent = frame
    
    -- Лук арбалета
    local bow = Instance.new("Part")
    bow.Name = "Bow"
    bow.Size = Vector3.new(0.05, 0.6, 0.05)
    bow.Material = Enum.Material.Metal
    bow.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    bow.Anchored = true
    bow.CanCollide = false
    bow.Parent = model
    
    bow.Position = frame.Position + Vector3.new(0, 0.3, 0)
    
    -- Свечение лука
    local bowLight = Instance.new("PointLight")
    bowLight.Color = Color3.fromRGB(192, 192, 192)
    bowLight.Range = 0.6
    bowLight.Brightness = 0.5
    bowLight.Parent = bow
    
    -- Тетива арбалета
    local string = Instance.new("Part")
    string.Name = "BowString"
    string.Size = Vector3.new(0.02, 0.5, 0.02)
    string.Material = Enum.Material.Fabric
    string.Color = Color3.fromRGB(255, 255, 255) -- Белый
    string.Anchored = true
    string.CanCollide = false
    string.Parent = model
    
    string.Position = bow.Position + Vector3.new(0, 0, 0.025)
    
    -- Рукоять арбалета
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.12, 0.3, 0.12)
    handle.Material = Enum.Material.Leather
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = frame.Position + Vector3.new(0, -0.25, 0)
    
    -- Обмотка рукояти
    for i = 1, 10 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.13, 0.015, 0.13)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.35 + (i - 1) * 0.03
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Спусковой крючок
    local trigger = Instance.new("Part")
    trigger.Name = "Trigger"
    trigger.Size = Vector3.new(0.02, 0.08, 0.02)
    trigger.Material = Enum.Material.Metal
    trigger.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    trigger.Anchored = true
    trigger.CanCollide = false
    trigger.Parent = model
    
    trigger.Position = frame.Position + Vector3.new(0, -0.15, 0.21)
    
    -- Ложе арбалета
    local stock = Instance.new("Part")
    stock.Name = "Stock"
    stock.Size = Vector3.new(0.08, 0.4, 0.15)
    stock.Material = Enum.Material.Wood
    stock.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    stock.Anchored = true
    stock.CanCollide = false
    stock.Parent = model
    
    stock.Position = frame.Position + Vector3.new(0, -0.5, 0)
    
    -- Деревянные узоры на ложе
    for i = 1, 6 do
        local pattern = Instance.new("Part")
        pattern.Name = "StockPattern" .. i
        pattern.Size = Vector3.new(0.06, 0.02, 0.06)
        pattern.Material = Enum.Material.Wood
        pattern.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.6 + (i - 1) * 0.12
        pattern.Position = stock.Position + Vector3.new(0, yPos, 0.105)
    end
    
    -- Прицел арбалета
    local sight = Instance.new("Part")
    sight.Name = "Sight"
    sight.Size = Vector3.new(0.02, 0.1, 0.02)
    sight.Material = Enum.Material.Metal
    sight.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    sight.Anchored = true
    sight.CanCollide = false
    sight.Parent = model
    
    sight.Position = frame.Position + Vector3.new(0, 0.1, 0.21)
    
    -- Металлические заклепки
    for i = 1, 6 do
        local rivet = Instance.new("Part")
        rivet.Name = "MetalRivet" .. i
        rivet.Size = Vector3.new(0.02, 0.02, 0.02)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 60
        local radius = 0.15
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rivet.Position = frame.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Стрела в арбалете
    local bolt = Instance.new("Part")
    bolt.Name = "Bolt"
    bolt.Size = Vector3.new(0.02, 0.3, 0.02)
    bolt.Material = Enum.Material.Wood
    bolt.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    bolt.Anchored = true
    bolt.CanCollide = false
    bolt.Parent = model
    
    bolt.Position = frame.Position + Vector3.new(0, 0, 0.21)
    
    -- Наконечник стрелы
    local boltTip = Instance.new("Part")
    boltTip.Name = "BoltTip"
    boltTip.Size = Vector3.new(0.01, 0.05, 0.01)
    boltTip.Material = Enum.Material.Metal
    boltTip.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    boltTip.Anchored = true
    boltTip.CanCollide = false
    boltTip.Parent = model
    
    boltTip.Position = bolt.Position + Vector3.new(0, 0.175, 0)
    
    -- Оперение стрелы
    for i = 1, 3 do
        local feather = Instance.new("Part")
        feather.Name = "BoltFeather" .. i
        feather.Size = Vector3.new(0.02, 0.04, 0.02)
        feather.Material = Enum.Material.Fabric
        feather.Color = Color3.fromRGB(255, 255, 255) -- Белый
        feather.Anchored = true
        feather.CanCollide = false
        feather.Parent = model
        
        -- Позиционирование перьев
        local angle = (i - 1) * 120
        local radius = 0.02
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        feather.Position = bolt.Position + Vector3.new(xPos, -0.15, zPos)
    end
    
    -- Металлические частицы вокруг арбалета
    for i = 1, 15 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.008, 0.008, 0.008)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.6, 0.6)
        local zPos = math.random(-0.3, 0.3)
        particle.Position = frame.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.15
        particleLight.Brightness = 0.3
        particleLight.Parent = particle
    end
    
    -- Деревянные частицы
    for i = 1, 8 do
        local woodParticle = Instance.new("Part")
        woodParticle.Name = "WoodParticle" .. i
        woodParticle.Size = Vector3.new(0.012, 0.012, 0.012)
        woodParticle.Material = Enum.Material.Wood
        woodParticle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        woodParticle.Anchored = true
        woodParticle.CanCollide = false
        woodParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.25, 0.25)
        local yPos = math.random(-0.5, 0.5)
        local zPos = math.random(-0.25, 0.25)
        woodParticle.Position = frame.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "crossbow")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "uncommon")
    model:SetAttribute("WeaponDamage", 35)
    model:SetAttribute("WeaponSpeed", 0.6)
    model:SetAttribute("WeaponRange", 30)
    model:SetAttribute("WeaponDurability", 90)
    model:SetAttribute("WeaponLevel", 4)
    model:SetAttribute("WeaponRarity", "uncommon")
    model:SetAttribute("WeaponClass", "ranged")
    model:SetAttribute("WeaponSubclass", "crossbow")
    model:SetAttribute("WeaponWeight", 2.5)
    model:SetAttribute("WeaponValue", 40)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("CrossbowAccuracy", 95)
    model:SetAttribute("CrossbowReloadSpeed", 2.0)
    model:SetAttribute("BoltType", "metal")
    
    return model
end

return CreateCrossbow