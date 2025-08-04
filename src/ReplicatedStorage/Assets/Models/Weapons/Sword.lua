-- Sword.lua
-- Модель меча

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateSword()
    local model = Instance.new("Model")
    model.Name = "Sword"
    
    -- Клинок меча
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.2, 2.5, 0.1)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    -- Создание текстуры клинка
    local bladeTexture = Instance.new("Texture")
    bladeTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    bladeTexture.StudsPerTileU = 1
    bladeTexture.StudsPerTileV = 2
    bladeTexture.Parent = blade
    
    -- Рукоять меча
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.15, 0.8, 0.15)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = blade.Position + Vector3.new(0, -1.65, 0)
    
    -- Обмотка рукояти
    for i = 1, 6 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.18, 0.1, 0.18)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -1.2 + (i - 1) * 0.15
        wrap.Position = blade.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Гарда меча
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.8, 0.2, 0.3)
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    guard.Anchored = true
    guard.CanCollide = false
    guard.Parent = model
    
    guard.Position = blade.Position + Vector3.new(0, -1.25, 0)
    
    -- Декоративные элементы гарды
    for i = 1, 2 do
        local guardDecoration = Instance.new("Part")
        guardDecoration.Name = "GuardDecoration" .. i
        guardDecoration.Size = Vector3.new(0.1, 0.3, 0.1)
        guardDecoration.Material = Enum.Material.Metal
        guardDecoration.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        guardDecoration.Anchored = true
        guardDecoration.CanCollide = false
        guardDecoration.Parent = model
        
        -- Позиционирование декораций
        local xPos = (i == 1) and 0.35 or -0.35
        guardDecoration.Position = guard.Position + Vector3.new(xPos, 0.25, 0)
    end
    
    -- Навершие рукояти
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Size = Vector3.new(0.2, 0.3, 0.2)
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Parent = model
    
    pommel.Position = handle.Position + Vector3.new(0, -0.55, 0)
    
    -- Дол клинка
    local fuller = Instance.new("Part")
    fuller.Name = "Fuller"
    fuller.Size = Vector3.new(0.1, 2.3, 0.05)
    fuller.Material = Enum.Material.Metal
    fuller.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    fuller.Anchored = true
    fuller.CanCollide = false
    fuller.Parent = model
    
    fuller.Position = blade.Position + Vector3.new(0, 0.1, 0.075)
    
    -- Острие клинка
    local tip = Instance.new("Part")
    tip.Name = "Tip"
    tip.Size = Vector3.new(0.1, 0.3, 0.05)
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    tip.Anchored = true
    tip.CanCollide = false
    tip.Parent = model
    
    tip.Position = blade.Position + Vector3.new(0, 1.4, 0.075)
    tip.Orientation = Vector3.new(0, 0, 45)
    
    -- Режущая кромка
    local edge = Instance.new("Part")
    edge.Name = "Edge"
    edge.Size = Vector3.new(0.05, 2.5, 0.1)
    edge.Material = Enum.Material.Metal
    edge.Color = Color3.fromRGB(255, 255, 255) -- Белый
    edge.Anchored = true
    edge.CanCollide = false
    edge.Parent = model
    
    edge.Position = blade.Position + Vector3.new(0, 0, 0.1)
    
    -- Декоративные руны на клинке
    for i = 1, 3 do
        local rune = Instance.new("Part")
        rune.Name = "BladeRune" .. i
        rune.Size = Vector3.new(0.15, 0.15, 0.05)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local yPos = -0.5 + (i - 1) * 0.8
        rune.Position = blade.Position + Vector3.new(0, yPos, 0.075)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 1
        runeLight.Brightness = 0.5
        runeLight.Parent = rune
    end
    
    -- Драгоценный камень в навершии
    local gem = Instance.new("Part")
    gem.Name = "PommelGem"
    gem.Size = Vector3.new(0.1, 0.1, 0.1)
    gem.Material = Enum.Material.Neon
    gem.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    gem.Anchored = true
    gem.CanCollide = false
    gem.Parent = model
    
    gem.Position = pommel.Position + Vector3.new(0, 0.2, 0)
    
    -- Свечение камня
    local gemLight = Instance.new("PointLight")
    gemLight.Color = Color3.fromRGB(255, 0, 255)
    gemLight.Range = 2
    gemLight.Brightness = 1
    gemLight.Parent = gem
    
    -- Кожаные ножны
    local scabbard = Instance.new("Part")
    scabbard.Name = "Scabbard"
    scabbard.Size = Vector3.new(0.25, 2.8, 0.15)
    scabbard.Material = Enum.Material.Leather
    scabbard.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
    scabbard.Anchored = true
    scabbard.CanCollide = false
    scabbard.Parent = model
    
    scabbard.Position = blade.Position + Vector3.new(0, 0, -0.2)
    
    -- Металлические накладки на ножнах
    for i = 1, 3 do
        local fitting = Instance.new("Part")
        fitting.Name = "ScabbardFitting" .. i
        fitting.Size = Vector3.new(0.3, 0.2, 0.2)
        fitting.Material = Enum.Material.Metal
        fitting.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        fitting.Anchored = true
        fitting.CanCollide = false
        fitting.Parent = model
        
        -- Позиционирование накладок
        local yPos = -0.8 + (i - 1) * 0.8
        fitting.Position = scabbard.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Подвес для ножен
    local suspension = Instance.new("Part")
    suspension.Name = "Suspension"
    suspension.Size = Vector3.new(0.1, 0.8, 0.1)
    suspension.Material = Enum.Material.Metal
    suspension.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    suspension.Anchored = true
    suspension.CanCollide = false
    suspension.Parent = model
    
    suspension.Position = scabbard.Position + Vector3.new(0, 1.2, 0)
    
    -- Кольцо подвеса
    local ring = Instance.new("Part")
    ring.Name = "SuspensionRing"
    ring.Size = Vector3.new(0.3, 0.3, 0.1)
    ring.Material = Enum.Material.Metal
    ring.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    ring.Anchored = true
    ring.CanCollide = false
    ring.Parent = model
    
    ring.Position = suspension.Position + Vector3.new(0, 0.55, 0)
    
    -- Эффект заточки
    local sharpnessEffect = Instance.new("Part")
    sharpnessEffect.Name = "SharpnessEffect"
    sharpnessEffect.Size = Vector3.new(0.3, 2.5, 0.15)
    sharpnessEffect.Material = Enum.Material.Neon
    sharpnessEffect.Color = Color3.fromRGB(255, 255, 255) -- Белый
    sharpnessEffect.Transparency = 0.8
    sharpnessEffect.Anchored = true
    sharpnessEffect.CanCollide = false
    sharpnessEffect.Parent = model
    
    sharpnessEffect.Position = blade.Position + Vector3.new(0, 0, 0.125)
    
    -- Свечение заточки
    local sharpnessLight = Instance.new("PointLight")
    sharpnessLight.Color = Color3.fromRGB(255, 255, 255)
    sharpnessLight.Range = 3
    sharpnessLight.Brightness = 0.3
    sharpnessLight.Parent = sharpnessEffect
    
    -- UI для меча
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = blade
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Меч"
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local qualityLabel = Instance.new("TextLabel")
    qualityLabel.Size = UDim2.new(1, 0, 0.5, 0)
    qualityLabel.Position = UDim2.new(0, 0, 0.5, 0)
    qualityLabel.BackgroundTransparency = 1
    qualityLabel.Text = "Обычный"
    qualityLabel.TextColor3 = Color3.fromRGB(192, 192, 192) -- Серебряный
    qualityLabel.TextScaled = true
    qualityLabel.Font = Enum.Font.Gotham
    qualityLabel.Parent = billboardGui
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "sword")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("Damage", 25)
    model:SetAttribute("AttackSpeed", 1.5)
    model:SetAttribute("AttackRange", 4)
    model:SetAttribute("Durability", 100)
    model:SetAttribute("MaxDurability", 100)
    model:SetAttribute("Sharpness", 1.0)
    model:SetAttribute("IsWeapon", true)
    model:SetAttribute("CanBeEnchanted", true)
    model:SetAttribute("EnchantmentSlots", 2)
    model:SetAttribute("BladeRunes", 3)
    model:SetAttribute("PommelGem", true)
    model:SetAttribute("ScabbardIncluded", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("QualityLabel", qualityLabel)
    
    return model
end

return CreateSword