-- Mace.lua
-- Модель булавы

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateMace()
    local model = Instance.new("Model")
    model.Name = "Mace"
    
    -- Рукоять булавы
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 1.0, 0.08)
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
    
    -- Головка булавы
    local head = Instance.new("Part")
    head.Name = "MaceHead"
    head.Size = Vector3.new(0.25, 0.25, 0.25)
    head.Material = Enum.Material.Metal
    head.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    head.Anchored = true
    head.CanCollide = false
    head.Parent = model
    
    head.Position = handle.Position + Vector3.new(0, 0.625, 0)
    
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
    
    -- Шипы на головке булавы
    for i = 1, 8 do
        local spike = Instance.new("Part")
        spike.Name = "MaceSpike" .. i
        spike.Size = Vector3.new(0.02, 0.08, 0.02)
        spike.Material = Enum.Material.Metal
        spike.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        spike.Anchored = true
        spike.CanCollide = false
        spike.Parent = model
        
        -- Позиционирование шипов
        local angle = (i - 1) * 45
        local radius = 0.12
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        spike.Position = head.Position + Vector3.new(xPos, 0.165, zPos)
    end
    
    -- Центральный шип
    local centerSpike = Instance.new("Part")
    centerSpike.Name = "CenterSpike"
    centerSpike.Size = Vector3.new(0.03, 0.12, 0.03)
    centerSpike.Material = Enum.Material.Metal
    centerSpike.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    centerSpike.Anchored = true
    centerSpike.CanCollide = false
    centerSpike.Parent = model
    
    centerSpike.Position = head.Position + Vector3.new(0, 0.185, 0)
    
    -- Крепление головки
    local mount = Instance.new("Part")
    mount.Name = "HeadMount"
    mount.Size = Vector3.new(0.12, 0.2, 0.12)
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    mount.Anchored = true
    mount.CanCollide = false
    mount.Parent = model
    
    mount.Position = head.Position + Vector3.new(0, -0.225, 0)
    
    -- Металлические заклепки крепления
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "MountRivet" .. i
        rivet.Size = Vector3.new(0.02, 0.02, 0.02)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 90
        local radius = 0.06
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rivet.Position = mount.Position + Vector3.new(xPos, 0, zPos)
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
        pattern.Size = Vector3.new(0.2, 0.05, 0.05)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local angle = (i - 1) * 90
        local radius = 0.1
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        pattern.Position = head.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Металлические частицы вокруг булавы
    for i = 1, 25 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.01, 0.01, 0.01)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.6, 0.6)
        local zPos = math.random(-0.3, 0.3)
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
        local xPos = math.random(-0.25, 0.25)
        local yPos = math.random(-0.5, 0.5)
        local zPos = math.random(-0.25, 0.25)
        woodParticle.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "mace")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "uncommon")
    model:SetAttribute("WeaponDamage", 45)
    model:SetAttribute("WeaponSpeed", 0.6)
    model:SetAttribute("WeaponRange", 2.5)
    model:SetAttribute("WeaponDurability", 110)
    model:SetAttribute("WeaponLevel", 4)
    model:SetAttribute("WeaponRarity", "uncommon")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "mace")
    model:SetAttribute("WeaponWeight", 3.5)
    model:SetAttribute("WeaponValue", 35)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("MaceStun", 40)
    model:SetAttribute("MaceBreak", 60)
    model:SetAttribute("MaceWeight", 3.5)
    
    return model
end

return CreateMace