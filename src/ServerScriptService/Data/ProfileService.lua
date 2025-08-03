-- ProfileService.lua
-- Сервис для хранения данных игроков

local ProfileService = {}
ProfileService.__index = ProfileService

-- Импорт зависимостей
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("NexusSiege_PlayerData")

-- Состояние
ProfileService.playerProfiles = {}
ProfileService.autoSaveInterval = 60 -- секунды

function ProfileService:Initialize()
    print("[ProfileService] Initializing...")
    
    -- Подключение событий игроков
    local Players = game:GetService("Players")
    
    Players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerRemoving(player)
    end)
    
    -- Запуск автосохранения
    self:StartAutoSave()
    
    print("[ProfileService] Initialized successfully!")
end

-- Обработка присоединения игрока
function ProfileService:OnPlayerAdded(player)
    print("[ProfileService] Player joined:", player.Name)
    
    -- Загрузка профиля
    local profile = self:LoadProfile(player)
    if profile then
        self.playerProfiles[player] = profile
        print("[ProfileService] Profile loaded for", player.Name)
    else
        warn("[ProfileService] Failed to load profile for", player.Name)
    end
end

-- Обработка выхода игрока
function ProfileService:OnPlayerRemoving(player)
    print("[ProfileService] Player leaving:", player.Name)
    
    -- Сохранение профиля
    local profile = self.playerProfiles[player]
    if profile then
        self:SaveProfile(player, profile)
        self.playerProfiles[player] = nil
        print("[ProfileService] Profile saved for", player.Name)
    end
end

-- Загрузка профиля игрока
function ProfileService:LoadProfile(player)
    local success, data = pcall(function()
        return playerDataStore:GetAsync(player.UserId)
    end)
    
    if success and data then
        -- Валидация данных
        if self:ValidateProfileData(data) then
            return data
        else
            warn("[ProfileService] Invalid profile data for", player.Name, "- using default")
            return self:GetDefaultProfile()
        end
    else
        print("[ProfileService] No existing profile for", player.Name, "- creating new")
        return self:GetDefaultProfile()
    end
end

-- Сохранение профиля игрока
function ProfileService:SaveProfile(player, data)
    if not data then
        warn("[ProfileService] No data to save for", player.Name)
        return false
    end
    
    -- Валидация данных перед сохранением
    if not self:ValidateProfileData(data) then
        warn("[ProfileService] Invalid data for", player.Name, "- not saving")
        return false
    end
    
    local success, result = pcall(function()
        playerDataStore:SetAsync(player.UserId, data)
    end)
    
    if success then
        print("[ProfileService] Profile saved successfully for", player.Name)
        return true
    else
        warn("[ProfileService] Failed to save profile for", player.Name, ":", result)
        return false
    end
end

-- Получение данных игрока
function ProfileService:GetPlayerData(player)
    return self.playerProfiles[player] or self:GetDefaultProfile()
end

-- Обновление данных игрока
function ProfileService:UpdatePlayerData(player, updates)
    local profile = self.playerProfiles[player]
    if not profile then
        warn("[ProfileService] No profile found for", player.Name)
        return false
    end
    
    -- Применение обновлений
    for key, value in pairs(updates) do
        profile[key] = value
    end
    
    -- Автосохранение
    self:SaveProfile(player, profile)
    
    return true
end

-- Получение профиля по умолчанию
function ProfileService:GetDefaultProfile()
    return {
        level = 1,
        experience = 0,
        experienceToNextLevel = 100,
        resources = {
            Wood = 50,
            Stone = 25,
            Crystal = 5,
            Gold = 100
        },
        selectedClass = "Warrior",
        unlockedClasses = {"Warrior"},
        statistics = {
            wavesCompleted = 0,
            enemiesKilled = 0,
            structuresBuilt = 0,
            resourcesGathered = 0,
            totalDamageDealt = 0,
            totalDamageReceived = 0,
            playTime = 0
        },
        achievements = {},
        settings = {
            soundVolume = 0.7,
            musicVolume = 0.5,
            uiScale = 1.0,
            showDamageNumbers = true,
            showNotifications = true
        },
        lastSaveTime = tick(),
        createdAt = tick()
    }
end

-- Валидация данных профиля
function ProfileService:ValidateProfileData(data)
    if not data or type(data) ~= "table" then
        return false
    end
    
    -- Проверка обязательных полей
    local requiredFields = {
        "level", "experience", "resources", "selectedClass", 
        "unlockedClasses", "statistics", "settings"
    }
    
    for _, field in ipairs(requiredFields) do
        if data[field] == nil then
            return false
        end
    end
    
    -- Проверка типов данных
    if type(data.level) ~= "number" or data.level < 1 then
        return false
    end
    
    if type(data.experience) ~= "number" or data.experience < 0 then
        return false
    end
    
    if type(data.resources) ~= "table" then
        return false
    end
    
    if type(data.selectedClass) ~= "string" then
        return false
    end
    
    if type(data.unlockedClasses) ~= "table" then
        return false
    end
    
    if type(data.statistics) ~= "table" then
        return false
    end
    
    return true
end

-- Добавление опыта игроку
function ProfileService:AddExperience(player, amount)
    local profile = self.playerProfiles[player]
    if not profile then
        return false
    end
    
    profile.experience = profile.experience + amount
    profile.statistics.playTime = profile.statistics.playTime + amount
    
    -- Проверка повышения уровня
    while profile.experience >= profile.experienceToNextLevel do
        profile.experience = profile.experience - profile.experienceToNextLevel
        profile.level = profile.level + 1
        profile.experienceToNextLevel = self:CalculateExperienceForLevel(profile.level)
        
        -- Уведомление о повышении уровня
        self:NotifyLevelUp(player, profile.level)
    end
    
    return true
