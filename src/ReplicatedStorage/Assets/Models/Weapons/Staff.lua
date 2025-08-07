-- Staff.lua
-- Модель магического посоха

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateStaff()
    local model = Instance.new("Model")
    model.Name = "Staff"
    
    -- Древко посоха
    local shaft = Instance.new("Part")
    shaft.Name = "Shaft"
    shaft.Size = Vector3.new(0.08, 2.2, 0.08)
    shaft.Material = Enum.Material.Wood
    shaft.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    shaft.Anchored = true
    shaft.CanCollide = false
    shaft.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 4
    woodTexture.Parent = shaft
    
    -- Магический кристалл на вершине
    local crystal = Instance.new("Part")
    crystal.Name = "MagicCrystal"
    crystal.Size = Vector3.new(0.2, 0.3, 0.2)
    crystal.Material = Enum.Material.Neon
    crystal.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
    crystal.Transparency = 0.3
    crystal.Anchored = true
    crystal.CanCollide = false
    crystal.Parent = model
    
    crystal.Position = shaft.Position + Vector3.new(0, 1.25, 0)
    
    -- Свечение кристалла
    local crystalLight = Instance.new("PointLight")
    crystalLight.Color = Color3.fromRGB(138, 43, 226)
    crystalLight.Range = 2.5
    crystalLight.Brightness = 2.0
    crystalLight.Parent = crystal
    
    -- Магические руны на кристалле
    for i = 1, 6 do
        local rune = Instance.new("Part")
        rune.Name = "CrystalRune" .. i
        rune.Size = Vector3.new(0.05, 0.05, 0.02)
        rune.Material = Enum.Material.Neon
        rune.Color = Color3.fromRGB(255, 255, 255) -- Белый
        rune.Anchored = true
        rune.CanCollide = false
        rune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 60
        local radius = 0.1
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        rune.Position = crystal.Position + Vector3.new(xPos, 0, zPos)
        
        -- Свечение рун
        local runeLight = Instance.new("PointLight")
        runeLight.Color = Color3.fromRGB(255, 255, 255)
        runeLight.Range = 0.8
        runeLight.Brightness = 1.5
        runeLight.Parent = rune
    end
    
    -- Крепление кристалла
    local mount = Instance.new("Part")
    mount.Name = "CrystalMount"
    mount.Size = Vector3.new(0.15, 0.2, 0.15)
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    mount.Anchored = true
    mount.CanCollide = false
    mount.Parent = model
    
    mount.Position = crystal.Position + Vector3.new(0, -0.25, 0)
    
    -- Свечение крепления
    local mountLight = Instance.new("PointLight")
    mountLight.Color = Color3.fromRGB(255, 215, 0)
    mountLight.Range = 1.0
    mountLight.Brightness = 0.8
    mountLight.Parent = mount
    
    -- Магические кольца на древке
    for i = 1, 8 do
        local ring = Instance.new("Part")
        ring.Name = "MagicRing" .. i
        ring.Size = Vector3.new(0.12, 0.03, 0.12)
        ring.Material = Enum.Material.Metal
        ring.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.9 + (i - 1) * 0.25
        ring.Position = shaft.Position + Vector3.new(0, yPos, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 215, 0)
        ringLight.Range = 0.6
        ringLight.Brightness = 0.7
        ringLight.Parent = ring
    end
    
    -- Магические руны на древке
    for i = 1, 12 do
        local shaftRune = Instance.new("Part")
        shaftRune.Name = "ShaftRune" .. i
        shaftRune.Size = Vector3.new(0.03, 0.03, 0.02)
        shaftRune.Material = Enum.Material.Neon
        shaftRune.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
        shaftRune.Anchored = true
        shaftRune.CanCollide = false
        shaftRune.Parent = model
        
        -- Позиционирование рун
        local angle = (i - 1) * 30
        local radius = 0.06
        local xPos = math.cos(math.rad(angle)) * radius
        local zPos = math.sin(math.rad(angle)) * radius
        local yPos = math.random(-0.8, 0.8)
        shaftRune.Position = shaft.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение рун
        local shaftRuneLight = Instance.new("PointLight")
        shaftRuneLight.Color = Color3.fromRGB(138, 43, 226)
        shaftRuneLight.Range = 0.4
        shaftRuneLight.Brightness = 1.0
        shaftRuneLight.Parent = shaftRune
    end
    
    -- Магические частицы вокруг посоха
    for i = 1, 40 do
        local particle = Instance.new("Part")
        particle.Name = "MagicParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.3, 0.3)
        local yPos = math.random(-1.2, 1.2)
        local zPos = math.random(-0.3, 0.3)
        particle.Position = shaft.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(138, 43, 226)
        particleLight.Range = 0.4
        particleLight.Brightness = 0.8
        particleLight.Parent = particle
    end
    
    -- Золотые частицы от колец
    for i = 1, 25 do
        local goldParticle = Instance.new("Part")
        goldParticle.Name = "GoldParticle" .. i
        goldParticle.Size = Vector3.new(0.01, 0.01, 0.01)
        goldParticle.Material = Enum.Material.Neon
        goldParticle.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        goldParticle.Anchored = true
        goldParticle.CanCollide = false
        goldParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.2, 0.2)
        local yPos = math.random(-1.0, 1.0)
        local zPos = math.random(-0.2, 0.2)
        goldParticle.Position = shaft.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local goldParticleLight = Instance.new("PointLight")
        goldParticleLight.Color = Color3.fromRGB(255, 215, 0)
        goldParticleLight.Range = 0.3
        goldParticleLight.Brightness = 0.6
        goldParticleLight.Parent = goldParticle
    end
    
    -- Белые частицы от кристалла
    for i = 1, 30 do
        local whiteParticle = Instance.new("Part")
        whiteParticle.Name = "WhiteParticle" .. i
        whiteParticle.Size = Vector3.new(0.012, 0.012, 0.012)
        whiteParticle.Material = Enum.Material.Neon
        whiteParticle.Color = Color3.fromRGB(255, 255, 255) -- Белый
        whiteParticle.Anchored = true
        whiteParticle.CanCollide = false
        whiteParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.25, 0.25)
        local yPos = math.random(1.0, 1.5)
        local zPos = math.random(-0.25, 0.25)
        whiteParticle.Position = crystal.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local whiteParticleLight = Instance.new("PointLight")
        whiteParticleLight.Color = Color3.fromRGB(255, 255, 255)
        whiteParticleLight.Range = 0.35
        whiteParticleLight.Brightness = 0.9
        whiteParticleLight.Parent = whiteParticle
    end
    
    -- Магическая аура вокруг посоха
    local aura = Instance.new("Part")
    aura.Name = "StaffAura"
    aura.Size = Vector3.new(0.4, 2.5, 0.4)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = shaft.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(138, 43, 226)
    auraLight.Range = 3.0
    auraLight.Brightness = 0.5
    auraLight.Parent = aura
    
    -- Магические кольца вокруг посоха
    for i = 1, 6 do
        local magicRing = Instance.new("Part")
        magicRing.Name = "AuraRing" .. i
        magicRing.Size = Vector3.new(0.3 + i * 0.1, 0.01, 0.3 + i * 0.1)
        magicRing.Material = Enum.Material.Neon
        magicRing.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
        magicRing.Transparency = 0.8
        magicRing.Anchored = true
        magicRing.CanCollide = false
        magicRing.Parent = model
        
        magicRing.Position = shaft.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local magicRingLight = Instance.new("PointLight")
        magicRingLight.Color = Color3.fromRGB(138, 43, 226)
        magicRingLight.Range = 1.5 + i * 0.3
        magicRingLight.Brightness = 0.4
        magicRingLight.Parent = magicRing
    end
    
    -- Магические спирали
    for i = 1, 4 do
        local spiral = Instance.new("Part")
        spiral.Name = "MagicSpiral" .. i
        spiral.Size = Vector3.new(0.25 + i * 0.1, 0.005, 0.25 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
        spiral.Transparency = 0.7
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = shaft.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(138, 43, 226)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.3
        spiralLight.Parent = spiral
    end
    
    -- Магические звезды
    for i = 1, 10 do
        local star = Instance.new("Part")
        star.Name = "MagicStar" .. i
        star.Size = Vector3.new(0.03, 0.03, 0.03)
        star.Material = Enum.Material.Neon
        star.Color = Color3.fromRGB(255, 255, 255) -- Белый
        star.Anchored = true
        star.CanCollide = false
        star.Parent = model
        
        -- Случайное позиционирование звезд
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-1.1, 1.1)
        local zPos = math.random(-0.4, 0.4)
        star.Position = shaft.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение звезд
        local starLight = Instance.new("PointLight")
        starLight.Color = Color3.fromRGB(255, 255, 255)
        starLight.Range = 0.5
        starLight.Brightness = 1.2
        starLight.Parent = star
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "staff")
    model:SetAttribute("WeaponMaterial", "magic")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 40)
    model:SetAttribute("WeaponSpeed", 0.8)
    model:SetAttribute("WeaponRange", 6)
    model:SetAttribute("WeaponDurability", 120)
    model:SetAttribute("WeaponLevel", 5)
    model:SetAttribute("WeaponRarity", "rare")
    model:SetAttribute("WeaponClass", "magic")
    model:SetAttribute("WeaponSubclass", "staff")
    model:SetAttribute("WeaponWeight", 2.0)
    model:SetAttribute("WeaponValue", 60)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("StaffMagic", 50)
    model:SetAttribute("StaffRange", 6)
    model:SetAttribute("StaffPower", 75)
    
    return model
end

return CreateStaff