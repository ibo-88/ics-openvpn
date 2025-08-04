-- StatisticsManager.lua
-- Полная система статистики и аналитики

local StatisticsManager = {}
StatisticsManager.__index = StatisticsManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)

-- Состояние
StatisticsManager.playerStats = {}
StatisticsManager.globalStats = {}
StatisticsManager.gameStats = {}
StatisticsManager.analytics = {}
StatisticsManager.reports = {}

function StatisticsManager:Initialize()
    print("[StatisticsManager] Initializing statistics system...")
    
    -- Инициализация статистики
    self:InitializePlayerStats()
    self:InitializeGlobalStats()
    self:InitializeGameStats()
    self:InitializeAnalytics()
    
    print("[StatisticsManager] Statistics system initialized!")
end

-- Инициализация статистики игроков
function StatisticsManager:InitializePlayerStats()
    self.playerStats = {}
end

-- Инициализация глобальной статистики
function StatisticsManager:InitializeGlobalStats()
    self.globalStats = {
        totalPlayers = 0,
        totalGames = 0,
        totalWaves = 0,
        totalEnemiesKilled = 0,
        totalResourcesGathered = 0,
        totalStructuresBuilt = 0,
        totalDamageDealt = 0,
        totalDamageTaken = 0,
        totalHealing = 0,
        averageGameDuration = 0,
        averageWavesPerGame = 0,
        averagePlayersPerGame = 0,
        winRate = 0,
        totalAchievements = 0,
        totalTransactions = 0
    }
end

-- Инициализация статистики игры
function StatisticsManager:InitializeGameStats()
    self.gameStats = {
        currentGame = {
            startTime = 0,
            endTime = 0,
            duration = 0,
            players = {},
            waves = 0,
            enemiesKilled = 0,
            resourcesGathered = 0,
            structuresBuilt = 0,
            damageDealt = 0,
            damageTaken = 0,
            healing = 0,
            achievements = 0,
            transactions = 0,
            result = nil
        },
        gameHistory = {}
    }
end

-- Инициализация аналитики
function StatisticsManager:InitializeAnalytics()
    self.analytics = {
        playerRetention = {},
        gamePerformance = {},
        balanceMetrics = {},
        engagementMetrics = {},
        errorLogs = {}
    }
end

-- Создание статистики игрока
function StatisticsManager:CreatePlayerStats(player)
    local stats = {
        player = player,
        userId = player.UserId,
        username = player.Name,
        
        -- Общая статистика
        totalGames = 0,
        gamesWon = 0,
        gamesLost = 0,
        totalPlayTime = 0,
        lastPlayed = 0,
        
        -- Боевая статистика
        totalDamageDealt = 0,
        totalDamageTaken = 0,
        totalHealing = 0,
        enemiesKilled = 0,
        deaths = 0,
        kills = 0,
        assists = 0,
        
        -- Статистика ресурсов
        resourcesGathered = {
            wood = 0,
            stone = 0,
            metal = 0,
            crystal = 0
        },
        totalResourcesGathered = 0,
        
        -- Статистика строительства
        structuresBuilt = {
            walls = 0,
            towers = 0,
            traps = 0
        },
        totalStructuresBuilt = 0,
        
        -- Статистика волн
        wavesCompleted = 0,
        totalWaves = 0,
        highestWave = 0,
        
        -- Статистика способностей
        abilitiesUsed = {
            warrior_attack = 0,
            warrior_defend = 0,
            engineer_build = 0,
            engineer_turret = 0
        },
        totalAbilitiesUsed = 0,
        
        -- Статистика достижений
        achievementsUnlocked = 0,
        totalAchievements = 0,
        
        -- Статистика экономики
        currencyEarned = {
            gold = 0,
            gems = 0,
            experience = 0,
            honor = 0
        },
        itemsPurchased = 0,
        itemsSold = 0,
        
        -- Статистика классов
        classUsage = {
            warrior = 0,
            engineer = 0
        },
        preferredClass = nil,
        
        -- Временные метрики
        sessionStats = {
            currentSession = {
                startTime = 0,
                duration = 0,
                damageDealt = 0,
                damageTaken = 0,
                enemiesKilled = 0,
                resourcesGathered = 0,
                structuresBuilt = 0
            }
        }
    }
    
    self.playerStats[player.UserId] = stats
    return stats
end

