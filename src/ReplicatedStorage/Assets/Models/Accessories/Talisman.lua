-- Talisman.lua
-- Модель магического талисмана
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateTalisman()
    local model = Instance.new("Model")
    model.Name = "Talisman"

    local plate = Instance.new("Part")
    plate.Name = "Plate"
    plate.Size = Vector3.new(0.5, 0.5, 0.1)
    plate.Anchored = true
    plate.CanCollide = false
    plate.Material = Enum.Material.Metal
    plate.Color = Color3.fromRGB(255, 215, 0)
    plate.Parent = model

    local rune = Instance.new("Part")
    rune.Name = "Rune"
    rune.Shape = Enum.PartType.Ball
    rune.Size = Vector3.new(0.2, 0.2, 0.2)
    rune.Position = Vector3.new(0, 0, 0.06)
    rune.Anchored = true
    rune.CanCollide = false
    rune.Material = Enum.Material.Neon
    rune.Color = Color3.fromRGB(0, 255, 255)
    rune.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 3
    glow.Brightness = 0.6
    glow.Parent = rune

    -- Атрибуты
    model:SetAttribute("AccessoryType", "talisman")
    model:SetAttribute("AccessoryMaterial", "metal")
    model:SetAttribute("AccessoryQuality", "legendary")
    model:SetAttribute("AccessoryRarity", "legendary")
    model:SetAttribute("AccessoryLevel", 24)
    model:SetAttribute("AccessoryValue", 5000)
    model:SetAttribute("AccessoryCraftable", true)
    model:SetAttribute("AccessoryTradeable", true)
    model:SetAttribute("AccessorySellable", true)
    model:SetAttribute("AccessoryDescription", "Древний талисман с руной")
    model:SetAttribute("BonusMagicPower", 40)
    model:SetAttribute("BonusCooldownReduction", 8)

    return model
end

return CreateTalisman