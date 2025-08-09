-- DemonLord.lua
-- Модель босса Демон-Лорд

local function CreateDemonLord()
    local model = Instance.new("Model")
    model.Name = "DemonLord"

    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(4, 6, 2)
    body.Anchored = true
    body.Color = Color3.fromRGB(120, 0, 0)
    body.Material = Enum.Material.Slate
    body.Parent = model

    local hornL = Instance.new("Part")
    hornL.Name = "HornL"
    hornL.Size = Vector3.new(0.5, 1.5, 0.5)
    hornL.Position = Vector3.new(-1, 3.5, 0)
    hornL.Anchored = true
    hornL.Color = Color3.fromRGB(50, 0, 0)
    hornL.Parent = model

    local hornR = hornL:Clone()
    hornR.Name = "HornR"
    hornR.Position = Vector3.new(1, 3.5, 0)
    hornR.Parent = model

    local aura = Instance.new("PointLight")
    aura.Color = Color3.fromRGB(255, 0, 0)
    aura.Range = 12
    aura.Brightness = 1.2
    aura.Parent = body

    -- Атрибуты
    model:SetAttribute("EnemyType", "demon_lord")
    model:SetAttribute("EnemyBoss", true)
    model:SetAttribute("EnemyLevel", 30)
    model:SetAttribute("EnemyHealth", 50000)
    model:SetAttribute("EnemyDamage", 450)
    model:SetAttribute("EnemyArmor", 100)
    model:SetAttribute("EnemyRarity", "legendary")
    model:SetAttribute("EnemyDescription", "Владыка демонов из бездны")

    return model
end

return CreateDemonLord