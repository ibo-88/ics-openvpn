# План Завершения Проекта NexusSiege

## 📊 Текущее Состояние Проекта

### ✅ Реализованные Системы
1. **Базовая архитектура** - модульная структура
2. **Система классов** - Warrior, Engineer с базовыми способностями
3. **UI система** - основной HUD, меню выбора класса
4. **Remote Events** - базовая структура коммуникации
5. **GameConstants** - константы игры
6. **FormulasModule** - формулы расчета урона
7. **GameController** - основной контроллер игры

### ⚠️ Частично Реализованные Системы
1. **Системы менеджеров** - только заглушки
2. **ProfileService** - базовая структура
3. **AntiCheat** - базовая структура

### ❌ Отсутствующие Системы
1. **Система врагов** - нет реализации
2. **Система волн** - нет спавна врагов
3. **Система ресурсов** - нет сбора
4. **Система строительства** - нет построек
5. **Система боя** - нет расчета урона
6. **Система сохранения** - нет данных игроков

## 🎯 Приоритетные Задачи

### 1. КРИТИЧЕСКИЕ (Необходимы для запуска)

#### A. Система Врагов (EnemySystem)
**Файлы для создания:**
- `src/ServerScriptService/Systems/EnemySystem/EnemyManager.lua`
- `src/ServerScriptService/Systems/EnemySystem/EnemyAI.lua`
- `src/ServerScriptService/Systems/EnemySystem/EnemySpawner.lua`

**Функциональность:**
```lua
-- Создание врагов
function EnemyManager:CreateEnemy(enemyType, spawnPoint)
    local enemy = Instance.new("Model")
    -- Настройка характеристик из GameConstants.Enemies
    -- Создание Humanoid и PrimaryPart
    -- Установка AI
end

-- AI врагов
function EnemyAI:UpdateAI(enemy)
    -- Поиск цели (Нексус или игроки)
    -- Движение по пути
    -- Атака при приближении
end

-- Спавн волн
function EnemySpawner:SpawnWave(waveNumber)
    -- Определение количества и типов врагов
    -- Спавн с задержками
    -- Отслеживание волны
end
```

#### B. Система Волн (WaveSystem) - ДОРАБОТКА
**Файл для доработки:**
- `src/ServerScriptService/Systems/WaveSystem/WaveManager.lua`

**Добавить:**
```lua
function WaveManager:StartWave(waveNumber)
    local waveData = self:GetWaveData(waveNumber)
    local spawnPoints = GameConstants.EnemySpawns
    
    for _, spawnPoint in pairs(spawnPoints) do
        for _, enemyData in pairs(waveData.enemies) do
            task.spawn(function()
                task.wait(enemyData.delay)
                EnemyManager:CreateEnemy(enemyData.type, spawnPoint)
            end)
        end
    end
end

function WaveManager:GetWaveData(waveNumber)
    -- Возвращает данные волны на основе номера
    -- Увеличивает сложность с каждой волной
end
```

#### C. Система Ресурсов (ResourceSystem) - ДОРАБОТКА
**Файл для доработки:**
- `src/ServerScriptService/Systems/ResourceSystem/ResourceManager.lua`

**Добавить:**
```lua
function ResourceManager:GatherResource(player, resourceType, amount)
    local playerData = ProfileService:GetPlayerData(player)
    local resourceData = GameConstants.Resources[resourceType]
    
    if playerData.resources[resourceType] + amount <= resourceData.maxStack then
        playerData.resources[resourceType] = playerData.resources[resourceType] + amount
        ProfileService:SavePlayerData(player, playerData)
        return true
    end
    return false
end

function ResourceManager:CreateResourceNode(resourceType, position)
    local node = Instance.new("Part")
    node.Name = resourceType .. "Node"
    node.Position = position
    node.Anchored = true
    node.Material = Enum.Material.Rock
    node.Parent = workspace
    
    -- Добавить атрибуты для сбора
    node:SetAttribute("ResourceType", resourceType)
    node:SetAttribute("RemainingAmount", 100)
end
```

