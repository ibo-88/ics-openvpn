-- AncientWood.lua
-- Модель древней древесины

local function CreateAncientWood()
    local model = Instance.new("Model")
    model.Name = "AncientWood"

    local trunk = Instance.new("Part")
    trunk.Name = "Trunk"
    trunk.Size = Vector3.new(1, 4, 1)
    trunk.Anchored = true
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(101, 67, 33)
    trunk.Parent = model

    local leaves = Instance.new("Part")
    leaves.Name = "Leaves"
    leaves.Shape = Enum.PartType.Ball
    leaves.Size = Vector3.new(3, 3, 3)
    leaves.Position = Vector3.new(0, 3, 0)
    leaves.Anchored = true
    leaves.Material = Enum.Material.Grass
    leaves.Color = Color3.fromRGB(34, 139, 34)
    leaves.Parent = model

    -- Атрибуты
    model:SetAttribute("ResourceType", "ancient_wood")
    model:SetAttribute("ResourceRarity", "rare")
    model:SetAttribute("ResourceYield", 10)
    model:SetAttribute("ResourceHardness", 3)
    model:SetAttribute("ResourceRespawnTime", 300)
    model:SetAttribute("ResourceDescription", "Древняя долговечная древесина")

    return model
end

return CreateAncientWood