-- ProfileService.lua
-- Сервис для хранения данных игроков

local ProfileService = {}
ProfileService.__index = ProfileService

function ProfileService:Initialize()
    print("[ProfileService] Initialized")
end

function ProfileService:LoadProfile(player)
    print("[ProfileService] Loading profile for", player.Name)
    -- TODO: Загрузка данных игрока
end

function ProfileService:SaveProfile(player)
    print("[ProfileService] Saving profile for", player.Name)
    -- TODO: Сохранение данных игрока
end

return setmetatable({}, ProfileService)