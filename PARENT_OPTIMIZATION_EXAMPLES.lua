-- PARENT_OPTIMIZATION_EXAMPLES.lua
-- Практические примеры оптимизации использования parent в NexusSiege

-- ============================================================================
-- 1. ОБЪЕКТНЫЙ ПУЛ ДЛЯ ВИЗУАЛЬНЫХ ЭФФЕКТОВ
-- ============================================================================

local EffectPool = {}
local EffectPoolSize = 20

-- Инициализация пула
local function InitializeEffectPool()
    for i = 1, EffectPoolSize do
        local effect = Instance.new("Part")
        effect.Shape = Enum.PartType.Ball
        effect.Size = Vector3.new(1, 1, 1)
        effect.Anchored = true
        effect.CanCollide = false
        effect.Material = Enum.Material.ForceField
        effect.Transparency = 0.5
        table.insert(EffectPool, effect)
    end
end

-- Получение эффекта из пула
local function GetEffect()
    if #EffectPool > 0 then
        return table.remove(EffectPool)
    else
        -- Создаем новый, если пул пуст
        local effect = Instance.new("Part")
        effect.Shape = Enum.PartType.Ball
        effect.Size = Vector3.new(1, 1, 1)
        effect.Anchored = true
        effect.CanCollide = false
        effect.Material = Enum.Material.ForceField
        effect.Transparency = 0.5
        return effect
    end
end

-- Возврат эффекта в пул
local function ReturnEffect(effect)
    if effect and typeof(effect) == "Instance" then
        effect.Parent = nil
        effect.Position = Vector3.new(0, 0, 0)
        effect.Color = Color3.fromRGB(255, 255, 255)
        effect.Transparency = 0.5
        table.insert(EffectPool, effect)
    end
end

-- ============================================================================
-- 2. БЕЗОПАСНЫЕ ОПЕРАЦИИ С PARENT
-- ============================================================================

-- Безопасное присвоение parent
local function SafeParentAssignment(object, parent)
    if not object or typeof(object) ~= "Instance" then
        warn("Invalid object for parent assignment")
        return false
    end
    
    if not parent or typeof(parent) ~= "Instance" then
        warn("Invalid parent for assignment")
        return false
    end
    
    local success, result = pcall(function()
        object.Parent = parent
    end)
    
    if not success then
        warn("Failed to set parent:", result)
        return false
    end
    
    return true
end

-- Безопасная проверка существования
local function SafeParentCheck(object)
    return object and typeof(object) == "Instance" and object.Parent ~= nil
end

-- Безопасное удаление объекта
local function SafeDestroy(object)
    if SafeParentCheck(object) then
        local success, result = pcall(function()
            object:Destroy()
        end)
        
        if not success then
            warn("Failed to destroy object:", result)
            return false
        end
        
        return true
    end
    return false
end

-- ============================================================================
-- 3. ФАБРИКА ОБЪЕКТОВ
-- ============================================================================

local ObjectFactory = {}

-- Создание визуального эффекта
function ObjectFactory:CreateEffect(position, color, size)
    local effect = GetEffect()
    effect.Position = position or Vector3.new(0, 0, 0)
    effect.Color = color or Color3.fromRGB(255, 255, 255)
    effect.Size = size or Vector3.new(1, 1, 1)
    
    if SafeParentAssignment(effect, workspace) then
        return effect
    else
        ReturnEffect(effect)
        return nil
    end
end

-- Создание UI элемента
function ObjectFactory:CreateUIElement(elementType, parent, properties)
    local element = Instance.new(elementType or "Frame")
    
    -- Применение свойств
    if properties then
        for key, value in pairs(properties) do
            element[key] = value
        end
    end
    
    -- Установка parent
    if parent and SafeParentAssignment(element, parent) then
        return element
    else
        element:Destroy()
        return nil
    end
end

-- Создание турели
function ObjectFactory:CreateTurret(position, damage, attackSpeed)
    local turret = Instance.new("Model")
    turret.Name = "Turret"
    
    -- Основание
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(4, 2, 4)
    base.Position = position
    base.Anchored = true
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(100, 100, 100)
    
    -- Ствол
    local barrel = Instance.new("Part")
    barrel.Name = "Barrel"
    barrel.Size = Vector3.new(1, 6, 1)
    barrel.Position = position + Vector3.new(0, 4, 0)
    barrel.Anchored = true
    barrel.Material = Enum.Material.Metal
    barrel.Color = Color3.fromRGB(80, 80, 80)
    
    -- Иерархия
    if SafeParentAssignment(base, turret) and 
       SafeParentAssignment(barrel, turret) and
       SafeParentAssignment(turret, workspace) then
        
        -- Атрибуты
        turret:SetAttribute("Damage", damage or 10)
        turret:SetAttribute("AttackSpeed", attackSpeed or 1)
        turret:SetAttribute("Range", 15)
        turret:SetAttribute("LastAttack", 0)
        
        turret.PrimaryPart = base
        return turret
    else
        SafeDestroy(turret)
        return nil
    end
