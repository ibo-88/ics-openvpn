-- Necklace.lua
-- Модель магического ожерелья
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CreateNecklace()
    local model = Instance.new("Model")
    model.Name = "Necklace"

    local chain = Instance.new("Part")
    chain.Name = "Chain"
    chain.Size = Vector3.new(0.1, 1.6, 0.1)
    chain.Anchored = true
    chain.CanCollide = false
    chain.Material = Enum.Material.Metal
    chain.Color = Color3.fromRGB(192, 192, 192)
    chain.Parent = model

    local pendant = Instance.new("Part")
    pendant.Name = "Pendant"
    pendant.Shape = Enum.PartType.Ball
    pendant.Size = Vector3.new(0.3, 0.3, 0.3)
    pendant.Position = Vector3.new(0, -0.8, 0)
    pendant.Anchored = true
    pendant.CanCollide = false
    pendant.Material = Enum.Material.Neon
    pendant.Color = Color3.fromRGB(255, 0, 255)
    pendant.Parent = model

    local glow = Instance.new("PointLight")
    glow.Color = Color3.fromRGB(255, 0, 255)
    glow.Range = 3
    glow.Brightness = 0.7
    glow.Parent = pendant

    -- Атрибуты
    model:SetAttribute("AccessoryType", "necklace")
    model:SetAttribute("AccessoryMaterial", "metal")
    model:SetAttribute("AccessoryQuality", "legendary")
    model:SetAttribute("AccessoryRarity", "legendary")
    model:SetAttribute("AccessoryLevel", 22)
    model:SetAttribute("AccessoryValue", 3500)
    model:SetAttribute("AccessoryCraftable", true)
    model:SetAttribute("AccessoryTradeable", true)
    model:SetAttribute("AccessorySellable", true)
    model:SetAttribute("AccessoryDescription", "Ожерелье с мистическим кулоном")
    model:SetAttribute("BonusMana", 50)
    model:SetAttribute("BonusCooldownReduction", 5)

    return model
end

return CreateNecklace