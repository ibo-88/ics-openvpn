-- SandWorm.lua
-- Модель босса Песчаный Червь

local function CreateSandWorm()
    local model = Instance.new("Model")
    model.Name = "SandWorm"

    for i = 1, 6 do
        local seg = Instance.new("Part")
        seg.Name = "Segment" .. i
        seg.Shape = Enum.PartType.Cylinder
        seg.Size = Vector3.new(1.2, 2, 1.2)
        seg.Position = Vector3.new(0, 0, i * 1.8)
        seg.Rotation = Vector3.new(0, 0, 90)
        seg.Anchored = true
        seg.CanCollide = false
        seg.Material = Enum.Material.Sand
        seg.Color = Color3.fromRGB(210, 180, 140)
        seg.Parent = model
    end

    local aura = Instance.new("PointLight")
    aura.Color = Color3.fromRGB(255, 220, 150)
    aura.Range = 10
    aura.Brightness = 0.8
    aura.Parent = model:FindFirstChild("Segment3") or model

    -- Атрибуты
    model:SetAttribute("EnemyType", "sand_worm")
    model:SetAttribute("EnemyBoss", true)
    model:SetAttribute("EnemyLevel", 32)
    model:SetAttribute("EnemyHealth", 58000)
    model:SetAttribute("EnemyDamage", 480)
    model:SetAttribute("EnemyArmor", 90)
    model:SetAttribute("EnemyRarity", "epic")
    model:SetAttribute("EnemyDescription", "Гигантский песчаный червь пустыни")

    return model
end

return CreateSandWorm