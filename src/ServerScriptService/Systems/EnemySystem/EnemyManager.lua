-- EnemyManager.lua
-- Система управления врагами в Nexus Siege

local EnemyManager = {}
EnemyManager.__index = EnemyManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local Formulas = require(ReplicatedStorage.Modules.Shared.FormulasModule)
local LootManager = require(script.Parent.Parent.LootSystem.LootManager)

-- Состояние
EnemyManager.activeEnemies = {}
EnemyManager.enemyCount = 0
EnemyManager.maxEnemies = 100

function EnemyManager:Initialize()
    print("[EnemyManager] Initializing...")
    
    -- Создание контейнера для врагов
    local enemiesFolder = Instance.new("Folder")
    enemiesFolder.Name = "Enemies"
    enemiesFolder.Parent = workspace
    
    self.enemiesFolder = enemiesFolder
    
    print("[EnemyManager] Initialized successfully!")
end

-- Создание врага
function EnemyManager:CreateEnemy(enemyType, spawnPoint)
    if self.enemyCount >= self.maxEnemies then
        warn("[EnemyManager] Maximum enemies reached!")
        return nil
    end
    
    local enemyData = GameConstants.Enemies[enemyType]
    if not enemyData then
        warn("[EnemyManager] Unknown enemy type:", enemyType)
        return nil
    end
    
    -- Создание модели врага
    local enemy = Instance.new("Model")
    enemy.Name = enemyType .. "_" .. self.enemyCount
    enemy.Parent = self.enemiesFolder
    
    -- Создание основной части
    local primaryPart = Instance.new("Part")
    primaryPart.Name = "PrimaryPart"
    primaryPart.Size = Vector3.new(4, 6, 4)
    primaryPart.Position = spawnPoint
    primaryPart.Anchored = false
    primaryPart.CanCollide = true
    primaryPart.Material = Enum.Material.Plastic
    primaryPart.Color = self:GetEnemyColor(enemyType)
    primaryPart.Parent = enemy
    
    -- Создание Humanoid
    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = enemyData.health
    humanoid.Health = enemyData.health
    humanoid.WalkSpeed = enemyData.speed
    humanoid.Parent = enemy
    
    -- Установка PrimaryPart
    enemy.PrimaryPart = primaryPart
    
    -- Добавление атрибутов
    enemy:SetAttribute("EnemyType", enemyType)
    enemy:SetAttribute("Damage", enemyData.damage)
    enemy:SetAttribute("AttackSpeed", enemyData.attackSpeed or 1)
    enemy:SetAttribute("Reward", enemyData.reward)
    enemy:SetAttribute("IsEnemy", true)
    enemy:SetAttribute("LastAttack", 0)
    enemy:SetAttribute("Target", nil)
    enemy:SetAttribute("Stunned", false)
    enemy:SetAttribute("Taunted", false)
    
    -- Специальные атрибуты
    if enemyData.weakTo then
        enemy:SetAttribute("WeakTo", enemyData.weakTo)
    end
    
    if enemyData.ability then
        enemy:SetAttribute("Ability", enemyData.ability)
    end
    
    -- Подключение событий
    humanoid.Died:Connect(function()
        self:HandleEnemyDeath(enemy)
    end)
    
    -- Добавление в активные враги
    table.insert(self.activeEnemies, enemy)
    self.enemyCount = self.enemyCount + 1
    
    -- Запуск AI
    self:StartEnemyAI(enemy)
    
    print("[EnemyManager] Created enemy:", enemyType, "at", spawnPoint)
    return enemy
end

-- Получение цвета врага
function EnemyManager:GetEnemyColor(enemyType)
    local colors = {
        GHOUL = Color3.fromRGB(100, 200, 100),      -- Зеленый
        RUNNER = Color3.fromRGB(255, 255, 0),       -- Желтый
        BRUTE = Color3.fromRGB(200, 50, 50),        -- Красный
        GHOST = Color3.fromRGB(150, 150, 255),      -- Синий
        BOMBER = Color3.fromRGB(255, 100, 0),       -- Оранжевый
        HEALER = Color3.fromRGB(255, 100, 255)      -- Розовый
    }
    
    return colors[enemyType] or Color3.fromRGB(128, 128, 128)
end

-- Запуск AI врага
function EnemyManager:StartEnemyAI(enemy)
    task.spawn(function()
        while enemy and enemy.Parent and enemy:GetAttribute("IsEnemy") do
            if not enemy:GetAttribute("Stunned") then
                self:UpdateEnemyAI(enemy)
            end
            task.wait(0.1)
        end
    end)
