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
    handle.Size = Vector3.new(0.15, 2, 0.15)
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
    
    -- Головка топора
    local axeHead = Instance.new("Part")
    axeHead.Name = "AxeHead"
    axeHead.Size = Vector3.new(0.8, 0.6, 0.3)
    axeHead.Material = Enum.Material.Metal
    axeHead.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    axeHead.Anchored = true
    axeHead.CanCollide = false
    axeHead.Parent = model
    
    axeHead.Position = handle.Position + Vector3.new(0, 1.3, 0)
    
    -- Лезвие топора
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.1, 0.8, 0.4)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(255, 255, 255) -- Белый
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    blade.Position = axeHead.Position + Vector3.new(0.35, 0, 0)
    
    -- Острие лезвия
    local bladeTip = Instance.new("Part")
    bladeTip.Name = "BladeTip"
    bladeTip.Size = Vector3.new(0.05, 0.3, 0.4)
    bladeTip.Material = Enum.Material.Metal
    bladeTip.Color = Color3.fromRGB(255, 255, 255) -- Белый
    bladeTip.Anchored = true
    bladeTip.CanCollide = false
    bladeTip.Parent = model
    
    bladeTip.Position = blade.Position + Vector3.new(0.075, 0.55, 0)
    bladeTip.Orientation = Vector3.new(0, 0, 45)
    
    -- Противоположная сторона топора (обух)
    local backside = Instance.new("Part")
    backside.Name = "Backside"
    backside.Size = Vector3.new(0.3, 0.6, 0.3)
    backside.Material = Enum.Material.Metal
    backside.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
    backside.Anchored = true
    backside.CanCollide = false
    backside.Parent = model
    
    backside.Position = axeHead.Position + Vector3.new(-0.25, 0, 0)
    
    -- Крепление головки к рукояти
    local mount = Instance.new("Part")
    mount.Name = "Mount"
    mount.Size = Vector3.new(0.2, 0.4, 0.2)
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    mount.Anchored = true
    mount.CanCollide = false
    mount.Parent = model
    
    mount.Position = axeHead.Position + Vector3.new(0, -0.5, 0)
    
    -- Заклепки крепления
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "MountRivet" .. i
        rivet.Size = Vector3.new(0.1, 0.1, 0.1)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 90
        local radius = 0.1
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rivet.Position = mount.Position + Vector3.new(xPos, 0, zPos)
    end
    
    -- Обмотка рукояти
    for i = 1, 8 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.18, 0.1, 0.18)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.8 + (i - 1) * 0.2
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Декоративные узоры на головке
    for i = 1, 3 do
        local pattern = Instance.new("Part")
        pattern.Name = "HeadPattern" .. i
        pattern.Size = Vector3.new(0.6, 0.1, 0.05)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.2 + (i - 1) * 0.2
        pattern.Position = axeHead.Position + Vector3.new(0, yPos, 0.175)
    end
    
    -- Магические руны на лезвии
    for i = 1, 2 do
        local rune = Instance.new("Part")
        rune.Name = "BladeRune" .. i
        rune.Size = Vector3.new(0.08, 0.08, 0.05)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local yPos = (i == 1) and 0.2 or -0.2
        rune.Position = blade.Position + Vector3.new(0, yPos, 0.225)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 1
        runeLight.Brightness = 0.5
        runeLight.Parent = rune
    end
    
    -- Драгоценный камень в рукояти
    local gem = Instance.new("Part")
    gem.Name = "HandleGem"
    gem.Size = Vector3.new(0.1, 0.1, 0.1)
    gem.Material = Enum.Material.Neon
    gem.Color = Color3.fromRGB(255, 0, 0) -- Красный
    gem.Anchored = true
    gem.CanCollide = false
    gem.Parent = model
    
    gem.Position = handle.Position + Vector3.new(0, -0.5, 0)
    
    -- Свечение камня
    local gemLight = Instance.new("PointLight")
    gemLight.Color = Color3.fromRGB(255, 0, 0)
    gemLight.Range = 1.5
    gemLight.Brightness = 0.8
    gemLight.Parent = gem
    
    -- Кожаные ножны для топора
    local sheath = Instance.new("Part")
    sheath.Name = "AxeSheath"
    sheath.Size = Vector3.new(0.3, 2.2, 0.2)
    sheath.Material = Enum.Material.Leather
    sheath.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
    sheath.Anchored = true
    sheath.CanCollide = false
    sheath.Parent = model
    
    sheath.Position = handle.Position + Vector3.new(0, 0, -0.3)
    
    -- Металлические накладки на ножнах
    for i = 1, 3 do
        local fitting = Instance.new("Part")
        fitting.Name = "SheathFitting" .. i
        fitting.Size = Vector3.new(0.35, 0.15, 0.25)
        fitting.Material = Enum.Material.Metal
        fitting.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        fitting.Anchored = true
        fitting.CanCollide = false
        fitting.Parent = model
        
        -- Позиционирование накладок
        local yPos = -0.6 + (i - 1) * 0.6
        fitting.Position = sheath.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Подвес для ножен
    local suspension = Instance.new("Part")
    suspension.Name = "AxeSuspension"
    suspension.Size = Vector3.new(0.1, 0.6, 0.1)
    suspension.Material = Enum.Material.Metal
    suspension.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    suspension.Anchored = true
    suspension.CanCollide = false
    suspension.Parent = model
    
    suspension.Position = sheath.Position + Vector3.new(0, 1.1, 0)
    
    -- Кольцо подвеса
    local ring = Instance.new("Part")
    ring.Name = "AxeSuspensionRing"
    ring.Size = Vector3.new(0.25, 0.25, 0.1)
    ring.Material = Enum.Material.Metal
    ring.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    ring.Anchored = true
    ring.CanCollide = false
    ring.Parent = model
    
    ring.Position = suspension.Position + Vector3.new(0, 0.425, 0)
    
    -- Эффект заточки лезвия
    local sharpnessEffect = Instance.new("Part")
    sharpnessEffect.Name = "AxeSharpnessEffect"
    sharpnessEffect.Size = Vector3.new(0.15, 0.8, 0.45)
    sharpnessEffect.Material = Enum.Material.Neon
    sharpnessEffect.Color = Color3.fromRGB(255, 255, 255) -- Белый
    sharpnessEffect.Transparency = 0.8
    sharpnessEffect.Anchored = true
    sharpnessEffect.CanCollide = false
    sharpnessEffect.Parent = model
    
    sharpnessEffect.Position = blade.Position + Vector3.new(0, 0, 0.225)
    
    -- Свечение заточки
    local sharpnessLight = Instance.new("PointLight")
    sharpnessLight.Color = Color3.fromRGB(255, 255, 255)
    sharpnessLight.Range = 2
    sharpnessLight.Brightness = 0.3
    sharpnessLight.Parent = sharpnessEffect
    
    -- Эффект силы топора
    local powerEffect = Instance.new("Part")
    powerEffect.Name = "AxePowerEffect"
    powerEffect.Size = Vector3.new(1.2, 2.5, 1.2)
    powerEffect.Material = Enum.Material.Neon
    powerEffect.Color = Color3.fromRGB(255, 100, 0) -- Оранжевый
    powerEffect.Transparency = 0.9
    powerEffect.Anchored = true
    powerEffect.CanCollide = false
    powerEffect.Parent = model
    
    powerEffect.Position = handle.Position
    
    -- Свечение силы
    local powerLight = Instance.new("PointLight")
    powerLight.Color = Color3.fromRGB(255, 100, 0)
    powerLight.Range = 4
    powerLight.Brightness = 0.5
    powerLight.Parent = powerEffect
    
    -- UI для топора
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = axeHead
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = "Топор"
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
    model:SetAttribute("WeaponType", "axe")
    model:SetAttribute("WeaponQuality", "common")
    model:SetAttribute("Damage", 35)
    model:SetAttribute("AttackSpeed", 1.2)
    model:SetAttribute("AttackRange", 5)
    model:SetAttribute("Durability", 120)
    model:SetAttribute("MaxDurability", 120)
    model:SetAttribute("Sharpness", 1.0)
    model:SetAttribute("IsWeapon", true)
    model:SetAttribute("CanBeEnchanted", true)
    model:SetAttribute("EnchantmentSlots", 2)
    model:SetAttribute("BladeRunes", 2)
    model:SetAttribute("HandleGem", true)
    model:SetAttribute("SheathIncluded", true)
    model:SetAttribute("PowerEffect", true)
    
    -- Сохранение ссылок на UI элементы
    model:SetAttribute("NameLabel", nameLabel)
    model:SetAttribute("QualityLabel", qualityLabel)
    
    return model
end

return CreateAxe