end

-- ============================================================================
-- 4. МЕНЕДЖЕР UI
-- ============================================================================

local UIManager = {
    activeHUDs = {},
    activeMenus = {},
    notifications = {}
}

-- Создание HUD для игрока
function UIManager:CreateHUD(player)
    if not player or typeof(player) ~= "Instance" then
        return nil
    end
    
    -- Проверяем, не существует ли уже HUD
    if self.activeHUDs[player] then
        return self.activeHUDs[player]
    end
    
    local screenGui = ObjectFactory:CreateUIElement("ScreenGui", player.PlayerGui, {
        Name = "MainHUD"
    })
    
    if screenGui then
        -- Основной контейнер
        local mainFrame = ObjectFactory:CreateUIElement("Frame", screenGui, {
            Name = "MainFrame",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        })
        
        if mainFrame then
            -- Верхняя панель
            local topPanel = ObjectFactory:CreateUIElement("Frame", mainFrame, {
                Name = "TopPanel",
                Size = UDim2.new(1, 0, 0, 60),
                Position = UDim2.new(0, 0, 0, 0),
                BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                BackgroundTransparency = 0.5
            })
            
            if topPanel then
                -- Информация о волне
                ObjectFactory:CreateUIElement("TextLabel", topPanel, {
                    Name = "WaveInfo",
                    Size = UDim2.new(0, 200, 1, 0),
                    Position = UDim2.new(0, 10, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "Волна: 0/10",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    Font = Enum.Font.GothamBold
                })
                
                -- Информация о фазе
                ObjectFactory:CreateUIElement("TextLabel", topPanel, {
                    Name = "PhaseInfo",
                    Size = UDim2.new(0, 200, 1, 0),
                    Position = UDim2.new(0, 220, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "День",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    Font = Enum.Font.GothamBold
                })
                
                -- Здоровье Нексуса
                ObjectFactory:CreateUIElement("TextLabel", topPanel, {
                    Name = "NexusHealth",
                    Size = UDim2.new(0, 200, 1, 0),
                    Position = UDim2.new(0, 430, 0, 0),
                    BackgroundTransparency = 1,
                    Text = "Нексус: 10000/10000",
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    TextScaled = true,
                    Font = Enum.Font.GothamBold
                })
            end
        end
        
        self.activeHUDs[player] = screenGui
        return screenGui
    end
    
    return nil
end

-- Удаление HUD игрока
function UIManager:DestroyHUD(player)
    if self.activeHUDs[player] then
        SafeDestroy(self.activeHUDs[player])
        self.activeHUDs[player] = nil
    end
end

-- Создание уведомления
function UIManager:CreateNotification(player, message, duration)
    if not player or not message then
        return nil
    end
    
    local screenGui = ObjectFactory:CreateUIElement("ScreenGui", player.PlayerGui, {
        Name = "Notification"
    })
    
    if screenGui then
        local notification = ObjectFactory:CreateUIElement("TextLabel", screenGui, {
            Size = UDim2.new(0, 300, 0, 50),
            Position = UDim2.new(0.5, -150, 0.2, 0),
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BackgroundTransparency = 0.3,
            Text = message,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextScaled = true,
            Font = Enum.Font.GothamBold
        })
        
        if notification then
            -- Автоматическое удаление
            task.spawn(function()
                task.wait(duration or 3)
                SafeDestroy(screenGui)
            end)
            
            return screenGui
        end
    end
    
    return nil
end

-- ============================================================================
-- 5. УЛУЧШЕННАЯ СИСТЕМА ТУРЕЛЕЙ
-- ============================================================================

local TurretManager = {
    activeTurrets = {},
    turretPool = {}
}

-- Создание турели с улучшенной логикой
function TurretManager:CreateTurret(position, owner)
    local turret = ObjectFactory:CreateTurret(position, 15, 1)
    
    if turret then
        turret:SetAttribute("Owner", owner)
        turret:SetAttribute("Created", tick())
        
        table.insert(self.activeTurrets, turret)
        
        -- Запуск логики атаки
        self:StartTurretLogic(turret)
        
        -- Автоматическое удаление через время
        task.spawn(function()
            task.wait(30) -- 30 секунд жизни
            self:DestroyTurret(turret)
        end)
        
        return turret
    end
    
    return nil
end

-- Логика работы турели
function TurretManager:StartTurretLogic(turret)
    task.spawn(function()
        while SafeParentCheck(turret) do
            local currentTime = tick()
            local lastAttack = turret:GetAttribute("LastAttack") or 0
            local attackSpeed = turret:GetAttribute("AttackSpeed") or 1
            
            if currentTime - lastAttack >= 1 / attackSpeed then
                -- Поиск врагов
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    local closestEnemy = nil
                    local closestDistance = math.huge
                    
                    for _, enemy in pairs(enemies:GetChildren()) do
                        if SafeParentCheck(enemy) and enemy:FindFirstChild("PrimaryPart") then
                            local distance = (enemy.PrimaryPart.Position - turret.PrimaryPart.Position).Magnitude
                            if distance <= turret:GetAttribute("Range") and distance < closestDistance then
                                closestEnemy = enemy
                                closestDistance = distance
                            end
                        end
                    end
                    
                    -- Атака
                    if closestEnemy then
                        self:TurretAttack(turret, closestEnemy)
                        turret:SetAttribute("LastAttack", currentTime)
                    end
                end
            end
            
            task.wait(0.1)
        end
    end)
end

-- Атака турели
function TurretManager:TurretAttack(turret, enemy)
    if not SafeParentCheck(turret) or not SafeParentCheck(enemy) then
        return
    end
    
    -- Создание выстрела
    local shot = ObjectFactory:CreateEffect(
        turret.PrimaryPart.Position,
        Color3.fromRGB(255, 255, 0),
        Vector3.new(0.5, 0.5, 0.5)
    )
    
    if shot then
        -- Анимация выстрела
        local tween = game:GetService("TweenService"):Create(shot, TweenInfo.new(0.5), {
            Position = enemy.PrimaryPart.Position
        })
        
        tween:Play()
        
        -- Удаление выстрела и нанесение урона
        task.spawn(function()
            task.wait(0.5)
            if SafeParentCheck(enemy) then
                -- Нанесение урона
                local damage = turret:GetAttribute("Damage") or 10
                -- Здесь должна быть логика нанесения урона
                print("Turret deals", damage, "damage to", enemy.Name)
            end
            
            ReturnEffect(shot)
        end)
    end
end

-- Удаление турели
function TurretManager:DestroyTurret(turret)
    if SafeParentCheck(turret) then
        -- Удаление из списка активных
        for i, activeTurret in ipairs(self.activeTurrets) do
            if activeTurret == turret then
                table.remove(self.activeTurrets, i)
                break
            end
        end
        
        SafeDestroy(turret)
    end
end

-- ============================================================================
-- 6. ИНИЦИАЛИЗАЦИЯ И ОЧИСТКА
-- ============================================================================

-- Инициализация всех систем
local function InitializeOptimizedSystems()
    print("[Optimization] Initializing optimized parent systems...")
    
    -- Инициализация пула эффектов
    InitializeEffectPool()
    
    -- Очистка при выходе игрока
    game:GetService("Players").PlayerRemoving:Connect(function(player)
        UIManager:DestroyHUD(player)
    end)
    
    print("[Optimization] Systems initialized successfully!")
end

-- Очистка всех ресурсов
local function CleanupOptimizedSystems()
    print("[Optimization] Cleaning up systems...")
    
    -- Очистка UI
    for player, hud in pairs(UIManager.activeHUDs) do
        SafeDestroy(hud)
    end
    UIManager.activeHUDs = {}
    
    -- Очистка турелей
    for _, turret in ipairs(TurretManager.activeTurrets) do
        SafeDestroy(turret)
    end
    TurretManager.activeTurrets = {}
    
    -- Очистка пула эффектов
    for _, effect in ipairs(EffectPool) do
        SafeDestroy(effect)
    end
    EffectPool = {}
    
    print("[Optimization] Cleanup completed!")
end

-- Экспорт функций
return {
    ObjectFactory = ObjectFactory,
    UIManager = UIManager,
    TurretManager = TurretManager,
    SafeParentAssignment = SafeParentAssignment,
    SafeParentCheck = SafeParentCheck,
    SafeDestroy = SafeDestroy,
    InitializeOptimizedSystems = InitializeOptimizedSystems,
    CleanupOptimizedSystems = CleanupOptimizedSystems
}