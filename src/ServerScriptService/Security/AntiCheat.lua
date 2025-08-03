-- AntiCheat.lua
-- Система анти-чита для Nexus Siege

local AntiCheat = {}
AntiCheat.__index = AntiCheat

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)

-- Состояние
AntiCheat.playerData = {}
AntiCheat.actionHistory = {}
AntiCheat.suspiciousPlayers = {}

function AntiCheat:Initialize()
    print("[AntiCheat] Initializing...")
    
    -- Подключение событий игроков
    local Players = game:GetService("Players")
    
    Players.PlayerAdded:Connect(function(player)
        self:OnPlayerAdded(player)
    end)
    
    Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerRemoving(player)
    end)
    
    print("[AntiCheat] Initialized successfully!")
end

-- Обработка присоединения игрока
function AntiCheat:OnPlayerAdded(player)
    self.playerData[player] = {
        lastActionTime = 0,
        actionCount = 0,
        suspiciousActions = 0,
        lastPosition = Vector3.new(0, 0, 0),
        lastSpeed = 0,
        violations = 0
    }
end

-- Обработка выхода игрока
function AntiCheat:OnPlayerRemoving(player)
    self.playerData[player] = nil
    self.suspiciousPlayers[player] = nil
end

-- Валидация действия
function AntiCheat:ValidateAction(player, action, data)
    if not player or not self.playerData[player] then
        return false
    end
    
    local playerData = self.playerData[player]
    local currentTime = tick()
    
    -- Проверка частоты действий
    if not self:CheckActionRate(player, currentTime) then
        self:LogViolation(player, "Action rate violation", action, data)
        return false
    end
    
    -- Проверка в зависимости от типа действия
    local isValid = true
    
    if action == "UseAbility" then
        isValid = self:ValidateAbilityUse(player, data)
    elseif action == "BuildStructure" then
        isValid = self:ValidateBuilding(player, data)
    elseif action == "GatherResource" then
        isValid = self:ValidateResourceGathering(player, data)
    elseif action == "Move" then
        isValid = self:ValidateMovement(player, data)
    end
    
    -- Обновление данных игрока
    playerData.lastActionTime = currentTime
    playerData.actionCount = playerData.actionCount + 1
    
    if not isValid then
        playerData.suspiciousActions = playerData.suspiciousActions + 1
        self:LogViolation(player, "Action validation failed", action, data)
    end
    
    return isValid
end

-- Проверка частоты действий
function AntiCheat:CheckActionRate(player, currentTime)
    local playerData = self.playerData[player]
    local timeSinceLastAction = currentTime - playerData.lastActionTime
    
    -- Минимальный интервал между действиями
    if timeSinceLastAction < 0.1 then
        return false
    end
    
    -- Проверка количества действий в секунду
    if playerData.actionCount > GameConstants.AntiCheat.ACTIONS_PER_SECOND then
        return false
    end
    
    return true
end

-- Валидация использования способности
function AntiCheat:ValidateAbilityUse(player, data)
    local character = player.Character
    if not character then
        return false
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        return false
    end
    
    -- Проверка скорости движения
    if humanoid.MoveSpeed > GameConstants.AntiCheat.MAX_SPEED then
        return false
    end
    
    -- Проверка высоты прыжка
    if humanoid.JumpPower > GameConstants.AntiCheat.MAX_JUMP_POWER then
        return false
    end
    
    -- Проверка позиции игрока
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local distance = (rootPart.Position - self.playerData[player].lastPosition).Magnitude
        if distance > GameConstants.AntiCheat.TELEPORT_THRESHOLD then
            return false
        end
    end
    
    return true
end

-- Валидация строительства
function AntiCheat:ValidateBuilding(player, data)
    if not data.structureType or not data.position then
        return false
    end
    
    local character = player.Character
    if not character then
        return false
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return false
    end
    
    -- Проверка расстояния до места строительства
    local distance = (rootPart.Position - data.position).Magnitude
    if distance > GameConstants.AntiCheat.MAX_ATTACK_RANGE then
        return false
    end
    
    -- Проверка валидности позиции
    if not self:IsValidBuildPosition(data.position) then
        return false
    end
    
    return true
