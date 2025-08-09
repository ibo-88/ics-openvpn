-- TimeRelic.lua
-- Модель магического артефакта Временной Реликт

local function CreateTimeRelic()
    local model = Instance.new("Model")
    model.Name = "TimeRelic"

    local core = Instance.new("Part")
    core.Name = "Core"
    core.Shape = Enum.PartType.Ball
    core.Size = Vector3.new(0.8, 0.8, 0.8)
    core.Anchored = true
    core.Material = Enum.Material.Neon
    core.Color = Color3.fromRGB(0, 255, 255)
    core.Parent = model

    local ring1 = Instance.new("Part")
    ring1.Name = "Ring1"
    ring1.Shape = Enum.PartType.Cylinder
    ring1.Size = Vector3.new(0.1, 1.6, 1.6)
    ring1.Rotation = Vector3.new(0, 0, 90)
    ring1.Anchored = true
    ring1.Material = Enum.Material.Metal
    ring1.Color = Color3.fromRGB(255, 215, 0)
    ring1.Parent = model

    local ring2 = ring1:Clone()
    ring2.Name = "Ring2"
    ring2.Rotation = Vector3.new(90, 0, 0)
    ring2.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 6
    glow.Brightness = 0.8
    glow.Parent = core

    -- Атрибуты
    model:SetAttribute("MagicType", "artifact")
    model:SetAttribute("MagicQuality", "legendary")
    model:SetAttribute("MagicRarity", "legendary")
    model:SetAttribute("MagicLevel", 30)
    model:SetAttribute("MagicValue", 8000)
    model:SetAttribute("MagicDescription", "Реликт времени, искажающий пространство")
    model:SetAttribute("BonusCooldownFreeze", 10)
    model:SetAttribute("BonusTimeWarp", true)

    return model
end

return CreateTimeRelic