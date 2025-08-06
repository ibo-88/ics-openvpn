-- Bow.lua
-- Модель лука

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBow()
    local model = Instance.new("Model")
    model.Name = "Bow"
    
    -- Основная дуга лука
    local bow = Instance.new("Part")
    bow.Name = "Bow"
    bow.Size = Vector3.new(0.1, 1.2, 0.1)
    bow.Material = Enum.Material.Wood
    bow.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    bow.Anchored = true
    bow.CanCollide = false
    bow.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 2
    woodTexture.Parent = bow
    
    -- Тетива лука
    local string = Instance.new("Part")
    string.Name = "BowString"
    string.Size = Vector3.new(0.02, 1.1, 0.02)
    string.Material = Enum.Material.Fabric
    string.Color = Color3.fromRGB(255, 255, 255) -- Белый
    string.Anchored = true
    string.CanCollide = false
    string.Parent = model
    
    string.Position = bow.Position + Vector3.new(0, 0, 0.06)
    
    -- Рукоять лука
    local handle = Instance.new("Part")
    handle.Name = "BowHandle"
    handle.Size = Vector3.new(0.15, 0.3, 0.15)
    handle.Material = Enum.Material.Leather
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = bow.Position + Vector3.new(0, 0, 0.075)
    
    -- Обмотка рукояти
    for i = 1, 8 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.16, 0.02, 0.16)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.15 + (i - 1) * 0.04
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Концы лука
    for i = 1, 2 do
        local tip = Instance.new("Part")
        tip.Name = "BowTip" .. i
        tip.Size = Vector3.new(0.08, 0.2, 0.08)
        tip.Material = Enum.Material.Wood
        tip.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        tip.Anchored = true
        tip.CanCollide = false
        tip.Parent = model
        
        -- Позиционирование концов
        local yPos = (i == 1) and 0.7 or -0.7
        tip.Position = bow.Position + Vector3.new(0, yPos, 0.05)
    end
    
    -- Крепления тетивы
    for i = 1, 2 do
        local notch = Instance.new("Part")
        notch.Name = "StringNotch" .. i
        notch.Size = Vector3.new(0.05, 0.05, 0.05)
        notch.Material = Enum.Material.Wood
        notch.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        notch.Anchored = true
        notch.CanCollide = false
        notch.Parent = model
        
        -- Позиционирование креплений
        local yPos = (i == 1) and 0.6 or -0.6
        notch.Position = bow.Position + Vector3.new(0, yPos, 0.08)
    end
    
    -- Деревянные узоры на луке
    for i = 1, 6 do
        local pattern = Instance.new("Part")
        pattern.Name = "BowPattern" .. i
        pattern.Size = Vector3.new(0.08, 0.05, 0.08)
        pattern.Material = Enum.Material.Wood
        pattern.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.5 + (i - 1) * 0.2
        pattern.Position = bow.Position + Vector3.new(0, yPos, 0.075)
    end
    
    -- Деревянные заклепки
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "BowRivet" .. i
        rivet.Size = Vector3.new(0.03, 0.03, 0.03)
        rivet.Material = Enum.Material.Wood
        rivet.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local yPos = -0.4 + (i - 1) * 0.25
        rivet.Position = bow.Position + Vector3.new(0, yPos, 0.08)
    end
    
    -- Деревянные частицы вокруг лука
    for i = 1, 12 do
        local particle = Instance.new("Part")
        particle.Name = "WoodParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Wood
        particle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-0.8, 0.8)
        local zPos = math.random(-0.3, 0.3)
        particle.Position = bow.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "bow")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 20)
    model:SetAttribute("WeaponSpeed", 1.5)
    model:SetAttribute("WeaponRange", 25)
    model:SetAttribute("WeaponDurability", 60)
    model:SetAttribute("WeaponLevel", 2)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "ranged")
    model:SetAttribute("WeaponSubclass", "bow")
    model:SetAttribute("WeaponWeight", 1.2)
    model:SetAttribute("WeaponValue", 15)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("BowAccuracy", 85)
    model:SetAttribute("BowDrawSpeed", 1.0)
    model:SetAttribute("ArrowType", "wooden")
    
    return model
end

return CreateBow