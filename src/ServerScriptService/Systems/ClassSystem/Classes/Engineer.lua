-- Engineer.lua
-- Класс Инженера для Nexus Siege

local Engineer = {}
Engineer.__index = Engineer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Модули
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local Formulas = require(ReplicatedStorage.Modules.Shared.FormulasModule)

function Engineer.new(player)
    local self = setmetatable({}, Engineer)
    
    self.player = player
    self.character = player.Character or player.CharacterAdded:Wait()
    
    -- Базовые характеристики
    self.stats = {
        health = GameConstants.ClassStats[GameConstants.Classes.ENGINEER].health,
        maxHealth = GameConstants.ClassStats[GameConstants.Classes.ENGINEER].health,
        damage = GameConstants.ClassStats[GameConstants.Classes.ENGINEER].damage,
        armor = GameConstants.ClassStats[GameConstants.Classes.ENGINEER].armor,
        speed = GameConstants.ClassStats[GameConstants.Classes.ENGINEER].speed,
        attackSpeed = GameConstants.ClassStats[GameConstants.Classes.ENGINEER].attackSpeed,
        mana = 100,
        maxMana = 100,
        manaRegen = 5 -- в секунду
    }
    
    -- Пассивные способности
    self.passives = {
        buildSpeed = 1.5, -- строит на 50% быстрее
        repairEfficiency = 2.0, -- ремонтирует в 2 раза эффективнее
        towerDiscount = 0.8 -- скидка 20% на постройки
    }
    
    -- Способности
    self.abilities = {
        overcharge = {
            name = "Перегрузка башни",
            cooldown = 20,
            lastUsed = 0,
            manaCost = 30,
            duration = 10,
            attackSpeedBonus = 2.0,
            description = "Удваивает скорость атаки выбранной башни"
        },
        emergencyRepair = {
            name = "Экстренный ремонт",
            cooldown = 30,
            lastUsed = 0,
            manaCost = 40,
            healAmount = 500,
            radius = 20,
            description = "Мгновенно восстанавливает HP построек в области"
        },
        miniTurret = {
            name = "Мини-турель",
            cooldown = 45,
            lastUsed = 0,
            manaCost = 50,
            duration = 30,
            damage = 15,
            attackSpeed = 0.5,
            description = "Устанавливает временную турель"
        },
        architect = {
            name = "Архитектор",
            cooldown = 180,
            lastUsed = 0,
            manaCost = 100,
            duration = 15,
            description = "Бесплатное строительство и мгновенная постройка"
        }
    }
    
    -- Внутренние переменные
    self.isInitialized = false
    self.manaRegenConnection = nil
    self.activeTurrets = {}
    
    self:Initialize()
    
    return self
end

function Engineer:Initialize()
    if self.isInitialized then return end
    
    -- Применение характеристик
    local humanoid = self.character:WaitForChild("Humanoid")
    humanoid.MaxHealth = self.stats.maxHealth
    humanoid.Health = self.stats.health
    humanoid.WalkSpeed = self.stats.speed
    
    -- Добавление атрибутов
    self.character:SetAttribute("Armor", self.stats.armor)
    self.character:SetAttribute("Class", GameConstants.Classes.ENGINEER)
    self.character:SetAttribute("Damage", self.stats.damage)
    self.character:SetAttribute("AttackSpeed", self.stats.attackSpeed)
    self.character:SetAttribute("BuildSpeed", self.passives.buildSpeed)
    self.character:SetAttribute("RepairEfficiency", self.passives.repairEfficiency)
    
    -- Запуск регенерации маны
    self:StartManaRegeneration()
    
    -- Подключение событий
    self:ConnectEvents()
    
    self.isInitialized = true
    print("[Engineer] Initialized for player:", self.player.Name)
end

function Engineer:ConnectEvents()
    -- Обработка смерти персонажа
    local humanoid = self.character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Died:Connect(function()
            self:OnDeath()
        end)
    end
    
    -- Обработка изменения персонажа
    self.player.CharacterAdded:Connect(function(newCharacter)
        self.character = newCharacter
        self:Initialize()
    end)
end

function Engineer:StartManaRegeneration()
    if self.manaRegenConnection then
        self.manaRegenConnection:Disconnect()
    end
    
    self.manaRegenConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
        if self.stats.mana < self.stats.maxMana then
            self.stats.mana = math.min(self.stats.maxMana, self.stats.mana + (self.stats.manaRegen * deltaTime))
        end
    end)
end

-- Способность 1: Перегрузка башни
function Engineer:OverchargeTower(targetTower)
    if not self:CanUseAbility("overcharge") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    if not targetTower then
        return false, "Цель не выбрана"
    end
    
    -- Применение перегрузки к башне
    targetTower:SetAttribute("Overcharged", true)
    targetTower:SetAttribute("AttackSpeedMultiplier", self.abilities.overcharge.attackSpeedBonus)
    
    -- Визуальный эффект
    self:CreateOverchargeEffect(targetTower)
    
    -- Снятие перегрузки через время
    task.spawn(function()
        task.wait(self.abilities.overcharge.duration)
        if targetTower and targetTower:GetAttribute("Overcharged") then
            targetTower:SetAttribute("Overcharged", false)
            targetTower:SetAttribute("AttackSpeedMultiplier", 1)
        end
    end)
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.overcharge.manaCost
    self.abilities.overcharge.lastUsed = tick()
    
    return true, "Перегрузка башни активирована!"
