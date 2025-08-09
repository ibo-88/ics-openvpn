-- Belt.lua
-- Модель магического пояса
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateBelt()
    local model = Instance.new("Model")
    model.Name = "Belt"

    local strap = Instance.new("Part")
    strap.Name = "Strap"
    strap.Shape = Enum.PartType.Cylinder
    strap.Size = Vector3.new(0.1, 0.9, 0.9)
    strap.Rotation = Vector3.new(0, 0, 90)
    strap.Anchored = true
    strap.CanCollide = false
    strap.Material = Enum.Material.Fabric
    strap.Color = Color3.fromRGB(101, 67, 33)
    strap.Parent = model

    local buckle = Instance.new("Part")
    buckle.Name = "Buckle"
    buckle.Size = Vector3.new(0.25, 0.15, 0.05)
    buckle.Position = Vector3.new(0, 0.45, 0)
    buckle.Anchored = true
    buckle.CanCollide = false
    buckle.Material = Enum.Material.Metal
    buckle.Color = Color3.fromRGB(255, 215, 0)
    buckle.Parent = model

    -- Атрибуты
    model:SetAttribute("AccessoryType", "belt")
    model:SetAttribute("AccessoryMaterial", "fabric")
    model:SetAttribute("AccessoryQuality", "epic")
    model:SetAttribute("AccessoryRarity", "epic")
    model:SetAttribute("AccessoryLevel", 16)
    model:SetAttribute("AccessoryValue", 1200)
    model:SetAttribute("AccessoryCraftable", true)
    model:SetAttribute("AccessoryTradeable", true)
    model:SetAttribute("AccessorySellable", true)
    model:SetAttribute("AccessoryDescription", "Пояс с золотой пряжкой")
    model:SetAttribute("BonusCarryCapacity", 10)
    model:SetAttribute("BonusDefense", 5)

    return model
end

return CreateBelt