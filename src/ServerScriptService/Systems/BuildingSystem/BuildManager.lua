-- BuildManager.lua
-- Управление строительством

local BuildManager = {}
BuildManager.__index = BuildManager

function BuildManager:Initialize()
    print("[BuildManager] Initialized")
end

function BuildManager:BuildStructure(player, structureType, position)
    print("[BuildManager] Player", player.Name, "builds", structureType, "at", position)
    -- TODO: Проверить ресурсы, построить объект
end

return setmetatable({}, BuildManager)