end

function Engineer:CreateOverchargeEffect(tower)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Cylinder
    effect.Size = Vector3.new(0.5, 20, 20)
    effect.Position = tower.PrimaryPart.Position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 100, 255) -- Розовый
    effect.Transparency = 0.3
    effect.Parent = workspace
    
    -- Анимация пульсации
    local tween = TweenService:Create(effect, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.7
    })
    tween:Play()
    
    Debris:AddItem(effect, self.abilities.overcharge.duration)
end

-- Способность 2: Экстренный ремонт
function Engineer:EmergencyRepair()
    if not self:CanUseAbility("emergencyRepair") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    local position = self.character.HumanoidRootPart.Position
    
    -- Визуальный эффект
    self:CreateRepairEffect(position)
    
    -- Поиск и ремонт построек в радиусе
    local structures = workspace:GetChildren()
    for _, structure in pairs(structures) do
        if structure:GetAttribute("StructureType") then
            local distance = (structure.PrimaryPart.Position - position).Magnitude
            if distance <= self.abilities.emergencyRepair.radius then
                self:RepairStructure(structure, self.abilities.emergencyRepair.healAmount)
            end
        end
    end
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.emergencyRepair.manaCost
    self.abilities.emergencyRepair.lastUsed = tick()
    
    return true, "Экстренный ремонт выполнен!"
end

function Engineer:CreateRepairEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Cylinder
    effect.Size = Vector3.new(0.5, 40, 40)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(100, 255, 100) -- Зеленый
    effect.Transparency = 0.5
    effect.Parent = workspace
    
    -- Анимация расширения
    local tween = TweenService:Create(effect, TweenInfo.new(0.5), {
        Size = Vector3.new(0.5, 40, 40),
        Transparency = 1
    })
    tween:Play()
    
    Debris:AddItem(effect, 1)
end

function Engineer:RepairStructure(structure, healAmount)
    local currentHealth = structure:GetAttribute("Health") or 0
    local maxHealth = structure:GetAttribute("MaxHealth") or 1000
    
    local newHealth = math.min(maxHealth, currentHealth + healAmount)
    structure:SetAttribute("Health", newHealth)
    
    -- Визуальный эффект ремонта
    self:CreateHealEffect(structure.PrimaryPart.Position)
end

function Engineer:CreateHealEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(2, 2, 2)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(100, 255, 100)
    effect.Transparency = 0.5
    effect.Parent = workspace
    
    -- Анимация исчезновения
    local tween = TweenService:Create(effect, TweenInfo.new(0.5), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    })
    tween:Play()
    
    Debris:AddItem(effect, 0.5)
end

-- Способность 3: Мини-турель
function Engineer:MiniTurret()
    if not self:CanUseAbility("miniTurret") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    local position = self.character.HumanoidRootPart.Position + Vector3.new(0, 0, 5)
    
    -- Создание мини-турели
    local turret = self:CreateMiniTurret(position)
    table.insert(self.activeTurrets, turret)
    
    -- Автоматическое удаление через время
    task.spawn(function()
        task.wait(self.abilities.miniTurret.duration)
        if turret and turret.Parent then
            turret:Destroy()
            -- Удаление из списка активных турелей
            for i, activeTurret in ipairs(self.activeTurrets) do
                if activeTurret == turret then
                    table.remove(self.activeTurrets, i)
                    break
                end
            end
        end
    end)
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.miniTurret.manaCost
    self.abilities.miniTurret.lastUsed = tick()
    
    return true, "Мини-турель установлена!"
end

function Engineer:CreateMiniTurret(position)
    local turret = Instance.new("Model")
    turret.Name = "MiniTurret"
    
    -- Основание
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = Vector3.new(4, 2, 4)
    base.Position = position
    base.Anchored = true
    base.Material = Enum.Material.Metal
    base.Color = Color3.fromRGB(100, 100, 100)
    base.Parent = turret
    
    -- Ствол
    local barrel = Instance.new("Part")
    barrel.Name = "Barrel"
    barrel.Size = Vector3.new(1, 6, 1)
    barrel.Position = position + Vector3.new(0, 4, 0)
    barrel.Anchored = true
    barrel.Material = Enum.Material.Metal
    barrel.Color = Color3.fromRGB(80, 80, 80)
    barrel.Parent = turret
    
    -- Атрибуты турели
    turret:SetAttribute("Damage", self.abilities.miniTurret.damage)
    turret:SetAttribute("AttackSpeed", self.abilities.miniTurret.attackSpeed)
    turret:SetAttribute("Range", 15)
    turret:SetAttribute("LastAttack", 0)
    
    turret.PrimaryPart = base
    turret.Parent = workspace
    
    -- Запуск логики атаки
    self:StartTurretLogic(turret)
    
    return turret
