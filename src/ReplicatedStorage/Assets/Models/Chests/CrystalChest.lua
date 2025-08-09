-- CrystalChest.lua
-- Модель кристального сундука

local function CreateCrystalChest()
    local model = Instance.new("Model")
    model.Name = "CrystalChest"

    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(3, 1.5, 2)
    base.Anchored = true
    base.Material = Enum.Material.Glass
    base.Transparency = 0.2
    base.Color = Color3.fromRGB(135, 206, 250)
    base.Parent = model

    local lid = Instance.new("Part")
    lid.Name = "Lid"
    lid.Size = Vector3.new(3, 0.8, 2)
    lid.Position = Vector3.new(0, 1.15, 0)
    lid.Anchored = true
    lid.Material = Enum.Material.Glass
    lid.Transparency = 0.2
    lid.Color = Color3.fromRGB(176, 224, 230)
    lid.Parent = model

    local lock = Instance.new("Part")
    lock.Name = "Lock"
    lock.Size = Vector3.new(0.3, 0.4, 0.1)
    lock.Position = Vector3.new(0, 0.6, 1.05)
    lock.Anchored = true
    lock.Material = Enum.Material.Metal
    lock.Color = Color3.fromRGB(0, 255, 255)
    lock.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 5
    glow.Brightness = 0.7
    glow.Parent = lock

    -- Атрибуты
    model:SetAttribute("ChestType", "crystal")
    model:SetAttribute("ChestRarity", "legendary")
    model:SetAttribute("ChestCapacity", 25)
    model:SetAttribute("ChestLocked", true)
    model:SetAttribute("ChestKeyType", "crystal_key")
    model:SetAttribute("ChestValue", 2000)
    model:SetAttribute("ChestDescription", "Кристальный сундук с легендарной добычей")

    return model
end

return CreateCrystalChest