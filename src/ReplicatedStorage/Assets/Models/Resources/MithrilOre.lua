-- MithrilOre.lua
-- Модель залежи мифриловой руды

local function CreateMithrilOre()
    local model = Instance.new("Model")
    model.Name = "MithrilOre"

    for i = 1, 5 do
        local chunk = Instance.new("Part")
        chunk.Name = "Chunk" .. i
        chunk.Size = Vector3.new(1.2, 0.8, 1)
        chunk.Position = Vector3.new((i-3)*0.9, 0, math.random(-1,1)*0.5)
        chunk.Anchored = true
        chunk.Material = Enum.Material.Metal
        chunk.Color = Color3.fromRGB(173, 216, 230)
        chunk.Parent = model
    end

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(0, 255, 255)
    glow.Range = 6
    glow.Brightness = 0.5
    glow.Parent = model

    -- Атрибуты
    model:SetAttribute("ResourceType", "mithril_ore")
    model:SetAttribute("ResourceRarity", "epic")
    model:SetAttribute("ResourceYield", 8)
    model:SetAttribute("ResourceHardness", 7)
    model:SetAttribute("ResourceRespawnTime", 600)
    model:SetAttribute("ResourceDescription", "Редкая мифриловая руда")

    return model
end

return CreateMithrilOre