end

function Engineer:StartTurretLogic(turret)
    task.spawn(function()
        while turret and turret.Parent do
            local currentTime = tick()
            local lastAttack = turret:GetAttribute("LastAttack") or 0
            local attackSpeed = turret:GetAttribute("AttackSpeed") or 1
            
            if currentTime - lastAttack >= 1 / attackSpeed then
                -- Поиск врагов в радиусе
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    local closestEnemy = nil
                    local closestDistance = math.huge
                    
                    for _, enemy in pairs(enemies:GetChildren()) do
                        if enemy:FindFirstChild("PrimaryPart") then
                            local distance = (enemy.PrimaryPart.Position - turret.PrimaryPart.Position).Magnitude
                            if distance <= turret:GetAttribute("Range") and distance < closestDistance then
                                closestEnemy = enemy
                                closestDistance = distance
                            end
                        end
                    end
                    
                    -- Атака ближайшего врага
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

function Engineer:TurretAttack(turret, enemy)
    local damage = turret:GetAttribute("Damage") or 15
    
    -- Нанесение урона
    local humanoid = enemy:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:TakeDamage(damage)
        
        -- Эффект выстрела
        self:CreateTurretShotEffect(turret.PrimaryPart.Position, enemy.PrimaryPart.Position)
    end
end

function Engineer:CreateTurretShotEffect(fromPos, toPos)
    local shot = Instance.new("Part")
    shot.Size = Vector3.new(0.2, 0.2, 0.2)
    shot.Position = fromPos
    shot.Anchored = true
    shot.CanCollide = false
    shot.Material = Enum.Material.ForceField
    shot.Color = Color3.fromRGB(255, 255, 0) -- Желтый
    shot.Transparency = 0.3
    shot.Parent = workspace
    
    -- Анимация полета
    local tween = TweenService:Create(shot, TweenInfo.new(0.2), {
        Position = toPos
    })
    tween:Play()
    
    Debris:AddItem(shot, 0.2)
end

-- Ультимейт: Архитектор
function Engineer:Architect()
    if not self:CanUseAbility("architect") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    -- Активация режима архитектора
    self.character:SetAttribute("ArchitectMode", true)
    self.character:SetAttribute("FreeBuilding", true)
    self.character:SetAttribute("InstantBuild", true)
    
    -- Визуальный эффект
    self:CreateArchitectEffect()
    
    -- Снятие режима через время
    task.spawn(function()
        task.wait(self.abilities.architect.duration)
        self.character:SetAttribute("ArchitectMode", false)
        self.character:SetAttribute("FreeBuilding", false)
        self.character:SetAttribute("InstantBuild", false)
    end)
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.architect.manaCost
    self.abilities.architect.lastUsed = tick()
    
    return true, "Режим Архитектора активирован!"
end

function Engineer:CreateArchitectEffect()
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Cylinder
    effect.Size = Vector3.new(0.5, 50, 50)
    effect.Position = self.character.HumanoidRootPart.Position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 255, 255) -- Белый
    effect.Transparency = 0.7
    effect.Parent = workspace
    
    -- Анимация пульсации
    local tween = TweenService:Create(effect, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Transparency = 0.9
    })
    tween:Play()
    
    Debris:AddItem(effect, self.abilities.architect.duration)
end

-- Вспомогательные функции
function Engineer:CanUseAbility(abilityName)
    local ability = self.abilities[abilityName]
    if not ability then return false end
    
    local currentTime = tick()
    local timeSinceLastUse = currentTime - ability.lastUsed
    
    return timeSinceLastUse >= ability.cooldown and self.stats.mana >= ability.manaCost
end

function Engineer:GetAbilityCooldown(abilityName)
    local ability = self.abilities[abilityName]
    if not ability then return 0 end
    
    local currentTime = tick()
    local timeSinceLastUse = currentTime - ability.lastUsed
    local remainingCooldown = ability.cooldown - timeSinceLastUse
    
    return math.max(0, remainingCooldown)
end

function Engineer:GetManaPercentage()
    return self.stats.mana / self.stats.maxMana
end

function Engineer:OnDeath()
    print("[Engineer] Player", self.player.Name, "died")
    
    -- Остановка регенерации маны
    if self.manaRegenConnection then
        self.manaRegenConnection:Disconnect()
        self.manaRegenConnection = nil
    end
    
    -- Удаление всех активных турелей
    for _, turret in pairs(self.activeTurrets) do
        if turret and turret.Parent then
            turret:Destroy()
        end
    end
    self.activeTurrets = {}
end

function Engineer:Destroy()
    if self.manaRegenConnection then
        self.manaRegenConnection:Disconnect()
    end
    
    -- Удаление турелей
    for _, turret in pairs(self.activeTurrets) do
        if turret and turret.Parent then
            turret:Destroy()
        end
    end
    
    self.isInitialized = false
end

return Engineer