-- Получение статистики игрока
function StatisticsManager:GetPlayerStats(player)
    if not player then return nil end
    
    local stats = self.playerStats[player.UserId]
    if not stats then
        stats = self:CreatePlayerStats(player)
    end
    
    return stats
end

-- Обновление статистики игрока
function StatisticsManager:UpdatePlayerStat(player, statType, value, operation)
    local stats = self:GetPlayerStats(player)
    if not stats then return false end
    
    operation = operation or "add"
    
    if operation == "add" then
        if type(stats[statType]) == "number" then
            stats[statType] = stats[statType] + value
        elseif type(stats[statType]) == "table" then
            -- Для вложенных таблиц
            for key, val in pairs(value) do
                if type(stats[statType][key]) == "number" then
                    stats[statType][key] = stats[statType][key] + val
                end
            end
        end
    elseif operation == "set" then
        stats[statType] = value
    elseif operation == "max" then
        if type(stats[statType]) == "number" then
            stats[statType] = math.max(stats[statType], value)
        end
    end
    
    return true
end

-- Обновление глобальной статистики
function StatisticsManager:UpdateGlobalStat(statType, value, operation)
    operation = operation or "add"
    
    if operation == "add" then
        if type(self.globalStats[statType]) == "number" then
            self.globalStats[statType] = self.globalStats[statType] + value
        end
    elseif operation == "set" then
        self.globalStats[statType] = value
    elseif operation == "average" then
        -- Для средних значений
        if self.globalStats[statType] then
            self.globalStats[statType] = (self.globalStats[statType] + value) / 2
        else
            self.globalStats[statType] = value
        end
    end
end

