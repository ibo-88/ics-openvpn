-- ResourceManager.lua
-- Управление ресурсами на сервере

local ResourceManager = {}
ResourceManager.__index = ResourceManager

function ResourceManager:Initialize()
    print("[ResourceManager] Initialized")
end

function ResourceManager:GatherResource(player, resourceType, amount)
    print("[ResourceManager] Player", player.Name, "gathered", amount, resourceType)
    -- TODO: Добавить ресурсы игроку
end

return setmetatable({}, ResourceManager)