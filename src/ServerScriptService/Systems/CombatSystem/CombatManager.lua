-- CombatManager.lua
-- Управление боевой системой

local CombatManager = {}
CombatManager.__index = CombatManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Formulas = require(ReplicatedStorage.Modules.Shared.FormulasModule)
local ProfileService = require(script.Parent.Parent.Data.ProfileService)

-- Состояние
CombatManager.damageNumbers = {}
CombatManager.combatLog = {}

function CombatManager:Initialize()
    print("[CombatManager] Initializing...")
    
    -- Создание контейнера для эффектов
    local effectsFolder = Instance.new("Folder")
    effectsFolder.Name = "CombatEffects"
    effectsFolder.Parent = workspace
    
    self.effectsFolder = effectsFolder
    
    print("[CombatManager] Initialized successfully!")
end

-- Нанесение урона
function CombatManager:DealDamage(attacker, target, amount, damageType)
    if not attacker or not target then
        warn("[CombatManager] Invalid attacker or target")
        return false
    end
    
    -- Получение данных атакующего
    local attackerData = self:GetAttackerData(attacker)
    local targetData = self:GetTargetData(target)
    
    -- Расчет финального урона
    local finalDamage, isCrit = Formulas.CalculateDamage(attackerData, targetData, amount, damageType or "Physical")
    
    -- Применение урона к цели
    local success = self:ApplyDamageToTarget(target, finalDamage)
    
    if success then
        -- Показать урон
        self:ShowDamageNumber(target.PrimaryPart.Position, finalDamage, isCrit, damageType)
        
        -- Создать эффект атаки
        self:CreateAttackEffect(attacker.PrimaryPart.Position, target.PrimaryPart.Position, damageType)
        
        -- Логирование
        self:LogCombatAction(attacker, target, finalDamage, isCrit, damageType)
        
        -- Проверка смерти
        if self:IsTargetDead(target) then
            self:HandleDeath(target, attacker)
        end
        
        print("[CombatManager]", attacker.Name, "deals", finalDamage, "damage to", target.Name, isCrit and "(CRIT!)" or "")
        return true
    end
    
    return false
end

-- Получение данных атакующего
function CombatManager:GetAttackerData(attacker)
    local data = {
        stats = {
            attackPower = 1,
            critChance = 0.05,
            critMultiplier = 2
        }
    }
    
    -- Если атакующий - игрок
    local player = game:GetService("Players"):GetPlayerFromCharacter(attacker)
    if player then
        local playerData = ProfileService:GetPlayerData(player)
        if playerData and playerData.selectedClass then
            local classStats = self:GetClassStats(playerData.selectedClass)
            data.stats.attackPower = classStats.attackPower or 1
            data.stats.critChance = classStats.critChance or 0.05
            data.stats.critMultiplier = classStats.critMultiplier or 2
        end
    end
    
    return data
end

-- Получение данных цели
function CombatManager:GetTargetData(target)
    local data = {
        stats = {
            armor = 0,
            magicResist = 0
        },
        vulnerabilities = {}
    }
    
    -- Если цель - враг
    if target:GetAttribute("IsEnemy") then
        local weakTo = target:GetAttribute("WeakTo")
        if weakTo then
            data.vulnerabilities[weakTo] = 1.5 -- +50% урон
        end
    end
    
    -- Если цель - игрок
    local player = game:GetService("Players"):GetPlayerFromCharacter(target)
    if player then
        local playerData = ProfileService:GetPlayerData(player)
        if playerData and playerData.selectedClass then
            local classStats = self:GetClassStats(playerData.selectedClass)
            data.stats.armor = classStats.armor or 0
            data.stats.magicResist = classStats.magicResist or 0
        end
    end
    
    return data
end

-- Получение характеристик класса
function CombatManager:GetClassStats(className)
    local classStats = {
        Warrior = {
            attackPower = 1.2,
            critChance = 0.1,
            critMultiplier = 2.5,
            armor = 20,
            magicResist = 10
        },
        Engineer = {
            attackPower = 1.0,
            critChance = 0.05,
            critMultiplier = 2.0,
            armor = 10,
            magicResist = 15
        },
        Miner = {
            attackPower = 1.1,
            critChance = 0.08,
            critMultiplier = 2.2,
            armor = 15,
            magicResist = 5
        }
    }
    
    return classStats[className] or classStats.Warrior
end

-- Применение урона к цели
function CombatManager:ApplyDamageToTarget(target, damage)
    local humanoid = target:FindFirstChild("Humanoid")
    if not humanoid then
        return false
    end
    
    -- Применение урона
    humanoid.Health = math.max(0, humanoid.Health - damage)
    
    -- Создание эффекта получения урона
    self:CreateDamageEffect(target)
    
    return true
end

-- Проверка смерти цели
function CombatManager:IsTargetDead(target)
    local humanoid = target:FindFirstChild("Humanoid")
    return humanoid and humanoid.Health <= 0
end

-- Обработка смерти
function CombatManager:HandleDeath(target, killer)
    if target:GetAttribute("IsEnemy") then
        -- Смерть врага
        self:HandleEnemyDeath(target, killer)
    else
        -- Смерть игрока
        self:HandlePlayerDeath(target, killer)
    end
