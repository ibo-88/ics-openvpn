-- ObsidianRock.lua
-- Модель обсидиановой скалы

local function CreateObsidianRock()
    local model = Instance.new("Model")
    model.Name = "ObsidianRock"

    for i = 1, 4 do
        local chunk = Instance.new("Part")
        chunk.Name = "Chunk" .. i
        chunk.Size = Vector3.new(1.4, 1, 1.2)
        chunk.Position = Vector3.new((i-2)*1.0, 0, math.random(-1,1)*0.5)
        chunk.Anchored = true
        chunk.Material = Enum.Material.Slate
        chunk.Color = Color3.fromRGB(20, 20, 20)
        chunk.Parent = model
    end

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(255, 64, 64)
    glow.Range = 4
    glow.Brightness = 0.4
    glow.Parent = model

    -- Атрибуты
    model:SetAttribute("ResourceType", "obsidian_rock")
    model:SetAttribute("ResourceRarity", "epic")
    model:SetAttribute("ResourceYield", 5)
    model:SetAttribute("ResourceHardness", 9)
    model:SetAttribute("ResourceRespawnTime", 900)
    model:SetAttribute("ResourceDescription", "Твердая обсидиановая порода")

    return model
end

return CreateObsidianRock