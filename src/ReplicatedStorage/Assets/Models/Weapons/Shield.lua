-- Shield.lua
-- Модель щита

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateShield()
    local model = Instance.new("Model")
    model.Name = "Shield"
    
    -- Основная часть щита
    local shield = Instance.new("Part")
    shield.Name = "ShieldBody"
    shield.Size = Vector3.new(0.8, 1.2, 0.1)
    shield.Material = Enum.Material.Wood
    shield.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    shield.Anchored = true
    shield.CanCollide = false
    shield.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 2
    woodTexture.StudsPerTileV = 3
    woodTexture.Parent = shield
    
    -- Металлическая окантовка щита
    local border = Instance.new("Part")
    border.Name = "ShieldBorder"
    border.Size = Vector3.new(0.85, 1.25, 0.05)
    border.Material = Enum.Material.Metal
    border.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    border.Anchored = true
    border.CanCollide = false
    border.Parent = model
    
    border.Position = shield.Position
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = border
    
    -- Свечение окантовки
    local borderLight = Instance.new("PointLight")
    borderLight.Color = Color3.fromRGB(192, 192, 192)
    borderLight.Range = 1.5
    borderLight.Brightness = 0.4
    borderLight.Parent = border
    
    -- Центральная бляха щита
    local boss = Instance.new("Part")
    boss.Name = "ShieldBoss"
    boss.Size = Vector3.new(0.2, 0.2, 0.08)
    boss.Material = Enum.Material.Metal
    boss.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    boss.Anchored = true
    boss.CanCollide = false
    boss.Parent = model
    
    boss.Position = shield.Position + Vector3.new(0, 0, 0.09)
    
    -- Свечение бляхи
    local bossLight = Instance.new("PointLight")
    bossLight.Color = Color3.fromRGB(255, 215, 0)
    bossLight.Range = 1.0
    bossLight.Brightness = 0.8
    bossLight.Parent = boss
    
    -- Декоративные узоры на щите
    for i = 1, 6 do
        local pattern = Instance.new("Part")
        pattern.Name = "ShieldPattern" .. i
        pattern.Size = Vector3.new(0.6, 0.05, 0.02)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.5 + (i - 1) * 0.2
        pattern.Position = shield.Position + Vector3.new(0, yPos, 0.06)
    end
    
    -- Вертикальные узоры
    for i = 1, 4 do
        local verticalPattern = Instance.new("Part")
        verticalPattern.Name = "VerticalPattern" .. i
        verticalPattern.Size = Vector3.new(0.05, 1.0, 0.02)
        verticalPattern.Material = Enum.Material.Metal
        verticalPattern.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        verticalPattern.Anchored = true
        verticalPattern.CanCollide = false
        verticalPattern.Parent = model
        
        -- Позиционирование вертикальных узоров
        local xPos = -0.3 + (i - 1) * 0.2
        verticalPattern.Position = shield.Position + Vector3.new(xPos, 0, 0.06)
    end
    
    -- Рукоять щита
    local handle = Instance.new("Part")
    handle.Name = "ShieldHandle"
    handle.Size = Vector3.new(0.15, 0.4, 0.08)
    handle.Material = Enum.Material.Metal
    handle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = shield.Position + Vector3.new(0, 0, -0.09)
    
    -- Ремни щита
    for i = 1, 2 do
        local strap = Instance.new("Part")
        strap.Name = "ShieldStrap" .. i
        strap.Size = Vector3.new(0.6, 0.08, 0.02)
        strap.Material = Enum.Material.Fabric
        strap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        strap.Anchored = true
        strap.CanCollide = false
        strap.Parent = model
        
        -- Позиционирование ремней
        local yPos = -0.2 + (i - 1) * 0.4
        strap.Position = shield.Position + Vector3.new(0, yPos, -0.06)
    end
    
    -- Металлические заклепки на щите
    for i = 1, 8 do
        local rivet = Instance.new("Part")
        rivet.Name = "ShieldRivet" .. i
        rivet.Size = Vector3.new(0.03, 0.03, 0.05)
        rivet.Material = Enum.Material.Metal
        rivet.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        rivet.Anchored = true
        rivet.CanCollide = false
        rivet.Parent = model
        
        -- Позиционирование заклепок
        local angle = (i - 1) * 45
        local radius = 0.35
        local xPos = math.cos(math.rad(angle)) * radius
        local yPos = math.sin(math.rad(angle)) * radius * 0.6
        rivet.Position = shield.Position + Vector3.new(xPos, yPos, 0.08)
    end
    
    -- Деревянные планки щита
    for i = 1, 5 do
        local plank = Instance.new("Part")
        plank.Name = "ShieldPlank" .. i
        plank.Size = Vector3.new(0.7, 0.15, 0.08)
        plank.Material = Enum.Material.Wood
        plank.Color = Color3.fromRGB(160, 82, 45) -- Светло-коричневый
        plank.Anchored = true
        plank.CanCollide = false
        plank.Parent = model
        
        -- Позиционирование планок
        local yPos = -0.5 + (i - 1) * 0.25
        plank.Position = shield.Position + Vector3.new(0, yPos, 0.05)
    end
    
    -- Металлические частицы вокруг щита
    for i = 1, 30 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.5, 0.5)
        local yPos = math.random(-0.7, 0.7)
        local zPos = math.random(-0.2, 0.2)
        particle.Position = shield.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.5
        particleLight.Parent = particle
    end
    
    -- Деревянные частицы
    for i = 1, 20 do
        local woodParticle = Instance.new("Part")
        woodParticle.Name = "WoodParticle" .. i
        woodParticle.Size = Vector3.new(0.02, 0.02, 0.02)
        woodParticle.Material = Enum.Material.Wood
        woodParticle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        woodParticle.Anchored = true
        woodParticle.CanCollide = false
        woodParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-0.6, 0.6)
        local zPos = math.random(-0.15, 0.15)
        woodParticle.Position = shield.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Золотые частицы от бляхи
    for i = 1, 15 do
        local goldParticle = Instance.new("Part")
        goldParticle.Name = "GoldParticle" .. i
        goldParticle.Size = Vector3.new(0.01, 0.01, 0.01)
        goldParticle.Material = Enum.Material.Neon
        goldParticle.Color = Color3.fromRGB(255, 215, 0) -- Золотой
        goldParticle.Anchored = true
        goldParticle.CanCollide = false
        goldParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.15, 0.15)
        local yPos = math.random(-0.15, 0.15)
        local zPos = math.random(0.1, 0.2)
        goldParticle.Position = boss.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local goldParticleLight = Instance.new("PointLight")
        goldParticleLight.Color = Color3.fromRGB(255, 215, 0)
        goldParticleLight.Range = 0.4
        goldParticleLight.Brightness = 0.6
        goldParticleLight.Parent = goldParticle
    end
    
    -- Защитная аура щита
    local aura = Instance.new("Part")
    aura.Name = "ShieldAura"
    aura.Size = Vector3.new(1.0, 1.4, 0.2)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = shield.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(192, 192, 192)
    auraLight.Range = 2.0
    auraLight.Brightness = 0.3
    auraLight.Parent = aura
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "shield")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "uncommon")
    model:SetAttribute("WeaponDamage", 0)
    model:SetAttribute("WeaponSpeed", 1.0)
    model:SetAttribute("WeaponRange", 0)
    model:SetAttribute("WeaponDurability", 150)
    model:SetAttribute("WeaponLevel", 4)
    model:SetAttribute("WeaponRarity", "uncommon")
    model:SetAttribute("WeaponClass", "defensive")
    model:SetAttribute("WeaponSubclass", "shield")
    model:SetAttribute("WeaponWeight", 2.5)
    model:SetAttribute("WeaponValue", 40)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("ShieldDefense", 75)
    model:SetAttribute("ShieldBlock", 85)
    model:SetAttribute("ShieldStability", 90)
    
    return model
end

return CreateShield