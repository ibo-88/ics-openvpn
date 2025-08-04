-- WaveManager.lua
-- Управление волнами врагов

local WaveManager = {}
WaveManager.__index = WaveManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local EnemyManager = require(script.Parent.Parent.EnemySystem.EnemyManager)
local LootManager = require(script.Parent.Parent.LootSystem.LootManager)

-- Состояние
WaveManager.currentWave = 0
WaveManager.isWaveActive = false
WaveManager.waveStartTime = 0
WaveManager.enemiesSpawned = 0
WaveManager.enemiesKilled = 0
WaveManager.totalEnemiesInWave = 0

function WaveManager:Initialize()
    print("[WaveManager] Initializing...")
    
    -- Инициализация EnemyManager
    EnemyManager:Initialize()
    
    print("[WaveManager] Initialized successfully!")
end

-- Запуск волны
function WaveManager:StartWave(waveNumber)
    if self.isWaveActive then
        warn("[WaveManager] Wave already active!")
        return false
    end
    
    self.currentWave = waveNumber
    self.isWaveActive = true
    self.waveStartTime = tick()
    self.enemiesSpawned = 0
    self.enemiesKilled = 0
    
    local waveData = self:GetWaveData(waveNumber)
    self.totalEnemiesInWave = waveData.totalEnemies
    
    print("[WaveManager] Starting wave", waveNumber, "with", self.totalEnemiesInWave, "enemies")
    
    -- Спавн врагов
    self:SpawnWaveEnemies(waveData)
    
    -- Запуск мониторинга волны
    self:MonitorWave()
    
    return true
end

-- Получение данных волны
function WaveManager:GetWaveData(waveNumber)
    local baseEnemies = {
        {type = "GHOUL", count = 5, delay = 0},
        {type = "RUNNER", count = 3, delay = 2},
        {type = "BRUTE", count = 1, delay = 5}
    }
    
    -- Увеличение сложности с каждой волной
    local multiplier = 1 + (waveNumber - 1) * 0.3
    local totalEnemies = 0
    
    for _, enemyData in ipairs(baseEnemies) do
        enemyData.count = math.floor(enemyData.count * multiplier)
        totalEnemies = totalEnemies + enemyData.count
    end
    
    -- Добавление специальных врагов на высоких волнах
    if waveNumber >= 5 then
        table.insert(baseEnemies, {type = "GHOST", count = math.floor(2 * multiplier), delay = 8})
        totalEnemies = totalEnemies + math.floor(2 * multiplier)
    end
    
    if waveNumber >= 8 then
        table.insert(baseEnemies, {type = "BOMBER", count = math.floor(1 * multiplier), delay = 10})
        totalEnemies = totalEnemies + math.floor(1 * multiplier)
    end
    
    if waveNumber >= 10 then
        table.insert(baseEnemies, {type = "HEALER", count = math.floor(1 * multiplier), delay = 12})
        totalEnemies = totalEnemies + math.floor(1 * multiplier)
    end
    
    return {
        enemies = baseEnemies,
        totalEnemies = totalEnemies,
        waveNumber = waveNumber
    }
end

-- Спавн врагов волны
function WaveManager:SpawnWaveEnemies(waveData)
    local spawnPoints = GameConstants.EnemySpawns
    local spawnPointNames = {"NORTH", "EAST", "SOUTH", "WEST"}
    
    for _, enemyData in ipairs(waveData.enemies) do
        for i = 1, enemyData.count do
            task.spawn(function()
                -- Задержка перед спавном
                task.wait(enemyData.delay + (i - 1) * 0.5)
                
                -- Выбор случайной точки спавна
                local spawnPointName = spawnPointNames[math.random(1, #spawnPointNames)]
                local spawnPoint = spawnPoints[spawnPointName].position
                
                -- Добавление случайности к позиции
                local randomOffset = Vector3.new(
                    math.random(-50, 50),
                    0,
                    math.random(-50, 50)
                )
                local finalSpawnPoint = spawnPoint + randomOffset
                
                -- Создание врага
                local enemy = EnemyManager:CreateEnemy(enemyData.type, finalSpawnPoint)
                if enemy then
                    self.enemiesSpawned = self.enemiesSpawned + 1
                end
            end)
        end
    end
end

-- Мониторинг волны
function WaveManager:MonitorWave()
    task.spawn(function()
        while self.isWaveActive do
            local currentEnemies = EnemyManager:GetEnemyCount()
            
            -- Проверка завершения волны
            if currentEnemies == 0 and self.enemiesSpawned >= self.totalEnemiesInWave then
                self:EndWave(self.currentWave)
                break
            end
            
            -- Проверка таймаута волны (5 минут)
            if tick() - self.waveStartTime > 300 then
                print("[WaveManager] Wave timeout reached!")
                self:EndWave(self.currentWave)
                break
            end
            
            task.wait(1)
        end
    end)
end

-- Завершение волны
function WaveManager:EndWave(waveNumber)
    if not self.isWaveActive then
        return
    end
    
    self.isWaveActive = false
    
    print("[WaveManager] Ending wave", waveNumber)
    print("[WaveManager] Enemies spawned:", self.enemiesSpawned)
    print("[WaveManager] Enemies killed:", self.enemiesKilled)
    
    -- Выдача наград за волну
    local players = game:GetService("Players"):GetPlayers()
    LootManager:GiveWaveReward(waveNumber, players)
    
    -- Очистка оставшихся врагов
    EnemyManager:ClearAllEnemies()
    
    -- Уведомление о завершении волны
    self:NotifyWaveEnd(waveNumber)
end

-- Уведомление о завершении волны
function WaveManager:NotifyWaveEnd(waveNumber)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("WaveEnded")
    
    if remote then
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            remote:FireClient(player, waveNumber, self.enemiesKilled)
        end
    end
end

-- Получение информации о текущей волне
function WaveManager:GetWaveInfo()
    return {
        currentWave = self.currentWave,
        isActive = self.isWaveActive,
        enemiesSpawned = self.enemiesSpawned,
        enemiesKilled = self.enemiesKilled,
        totalEnemies = self.totalEnemiesInWave,
        remainingEnemies = EnemyManager:GetEnemyCount()
    }
end

-- Принудительное завершение волны
function WaveManager:ForceEndWave()
    if self.isWaveActive then
        self:EndWave(self.currentWave)
    end
end

-- Получение прогресса волны
function WaveManager:GetWaveProgress()
    if not self.isWaveActive then
        return 0
    end
    
    local totalProgress = self.enemiesSpawned + EnemyManager:GetEnemyCount()
    return math.min(100, (totalProgress / self.totalEnemiesInWave) * 100)
end

return setmetatable({}, WaveManager)