-- IceDragon.lua
-- Модель босса Ледяной Дракон

local function CreateIceDragon()
    local model = Instance.new("Model")
    model.Name = "IceDragon"

    local body = Instance.new("Part")
    body.Name = "Body"
    body.Size = Vector3.new(6, 4, 10)
    body.Anchored = true
    body.Color = Color3.fromRGB(150, 200, 255)
    body.Material = Enum.Material.Ice
    body.Parent = model

    local wingL = Instance.new("Part")
    wingL.Name = "WingL"
    wingL.Size = Vector3.new(0.5, 3, 6)
    wingL.Position = Vector3.new(-3, 1, 0)
    wingL.Anchored = true
    wingL.Color = Color3.fromRGB(200, 230, 255)
    wingL.Material = Enum.Material.Ice
    wingL.Parent = model

    local wingR = wingL:Clone()
    wingR.Name = "WingR"
    wingR.Position = Vector3.new(3, 1, 0)
    wingR.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(150, 200, 255)
    glow.Range = 15
    glow.Brightness = 1
    glow.Parent = body

    -- Атрибуты
    model:SetAttribute("EnemyType", "ice_dragon")
    model:SetAttribute("EnemyBoss", true)
    model:SetAttribute("EnemyLevel", 35)
    model:SetAttribute("EnemyHealth", 65000)
    model:SetAttribute("EnemyDamage", 520)
    model:SetAttribute("EnemyArmor", 120)
    model:SetAttribute("EnemyRarity", "legendary")
    model:SetAttribute("EnemyDescription", "Ледяной дракон, повелитель зимы")

    return model
end

return CreateIceDragon