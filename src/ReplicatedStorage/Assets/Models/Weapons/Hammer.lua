-- Hammer.lua
-- Модель молота

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateHammer()
    local model = Instance.new("Model")
    model.Name = "Hammer"
    
    -- Рукоять молота
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 1.2, 0.08)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 2
    woodTexture.Parent = handle
    
    -- Головка молота
    local head = Instance.new("Part")
    head.Name = "HammerHead"
    head.Size = Vector3.new(0.3, 0.4, 0.3)
    head.Material = Enum.Material.Metal
    head.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    head.Anchored = true
    head.CanCollide = false
    head.Parent = model
    
    head.Position = handle.Position + Vector3.new(0, 0.8, 0)
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = head
    
    -- Свечение головки
    local headLight = Instance.new("PointLight")
    headLight.Color = Color3.fromRGB(192, 192, 192)
    headLight.Range = 1.0
    headLight.Brightness = 0.6
    headLight.Parent = head
    
    -- Проушина молота
    local eye = Instance.new("Part")
    eye.Name = "HammerEye"
    eye.Size = Vector3.new(0.12, 0.12, 0.08)
    eye.Material = Enum.Material.Metal
    eye.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    eye.Anchored = true
    eye.CanCollide = false
    eye.Parent = model
    
    eye.Position = head.Position + Vector3.new(0, -0.1, 0)
    
    -- Клин для крепления
    local wedge = Instance.new("Part")
    wedge.Name = "Wedge"
    wedge.Size = Vector3.new(0.1, 0.25, 0.06)
    wedge.Material = Enum.Material.Wood
    wedge.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
    wedge.Anchored = true
    wedge.CanCollide = false
    wedge.Parent = model
    
    wedge.Position = eye.Position + Vector3.new(0, -0.125, 0)
    
    -- Металлические заклепки
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "MetalRivet" .. i
        rivet.Size = Vector3.new(0.02, 0.02, 0.02)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 90
        local radius = 0.05
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rivet.Position = eye.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Деревянные кольца на рукояти
    for i = 1, 4 do
        local ring = Instance.new("Part")
        ring.Name = "HandleRing" .. i
        ring.Size = Vector3.new(0.12, 0.03, 0.12)
        ring.Material = Enum.Material.Wood
        ring.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.4 + (i - 1) * 0.25
        ring.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Деревянная обмотка рукояти
    for i = 1, 20 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.09, 0.015, 0.09)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.5 + (i - 1) * 0.05
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Декоративные узоры на головке
    for i = 1, 4 do
        local pattern = Instance.new("Part")
        pattern.Name = "HeadPattern" .. i
        pattern.Size = Vector3.new(0.25, 0.05, 0.05)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local angle = (i - 1) * 90
        local radius = 0.15
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        pattern.Position = head.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Металлические частицы вокруг молота
    for i = 1, 20 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.01, 0.01, 0.01)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-0.8, 0.8)
        local zPos = math.random(-0.4, 0.4)
        particle.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.2
        particleLight.Brightness = 0.4
        particleLight.Parent = particle
    end
    
    -- Деревянные частицы
    for i = 1, 12 do
        local woodParticle = Instance.new("Part")
        woodParticle.Name = "WoodParticle" .. i
        woodParticle.Size = Vector3.new(0.015, 0.015, 0.015)
        woodParticle.Material = Enum.Material.Wood
        woodParticle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        woodParticle.Anchored = true
        woodParticle.CanCollide = false
        woodParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.6, 0.6)
        local zPos = math.random(-0.3, 0.3)
        woodParticle.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "hammer")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 40)
    model:SetAttribute("WeaponSpeed", 0.7)
    model:SetAttribute("WeaponRange", 2.5)
    model:SetAttribute("WeaponDurability", 100)
    model:SetAttribute("WeaponLevel", 3)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "hammer")
    model:SetAttribute("WeaponWeight", 3.0)
    model:SetAttribute("WeaponValue", 25)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("HammerStun", 30)
    model:SetAttribute("HammerBreak", 50)
    model:SetAttribute("HammerWeight", 3.0)
    
    return model
end

return CreateHammer