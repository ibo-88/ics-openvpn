-- IronSword.lua
-- Модель железного меча

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateIronSword()
    local model = Instance.new("Model")
    model.Name = "IronSword"
    
    -- Клинок меча
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.08, 1.4, 0.08)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 2
    metalTexture.Parent = blade
    
    -- Рукоять меча
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.12, 0.5, 0.12)
    handle.Material = Enum.Material.Leather
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = blade.Position + Vector3.new(0, -0.95, 0)
    
    -- Гарда меча
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.5, 0.08, 0.08)
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    guard.Anchored = true
    guard.CanCollide = false
    guard.Parent = model
    
    guard.Position = blade.Position + Vector3.new(0, -0.7, 0)
    
    -- Навершие рукояти
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Size = Vector3.new(0.15, 0.15, 0.15)
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Parent = model
    
    pommel.Position = handle.Position + Vector3.new(0, -0.325, 0)
    
    -- Острие меча
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Size = Vector3.new(0.04, 0.25, 0.04)
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    tip.Anchored = true
    tip.CanCollide = false
    tip.Parent = model
    
    tip.Position = blade.Position + Vector3.new(0, 0.825, 0)
    
    -- Доли клинка
    for i = 1, 2 do
        local fuller = Instance.new("Part")
        fuller.Name = "BladeFuller" .. i
        fuller.Size = Vector3.new(0.06, 1.2, 0.02)
        fuller.Material = Enum.Material.Metal
        fuller.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        fuller.Anchored = true
        fuller.CanCollide = false
        fuller.Parent = model
        
        -- Позиционирование долей
        local zPos = (i == 1) and 0.05 or -0.05
        fuller.Position = blade.Position + Vector3.new(0, 0.1, zPos)
    end
    
    -- Зазубрины на клинке
    for i = 1, 5 do
        local serration = Instance.new("Part")
        serration.Name = "BladeSerration" .. i
        serration.Size = Vector3.new(0.03, 0.08, 0.03)
        serration.Material = Enum.Material.Metal
        serration.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        serration.Anchored = true
        serration.CanCollide = false
        serration.Parent = model
        
        -- Позиционирование зазубрин
        local yPos = 0.2 + (i - 1) * 0.25
        serration.Position = blade.Position + Vector3.new(0, yPos, 0.055)
    end
    
    -- Металлические заклепки на рукояти
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "HandleRivet" .. i
        rivet.Size = Vector3.new(0.03, 0.03, 0.03)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local yPos = -0.7 + (i - 1) * 0.15
        rivet.Position = handle.Position + Vector3.new(0, yPos, 0.075)
    end
    
    -- Декоративные элементы на гарде
    for i = 1, 2 do
        local decoration = Instance.new("Part")
        decoration.Name = "GuardDecoration" .. i
        decoration.Size = Vector3.new(0.08, 0.12, 0.08)
        decoration.Material = Enum.Material.Metal
        decoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        decoration.Anchored = true
        decoration.CanCollide = false
        decoration.Parent = model
        
        -- Позиционирование декораций
        local xPos = (i == 1) and 0.29 or -0.29
        decoration.Position = guard.Position + Vector3.new(xPos, 0, 0)
    end
    
    -- Кольца на рукояти
    for i = 1, 3 do
        local ring = Instance.new("Part")
        ring.Name = "HandleRing" .. i
        ring.Size = Vector3.new(0.15, 0.03, 0.15)
        ring.Material = Enum.Material.Metal
        ring.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.6 + (i - 1) * 0.15
        ring.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Насечки на клинке
    for i = 1, 8 do
        local notch = Instance.new("Part")
        notch.Name = "BladeNotch" .. i
        notch.Size = Vector3.new(0.05, 0.015, 0.05)
        notch.Material = Enum.Material.Metal
        notch.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        notch.Anchored = true
        notch.CanCollide = false
        notch.Parent = model
        
        -- Позиционирование насечек
        local yPos = -0.6 + (i - 1) * 0.15
        notch.Position = blade.Position + Vector3.new(0, yPos, 0.06)
    end
    
    -- Обмотка рукояти
    for i = 1, 12 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.13, 0.015, 0.13)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.7 + (i - 1) * 0.04
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Украшения на навершии
    for i = 1, 6 do
        local ornament = Instance.new("Part")
        ornament.Name = "PommelOrnament" .. i
        ornament.Size = Vector3.new(0.03, 0.03, 0.03)
        ornament.Material = Enum.Material.Metal
        ornament.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        ornament.Anchored = true
        ornament.CanCollide = false
        ornament.Parent = model
        
        -- Позиционирование украшений
        local angle = (i - 1) * 60
        local radius = 0.06
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        ornament.Position = pommel.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Металлические частицы вокруг меча
    for i = 1, 15 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Metal
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-1.2, 1.2)
        local zPos = math.random(-0.4, 0.4)
        particle.Position = blade.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.3
        particleLight.Parent = particle
    end
    
    -- Свечение клинка
    local bladeLight = Instance.new("PointLight")
    bladeLight.Color = Color3.fromRGB(192, 192, 192)
    bladeLight.Range = 2
    bladeLight.Brightness = 0.5
    bladeLight.Parent = blade
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "sword")
    model:SetAttribute("WeaponMaterial", "iron")
    model:SetAttribute("WeaponQuality", "uncommon")
    model:SetAttribute("WeaponDamage", 25)
    model:SetAttribute("WeaponSpeed", 1.0)
    model:SetAttribute("WeaponRange", 4)
    model:SetAttribute("WeaponDurability", 100)
    model:SetAttribute("WeaponLevel", 3)
    model:SetAttribute("WeaponRarity", "uncommon")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "sword")
    model:SetAttribute("WeaponWeight", 1.5)
    model:SetAttribute("WeaponValue", 25)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("WeaponSharpness", 85)
    model:SetAttribute("WeaponBalance", 90)
    model:SetAttribute("WeaponFlexibility", 75)
    
    return model
end

return CreateIronSword