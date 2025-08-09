-- LichKing.lua
-- Модель босса Король-Лич

local function CreateLichKing()
    local model = Instance.new("Model")
    model.Name = "LichKing"

    local robe = Instance.new("Part")
    robe.Name = "Robe"
    robe.Size = Vector3.new(2, 4, 1.5)
    robe.Anchored = true
    robe.Color = Color3.fromRGB(40, 40, 60)
    robe.Material = Enum.Material.Fabric
    robe.Parent = model

    local crown = Instance.new("Part")
    crown.Name = "Crown"
    crown.Size = Vector3.new(0.6, 0.4, 0.6)
    crown.Position = Vector3.new(0, 2.2, 0)
    crown.Anchored = true
    crown.Material = Enum.Material.Metal
    crown.Color = Color3.fromRGB(255, 215, 0)
    crown.Parent = model

    local aura = Instance.new("PointLight")
    aura.Color = Color3.fromRGB(120, 0, 255)
    aura.Range = 10
    aura.Brightness = 0.9
    aura.Parent = robe

    -- Атрибуты
    model:SetAttribute("EnemyType", "lich_king")
    model:SetAttribute("EnemyBoss", true)
    model:SetAttribute("EnemyLevel", 34)
    model:SetAttribute("EnemyHealth", 60000)
    model:SetAttribute("EnemyDamage", 500)
    model:SetAttribute("EnemyArmor", 110)
    model:SetAttribute("EnemyRarity", "legendary")
    model:SetAttribute("EnemyDescription", "Властитель нежити и магии смерти")

    return model
end

return CreateLichKing