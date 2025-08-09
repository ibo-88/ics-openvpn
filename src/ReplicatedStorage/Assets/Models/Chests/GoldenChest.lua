-- GoldenChest.lua
-- Модель золотого сундука

local function CreateGoldenChest()
    local model = Instance.new("Model")
    model.Name = "GoldenChest"

    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(3, 1.5, 2)
    base.Anchored = true
    base.Material = Enum.Material.Wood
    base.Color = Color3.fromRGB(139, 69, 19)
    base.Parent = model

    local lid = Instance.new("Part")
    lid.Name = "Lid"
    lid.Size = Vector3.new(3, 0.8, 2)
    lid.Position = Vector3.new(0, 1.15, 0)
    lid.Anchored = true
    lid.Material = Enum.Material.Wood
    lid.Color = Color3.fromRGB(160, 82, 45)
    lid.Parent = model

    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.3, 0.4, 0.1)
    lock.Position = Vector3.new(0, 0.6, 1.05)
    lock.Anchored = true
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(255, 215, 0)
    lock.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(255, 215, 0)
    glow.Range = 5
    glow.Brightness = 0.6
    glow.Parent = lock

    -- Атрибуты
    model:SetAttribute("ChestType", "golden")
    model:SetAttribute("ChestRarity", "epic")
    model:SetAttribute("ChestCapacity", 20)
    model:SetAttribute("ChestLocked", true)
    model:SetAttribute("ChestKeyType", "gold_key")
    model:SetAttribute("ChestValue", 1200)
    model:SetAttribute("ChestDescription", "Золотой сундук с редкими сокровищами")

    return model
end

return CreateGoldenChest