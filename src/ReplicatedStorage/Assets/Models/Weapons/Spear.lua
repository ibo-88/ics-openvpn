-- Spear.lua
-- Модель копья

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateSpear()
    local model = Instance.new("Model")
    model.Name = "Spear"
    
    -- Древко копья
    local shaft = Instance.new("Part")
    shaft.Name = "Shaft"
    shaft.Size = Vector3.new(0.06, 2.0, 0.06)
    shaft.Material = Enum.Material.Wood
    shaft.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    shaft.Anchored = true
    shaft.CanCollide = false
    shaft.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 3
    woodTexture.Parent = shaft
    
    -- Наконечник копья
    local tip = Instance.new("Part")
    tip.Name = "SpearTip"
    tip.Size = Vector3.new(0.02, 0.3, 0.02)
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    tip.Anchored = true
    tip.CanCollide = false
    tip.Parent = model
    
    tip.Position = shaft.Position + Vector3.new(0, 1.15, 0)
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = tip
    
    -- Свечение наконечника
    local tipLight = Instance.new("PointLight")
    tipLight.Color = Color3.fromRGB(192, 192, 192)
    tipLight.Range = 0.8
    tipLight.Brightness = 0.6
    tipLight.Parent = tip
    
    -- Острие наконечника
    local point = Instance.new("Part")
    point.Name = "SpearPoint"
    point.Size = Vector3.new(0.01, 0.1, 0.01)
    point.Material = Enum.Material.Metal
    point.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    point.Anchored = true
    point.CanCollide = false
    point.Parent = model
    
    point.Position = tip.Position + Vector3.new(0, 0.2, 0)
    
    -- Крепление наконечника
    local socket = Instance.new("Part")
    socket.Name = "TipSocket"
    socket.Size = Vector3.new(0.08, 0.15, 0.08)
    socket.Material = Enum.Material.Metal
    socket.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    socket.Anchored = true
    socket.CanCollide = false
    socket.Parent = model
    
    socket.Position = tip.Position + Vector3.new(0, -0.225, 0)
    
    -- Металлические заклепки крепления
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "SocketRivet" .. i
        rivet.Size = Vector3.new(0.02, 0.02, 0.02)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 90
        local radius = 0.04
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rivet.Position = socket.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Деревянные кольца на древке
    for i = 1, 6 do
        local ring = Instance.new("Part")
        ring.Name = "ShaftRing" .. i
        ring.Size = Vector3.new(0.1, 0.03, 0.1)
        ring.Material = Enum.Material.Wood
        ring.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.8 + (i - 1) * 0.3
        ring.Position = shaft.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Деревянная обмотка древка
    for i = 1, 25 do
        local wrap = Instance.new("Part")
        wrap.Name = "ShaftWrap" .. i
        wrap.Size = Vector3.new(0.07, 0.015, 0.07)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.9 + (i - 1) * 0.07
        wrap.Position = shaft.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Декоративные узоры на древке
    for i = 1, 8 do
        local pattern = Instance.new("Part")
        pattern.Name = "ShaftPattern" .. i
        pattern.Size = Vector3.new(0.05, 0.02, 0.05)
        pattern.Material = Enum.Material.Wood
        pattern.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.7 + (i - 1) * 0.2
        pattern.Position = shaft.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Металлические частицы вокруг копья
    for i = 1, 18 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.008, 0.008, 0.008)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.2, 0.2)
        local yPos = math.random(-1.0, 1.0)
        local zPos = math.random(-0.2, 0.2)
        particle.Position = shaft.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.15
        particleLight.Brightness = 0.3
        particleLight.Parent = particle
    end
    
    -- Деревянные частицы
    for i = 1, 15 do
        local woodParticle = Instance.new("Part")
        woodParticle.Name = "WoodParticle" .. i
        woodParticle.Size = Vector3.new(0.012, 0.012, 0.012)
        woodParticle.Material = Enum.Material.Wood
        woodParticle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        woodParticle.Anchored = true
        woodParticle.CanCollide = false
        woodParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.15, 0.15)
        local yPos = math.random(-0.8, 0.8)
        local zPos = math.random(-0.15, 0.15)
        woodParticle.Position = shaft.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "spear")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 28)
    model:SetAttribute("WeaponSpeed", 1.2)
    model:SetAttribute("WeaponRange", 4)
    model:SetAttribute("WeaponDurability", 85)
    model:SetAttribute("WeaponLevel", 3)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "spear")
    model:SetAttribute("WeaponWeight", 1.8)
    model:SetAttribute("WeaponValue", 22)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("SpearReach", 4)
    model:SetAttribute("SpearThrust", 35)
    model:SetAttribute("SpearBalance", 80)
    
    return model
end

return CreateSpear