### 2. ВАЖНЫЕ (Необходимы для полноценной игры)

#### A. Система Строительства (BuildingSystem) - ДОРАБОТКА
**Файл для доработки:**
- `src/ServerScriptService/Systems/BuildingSystem/BuildManager.lua`

**Добавить:**
```lua
function BuildManager:BuildStructure(player, structureType, position)
    local playerData = ProfileService:GetPlayerData(player)
    local structureData = GameConstants.Walls[structureType] or GameConstants.Towers[structureType]
    
    -- Проверка ресурсов
    if self:HasResources(playerData, structureData.cost) then
        -- Создание структуры
        local structure = self:CreateStructure(structureType, position)
        
        -- Списание ресурсов
        self:SpendResources(playerData, structureData.cost)
        ProfileService:SavePlayerData(player, playerData)
        
        return structure
    end
    return nil
end

function BuildManager:CreateStructure(structureType, position)
    local structure = Instance.new("Model")
    structure.Name = structureType
    
    -- Создание частей структуры
    local base = Instance.new("Part")
    base.Size = GameConstants.Walls[structureType].size
    base.Position = position
    base.Anchored = true
    base.Parent = structure
    
    structure.PrimaryPart = base
    structure.Parent = workspace
    
    return structure
end
```

#### B. Система Боя (CombatSystem) - ДОРАБОТКА
**Файл для доработки:**
- `src/ServerScriptService/Systems/CombatSystem/CombatManager.lua`

**Добавить:**
```lua
function CombatManager:DealDamage(attacker, target, amount, damageType)
    local Formulas = require(ReplicatedStorage.Modules.Shared.FormulasModule)
    
    local finalDamage, isCrit = Formulas.CalculateDamage(attacker, target, amount, damageType)
    
    local humanoid = target:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = humanoid.Health - finalDamage
        
        -- Показать урон
        self:ShowDamageNumber(target.PrimaryPart.Position, finalDamage, isCrit)
        
        -- Проверить смерть
        if humanoid.Health <= 0 then
            self:HandleDeath(target, attacker)
        end
    end
end

function CombatManager:HandleDeath(target, killer)
    if target:GetAttribute("IsEnemy") then
        -- Дать награду игроку
        local reward = target:GetAttribute("Reward") or 10
        ProfileService:AddResources(killer, {Gold = reward})
        
        -- Удалить врага
        target:Destroy()
    end
end
```

#### C. Система Сохранения (ProfileService) - ДОРАБОТКА
**Файл для доработки:**
- `src/ServerScriptService/Data/ProfileService.lua`

**Добавить:**
```lua
local DataStoreService = game:GetService("DataStoreService")
local playerDataStore = DataStoreService:GetDataStore("NexusSiege_PlayerData")

function ProfileService:LoadProfile(player)
    local success, data = pcall(function()
        return playerDataStore:GetAsync(player.UserId)
    end)
    
    if success and data then
        return data
    else
        return self:GetDefaultProfile()
    end
end

function ProfileService:SaveProfile(player, data)
    local success, result = pcall(function()
        playerDataStore:SetAsync(player.UserId, data)
    end)
    
    if not success then
        warn("Failed to save profile for", player.Name, ":", result)
    end
end

function ProfileService:GetDefaultProfile()
    return {
        level = 1,
        experience = 0,
        resources = {
            Wood = 0,
            Stone = 0,
            Crystal = 0,
            Gold = 100
        },
        selectedClass = "Warrior",
        unlockedClasses = {"Warrior"},
        statistics = {
            wavesCompleted = 0,
            enemiesKilled = 0,
            structuresBuilt = 0
        }
    }
end
```

### 3. ДОПОЛНИТЕЛЬНЫЕ (Улучшения)

#### A. Система Анти-Чита (AntiCheat) - ДОРАБОТКА
**Файл для доработки:**
- `src/ServerScriptService/Security/AntiCheat.lua`

