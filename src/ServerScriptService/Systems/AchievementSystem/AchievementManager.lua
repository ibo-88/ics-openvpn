-- AchievementManager.lua
-- Система достижений для Nexus Siege

local AchievementManager = {}
AchievementManager.__index = AchievementManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Data.ProfileService)

-- Состояние
AchievementManager.achievements = {}
AchievementManager.playerProgress = {}
AchievementManager.achievementEvents = {}

function AchievementManager:Initialize()
    print("[AchievementManager] Initializing...")
    
    -- Инициализация достижений
    self:InitializeAchievements()
    
    -- Подключение событий
    self:ConnectEvents()
    
    print("[AchievementManager] Initialized successfully!")
end

-- Инициализация достижений
function AchievementManager:InitializeAchievements()
    self.achievements = {
        -- Достижения за убийства
        {
            id = "first_blood",
            name = "Первая Кровь",
            description = "Убейте первого врага",
            icon = "🩸",
            category = "Combat",
            requirement = {type = "kills", amount = 1},
            reward = {gold = 50, experience = 25}
        },
        {
            id = "warrior",
            name = "Воин",
            description = "Убейте 100 врагов",
            icon = "⚔️",
            category = "Combat",
            requirement = {type = "kills", amount = 100},
            reward = {gold = 500, experience = 200}
        },
        {
            id = "slayer",
            name = "Истребитель",
            description = "Убейте 1000 врагов",
            icon = "🗡️",
            category = "Combat",
            requirement = {type = "kills", amount = 1000},
            reward = {gold = 2000, experience = 1000}
        },
        
        -- Достижения за строительство
        {
            id = "builder",
            name = "Строитель",
            description = "Постройте первую стену",
            icon = "🧱",
            category = "Building",
            requirement = {type = "structures_built", amount = 1},
            reward = {gold = 30, experience = 15}
        },
        {
            id = "architect",
            name = "Архитектор",
            description = "Постройте 50 структур",
            icon = "🏗️",
            category = "Building",
            requirement = {type = "structures_built", amount = 50},
            reward = {gold = 300, experience = 150}
        },
        {
            id = "fortress_master",
            name = "Мастер Крепости",
            description = "Постройте 200 структур",
            icon = "🏰",
            category = "Building",
            requirement = {type = "structures_built", amount = 200},
            reward = {gold = 1000, experience = 500}
        },
        
        -- Достижения за ресурсы
        {
            id = "gatherer",
            name = "Собиратель",
            description = "Соберите 100 ресурсов",
            icon = "⛏️",
            category = "Resources",
            requirement = {type = "resources_gathered", amount = 100},
            reward = {gold = 40, experience = 20}
        },
        {
            id = "miner",
            name = "Шахтер",
            description = "Соберите 1000 ресурсов",
            icon = "⛏️",
            category = "Resources",
            requirement = {type = "resources_gathered", amount = 1000},
            reward = {gold = 400, experience = 200}
        },
        {
            id = "resource_king",
            name = "Король Ресурсов",
            description = "Соберите 10000 ресурсов",
            icon = "👑",
            category = "Resources",
            requirement = {type = "resources_gathered", amount = 10000},
            reward = {gold = 2000, experience = 1000}
        },
        
        -- Достижения за волны
        {
            id = "survivor",
            name = "Выживший",
            description = "Завершите первую волну",
            icon = "🌊",
            category = "Waves",
            requirement = {type = "waves_completed", amount = 1},
            reward = {gold = 100, experience = 50}
        },
        {
            id = "wave_master",
            name = "Мастер Волн",
            description = "Завершите 10 волн",
            icon = "🌊",
            category = "Waves",
            requirement = {type = "waves_completed", amount = 10},
            reward = {gold = 500, experience = 250}
        },
        {
            id = "wave_legend",
            name = "Легенда Волн",
            description = "Завершите 50 волн",
            icon = "🌊",
            category = "Waves",
            requirement = {type = "waves_completed", amount = 50},
            reward = {gold = 2500, experience = 1250}
        },
        
        -- Достижения за уровни
        {
            id = "novice",
            name = "Новичок",
            description = "Достигните 5 уровня",
            icon = "⭐",
            category = "Levels",
            requirement = {type = "level", amount = 5},
            reward = {gold = 200, experience = 100}
        },
        {
            id = "veteran",
            name = "Ветеран",
            description = "Достигните 20 уровня",
            icon = "⭐⭐",
            category = "Levels",
            requirement = {type = "level", amount = 20},
            reward = {gold = 800, experience = 400}
        },
        {
            id = "master",
            name = "Мастер",
            description = "Достигните 50 уровня",
            icon = "⭐⭐⭐",
            category = "Levels",
            requirement = {type = "level", amount = 50},
            reward = {gold = 2000, experience = 1000}
        },
        
        -- Достижения за время игры
        {
            id = "dedicated",
            name = "Преданный",
            description = "Играйте 1 час",
            icon = "⏰",
            category = "Time",
            requirement = {type = "play_time", amount = 3600},
            reward = {gold = 150, experience = 75}
        },
        {
            id = "hardcore",
            name = "Хардкор",
            description = "Играйте 10 часов",
            icon = "⏰",
            category = "Time",
            requirement = {type = "play_time", amount = 36000},
            reward = {gold = 1000, experience = 500}
        },
        
        -- Секретные достижения
        {
            id = "explorer",
            name = "Исследователь",
            description = "Откройте секретное достижение",
            icon = "🔍",
            category = "Secret",
            requirement = {type = "secret", amount = 1},
            reward = {gold = 500, experience = 250},
            secret = true
        }
    }
    
    print("[AchievementManager] Loaded " .. #self.achievements .. " achievements")
end

-- Подключение событий
function AchievementManager:ConnectEvents()
    -- События для отслеживания прогресса
    self.achievementEvents = {
        kills = function(player, amount)
            self:UpdateProgress(player, "kills", amount)
        end,
        structures_built = function(player, amount)
            self:UpdateProgress(player, "structures_built", amount)
        end,
        resources_gathered = function(player, amount)
            self:UpdateProgress(player, "resources_gathered", amount)
        end,
        waves_completed = function(player, amount)
            self:UpdateProgress(player, "waves_completed", amount)
        end,
        level = function(player, level)
            self:UpdateProgress(player, "level", level)
        end,
        play_time = function(player, time)
            self:UpdateProgress(player, "play_time", time)
        end
    }
end

-- Обновление прогресса игрока
function AchievementManager:UpdateProgress(player, progressType, amount)
    if not player then return end
    
    -- Получение данных игрока
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData then return end
    
    -- Инициализация прогресса достижений
    if not playerData.achievements then
        playerData.achievements = {
            progress = {},
            unlocked = {}
        }
    end
    
    -- Обновление прогресса
    if not playerData.achievements.progress[progressType] then
        playerData.achievements.progress[progressType] = 0
    end
    
    playerData.achievements.progress[progressType] = playerData.achievements.progress[progressType] + amount
    
    -- Проверка достижений
    self:CheckAchievements(player, playerData)
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
end

-- Проверка достижений
function AchievementManager:CheckAchievements(player, playerData)
    for _, achievement in ipairs(self.achievements) do
        -- Пропускаем уже разблокированные достижения
        if playerData.achievements.unlocked[achievement.id] then
            continue
        end
        
        -- Проверка требований
        if self:CheckAchievementRequirement(player, achievement, playerData) then
            self:UnlockAchievement(player, achievement)
        end
    end
end

-- Проверка требований достижения
function AchievementManager:CheckAchievementRequirement(player, achievement, playerData)
    local requirement = achievement.requirement
    local progress = playerData.achievements.progress[requirement.type] or 0
    
    if requirement.type == "level" then
        return playerData.level >= requirement.amount
    elseif requirement.type == "play_time" then
        return playerData.statistics.playTime >= requirement.amount
    else
        return progress >= requirement.amount
    end
end

-- Разблокировка достижения
function AchievementManager:UnlockAchievement(player, achievement)
    print("[AchievementManager] Player", player.Name, "unlocked achievement:", achievement.name)
    
    -- Получение данных игрока
    local playerData = ProfileService:GetPlayerData(player)
    
    -- Отметка как разблокированное
    playerData.achievements.unlocked[achievement.id] = {
        unlockedAt = tick(),
        progress = playerData.achievements.progress
    }
    
    -- Выдача наград
    if achievement.reward then
        if achievement.reward.gold then
            ProfileService:AddResources(player, {Gold = achievement.reward.gold})
        end
        
        if achievement.reward.experience then
            ProfileService:AddExperience(player, achievement.reward.experience)
        end
    end
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    -- Уведомление игрока
    self:NotifyAchievementUnlocked(player, achievement)
    
    -- Запуск события
    self:FireAchievementEvent(player, achievement)
end

-- Уведомление о разблокировке достижения
function AchievementManager:NotifyAchievementUnlocked(player, achievement)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        local message = "🏆 Достижение разблокировано: " .. achievement.name
        remote:FireClient(player, message, "success", 5)
    end
end

-- Запуск события достижения
function AchievementManager:FireAchievementEvent(player, achievement)
    -- Здесь можно добавить дополнительные события
    -- Например, звуковые эффекты, визуальные эффекты и т.д.
end

-- Получение прогресса достижений игрока
function AchievementManager:GetPlayerAchievements(player)
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData or not playerData.achievements then
        return {progress = {}, unlocked = {}}
    end
    
    return playerData.achievements
end

-- Получение всех достижений
function AchievementManager:GetAllAchievements()
    return self.achievements
end

-- Получение достижений по категории
function AchievementManager:GetAchievementsByCategory(category)
    local categoryAchievements = {}
    
    for _, achievement in ipairs(self.achievements) do
        if achievement.category == category then
            table.insert(categoryAchievements, achievement)
        end
    end
    
    return categoryAchievements
end

-- Получение статистики достижений
function AchievementManager:GetAchievementStatistics(player)
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData or not playerData.achievements then
        return {
            total = #self.achievements,
            unlocked = 0,
            progress = {},
            completionRate = 0
        }
    end
    
    local unlockedCount = 0
    for _ in pairs(playerData.achievements.unlocked) do
        unlockedCount = unlockedCount + 1
    end
    
    return {
        total = #self.achievements,
        unlocked = unlockedCount,
        progress = playerData.achievements.progress,
        completionRate = math.floor((unlockedCount / #self.achievements) * 100)
    }
end

-- Проверка, разблокировано ли достижение
function AchievementManager:IsAchievementUnlocked(player, achievementId)
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData or not playerData.achievements then
        return false
    end
    
    return playerData.achievements.unlocked[achievementId] ~= nil
end

-- Получение прогресса конкретного достижения
function AchievementManager:GetAchievementProgress(player, achievementId)
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData or not playerData.achievements then
        return 0
    end
    
    -- Поиск достижения
    local achievement = nil
    for _, ach in ipairs(self.achievements) do
        if ach.id == achievementId then
            achievement = ach
            break
        end
    end
    
    if not achievement then
        return 0
    end
    
    local requirement = achievement.requirement
    local progress = playerData.achievements.progress[requirement.type] or 0
    
    if requirement.type == "level" then
        return math.min(playerData.level, requirement.amount)
    elseif requirement.type == "play_time" then
        return math.min(playerData.statistics.playTime, requirement.amount)
    else
        return math.min(progress, requirement.amount)
    end
end

-- Получение процента прогресса достижения
function AchievementManager:GetAchievementProgressPercent(player, achievementId)
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData or not playerData.achievements then
        return 0
    end
    
    -- Поиск достижения
    local achievement = nil
    for _, ach in ipairs(self.achievements) do
        if ach.id == achievementId then
            achievement = ach
            break
        end
    end
    
    if not achievement then
        return 0
    end
    
    local requirement = achievement.requirement
    local progress = playerData.achievements.progress[requirement.type] or 0
    
    if requirement.type == "level" then
        return math.min((playerData.level / requirement.amount) * 100, 100)
    elseif requirement.type == "play_time" then
        return math.min((playerData.statistics.playTime / requirement.amount) * 100, 100)
    else
        return math.min((progress / requirement.amount) * 100, 100)
    end
end

-- Сброс достижений игрока (для тестирования)
function AchievementManager:ResetPlayerAchievements(player)
    local playerData = ProfileService:GetPlayerData(player)
    if playerData then
        playerData.achievements = {
            progress = {},
            unlocked = {}
        }
        ProfileService:SavePlayerData(player, playerData)
        print("[AchievementManager] Reset achievements for", player.Name)
    end
end

-- Получение последних разблокированных достижений
function AchievementManager:GetRecentAchievements(player, count)
    local playerData = ProfileService:GetPlayerData(player)
    if not playerData or not playerData.achievements then
        return {}
    end
    
    local recent = {}
    for achievementId, unlockData in pairs(playerData.achievements.unlocked) do
        table.insert(recent, {
            id = achievementId,
            unlockedAt = unlockData.unlockedAt
        })
    end
    
    -- Сортировка по времени разблокировки
    table.sort(recent, function(a, b)
        return a.unlockedAt > b.unlockedAt
    end)
    
    -- Возврат только последних count достижений
    local result = {}
    for i = 1, math.min(count, #recent) do
        table.insert(result, recent[i])
    end
    
    return result
end

return setmetatable({}, AchievementManager)