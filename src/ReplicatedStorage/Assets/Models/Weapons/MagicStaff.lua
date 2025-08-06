-- MagicStaff.lua
-- Модель магического посоха

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateMagicStaff()
    local model = Instance.new("Model")
    model.Name = "MagicStaff"
    
    -- Основной ствол посоха
    local staff = Instance.new("Part")
    staff.Name = "Staff"
    staff.Size = Vector3.new(0.08, 2.5, 0.08)
    staff.Material = Enum.Material.Wood
    staff.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    staff.Anchored = true
    staff.CanCollide = false
    staff.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 3
    woodTexture.Parent = staff
    
    -- Магический кристалл на вершине
    local crystal = Instance.new("Part")
    crystal.Name = "MagicCrystal"
    crystal.Size = Vector3.new(0.3, 0.4, 0.3)
    crystal.Material = Enum.Material.Neon
    crystal.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    crystal.Anchored = true
    crystal.CanCollide = false
    crystal.Parent = model
    
    crystal.Position = staff.Position + Vector3.new(0, 1.45, 0)
    
    -- Свечение кристалла
    local crystalLight = Instance.new("PointLight")
    crystalLight.Color = Color3.fromRGB(255, 0, 255)
    crystalLight.Range = 4
    crystalLight.Brightness = 2
    crystalLight.Parent = crystal
    
    -- Магические руны на кристалле
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "CrystalRune" .. i
        rune.Size = Vector3.new(0.1, 0.1, 0.05)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 0.2
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = crystal.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 0)
        runeLight.Range = 1
        runeLight.Brightness = 1
        runeLight.Parent = rune
    end
    
    -- Магические кольца вокруг кристалла
    for i = 1, 3 do
        local ring = Instance.new("Part")
        ring.Name = "MagicRing" .. i
        ring.Size = Vector3.new(0.4 + i * 0.1, 0.05, 0.4 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        ring.Transparency = 0.5
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = crystal.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(0, 255, 255)
        ringLight.Range = 2 + i * 0.5
        ringLight.Brightness = 0.8
        ringLight.Parent = ring
    end
    
    -- Магические камни вдоль посоха
    for i = 1, 5 do
        local gem = Instance.new("Part")
        gem.Name = "StaffGem" .. i
        gem.Size = Vector3.new(0.15, 0.15, 0.15)
        gem.Material = Enum.Material.Neon
        gem.Color = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255)) -- Случайный цвет
        gem.Anchored = true
        gem.CanCollide = false
        gem.Parent = model
        
        -- Позиционирование камней
        local yPos = -1 + (i - 1) * 0.4
        gem.Position = staff.Position + Vector3.new(0, yPos, 0.075)
        
        -- Свечение камней
        local gemLight = Instance.new("PointLight")
        gemLight.Color = gem.Color
        gemLight.Range = 1.5
        gemLight.Brightness = 1
        gemLight.Parent = gem
    end
    
    -- Магические руны на посохе
    for i = 1, 8 do
        local staffRune = Instance.new("Part")
        staffRune.Name = "StaffRune" .. i
        staffRune.Size = Vector3.new(0.08, 0.08, 0.05)
        staffRune.Material = Enum.Material.Neon
        staffRune.Color = Color3.fromRGB(255, 255, 0) -- Золотой
        staffRune.Anchored = true
        staffRune.CanCollide = false
        staffRune.Parent = model
        
        -- Позиционирование рун
        local yPos = -1.2 + (i - 1) * 0.3
        staffRune.Position = staff.Position + Vector3.new(0, yPos, 0.065)
        
        -- Свечение рун
        local staffRuneLight = Instance.new("PointLight")
        staffRuneLight.Color = Color3.fromRGB(255, 255, 0)
        staffRuneLight.Range = 0.8
        staffRuneLight.Brightness = 0.6
        staffRuneLight.Parent = staffRune
    end
    
    -- Магическая обмотка посоха
    for i = 1, 20 do
        local wrap = Instance.new("Part")
        wrap.Name = "StaffWrap" .. i
        wrap.Size = Vector3.new(0.09, 0.02, 0.09)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(75, 0, 130) -- Индиго
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -1.25 + (i - 1) * 0.125
        wrap.Position = staff.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Магические частицы вокруг посоха
    for i = 1, 25 do
        local particle = Instance.new("Part")
        particle.Name = "MagicParticle" .. i
        particle.Size = Vector3.new(0.02, 0.02, 0.02)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.5, 0.5)
        local yPos = math.random(-1.5, 1.5)
        local zPos = math.random(-0.5, 0.5)
        particle.Position = staff.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(255, 255, 255)
        particleLight.Range = 0.4
        particleLight.Brightness = 0.5
        particleLight.Parent = particle
    end
    
    -- Магическая аура вокруг посоха
    local aura = Instance.new("Part")
    aura.Name = "StaffAura"
    aura.Size = Vector3.new(0.3, 2.5, 0.3)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
    aura.Transparency = 0.8
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = staff.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(255, 0, 255)
    auraLight.Range = 3
    auraLight.Brightness = 0.8
    auraLight.Parent = aura
    
    -- Магические кольца вокруг посоха
    for i = 1, 4 do
        local magicRing = Instance.new("Part")
        magicRing.Name = "StaffMagicRing" .. i
        magicRing.Size = Vector3.new(0.2 + i * 0.1, 0.02, 0.2 + i * 0.1)
        magicRing.Material = Enum.Material.Neon
        magicRing.Color = Color3.fromRGB(255, 0, 255) -- Пурпурный
        magicRing.Transparency = 0.7
        magicRing.Anchored = true
        magicRing.CanCollide = false
        magicRing.Parent = model
        
        -- Позиционирование колец
        local yPos = -1 + (i - 1) * 0.5
        magicRing.Position = staff.Position + Vector3.new(0, yPos, 0)
        
        -- Свечение колец
        local magicRingLight = Instance.new("PointLight")
        magicRingLight.Color = Color3.fromRGB(255, 0, 255)
        magicRingLight.Range = 1.5 + i * 0.3
        magicRingLight.Brightness = 0.6
        magicRingLight.Parent = magicRing
    end
    
    -- Магические символы на посохе
    for i = 1, 6 do
        local symbol = Instance.new("Part")
        symbol.Name = "StaffSymbol" .. i
        symbol.Size = Vector3.new(0.1, 0.1, 0.05)
        symbol.Material = Enum.Material.Neon
        symbol.Color = Color3.fromRGB(0, 255, 255) -- Голубой
        symbol.Anchored = true
        symbol.CanCollide = false
        symbol.Parent = model
        
        -- Позиционирование символов
        local yPos = -1.1 + (i - 1) * 0.4
        symbol.Position = staff.Position + Vector3.new(0, yPos, 0.065)
        
        -- Свечение символов
        local symbolLight = Instance.new("PointLight")
        symbolLight.Color = Color3.fromRGB(0, 255, 255)
        symbolLight.Range = 1
        symbolLight.Brightness = 0.7
        symbolLight.Parent = symbol
    end
    
    -- Магические искры
    for i = 1, 12 do
        local spark = Instance.new("Part")
        spark.Name = "MagicSpark" .. i
        spark.Size = Vector3.new(0.01, 0.01, 0.01)
        spark.Material = Enum.Material.Neon
        spark.Color = Color3.fromRGB(255, 255, 0) -- Желтый
        spark.Anchored = true
        spark.CanCollide = false
        spark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-1.2, 1.2)
        local zPos = math.random(-0.3, 0.3)
        spark.Position = staff.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 255, 0)
        sparkLight.Range = 0.3
        sparkLight.Brightness = 0.8
        sparkLight.Parent = spark
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "staff")
    model:SetAttribute("WeaponMaterial", "magic")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 35)
    model:SetAttribute("WeaponSpeed", 0.8)
    model:SetAttribute("WeaponRange", 8)
    model:SetAttribute("WeaponDurability", 150)
    model:SetAttribute("WeaponLevel", 5)
    model:SetAttribute("WeaponRarity", "rare")
    model:SetAttribute("WeaponClass", "magic")
    model:SetAttribute("WeaponSubclass", "staff")
    model:SetAttribute("WeaponWeight", 2.0)
    model:SetAttribute("WeaponValue", 75)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("MagicPower", 85)
    model:SetAttribute("SpellRange", 12)
    model:SetAttribute("ManaCost", 15)
    model:SetAttribute("MagicRegeneration", 5)
    
    return model
end

return CreateMagicStaff