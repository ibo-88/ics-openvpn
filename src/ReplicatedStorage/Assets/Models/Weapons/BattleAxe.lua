-- BattleAxe.lua
-- Модель боевого топора

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateBattleAxe()
    local model = Instance.new("Model")
    model.Name = "BattleAxe"
    
    -- Рукоять топора
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 1.8, 0.08)
    handle.Material = Enum.Material.Wood
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    -- Создание текстуры дерева
    local woodTexture = Instance.new("Texture")
    woodTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    woodTexture.StudsPerTileU = 1
    woodTexture.StudsPerTileV = 4
    woodTexture.Parent = handle
    
    -- Лезвие топора
    local blade = Instance.new("Part")
    blade.Name = "AxeBlade"
    blade.Size = Vector3.new(0.5, 0.4, 0.08)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    blade.Position = handle.Position + Vector3.new(0, 1.1, 0)
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = blade
    
    -- Свечение лезвия
    local bladeLight = Instance.new("PointLight")
    bladeLight.Color = Color3.fromRGB(192, 192, 192)
    bladeLight.Range = 1.5
    bladeLight.Brightness = 0.8
    bladeLight.Parent = blade
    
    -- Острие лезвия
    local edge = Instance.new("Part")
    edge.Name = "BladeEdge"
    edge.Size = Vector3.new(0.45, 0.02, 0.1)
    edge.Material = Enum.Material.Metal
    edge.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    edge.Anchored = true
    edge.CanCollide = false
    edge.Parent = model
    
    edge.Position = blade.Position + Vector3.new(0, 0.21, 0)
    
    -- Свечение острия
    local edgeLight = Instance.new("PointLight")
    edgeLight.Color = Color3.fromRGB(169, 169, 169)
    edgeLight.Range = 0.8
    edgeLight.Brightness = 1.0
    edgeLight.Parent = edge
    
    -- Крепление лезвия
    local mount = Instance.new("Part")
    mount.Name = "BladeMount"
    mount.Size = Vector3.new(0.12, 0.3, 0.12)
    mount.Material = Enum.Material.Metal
    mount.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    mount.Anchored = true
    mount.CanCollide = false
    mount.Parent = model
    
    mount.Position = blade.Position + Vector3.new(0, -0.35, 0)
    
    -- Металлические заклепки крепления
    for i = 1, 4 do
        local rivet = Instance.new("Part")
        rivet.Name = "MountRivet" .. i
        rivet.Size = Vector3.new(0.025, 0.025, 0.025)
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
    for i = 1, 8 do
        local ring = Instance.new("Part")
        ring.Name = "HandleRing" .. i
        ring.Size = Vector3.new(0.12, 0.03, 0.12)
        ring.Material = Enum.Material.Wood
        ring.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        -- Позиционирование колец
        local yPos = -0.8 + (i - 1) * 0.2
        ring.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Деревянная обмотка рукояти
    for i = 1, 36 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.1, 0.015, 0.1)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.9 + (i - 1) * 0.05
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Декоративные узоры на лезвии
    for i = 1, 3 do
        local pattern = Instance.new("Part")
        pattern.Name = "BladePattern" .. i
        pattern.Size = Vector3.new(0.4, 0.05, 0.05)
        pattern.Material = Enum.Material.Metal
        pattern.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        pattern.Anchored = true
        pattern.CanCollide = false
        pattern.Parent = model
        
        -- Позиционирование узоров
        local yPos = -0.15 + (i - 1) * 0.15
        pattern.Position = blade.Position + Vector3.new(0, yPos, 0.065)
    end
    
    -- Металлические частицы вокруг топора
    for i = 1, 40 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.015, 0.015, 0.015)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.4, 0.4)
        local yPos = math.random(-1.0, 1.0)
        local zPos = math.random(-0.4, 0.4)
        particle.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.3
        particleLight.Brightness = 0.6
        particleLight.Parent = particle
    end
    
    -- Деревянные частицы
    for i = 1, 25 do
        local woodParticle = Instance.new("Part")
        woodParticle.Name = "WoodParticle" .. i
        woodParticle.Size = Vector3.new(0.02, 0.02, 0.02)
        woodParticle.Material = Enum.Material.Wood
        woodParticle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
        woodParticle.Anchored = true
        woodParticle.CanCollide = false
        woodParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.35, 0.35)
        local yPos = math.random(-0.9, 0.9)
        local zPos = math.random(-0.35, 0.35)
        woodParticle.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
    end
    
    -- Серые частицы от острия
    for i = 1, 20 do
        local grayParticle = Instance.new("Part")
        grayParticle.Name = "GrayParticle" .. i
        grayParticle.Size = Vector3.new(0.012, 0.012, 0.012)
        grayParticle.Material = Enum.Material.Neon
        grayParticle.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        grayParticle.Anchored = true
        grayParticle.CanCollide = false
        grayParticle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.25, 0.25)
        local yPos = math.random(0.9, 1.3)
        local zPos = math.random(-0.25, 0.25)
        grayParticle.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local grayParticleLight = Instance.new("PointLight")
        grayParticleLight.Color = Color3.fromRGB(169, 169, 169)
        grayParticleLight.Range = 0.35
        grayParticleLight.Brightness = 0.7
        grayParticleLight.Parent = grayParticle
    end
    
    -- Боевая аура вокруг топора
    local aura = Instance.new("Part")
    aura.Name = "BattleAxeAura"
    aura.Size = Vector3.new(0.6, 2.0, 0.6)
    aura.Material = Enum.Material.Neon
    aura.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    aura.Transparency = 0.9
    aura.Anchored = true
    aura.CanCollide = false
    aura.Parent = model
    
    aura.Position = handle.Position
    
    -- Свечение ауры
    local auraLight = Instance.new("PointLight")
    auraLight.Color = Color3.fromRGB(192, 192, 192)
    auraLight.Range = 3.0
    auraLight.Brightness = 0.5
    auraLight.Parent = aura
    
    -- Боевые кольца вокруг топора
    for i = 1, 6 do
        local ring = Instance.new("Part")
        ring.Name = "BattleRing" .. i
        ring.Size = Vector3.new(0.5 + i * 0.1, 0.01, 0.5 + i * 0.1)
        ring.Material = Enum.Material.Neon
        ring.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        ring.Transparency = 0.8
        ring.Anchored = true
        ring.CanCollide = false
        ring.Parent = model
        
        ring.Position = handle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(192, 192, 192)
        ringLight.Range = 1.5 + i * 0.3
        ringLight.Brightness = 0.4
        ringLight.Parent = ring
    end
    
    -- Боевые спирали
    for i = 1, 5 do
        local spiral = Instance.new("Part")
        spiral.Name = "BattleSpiral" .. i
        spiral.Size = Vector3.new(0.4 + i * 0.1, 0.005, 0.4 + i * 0.1)
        spiral.Material = Enum.Material.Neon
        spiral.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        spiral.Transparency = 0.7
        spiral.Anchored = true
        spiral.CanCollide = false
        spiral.Parent = model
        
        spiral.Position = handle.Position + Vector3.new(0, 0, 0)
        
        -- Свечение спиралей
        local spiralLight = Instance.new("PointLight")
        spiralLight.Color = Color3.fromRGB(192, 192, 192)
        spiralLight.Range = 1 + i * 0.2
        spiralLight.Brightness = 0.3
        spiralLight.Parent = spiral
    end
    
    -- Боевые звезды
    for i = 1, 10 do
        local star = Instance.new("Part")
        star.Name = "BattleStar" .. i
        star.Size = Vector3.new(0.03, 0.03, 0.03)
        star.Material = Enum.Material.Neon
        star.Color = Color3.fromRGB(255, 255, 255) -- Белый
        star.Anchored = true
        star.CanCollide = false
        star.Parent = model
        
        -- Случайное позиционирование звезд
        local xPos = math.random(-0.5, 0.5)
        local yPos = math.random(-1.0, 1.0)
        local zPos = math.random(-0.5, 0.5)
        star.Position = handle.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение звезд
        local starLight = Instance.new("PointLight")
        starLight.Color = Color3.fromRGB(255, 255, 255)
        starLight.Range = 0.5
        starLight.Brightness = 0.9
        starLight.Parent = star
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "battleaxe")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "rare")
    model:SetAttribute("WeaponDamage", 55)
    model:SetAttribute("WeaponSpeed", 0.7)
    model:SetAttribute("WeaponRange", 3.5)
    model:SetAttribute("WeaponDurability", 130)
    model:SetAttribute("WeaponLevel", 6)
    model:SetAttribute("WeaponRarity", "rare")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "axe")
    model:SetAttribute("WeaponWeight", 4.0)
    model:SetAttribute("WeaponValue", 70)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("BattleAxeCleave", 75)
    model:SetAttribute("BattleAxeBreak", 70)
    model:SetAttribute("BattleAxeWeight", 4.0)
    
    return model
end

return CreateBattleAxe