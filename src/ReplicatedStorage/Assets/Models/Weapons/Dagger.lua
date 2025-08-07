-- Dagger.lua
-- Модель кинжала

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)

local function CreateDagger()
    local model = Instance.new("Model")
    model.Name = "Dagger"
    
    -- Лезвие кинжала
    local blade = Instance.new("Part")
    blade.Name = "Blade"
    blade.Size = Vector3.new(0.05, 0.4, 0.2)
    blade.Material = Enum.Material.Metal
    blade.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    blade.Anchored = true
    blade.CanCollide = false
    blade.Parent = model
    
    -- Создание текстуры металла
    local metalTexture = Instance.new("Texture")
    metalTexture.Texture = "rbxassetid://0" -- Замените на реальный ID текстуры
    metalTexture.StudsPerTileU = 1
    metalTexture.StudsPerTileV = 1
    metalTexture.Parent = blade
    
    -- Свечение лезвия
    local bladeLight = Instance.new("PointLight")
    bladeLight.Color = Color3.fromRGB(192, 192, 192)
    bladeLight.Range = 0.8
    bladeLight.Brightness = 0.6
    bladeLight.Parent = blade
    
    -- Острие кинжала
    local tip = Instance.new("Part")
    tip.Name = "BladeTip"
    tip.Size = Vector3.new(0.02, 0.15, 0.15)
    tip.Material = Enum.Material.Metal
    tip.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
    tip.Anchored = true
    tip.CanCollide = false
    tip.Parent = model
    
    tip.Position = blade.Position + Vector3.new(0, 0.275, 0)
    
    -- Рукоять кинжала
    local handle = Instance.new("Part")
    handle.Name = "Handle"
    handle.Size = Vector3.new(0.08, 0.15, 0.08)
    handle.Material = Enum.Material.Leather
    handle.Color = Color3.fromRGB(139, 69, 19) -- Коричневый
    handle.Anchored = true
    handle.CanCollide = false
    handle.Parent = model
    
    handle.Position = blade.Position + Vector3.new(0, -0.275, 0)
    
    -- Гарда кинжала
    local guard = Instance.new("Part")
    guard.Name = "Guard"
    guard.Size = Vector3.new(0.2, 0.05, 0.05)
    guard.Material = Enum.Material.Metal
    guard.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    guard.Anchored = true
    guard.CanCollide = false
    guard.Parent = model
    
    guard.Position = blade.Position + Vector3.new(0, -0.2, 0)
    
    -- Детали гарды
    for i = 1, 2 do
        local guardDetail = Instance.new("Part")
        guardDetail.Name = "GuardDetail" .. i
        guardDetail.Size = Vector3.new(0.05, 0.08, 0.05)
        guardDetail.Material = Enum.Material.Metal
        guardDetail.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        guardDetail.Anchored = true
        guardDetail.CanCollide = false
        guardDetail.Parent = model
        
        -- Позиционирование деталей гарды
        local xPos = (i == 1) and 0.125 or -0.125
        guardDetail.Position = guard.Position + Vector3.new(xPos, 0, 0)
    end
    
    -- Обмотка рукояти
    for i = 1, 8 do
        local wrap = Instance.new("Part")
        wrap.Name = "HandleWrap" .. i
        wrap.Size = Vector3.new(0.09, 0.015, 0.09)
        wrap.Material = Enum.Material.Fabric
        wrap.Color = Color3.fromRGB(101, 67, 33) -- Темно-коричневый
        wrap.Anchored = true
        wrap.CanCollide = false
        wrap.Parent = model
        
        -- Позиционирование обмотки
        local yPos = -0.35 + (i - 1) * 0.02
        wrap.Position = handle.Position + Vector3.new(0, yPos, 0)
    end
    
    -- Навершие рукояти
    local pommel = Instance.new("Part")
    pommel.Name = "Pommel"
    pommel.Size = Vector3.new(0.1, 0.08, 0.1)
    pommel.Material = Enum.Material.Metal
    pommel.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
    pommel.Anchored = true
    pommel.CanCollide = false
    pommel.Parent = model
    
    pommel.Position = handle.Position + Vector3.new(0, -0.115, 0)
    
    -- Драгоценный камень в навершии
    local gem = Instance.new("Part")
    gem.Name = "PommelGem"
    gem.Size = Vector3.new(0.04, 0.04, 0.04)
    gem.Material = Enum.Material.Neon
    gem.Color = Color3.fromRGB(255, 0, 0) -- Красный
    gem.Anchored = true
    gem.CanCollide = false
    gem.Parent = model
    
    gem.Position = pommel.Position + Vector3.new(0, 0, 0.07)
    
    -- Свечение камня
    local gemLight = Instance.new("PointLight")
    gemLight.Color = Color3.fromRGB(255, 0, 0)
    gemLight.Range = 0.5
    gemLight.Brightness = 0.8
    gemLight.Parent = gem
    
    -- Долы на лезвии
    for i = 1, 2 do
        local fuller = Instance.new("Part")
        fuller.Name = "BladeFuller" .. i
        fuller.Size = Vector3.new(0.02, 0.35, 0.05)
        fuller.Material = Enum.Material.Metal
        fuller.Color = Color3.fromRGB(169, 169, 169) -- Светло-серый
        fuller.Anchored = true
        fuller.CanCollide = false
        fuller.Parent = model
        
        -- Позиционирование долов
        local zPos = (i == 1) and 0.125 or -0.125
        fuller.Position = blade.Position + Vector3.new(0, 0, zPos)
    end
    
    -- Насечки на лезвии
    for i = 1, 6 do
        local serration = Instance.new("Part")
        serration.Name = "BladeSerration" .. i
        serration.Size = Vector3.new(0.03, 0.02, 0.03)
        serration.Material = Enum.Material.Metal
        serration.Color = Color3.fromRGB(105, 105, 105) -- Темно-серый
        serration.Anchored = true
        serration.CanCollide = false
        serration.Parent = model
        
        -- Позиционирование насечек
        local yPos = -0.15 + (i - 1) * 0.05
        serration.Position = blade.Position + Vector3.new(0, yPos, 0.115)
    end
    
    -- Металлические частицы вокруг кинжала
    for i = 1, 12 do
        local particle = Instance.new("Part")
        particle.Name = "MetalParticle" .. i
        particle.Size = Vector3.new(0.008, 0.008, 0.008)
        particle.Material = Enum.Material.Neon
        particle.Color = Color3.fromRGB(192, 192, 192) -- Серебряный
        particle.Anchored = true
        particle.CanCollide = false
        particle.Parent = model
        
        -- Случайное позиционирование частиц
        local xPos = math.random(-0.2, 0.2)
        local yPos = math.random(-0.4, 0.4)
        local zPos = math.random(-0.2, 0.2)
        particle.Position = blade.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение частиц
        local particleLight = Instance.new("PointLight")
        particleLight.Color = Color3.fromRGB(192, 192, 192)
        particleLight.Range = 0.15
        particleLight.Brightness = 0.3
        particleLight.Parent = particle
    end
    
    -- Кровавые искры
    for i = 1, 6 do
        local bloodSpark = Instance.new("Part")
        bloodSpark.Name = "BloodSpark" .. i
        bloodSpark.Size = Vector3.new(0.004, 0.004, 0.004)
        bloodSpark.Material = Enum.Material.Neon
        bloodSpark.Color = Color3.fromRGB(255, 0, 0) -- Красный
        bloodSpark.Anchored = true
        bloodSpark.CanCollide = false
        bloodSpark.Parent = model
        
        -- Случайное позиционирование искр
        local xPos = math.random(-0.15, 0.15)
        local yPos = math.random(-0.3, 0.3)
        local zPos = math.random(-0.15, 0.15)
        bloodSpark.Position = blade.Position + Vector3.new(xPos, yPos, zPos)
        
        -- Свечение искр
        local sparkLight = Instance.new("PointLight")
        sparkLight.Color = Color3.fromRGB(255, 0, 0)
        sparkLight.Range = 0.1
        sparkLight.Brightness = 0.5
        sparkLight.Parent = bloodSpark
    end
    
    -- Кровавая аура вокруг кинжала
    local bloodAura = Instance.new("Part")
    bloodAura.Name = "BloodAura"
    bloodAura.Size = Vector3.new(0.3, 0.6, 0.3)
    bloodAura.Material = Enum.Material.Neon
    bloodAura.Color = Color3.fromRGB(255, 0, 0) -- Красный
    bloodAura.Transparency = 0.9
    bloodAura.Anchored = true
    bloodAura.CanCollide = false
    bloodAura.Parent = model
    
    bloodAura.Position = blade.Position
    
    -- Свечение кровавой ауры
    local bloodAuraLight = Instance.new("PointLight")
    bloodAuraLight.Color = Color3.fromRGB(255, 0, 0)
    bloodAuraLight.Range = 1.5
    bloodAuraLight.Brightness = 0.4
    bloodAuraLight.Parent = bloodAura
    
    -- Кровавые кольца
    for i = 1, 3 do
        local bloodRing = Instance.new("Part")
        bloodRing.Name = "BloodRing" .. i
        bloodRing.Size = Vector3.new(0.25 + i * 0.1, 0.01, 0.25 + i * 0.1)
        bloodRing.Material = Enum.Material.Neon
        bloodRing.Color = Color3.fromRGB(255, 0, 0) -- Красный
        bloodRing.Transparency = 0.8
        bloodRing.Anchored = true
        bloodRing.CanCollide = false
        bloodRing.Parent = model
        
        bloodRing.Position = blade.Position + Vector3.new(0, 0, 0)
        
        -- Свечение колец
        local ringLight = Instance.new("PointLight")
        ringLight.Color = Color3.fromRGB(255, 0, 0)
        ringLight.Range = 0.8 + i * 0.2
        ringLight.Brightness = 0.3
        ringLight.Parent = bloodRing
    end
    
    -- Установка атрибутов
    model:SetAttribute("WeaponType", "dagger")
    model:SetAttribute("WeaponMaterial", "metal")
    model:SetAttribute("WeaponQuality", "uncommon")
    model:SetAttribute("WeaponDamage", 25)
    model:SetAttribute("WeaponSpeed", 2.0)
    model:SetAttribute("WeaponRange", 1.5)
    model:SetAttribute("WeaponDurability", 70)
    model:SetAttribute("WeaponLevel", 3)
    model:SetAttribute("WeaponRarity", "uncommon")
    model:SetAttribute("WeaponClass", "melee")
    model:SetAttribute("WeaponSubclass", "dagger")
    model:SetAttribute("WeaponWeight", 0.8)
    model:SetAttribute("WeaponValue", 25)
    model:SetAttribute("WeaponCraftable", true)
    model:SetAttribute("WeaponRepairable", true)
    model:SetAttribute("WeaponEnchantable", true)
    model:SetAttribute("WeaponUpgradeable", true)
    model:SetAttribute("WeaponTradeable", true)
    model:SetAttribute("WeaponDroppable", true)
    model:SetAttribute("WeaponSellable", true)
    model:SetAttribute("DaggerStealth", 90)
    model:SetAttribute("DaggerCritical", 25)
    model:SetAttribute("DaggerBackstab", 150)
    
    return model
end

return CreateDagger