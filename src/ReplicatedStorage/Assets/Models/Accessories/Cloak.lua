-- Cloak.lua
-- Модель магического плаща
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateCloak()
    local model = Instance.new("Model")
    model.Name = "Cloak"

    local fabric = Instance.new("Part")
    fabric.Name = "Fabric"
    fabric.Size = Vector3.new(1.2, 1.8, 0.05)
    fabric.Anchored = true
    fabric.CanCollide = false
    fabric.Material = Enum.Material.Fabric
    fabric.Color = Color3.fromRGB(50, 50, 80)
    fabric.Parent = model

    local clasp = Instance.new("Part")
    clasp.Name = "Clasp"
    clasp.Size = Vector3.new(0.2, 0.1, 0.05)
    clasp.Position = Vector3.new(0, 0.95, 0.03)
    clasp.Anchored = true
    clasp.CanCollide = false
    clasp.Material = Enum.Material.Metal
    clasp.Color = Color3.fromRGB(255, 215, 0)
    clasp.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(200, 200, 255)
    glow.Range = 3
    glow.Brightness = 0.4
    glow.Parent = fabric

    -- Атрибуты
    model:SetAttribute("AccessoryType", "cloak")
    model:SetAttribute("AccessoryMaterial", "fabric")
    model:SetAttribute("AccessoryQuality", "rare")
    model:SetAttribute("AccessoryRarity", "rare")
    model:SetAttribute("AccessoryLevel", 12)
    model:SetAttribute("AccessoryValue", 800)
    model:SetAttribute("AccessoryCraftable", true)
    model:SetAttribute("AccessoryTradeable", true)
    model:SetAttribute("AccessorySellable", true)
    model:SetAttribute("AccessoryDescription", "Магический плащ с эмблемой")
    model:SetAttribute("BonusEvasion", 4)
    model:SetAttribute("BonusMoveSpeed", 3)

    return model
end

return CreateCloak