end

-- Обновление AI врага
function EnemyManager:UpdateEnemyAI(enemy)
    local humanoid = enemy:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then
        return
    end
    
    local target = self:FindTarget(enemy)
    if target then
        -- Движение к цели
        self:MoveToTarget(enemy, target)
        
        -- Проверка атаки
        self:CheckAttack(enemy, target)
    else
        -- Поиск новой цели
        self:FindNewTarget(enemy)
    end
end

-- Поиск цели
function EnemyManager:FindTarget(enemy)
    -- Проверка провокации
    if enemy:GetAttribute("Taunted") then
        local tauntedTarget = enemy:GetAttribute("TauntedTarget")
        if tauntedTarget and tauntedTarget.Parent then
            return tauntedTarget
        else
            enemy:SetAttribute("Taunted", false)
        end
    end
    
    -- Поиск ближайшего игрока
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - enemy.PrimaryPart.Position).Magnitude
            if distance < closestDistance and distance <= 50 then
                closestPlayer = character
                closestDistance = distance
            end
        end
    end
    
    -- Если нет игроков поблизости, атакуем Нексус
    if not closestPlayer then
        local nexus = workspace:FindFirstChild("Nexus")
        if nexus and nexus:FindFirstChild("PrimaryPart") then
            return nexus
        end
    end
    
    return closestPlayer
end

-- Движение к цели
function EnemyManager:MoveToTarget(enemy, target)
    local humanoid = enemy:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    local targetPosition = target.PrimaryPart.Position
    local enemyPosition = enemy.PrimaryPart.Position
    local distance = (targetPosition - enemyPosition).Magnitude
    
    -- Если цель в пределах атаки, остановиться
    if distance <= 5 then
        humanoid:Move(Vector3.new(0, 0, 0))
        return
    end
    
    -- Движение к цели
    local direction = (targetPosition - enemyPosition).Unit
    humanoid:Move(direction)
    
    -- Поворот к цели
    local lookAt = CFrame.lookAt(enemyPosition, targetPosition)
    enemy.PrimaryPart.CFrame = CFrame.new(enemyPosition, Vector3.new(targetPosition.X, enemyPosition.Y, targetPosition.Z))
end

-- Проверка атаки
function EnemyManager:CheckAttack(enemy, target)
    local currentTime = tick()
    local lastAttack = enemy:GetAttribute("LastAttack") or 0
    local attackSpeed = enemy:GetAttribute("AttackSpeed") or 1
    
    if currentTime - lastAttack >= 1 / attackSpeed then
        local distance = (target.PrimaryPart.Position - enemy.PrimaryPart.Position).Magnitude
        
        if distance <= 5 then
            self:PerformAttack(enemy, target)
            enemy:SetAttribute("LastAttack", currentTime)
        end
    end
end

-- Выполнение атаки
function EnemyManager:PerformAttack(enemy, target)
    local damage = enemy:GetAttribute("Damage") or 10
    
    -- Проверка типа цели
    if target:GetAttribute("IsEnemy") then
        -- Враг атакует врага (не должно происходить)
        return
    end
    
    local targetHumanoid = target:FindFirstChild("Humanoid")
    if targetHumanoid then
        -- Нанесение урона
        targetHumanoid.Health = targetHumanoid.Health - damage
        
        -- Создание эффекта атаки
        self:CreateAttackEffect(enemy.PrimaryPart.Position, target.PrimaryPart.Position)
        
        -- Специальные способности врагов
        self:UseEnemyAbility(enemy, target)
        
        print("[EnemyManager]", enemy.Name, "attacks", target.Name, "for", damage, "damage")
    end
end

-- Использование способности врага
function EnemyManager:UseEnemyAbility(enemy, target)
    local ability = enemy:GetAttribute("Ability")
    
    if ability == "Explode" then
        -- Подрывник взрывается при смерти
        enemy:SetAttribute("WillExplode", true)
    elseif ability == "HealAura" then
        -- Целитель лечит других врагов
        self:HealNearbyEnemies(enemy)
    elseif ability == "Flying" then
        -- Призрак может летать
        self:MakeEnemyFly(enemy)
    end
end