end

-- Обработка смерти врага
function CombatManager:HandleEnemyDeath(enemy, killer)
    local reward = enemy:GetAttribute("Reward") or 10
    local experience = enemy:GetAttribute("Experience") or 5
    
    -- Награда убийце
    if killer then
        local player = game:GetService("Players"):GetPlayerFromCharacter(killer)
        if player then
            self:GiveRewardToPlayer(player, reward, experience)
        end
    end
    
    -- Создание эффекта смерти
    self:CreateDeathEffect(enemy.PrimaryPart.Position)
    
    print("[CombatManager] Enemy", enemy.Name, "died. Reward:", reward)
end

-- Обработка смерти игрока
function CombatManager:HandlePlayerDeath(player, killer)
    local playerInstance = game:GetService("Players"):GetPlayerFromCharacter(player)
    if not playerInstance then return end
    
    -- Создание эффекта смерти игрока
    self:CreatePlayerDeathEffect(player.PrimaryPart.Position)
    
    -- Уведомление игрока
    self:NotifyPlayer(playerInstance, "Вы погибли!", "error", 5)
    
    print("[CombatManager] Player", playerInstance.Name, "died")
end

-- Выдача награды игроку
function CombatManager:GiveRewardToPlayer(player, gold, experience)
    local playerData = ProfileService:GetPlayerData(player)
    
    -- Добавление золота
    if not playerData.resources then
        playerData.resources = {}
    end
    if not playerData.resources.Gold then
        playerData.resources.Gold = 0
    end
    playerData.resources.Gold = playerData.resources.Gold + gold
    
    -- Добавление опыта
    if not playerData.experience then
        playerData.experience = 0
    end
    playerData.experience = playerData.experience + experience
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "+" .. gold .. " Gold, +" .. experience .. " XP", "success", 3)
end

-- Показ числа урона
function CombatManager:ShowDamageNumber(position, damage, isCrit, damageType)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Adornee = Instance.new("Part")
    billboardGui.Adornee.Position = position
    billboardGui.Adornee.Parent = workspace
    billboardGui.Parent = workspace
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = tostring(math.floor(damage))
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboardGui
    
    -- Настройка цвета и размера в зависимости от типа урона
    if isCrit then
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0) -- Красный для крита
        textLabel.Text = textLabel.Text .. "!"
        billboardGui.Size = UDim2.new(0, 120, 0, 60)
    elseif damageType == "Magic" then
        textLabel.TextColor3 = Color3.fromRGB(138, 43, 226) -- Фиолетовый для магии
    elseif damageType == "True" then
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 0) -- Желтый для чистого урона
    else
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый для физического
    end
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(billboardGui, TweenInfo.new(1), {
        StudsOffset = Vector3.new(0, 6, 0)
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(billboardGui, 1)
end

-- Создание эффекта атаки
function CombatManager:CreateAttackEffect(startPos, endPos, damageType)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(1, 1, 1)
    effect.Position = startPos
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Parent = self.effectsFolder
    
    -- Настройка цвета в зависимости от типа урона
    if damageType == "Magic" then
        effect.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
    elseif damageType == "True" then
        effect.Color = Color3.fromRGB(255, 255, 0) -- Желтый
    else
        effect.Color = Color3.fromRGB(255, 255, 255) -- Белый
    end
    
    effect.Transparency = 0.5
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(0.3), {
        Position = endPos,
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 0.3)
end

-- Создание эффекта получения урона
function CombatManager:CreateDamageEffect(target)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(6, 6, 6)
    effect.Position = target.PrimaryPart.Position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 0, 0)
    effect.Transparency = 0.7
    effect.Parent = self.effectsFolder
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(0.5), {
        Size = Vector3.new(12, 12, 12),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 0.5)
end

-- Создание эффекта смерти
function CombatManager:CreateDeathEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(2, 2, 2)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(100, 100, 100)
    effect.Transparency = 0.3
    effect.Parent = self.effectsFolder
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(1), {
        Size = Vector3.new(20, 20, 20),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 1)
end

-- Создание эффекта смерти игрока
function CombatManager:CreatePlayerDeathEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(3, 3, 3)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 0, 0)
    effect.Transparency = 0.3
    effect.Parent = self.effectsFolder
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(1.5), {
        Size = Vector3.new(25, 25, 25),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 1.5)
end

-- Уведомление игрока
function CombatManager:NotifyPlayer(player, message, type, duration)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        remote:FireClient(player, message, type, duration or 3)
    end
end

-- Логирование боевых действий
function CombatManager:LogCombatAction(attacker, target, damage, isCrit, damageType)
    local logEntry = {
        timestamp = tick(),
        attacker = attacker.Name,
        target = target.Name,
        damage = damage,
        isCrit = isCrit,
        damageType = damageType
    }
    
    table.insert(self.combatLog, logEntry)
    
    -- Ограничение размера лога
    if #self.combatLog > 1000 then
        table.remove(self.combatLog, 1)
    end
end

-- Получение боевого лога
function CombatManager:GetCombatLog()
    return self.combatLog
end

-- Очистка боевого лога
function CombatManager:ClearCombatLog()
    self.combatLog = {}
end

return setmetatable({}, CombatManager)