end

-- Расчет опыта для уровня
function ProfileService:CalculateExperienceForLevel(level)
    return 100 + (level - 1) * 50
end

-- Уведомление о повышении уровня
function ProfileService:NotifyLevelUp(player, newLevel)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        remote:FireClient(player, "Уровень повышен! " .. newLevel, "success", 5)
    end
end

-- Добавление ресурсов игроку
function ProfileService:AddResources(player, resources)
    local profile = self.playerProfiles[player]
    if not profile then
        return false
    end
    
    for resourceType, amount in pairs(resources) do
        if not profile.resources[resourceType] then
            profile.resources[resourceType] = 0
        end
        profile.resources[resourceType] = profile.resources[resourceType] + amount
    end
    
    return true
end

-- Списание ресурсов игрока
function ProfileService:SpendResources(player, resources)
    local profile = self.playerProfiles[player]
    if not profile then
        return false
    end
    
    -- Проверка наличия ресурсов
    for resourceType, amount in pairs(resources) do
        if not profile.resources[resourceType] or profile.resources[resourceType] < amount then
            return false
        end
    end
    
    -- Списание ресурсов
    for resourceType, amount in pairs(resources) do
        profile.resources[resourceType] = profile.resources[resourceType] - amount
    end
    
    return true
end

-- Разблокировка класса
function ProfileService:UnlockClass(player, className)
    local profile = self.playerProfiles[player]
    if not profile then
        return false
    end
    
    -- Проверка, не разблокирован ли уже класс
    for _, unlockedClass in ipairs(profile.unlockedClasses) do
        if unlockedClass == className then
            return false
        end
    end
    
    -- Разблокировка класса
    table.insert(profile.unlockedClasses, className)
    
    -- Уведомление игрока
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        remote:FireClient(player, "Разблокирован класс: " .. className, "success", 5)
    end
    
    return true
end

-- Обновление статистики
function ProfileService:UpdateStatistics(player, updates)
    local profile = self.playerProfiles[player]
    if not profile then
        return false
    end
    
    for statName, value in pairs(updates) do
        if profile.statistics[statName] then
            if type(value) == "number" then
                profile.statistics[statName] = profile.statistics[statName] + value
            else
                profile.statistics[statName] = value
            end
        end
    end
    
    return true
end

-- Получение статистики игрока
function ProfileService:GetPlayerStatistics(player)
    local profile = self.playerProfiles[player]
    if not profile then
        return {}
    end
    
    return profile.statistics
end

-- Сохранение настроек игрока
function ProfileService:SavePlayerSettings(player, settings)
    local profile = self.playerProfiles[player]
    if not profile then
        return false
    end
    
    for settingName, value in pairs(settings) do
        if profile.settings[settingName] ~= nil then
            profile.settings[settingName] = value
        end
    end
    
    return true
end

-- Получение настроек игрока
function ProfileService:GetPlayerSettings(player)
    local profile = self.playerProfiles[player]
    if not profile then
        return self:GetDefaultProfile().settings
    end
    
    return profile.settings
end

-- Запуск автосохранения
function ProfileService:StartAutoSave()
    task.spawn(function()
        while true do
            task.wait(self.autoSaveInterval)
            
            for player, profile in pairs(self.playerProfiles) do
                if player and player.Parent then
                    self:SaveProfile(player, profile)
                end
            end
            
            print("[ProfileService] Auto-save completed")
        end
    end)
end

-- Принудительное сохранение всех профилей
function ProfileService:ForceSaveAll()
    print("[ProfileService] Force saving all profiles...")
    
    for player, profile in pairs(self.playerProfiles) do
        if player and player.Parent then
            self:SaveProfile(player, profile)
        end
    end
    
    print("[ProfileService] Force save completed")
end

-- Очистка профиля игрока
function ProfileService:ClearPlayerProfile(player)
    if self.playerProfiles[player] then
        self.playerProfiles[player] = nil
    end
    
    -- Удаление из DataStore
    local success, result = pcall(function()
        playerDataStore:RemoveAsync(player.UserId)
    end)
    
    if success then
        print("[ProfileService] Profile cleared for", player.Name)
        return true
    else
        warn("[ProfileService] Failed to clear profile for", player.Name, ":", result)
        return false
    end
end

-- Получение списка всех профилей
function ProfileService:GetAllProfiles()
    return self.playerProfiles
end

-- Получение статистики сервера
function ProfileService:GetServerStatistics()
    local stats = {
        totalPlayers = 0,
        totalLevel = 0,
        totalExperience = 0,
        totalResources = {
            Wood = 0,
            Stone = 0,
            Crystal = 0,
            Gold = 0
        }
    }
    
    for player, profile in pairs(self.playerProfiles) do
        if player and player.Parent then
            stats.totalPlayers = stats.totalPlayers + 1
            stats.totalLevel = stats.totalLevel + profile.level
            stats.totalExperience = stats.totalExperience + profile.experience
            
            for resourceType, amount in pairs(profile.resources) do
                if stats.totalResources[resourceType] then
                    stats.totalResources[resourceType] = stats.totalResources[resourceType] + amount
                end
            end
        end
    end
    
    return stats
end

return setmetatable({}, ProfileService)