-- Axe.lua
-- Модель топора

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateAxe()
    local model = Instance.new("Model")
    model.Name = "Axe"
    
    -- Рукоять топора
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
    
    -- Лезвие топора
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.4, 0.3, 0.05)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    blade.Position = handle.Position + Vector3.new(0, 0.4, 0)
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = blade
    
    -- Свечение лезвия
    local bladeLight = Instance.new("PointLight")
    bladeLight.Color = Color3.fromRGB(192, 192, 192)
    bladeLight.Range = 1
    bladeLight.Brightness = 0.5
    bladeLight.Parent = blade
    
    -- Острие лезвия
    local edge = Instance.new("Part")
    edge.Name = "BladeEdge"
    edge.Size = Vector3.new(0.35, 0.25, 0.02)
    edge.Material = Enum.Material.Metal
    edge.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    edge.Anchored = true
    edge.CanCollide = false
    edge.Parent = model
    
    edge.Position = blade.Position + Vector3.new(0, 0, 0.035)
    
    -- Проушина топора
    local eye = Instance.new("Part")
    eye.Name = "AxeEye"
    eye.Size = Vector3.new(0.15, 0.15, 0.08)
    eye.Material = Enum.Material.Metal
    eye.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    eye.Anchored = true
    eye.CanCollide = false
    eye.Parent = model
    
    eye.Position = blade.Position + Vector3.new(0, -0.1, 0)
    
    -- Клин для крепления
    local wedge = Instance.new("Part")
    wedge.Name = "Wedge"
    wedge.Size = Vector3.new(0.12, 0.2, 0.06)
    wedge.Material = Enum.Material.Wood
    wedge.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
    wedge.Anchored = true
    wedge.CanCollide = false
    wedge.Parent = model
    
    wedge.Position = eye.Position + Vector3.new(0, -0.1, 0)
    
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
        local radius = 0.06
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rivet.Position = eye.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Деревянные кольца на рукояти
    for i = 1, 3 do
        local ring = Instance.new("Part")
        ring.Name = "HandleRing" .. i
        ring.Size = Vector3.new(0.12, 0.03, 0.12)
        ring.Material = Enum.Material.Wood
        ring.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.3 + (i - 1) * 0.3
        ring.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Деревянная обмотка рукояти
    for i = 1, 15 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.09, 0.015, 0.09)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.4 + (i - 1) * 0.05
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Насечки на лезвии
    for i = 1, 8 do
        local notch = Instance.new("Part")
        notch.Name = "BladeNotch" .. i
        notch.Size = Vector3.new(0.03, 0.02, 0.03)
        notch.Material = Enum.Material.Metal
        notch.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        notch.Anchored = true
        notch.CanCollide = false
        notch.Parent = model
        
        -- Позиционирование насечек
        local angle = (i - 1) * 45
        local radius = 0.15
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        notch.Position = blade.Position + Vector3.new(xPos, 0, zPos + 0.04)
    end
    
    -- Металлические частицы вокруг топора
    for i = 1, 18 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.01, 0.01, 0.01)
        particle.Material = Enum.Material.Metal
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
        particleLight.Brightness = 0.3
        particleLight.Parent = particle
    end
    
    -- Деревянные частицы
    for i = 1, 10 do
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
    model:SetAttribute("WeaponType", "axe")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 30)
    model:SetAttribute("WeaponSpeed", 0.8)
    model:SetAttribute("WeaponRange", 2)
    model:SetAttribute("WeaponDurability", 80)
    model:SetAttribute("WeaponLevel", 2)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "axe")
    model:SetAttribute("WeaponWeight", 2.0)
    model:SetAttribute("WeaponValue", 20)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("AxeSharpness", 90)
    model:SetAttribute("AxeBalance", 75)
    model:SetAttribute("WoodcuttingBonus", 25)
    
    return model
end

return CreateAxe