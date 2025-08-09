-- Ring.lua
-- Модель магического кольца
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateRing()
    local model = Instance.new("Model")
    model.Name = "Ring"

    -- Основа кольца
    local band = Instance.new("Part")
    band.Name = "Band"
    band.Shape = Enum.PartType.Cylinder
    band.Size = Vector3.new(0.08, 0.45, 0.45)
    band.Rotation = Vector3.new(0, 0, 90)
    band.Anchored = true
    band.CanCollide = false
    band.Material = Enum.Material.Metal
    band.Color = Color3.fromRGB(255, 215, 0)
    band.Parent = model

    -- Вставка с камнем
    local gem = Instance.new("Part")
    gem.Name = "Gem"
    gem.Shape = Enum.PartType.Ball
    gem.Size = Vector3.new(0.18, 0.18, 0.18)
    gem.Position = Vector3.new(0, 0.2, 0)
    gem.Anchored = true
    gem.CanCollide = false
    gem.Material = Enum.Material.Neon
    gem.Color = Color3.fromRGB(0, 255, 255)
    gem.Parent = model

    local glow = Instance.new("PointLight")
    glow.Name = "Glow"
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 2
    glow.Brightness = 0.6
    glow.Parent = gem

    -- Атрибуты
    model:SetAttribute("AccessoryType", "ring")
    model:SetAttribute("AccessoryMaterial", "metal")
    model:SetAttribute("AccessoryQuality", "epic")
    model:SetAttribute("AccessoryRarity", "epic")
    model:SetAttribute("AccessoryLevel", 18)
    model:SetAttribute("AccessoryValue", 1500)
    model:SetAttribute("AccessoryCraftable", true)
    model:SetAttribute("AccessoryTradeable", true)
    model:SetAttribute("AccessorySellable", true)
    model:SetAttribute("AccessoryDescription", "Магическое кольцо с кристаллом")
    model:SetAttribute("BonusMagicPower", 20)
    model:SetAttribute("BonusLuck", 5)

    return model
end

return CreateRing