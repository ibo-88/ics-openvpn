-- AntiCheat.lua
-- Базовая заглушка античита

local AntiCheat = {}
AntiCheat.__index = AntiCheat

function AntiCheat:Initialize()
    print("[AntiCheat] Initialized")
end

function AntiCheat:ValidateAction(player, action, data)
    -- TODO: Реализовать проверки
    return true
end

return setmetatable({}, AntiCheat)