-- Лечение ближайших врагов
function EnemyManager:HealNearbyEnemies(healer)
    local healAmount = 20
    local healRadius = 15
    
    for _, enemy in pairs(self.activeEnemies) do
        if enemy ~= healer and enemy:FindFirstChild("Humanoid") then
            local distance = (enemy.PrimaryPart.Position - healer.PrimaryPart.Position).Magnitude
            
            if distance <= healRadius then
                local humanoid = enemy:FindFirstChild("Humanoid")
                humanoid.Health = math.min(humanoid.MaxHealth, humanoid.Health + healAmount)
                
                -- Эффект лечения
                self:CreateHealEffect(enemy.PrimaryPart.Position)
            end
        end
    end
end

-- Создание эффекта атаки
function EnemyManager:CreateAttackEffect(startPos, endPos)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(1, 1, 1)
    effect.Position = startPos
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 0, 0)
    effect.Transparency = 0.5
    effect.Parent = workspace
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(0.3), {
        Position = endPos,
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 0.3)
end

-- Создание эффекта лечения
function EnemyManager:CreateHealEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(2, 2, 2)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(0, 255, 0)
    effect.Transparency = 0.3
    effect.Parent = workspace
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(1), {
        Size = Vector3.new(8, 8, 8),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 1)
end

-- Обработка смерти врага
function EnemyManager:HandleEnemyDeath(enemy)
    -- Проверка взрыва
    if enemy:GetAttribute("WillExplode") then
        self:CreateExplosion(enemy.PrimaryPart.Position)
    end
    
    -- Дроп лута
    local enemyType = enemy:GetAttribute("EnemyType")
    local position = enemy.PrimaryPart.Position
    
    -- Определение типа врага для лута
    local lootType = "common_enemy"
    if enemyType == "Boss" or enemyType == "Dragon" then
        lootType = "boss_enemy"
    elseif enemyType == "Elite" or enemyType == "Troll" then
        lootType = "elite_enemy"
    end
    
    -- Создание лута
    LootManager:DropLootFromEnemy(enemy, lootType, position)
    
    -- Удаление из активных врагов
    for i, activeEnemy in ipairs(self.activeEnemies) do
        if activeEnemy == enemy then
            table.remove(self.activeEnemies, i)
            break
        end
    end
    
    self.enemyCount = self.enemyCount - 1
    
    -- Удаление через время
    game:GetService("Debris"):AddItem(enemy, 2)
    
    print("[EnemyManager] Enemy died:", enemy.Name)
end

-- Создание взрыва
function EnemyManager:CreateExplosion(position)
    local explosionRadius = 10
    local explosionDamage = 50
    
    -- Поиск целей в радиусе
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            local distance = (character.HumanoidRootPart.Position - position).Magnitude
            
            if distance <= explosionRadius then
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    -- Урон уменьшается с расстоянием
                    local damage = explosionDamage * (1 - (distance / explosionRadius))
                    humanoid.Health = humanoid.Health - damage
                end
            end
        end
    end
    
    -- Визуальный эффект взрыва
    local explosion = Instance.new("Part")
    explosion.Shape = Enum.PartType.Ball
    explosion.Size = Vector3.new(1, 1, 1)
    explosion.Position = position
    explosion.Anchored = true
    explosion.CanCollide = false
    explosion.Material = Enum.Material.ForceField
    explosion.Color = Color3.fromRGB(255, 100, 0)
    explosion.Transparency = 0.3
    explosion.Parent = workspace
    
    -- Анимация взрыва
    local tween = game:GetService("TweenService"):Create(explosion, TweenInfo.new(0.5), {
        Size = Vector3.new(explosionRadius * 2, explosionRadius * 2, explosionRadius * 2),
        Transparency = 1
    })
    tween:Play()
    
    game:GetService("Debris"):AddItem(explosion, 0.5)
end

-- Получение количества активных врагов
function EnemyManager:GetEnemyCount()
    return self.enemyCount
end

-- Очистка всех врагов
function EnemyManager:ClearAllEnemies()
    for _, enemy in pairs(self.activeEnemies) do
        if enemy and enemy.Parent then
            enemy:Destroy()
        end
    end
    
    self.activeEnemies = {}
    self.enemyCount = 0
    
    print("[EnemyManager] All enemies cleared")
end

-- Получение врагов в радиусе
function EnemyManager:GetEnemiesInRadius(position, radius)
    local enemiesInRadius = {}
    
    for _, enemy in pairs(self.activeEnemies) do
        if enemy and enemy.Parent and enemy:FindFirstChild("PrimaryPart") then
            local distance = (enemy.PrimaryPart.Position - position).Magnitude
            if distance <= radius then
                table.insert(enemiesInRadius, enemy)
            end
        end
    end
    
    return enemiesInRadius
end

return setmetatable({}, EnemyManager)