**Добавить:**
```lua
function AntiCheat:ValidateAction(player, action, data)
    local playerData = self.playerData[player] or {}
    
    if action == "UseAbility" then
        return self:ValidateAbilityUse(player, data)
    elseif action == "BuildStructure" then
        return self:ValidateBuilding(player, data)
    elseif action == "GatherResource" then
        return self:ValidateResourceGathering(player, data)
    end
    
    return true
end

function AntiCheat:ValidateAbilityUse(player, data)
    local character = player.Character
    if not character then return false end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return false end
    
    -- Проверка скорости
    if humanoid.MoveSpeed > GameConstants.AntiCheat.MAX_SPEED then
        return false
    end
    
    -- Проверка кулдауна
    local lastUse = player:GetAttribute("LastAbilityUse") or 0
    if tick() - lastUse < 0.1 then
        return false
    end
    
    return true
end
```

#### B. Система Уведомлений
**Файл для создания:**
- `src/ReplicatedStorage/Modules/Shared/NotificationSystem.lua`

```lua
local NotificationSystem = {}

function NotificationSystem:ShowNotification(player, message, type, duration)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        remote:FireClient(player, message, type, duration)
    end
end

function NotificationSystem:ShowWaveStart(waveNumber)
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        self:ShowNotification(player, "Волна " .. waveNumber .. " началась!", "info", 3)
    end
end

return NotificationSystem
```

#### C. Система Достижений
**Файл для создания:**
- `src/ServerScriptService/Systems/AchievementSystem/AchievementManager.lua`

```lua
local AchievementManager = {}

local Achievements = {
    FIRST_WAVE = {
        name = "Первая кровь",
        description = "Завершите первую волну",
        reward = {Gold = 50}
    },
    WAVE_MASTER = {
        name = "Мастер волн",
        description = "Завершите 10 волн",
        reward = {Gold = 500, Crystal = 10}
    }
}

function AchievementManager:CheckAchievements(player, event, data)
    local playerData = ProfileService:GetPlayerData(player)
    
    if event == "WaveCompleted" and data.waveNumber == 1 then
        self:GrantAchievement(player, "FIRST_WAVE")
    elseif event == "WaveCompleted" and data.waveNumber == 10 then
        self:GrantAchievement(player, "WAVE_MASTER")
    end
end

return AchievementManager
```

## 📋 План Реализации

### Неделя 1: Критические системы
- [ ] Система врагов (EnemySystem)
- [ ] Система волн (WaveSystem)
- [ ] Система ресурсов (ResourceSystem)

### Неделя 2: Важные системы
- [ ] Система строительства (BuildingSystem)
- [ ] Система боя (CombatSystem)
- [ ] Система сохранения (ProfileService)

### Неделя 3: Дополнительные системы
- [ ] Система анти-чита (AntiCheat)
- [ ] Система уведомлений
- [ ] Система достижений

### Неделя 4: Тестирование и полировка
- [ ] Интеграционное тестирование
- [ ] Балансировка игры
- [ ] Исправление багов
- [ ] Оптимизация производительности

## 🎯 Критерии Готовности

### Минимально жизнеспособный продукт (MVP):
- [ ] Игроки могут присоединяться к игре
- [ ] Система волн работает
- [ ] Враги спавнятся и атакуют
- [ ] Игроки могут собирать ресурсы
- [ ] Игроки могут строить защиту
- [ ] Игроки могут использовать способности
- [ ] Данные игроков сохраняются

### Полноценная игра:
- [ ] Все системы интегрированы
- [ ] Баланс игры настроен
- [ ] Анти-чит работает
- [ ] Система достижений
- [ ] Уведомления и обратная связь
- [ ] Оптимизация производительности

## 🚀 Следующие Шаги

1. **Начать с EnemySystem** - это критически важно для игры
2. **Реализовать WaveManager** - для управления волнами
3. **Доработать ResourceManager** - для сбора ресурсов
4. **Интегрировать все системы** в GameController
5. **Протестировать** базовую функциональность
6. **Добавить дополнительные функции**

Проект имеет хорошую архитектурную основу и готов к завершению! 🎮