-- Начало игры
function StatisticsManager:StartGame(players)
    self.gameStats.currentGame = {
        startTime = os.time(),
        endTime = 0,
        duration = 0,
        players = {},
        waves = 0,
        enemiesKilled = 0,
        resourcesGathered = 0,
        structuresBuilt = 0,
        damageDealt = 0,
        damageTaken = 0,
        healing = 0,
        achievements = 0,
        transactions = 0,
        result = nil
    }
    
    -- Инициализация статистики игроков для этой игры
    for _, player in pairs(players) do
        local playerStats = self:GetPlayerStats(player)
        if playerStats then
            self.gameStats.currentGame.players[player.UserId] = {
                player = player,
                damageDealt = 0,
                damageTaken = 0,
                enemiesKilled = 0,
                resourcesGathered = 0,
                structuresBuilt = 0,
                abilitiesUsed = 0,
                startTime = os.time()
            }
        end
    end
    
    -- Обновление глобальной статистики
    self:UpdateGlobalStat("totalGames", 1, "add")
    self:UpdateGlobalStat("totalPlayers", #players, "add")
end

-- Завершение игры
function StatisticsManager:EndGame(result)
    local currentGame = self.gameStats.currentGame
    currentGame.endTime = os.time()
    currentGame.duration = currentGame.endTime - currentGame.startTime
    currentGame.result = result
    
    -- Обновление статистики игроков
    for userId, playerGameStats in pairs(currentGame.players) do
        local player = playerGameStats.player
        local playerStats = self:GetPlayerStats(player)
        
        if playerStats then
            -- Обновление общей статистики
            self:UpdatePlayerStat(player, "totalGames", 1, "add")
            if result == "victory" then
                self:UpdatePlayerStat(player, "gamesWon", 1, "add")
            else
                self:UpdatePlayerStat(player, "gamesLost", 1, "add")
            end
            
            self:UpdatePlayerStat(player, "totalPlayTime", currentGame.duration, "add")
            self:UpdatePlayerStat(player, "lastPlayed", os.time(), "set")
            
            -- Обновление боевой статистики
            self:UpdatePlayerStat(player, "totalDamageDealt", playerGameStats.damageDealt, "add")
            self:UpdatePlayerStat(player, "totalDamageTaken", playerGameStats.damageTaken, "add")
            self:UpdatePlayerStat(player, "enemiesKilled", playerGameStats.enemiesKilled, "add")
            
            -- Обновление статистики ресурсов
            self:UpdatePlayerStat(player, "resourcesGathered", playerGameStats.resourcesGathered, "add")
            self:UpdatePlayerStat(player, "totalResourcesGathered", 
                                playerGameStats.resourcesGathered.wood + 
                                playerGameStats.resourcesGathered.stone + 
                                playerGameStats.resourcesGathered.metal + 
                                playerGameStats.resourcesGathered.crystal, "add")
            
            -- Обновление статистики строительства
            self:UpdatePlayerStat(player, "structuresBuilt", playerGameStats.structuresBuilt, "add")
            self:UpdatePlayerStat(player, "totalStructuresBuilt", 
                                playerGameStats.structuresBuilt.walls + 
                                playerGameStats.structuresBuilt.towers + 
                                playerGameStats.structuresBuilt.traps, "add")
            
            -- Обновление статистики волн
            self:UpdatePlayerStat(player, "wavesCompleted", currentGame.waves, "add")
            self:UpdatePlayerStat(player, "totalWaves", currentGame.waves, "add")
            self:UpdatePlayerStat(player, "highestWave", currentGame.waves, "max")
        end
    end
    
    -- Обновление глобальной статистики
    self:UpdateGlobalStat("totalWaves", currentGame.waves, "add")
    self:UpdateGlobalStat("totalEnemiesKilled", currentGame.enemiesKilled, "add")
    self:UpdateGlobalStat("totalResourcesGathered", currentGame.resourcesGathered, "add")
    self:UpdateGlobalStat("totalStructuresBuilt", currentGame.structuresBuilt, "add")
    self:UpdateGlobalStat("totalDamageDealt", currentGame.damageDealt, "add")
    self:UpdateGlobalStat("totalDamageTaken", currentGame.damageTaken, "add")
    self:UpdateGlobalStat("totalHealing", currentGame.healing, "add")
    self:UpdateGlobalStat("totalAchievements", currentGame.achievements, "add")
    self:UpdateGlobalStat("totalTransactions", currentGame.transactions, "add")
    
    -- Обновление средних значений
    self:UpdateGlobalStat("averageGameDuration", currentGame.duration, "average")
    self:UpdateGlobalStat("averageWavesPerGame", currentGame.waves, "average")
    self:UpdateGlobalStat("averagePlayersPerGame", #currentGame.players, "average")
    
    -- Расчет процента побед
    if result == "victory" then
        local totalGames = self.globalStats.totalGames
        local gamesWon = 0
        for _, stats in pairs(self.playerStats) do
            gamesWon = gamesWon + stats.gamesWon
        end
        self.globalStats.winRate = (gamesWon / totalGames) * 100
    end
    
    -- Сохранение игры в историю
    table.insert(self.gameStats.gameHistory, currentGame)
    
    -- Ограничение размера истории
    if #self.gameStats.gameHistory > 100 then
        table.remove(self.gameStats.gameHistory, 1)
    end
end

-- Обновление статистики во время игры
function StatisticsManager:UpdateGameStat(statType, value, player)
    local currentGame = self.gameStats.currentGame
    
    if currentGame.players[player.UserId] then
        if type(currentGame.players[player.UserId][statType]) == "number" then
            currentGame.players[player.UserId][statType] = currentGame.players[player.UserId][statType] + value
        end
    end
    
    if type(currentGame[statType]) == "number" then
        currentGame[statType] = currentGame[statType] + value
    end
end

-- Отслеживание использования способности
function StatisticsManager:TrackAbilityUse(player, abilityName)
    local playerStats = self:GetPlayerStats(player)
    if playerStats then
        if playerStats.abilitiesUsed[abilityName] then
            playerStats.abilitiesUsed[abilityName] = playerStats.abilitiesUsed[abilityName] + 1
        end
        playerStats.totalAbilitiesUsed = playerStats.totalAbilitiesUsed + 1
    end
    
    self:UpdateGameStat("abilitiesUsed", 1, player)
end

-- Отслеживание выбора класса
function StatisticsManager:TrackClassSelection(player, className)
    local playerStats = self:GetPlayerStats(player)
    if playerStats then
        if playerStats.classUsage[className] then
            playerStats.classUsage[className] = playerStats.classUsage[className] + 1
        end
        
        -- Определение предпочтительного класса
        local maxUsage = 0
        for class, usage in pairs(playerStats.classUsage) do
            if usage > maxUsage then
                maxUsage = usage
                playerStats.preferredClass = class
            end
        end
    end
end

-- Отслеживание транзакции
function StatisticsManager:TrackTransaction(player, transactionType, amount, currency)
    local playerStats = self:GetPlayerStats(player)
    if playerStats then
        if playerStats.currencyEarned[currency] then
            if transactionType == "earn" then
                playerStats.currencyEarned[currency] = playerStats.currencyEarned[currency] + amount
            elseif transactionType == "spend" then
                playerStats.currencyEarned[currency] = playerStats.currencyEarned[currency] - amount
            end
        end
        
        if transactionType == "purchase" then
            playerStats.itemsPurchased = playerStats.itemsPurchased + 1
        elseif transactionType == "sell" then
            playerStats.itemsSold = playerStats.itemsSold + 1
        end
    end
    
    self:UpdateGameStat("transactions", 1, player)
end

-- Отслеживание достижения
function StatisticsManager:TrackAchievement(player, achievementName)
    local playerStats = self:GetPlayerStats(player)
    if playerStats then
        playerStats.achievementsUnlocked = playerStats.achievementsUnlocked + 1
    end
    
    self:UpdateGameStat("achievements", 1, player)
end

-- Получение статистики игрока
function StatisticsManager:GetPlayerStatistics(player)
    local stats = self:GetPlayerStats(player)
    if not stats then return nil end
    
    return {
        general = {
            totalGames = stats.totalGames,
            gamesWon = stats.gamesWon,
            gamesLost = stats.gamesLost,
            winRate = stats.totalGames > 0 and (stats.gamesWon / stats.totalGames) * 100 or 0,
            totalPlayTime = stats.totalPlayTime,
            lastPlayed = stats.lastPlayed
        },
        combat = {
            totalDamageDealt = stats.totalDamageDealt,
            totalDamageTaken = stats.totalDamageTaken,
            totalHealing = stats.totalHealing,
            enemiesKilled = stats.enemiesKilled,
            deaths = stats.deaths,
            kills = stats.kills,
            assists = stats.assists,
            kdr = stats.deaths > 0 and stats.kills / stats.deaths or stats.kills
        },
        resources = stats.resourcesGathered,
        building = stats.structuresBuilt,
        waves = {
            completed = stats.wavesCompleted,
            total = stats.totalWaves,
            highest = stats.highestWave
        },
        abilities = stats.abilitiesUsed,
        achievements = {
            unlocked = stats.achievementsUnlocked,
            total = stats.totalAchievements
        },
        economy = {
            currencyEarned = stats.currencyEarned,
            itemsPurchased = stats.itemsPurchased,
            itemsSold = stats.itemsSold
        },
        classes = {
            usage = stats.classUsage,
            preferred = stats.preferredClass
        }
    }
end

-- Получение глобальной статистики
function StatisticsManager:GetGlobalStatistics()
    return self.globalStats
end

-- Получение статистики текущей игры
function StatisticsManager:GetCurrentGameStats()
    return self.gameStats.currentGame
end

-- Получение истории игр
function StatisticsManager:GetGameHistory(limit)
    limit = limit or 10
    
    local history = {}
    for i = #self.gameStats.gameHistory, math.max(1, #self.gameStats.gameHistory - limit + 1), -1 do
        table.insert(history, self.gameStats.gameHistory[i])
    end
    
    return history
end

-- Создание отчета
function StatisticsManager:GenerateReport(reportType, filters)
    local report = {
        type = reportType,
        timestamp = os.time(),
        data = {}
    }
    
    if reportType == "player_performance" then
        report.data = self:GeneratePlayerPerformanceReport(filters)
    elseif reportType == "game_balance" then
        report.data = self:GenerateGameBalanceReport(filters)
    elseif reportType == "engagement" then
        report.data = self:GenerateEngagementReport(filters)
    elseif reportType == "economy" then
        report.data = self:GenerateEconomyReport(filters)
    end
    
    table.insert(self.reports, report)
    
    -- Ограничение размера отчетов
    if #self.reports > 50 then
        table.remove(self.reports, 1)
    end
    
    return report
end

-- Генерация отчета производительности игроков
function StatisticsManager:GeneratePlayerPerformanceReport(filters)
    local report = {
        topPlayers = {},
        averageStats = {},
        classPerformance = {}
    }
    
    -- Топ игроков по урону
    local playersByDamage = {}
    for userId, stats in pairs(self.playerStats) do
        table.insert(playersByDamage, {
            player = stats.player,
            damage = stats.totalDamageDealt
        })
    end
    
    table.sort(playersByDamage, function(a, b)
        return a.damage > b.damage
    end)
    
    for i = 1, math.min(10, #playersByDamage) do
        table.insert(report.topPlayers, playersByDamage[i])
    end
    
    -- Средняя статистика
    local totalPlayers = 0
    local totalDamage = 0
    local totalKills = 0
    local totalGames = 0
    
    for _, stats in pairs(self.playerStats) do
        totalPlayers = totalPlayers + 1
        totalDamage = totalDamage + stats.totalDamageDealt
        totalKills = totalKills + stats.enemiesKilled
        totalGames = totalGames + stats.totalGames
    end
    
    report.averageStats = {
        averageDamage = totalPlayers > 0 and totalDamage / totalPlayers or 0,
        averageKills = totalPlayers > 0 and totalKills / totalPlayers or 0,
        averageGames = totalPlayers > 0 and totalGames / totalPlayers or 0
    }
    
    return report
end

-- Генерация отчета баланса игры
function StatisticsManager:GenerateGameBalanceReport(filters)
    local report = {
        winRate = self.globalStats.winRate,
        averageGameDuration = self.globalStats.averageGameDuration,
        averageWavesPerGame = self.globalStats.averageWavesPerGame,
        classUsage = {},
        abilityUsage = {}
    }
    
    -- Использование классов
    local totalClassUsage = {warrior = 0, engineer = 0}
    for _, stats in pairs(self.playerStats) do
        for class, usage in pairs(stats.classUsage) do
            totalClassUsage[class] = totalClassUsage[class] + usage
        end
    end
    
    report.classUsage = totalClassUsage
    
    -- Использование способностей
    local totalAbilityUsage = {}
    for _, stats in pairs(self.playerStats) do
        for ability, usage in pairs(stats.abilitiesUsed) do
            totalAbilityUsage[ability] = (totalAbilityUsage[ability] or 0) + usage
        end
    end
    
    report.abilityUsage = totalAbilityUsage
    
    return report
end

-- Генерация отчета вовлеченности
function StatisticsManager:GenerateEngagementReport(filters)
    local report = {
        playerRetention = {},
        sessionDuration = {},
        activityMetrics = {}
    }
    
    -- Анализ удержания игроков
    local activePlayers = 0
    local totalPlayers = 0
    
    for _, stats in pairs(self.playerStats) do
        totalPlayers = totalPlayers + 1
        if os.time() - stats.lastPlayed < 86400 then -- Активен за последние 24 часа
            activePlayers = activePlayers + 1
        end
    end
    
    report.playerRetention = {
        totalPlayers = totalPlayers,
        activePlayers = activePlayers,
        retentionRate = totalPlayers > 0 and (activePlayers / totalPlayers) * 100 or 0
    }
    
    return report
end

-- Генерация отчета экономики
function StatisticsManager:GenerateEconomyReport(filters)
    local report = {
        currencyFlow = {},
        itemTransactions = {},
        playerEconomy = {}
    }
    
    -- Поток валюты
    local totalCurrency = {gold = 0, gems = 0, experience = 0, honor = 0}
    for _, stats in pairs(self.playerStats) do
        for currency, amount in pairs(stats.currencyEarned) do
            totalCurrency[currency] = totalCurrency[currency] + amount
        end
    end
    
    report.currencyFlow = totalCurrency
    
    -- Транзакции предметов
    local totalPurchases = 0
    local totalSales = 0
    for _, stats in pairs(self.playerStats) do
        totalPurchases = totalPurchases + stats.itemsPurchased
        totalSales = totalSales + stats.itemsSold
    end
    
    report.itemTransactions = {
        purchases = totalPurchases,
        sales = totalSales,
        total = totalPurchases + totalSales
    }
    
    return report
end

-- Сохранение статистики
function StatisticsManager:SaveStatistics()
    local data = {
        playerStats = self.playerStats,
        globalStats = self.globalStats,
        gameStats = self.gameStats,
        analytics = self.analytics,
        reports = self.reports
    }
    
    -- Здесь можно добавить сохранение в DataStore или файл
    local success, result = pcall(function()
        return HttpService:JSONEncode(data)
    end)
    
    return success
end

-- Загрузка статистики
function StatisticsManager:LoadStatistics()
    -- Здесь можно добавить загрузку из DataStore или файла
    -- Временная заглушка
    return true
end

-- Очистка статистики игрока
function StatisticsManager:CleanupPlayer(player)
    if player and self.playerStats[player.UserId] then
        self.playerStats[player.UserId] = nil
    end
end

-- Очистка системы статистики
function StatisticsManager:Cleanup()
    self:SaveStatistics()
    
    self.playerStats = {}
    self.globalStats = {}
    self.gameStats = {}
    self.analytics = {}
    self.reports = {}
end

return StatisticsManager