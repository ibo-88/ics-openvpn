-- WoodenSword.lua
-- Модель деревянного меча

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateWoodenSword()
    local model = Instance.new("Model")
    model.Name = "WoodenSword"
    
    -- Клинок меча
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.1, 1.2, 0.1)
    blade.Material = Enum.Material.Wood
    blade.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 2
    woodTexture.Parent = blade
    
    -- Рукоять меча
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.15, 0.4, 0.15)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = blade.Position + Vector3.new(0, -0.8, 0)
    
    -- Гарда меча
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.4, 0.1, 0.1)
    guard.Material = Enum.Material.Wood
    guard.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    guard.Anchored = true
    guard.CanCollide = false
    guard.Parent = model
    
    guard.Position = blade.Position + Vector3.new(0, -0.6, 0)
    
    -- Навершие рукояти
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Size = Vector3.new(0.2, 0.2, 0.2)
    pommel.Material = Enum.Material.Wood
    pommel.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Parent = model
    
    pommel.Position = handle.Position + Vector3.new(0, -0.3, 0)
    
    -- Острие меча
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Size = Vector3.new(0.05, 0.2, 0.05)
    tip.Material = Enum.Material.Wood
    tip.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    tip.Anchored = true
    tip.CanCollide = false
    tip.Parent = model
    
    tip.Position = blade.Position + Vector3.new(0, 0.7, 0)
    
    -- Деревянные заклепки на рукояти
    for i = 1, 3 do
        local rivet = Instance.new("Part")
        rivet.Name = "HandleRivet" .. i
        rivet.Size = Vector3.new(0.05, 0.05, 0.05)
        rivet.Material = Enum.Material.Wood
        rivet.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local yPos = -0.6 + (i - 1) * 0.2
        rivet.Position = handle.Position + Vector3.new(0, yPos, 0.1)
    end
    
    -- Деревянные узоры на клинке
    for i = 1, 4 do
        local pattern = Instance.new("Part")
        pattern.Name = "BladePattern" .. i
        pattern.Size = Vector3.new(0.08, 0.05, 0.08)
        pattern.Material = Enum.Material.Wood
        pattern.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.4 + (i - 1) * 0.3
        pattern.Position = blade.Position + Vector3.new(0, yPos, 0.075)
    end
    
    -- Деревянные декоративные элементы на гарде
    for i = 1, 2 do
        local decoration = Instance.new("Part")
        decoration.Name = "GuardDecoration" .. i
        decoration.Size = Vector3.new(0.1, 0.15, 0.1)
        decoration.Material = Enum.Material.Wood
        decoration.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local xPos = (i == 1) and 0.25 or -0.25
        decoration.Position = guard.Position + Vector3.new(xPos, 0, 0)
    end
    
    -- Деревянные кольца на рукояти
    for i = 1, 2 do
        local ring = Instance.new("Part")
        ring.Name = "HandleRing" .. i
        ring.Size = Vector3.new(0.2, 0.05, 0.2)
        ring.Material = Enum.Material.Wood
        ring.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = (i == 1) and -0.5 or -0.1
        ring.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Деревянные насечки на клинке
    for i = 1, 6 do
        local notch = Instance.new("Part")
        notch.Name = "BladeNotch" .. i
        notch.Size = Vector3.new(0.06, 0.02, 0.06)
        notch.Material = Enum.Material.Wood
        notch.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        notch.Anchored = true
        notch.CanCollide = false
        notch.Parent = model
        
        -- Позиционирование насечек
        local yPos = -0.5 + (i - 1) * 0.2
        notch.Position = blade.Position + Vector3.new(0, yPos, 0.08)
    end
    
    -- Деревянная обмотка рукояти
    for i = 1, 8 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.16, 0.02, 0.16)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.6 + (i - 1) * 0.05
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Деревянные зазубрины на клинке
    for i = 1, 3 do
        local serration = Instance.new("Part")
        serration.Name = "BladeSerration" .. i
        serration.Size = Vector3.new(0.04, 0.1, 0.04)
        serration.Material = Enum.Material.Wood
        serration.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        serration.Anchored = true
        serration.CanCollide = false
        serration.Parent = model
        
        -- Позиционирование зазубрин
        local yPos = 0.1 + (i - 1) * 0.3
        serration.Position = blade.Position + Vector3.new(0, yPos, 0.07)
    end
    
    -- Деревянные украшения на навершии
    for i = 1, 4 do
        local ornament = Instance.new("Part")
        ornament.Name = "PommelOrnament" .. i
        ornament.Size = Vector3.new(0.05, 0.05, 0.05)
        ornament.Material = Enum.Material.Wood
        ornament.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        ornament.Anchored = true
        ornament.CanCollide = false
        ornament.Parent = model
        
        -- Позиционирование украшений
        local angle = (i - 1) * 90
        local radius = 0.075
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        ornament.Position = pommel.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Деревянные частицы вокруг меча
    for i = 1, 10 do
        local particle = Instance.new("Part")
        particle.Name = "WoodParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Wood
        particle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-1, 1)
        local zPos = math.random(-0.3, 0.3)
        particle.Position = blade.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "sword")
    model:SetAttribute("WeaponMaterial", "wood")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("WeaponDamage", 15)
    model:SetAttribute("WeaponSpeed", 1.2)
    model:SetAttribute("WeaponRange", 3)
    model:SetAttribute("WeaponDurability", 50)
    model:SetAttribute("WeaponLevel", 1)
    model:SetAttribute("WeaponRarity", "common")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "sword")
    model:SetAttribute("WeaponWeight", 1.0)
    model:SetAttribute("WeaponValue", 10)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    
    return model
end

return CreateWoodenSword