end

-- Валидация сбора ресурсов
function AntiCheat:ValidateResourceGathering(player, data)
    if not data.resourceType or not data.amount then
        return false
    end
    
    -- Проверка количества ресурсов за раз
    if data.amount > GameConstants.AntiCheat.MAX_RESOURCES_PER_GATHER then
        return false
    end
    
    -- Проверка типа ресурса
    local validResources = {"Wood", "Stone", "Crystal"}
    local isValidResource = false
    
    for _, resourceType in ipairs(validResources) do
        if data.resourceType == resourceType then
            isValidResource = true
            break
        end
    end
    
    if not isValidResource then
        return false
    end
    
    return true
end

-- Валидация движения
function AntiCheat:ValidateMovement(player, data)
    local character = player.Character
    if not character then
        return false
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        return false
    end
    
    local currentPosition = rootPart.Position
    local lastPosition = self.playerData[player].lastPosition
    local distance = (currentPosition - lastPosition).Magnitude
    
    -- Проверка скорости движения
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        local speed = distance / (tick() - self.playerData[player].lastActionTime)
        if speed > GameConstants.AntiCheat.MAX_SPEED then
            return false
        end
    end
    
    -- Обновление последней позиции
    self.playerData[player].lastPosition = currentPosition
    
    return true
end

-- Проверка валидности позиции строительства
function AntiCheat:IsValidBuildPosition(position)
    -- Проверка, что позиция не под землей
    if position.Y < -10 then
        return false
    end
    
    -- Проверка, что позиция не слишком высоко
    if position.Y > 100 then
        return false
    end
    
    -- Проверка, что позиция в пределах карты
    local distanceFromCenter = Vector3.new(position.X, 0, position.Z).Magnitude
    if distanceFromCenter > 1000 then
        return false
    end
    
    return true
end

-- Логирование нарушений
function AntiCheat:LogViolation(player, reason, action, data)
    local playerData = self.playerData[player]
    playerData.violations = playerData.violations + 1
    
    local violation = {
        player = player.Name,
        reason = reason,
        action = action,
        data = data,
        timestamp = tick(),
        violations = playerData.violations
    }
    
    table.insert(self.actionHistory, violation)
    
    -- Ограничение размера истории
    if #self.actionHistory > 1000 then
        table.remove(self.actionHistory, 1)
    end
    
    -- Проверка на подозрительную активность
    if playerData.violations >= 5 then
        self.suspiciousPlayers[player] = true
        warn("[AntiCheat] Player", player.Name, "marked as suspicious. Violations:", playerData.violations)
    end
    
    print("[AntiCheat] Violation:", player.Name, reason, action)
end

-- Получение истории нарушений
function AntiCheat:GetViolationHistory()
    return self.actionHistory
end

-- Получение подозрительных игроков
function AntiCheat:GetSuspiciousPlayers()
    return self.suspiciousPlayers
end

-- Сброс нарушений игрока
function AntiCheat:ResetPlayerViolations(player)
    if self.playerData[player] then
        self.playerData[player].violations = 0
        self.playerData[player].suspiciousActions = 0
    end
    
    self.suspiciousPlayers[player] = nil
end

-- Проверка, является ли игрок подозрительным
function AntiCheat:IsPlayerSuspicious(player)
    return self.suspiciousPlayers[player] ~= nil
end

-- Получение статистики анти-чита
function AntiCheat:GetStatistics()
    local stats = {
        totalViolations = 0,
        suspiciousPlayers = 0,
        totalActions = 0
    }
    
    for _, playerData in pairs(self.playerData) do
        stats.totalViolations = stats.totalViolations + playerData.violations
        stats.totalActions = stats.totalActions + playerData.actionCount
    end
    
    stats.suspiciousPlayers = 0
    for _ in pairs(self.suspiciousPlayers) do
        stats.suspiciousPlayers = stats.suspiciousPlayers + 1
    end
    
    return stats
end

return setmetatable({}, AntiCheat)