-- Bracers.lua
-- Модель наручей
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateBracers()
    local model = Instance.new("Model")
    model.Name = "Bracers"

    local left = Instance.new("Part")
    left.Name = "LeftBracer"
    left.Size = Vector3.new(0.6, 0.3, 0.3)
    left.Position = Vector3.new(-0.4, 0, 0)
    left.Anchored = true
    left.CanCollide = false
    left.Material = Enum.Material.Metal
    left.Color = Color3.fromRGB(105, 105, 105)
    left.Parent = model

    local right = Instance.new("Part")
    right.Name = "RightBracer"
    right.Size = Vector3.new(0.6, 0.3, 0.3)
    right.Position = Vector3.new(0.4, 0, 0)
    right.Anchored = true
    right.CanCollide = false
    right.Material = Enum.Material.Metal
    right.Color = Color3.fromRGB(105, 105, 105)
    right.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(255, 255, 200)
    glow.Range = 2
    glow.Brightness = 0.3
    glow.Parent = left

    -- Атрибуты
    model:SetAttribute("AccessoryType", "bracers")
    model:SetAttribute("AccessoryMaterial", "metal")
    model:SetAttribute("AccessoryQuality", "rare")
    model:SetAttribute("AccessoryRarity", "rare")
    model:SetAttribute("AccessoryLevel", 10)
    model:SetAttribute("AccessoryValue", 700)
    model:SetAttribute("AccessoryCraftable", true)
    model:SetAttribute("AccessoryTradeable", true)
    model:SetAttribute("AccessorySellable", true)
    model:SetAttribute("AccessoryDescription", "Металлические наручи")
    model:SetAttribute("BonusDefense", 8)
    model:SetAttribute("BonusResistance", 3)

    return model
end

return CreateBracers