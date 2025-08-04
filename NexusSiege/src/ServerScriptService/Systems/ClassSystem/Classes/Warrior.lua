-- Warrior.lua
-- Класс Воина для Nexus Siege

local Warrior = {}
Warrior.__index = Warrior

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

-- Модули
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local Formulas = require(ReplicatedStorage.Modules.Shared.FormulasModule)

function Warrior.new(player)
    local self = setmetatable({}, Warrior)
    
    self.player = player
    self.character = player.Character or player.CharacterAdded:Wait()
    
    -- Базовые характеристики
    self.stats = {
        health = GameConstants.ClassStats[GameConstants.Classes.WARRIOR].health,
        maxHealth = GameConstants.ClassStats[GameConstants.Classes.WARRIOR].health,
        damage = GameConstants.ClassStats[GameConstants.Classes.WARRIOR].damage,
        armor = GameConstants.ClassStats[GameConstants.Classes.WARRIOR].armor,
        speed = GameConstants.ClassStats[GameConstants.Classes.WARRIOR].speed,
        attackSpeed = GameConstants.ClassStats[GameConstants.Classes.WARRIOR].attackSpeed,
        mana = 100,
        maxMana = 100,
        manaRegen = 5 -- в секунду
    }
    
    -- Способности
    self.abilities = {
        warCry = {
            name = "Провоцирующий клич",
            cooldown = 15,
            lastUsed = 0,
            manaCost = 20,
            description = "Заставляет врагов в радиусе 15 атаковать вас на 3 секунды"
        },
        whirlwind = {
            name = "Вихрь клинков",
            cooldown = 10,
            lastUsed = 0,
            manaCost = 30,
            damage = 50,
            radius = 8,
            description = "AOE урон вокруг персонажа"
        },
        groundSlam = {
            name = "Удар по земле",
            cooldown = 20,
            lastUsed = 0,
            manaCost = 40,
            stunDuration = 2,
            radius = 12,
            description = "Оглушает врагов в области"
        },
        banner = {
            name = "Знамя Непокорности",
            cooldown = 120,
            lastUsed = 0,
            manaCost = 100,
            duration = 20,
            buffRadius = 30,
            description = "Дает +50% защиты и +30% урона союзникам в области"
        }
    }
    
    -- Баффы и дебаффы
    self.buffs = {}
    self.debuffs = {}
    
    -- Внутренние переменные
    self.isInitialized = false
    self.manaRegenConnection = nil
    
    self:Initialize()
    
    return self
end

function Warrior:Initialize()
    if self.isInitialized then return end
    
    -- Применение характеристик
    local humanoid = self.character:WaitForChild("Humanoid")
    humanoid.MaxHealth = self.stats.maxHealth
    humanoid.Health = self.stats.health
    humanoid.WalkSpeed = self.stats.speed
    
    -- Добавление брони
    self.character:SetAttribute("Armor", self.stats.armor)
    self.character:SetAttribute("Class", GameConstants.Classes.WARRIOR)
    self.character:SetAttribute("Damage", self.stats.damage)
    self.character:SetAttribute("AttackSpeed", self.stats.attackSpeed)
    
    -- Запуск регенерации маны
    self:StartManaRegeneration()
    
    -- Подключение событий
    self:ConnectEvents()
    
    self.isInitialized = true
    print("[Warrior] Initialized for player:", self.player.Name)
end

function Warrior:ConnectEvents()
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

function Warrior:StartManaRegeneration()
    if self.manaRegenConnection then
        self.manaRegenConnection:Disconnect()
    end
    
    self.manaRegenConnection = game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
        if self.stats.mana < self.stats.maxMana then
            self.stats.mana = math.min(self.stats.maxMana, self.stats.mana + (self.stats.manaRegen * deltaTime))
        end
    end)
end

-- Способность 1: Провоцирующий клич
function Warrior:WarCry()
    if not self:CanUseAbility("warCry") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    local position = self.character.HumanoidRootPart.Position
    
    -- Визуальный эффект
    self:CreateWarCryEffect(position)
    
    -- Провокация врагов в радиусе
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            if enemy:FindFirstChild("PrimaryPart") then
                local distance = (enemy.PrimaryPart.Position - position).Magnitude
                if distance <= 15 then
                    self:TauntEnemy(enemy)
                end
            end
        end
    end
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.warCry.manaCost
    self.abilities.warCry.lastUsed = tick()
    
    -- Звуковой эффект
    self:PlayAbilitySound("warCry")
    
    return true, "Провоцирующий клич активирован!"
end

function Warrior:CreateWarCryEffect(position)
    -- Создание визуального эффекта
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Cylinder
    effect.Size = Vector3.new(0.5, 30, 30)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    effect.Transparency = 0.3
    effect.Parent = workspace
    
    -- Анимация расширения
    local tween = TweenService:Create(effect, TweenInfo.new(1), {
        Size = Vector3.new(0.5, 30, 30),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление эффекта
    Debris:AddItem(effect, 1)
end

function Warrior:TauntEnemy(enemy)
    -- Заставляем врага атаковать воина
    enemy:SetAttribute("Target", self.character)
    enemy:SetAttribute("Taunted", true)
    
    -- Снимаем провокацию через 3 секунды
    task.spawn(function()
        task.wait(3)
        if enemy and enemy:GetAttribute("Taunted") then
            enemy:SetAttribute("Taunted", false)
        end
    end)
end

-- Способность 2: Вихрь клинков
function Warrior:Whirlwind()
    if not self:CanUseAbility("whirlwind") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    local position = self.character.HumanoidRootPart.Position
    
    -- Анимация вращения
    self:PlayWhirlwindAnimation()
    
    -- Урон по области
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            if enemy:FindFirstChild("PrimaryPart") then
                local distance = (enemy.PrimaryPart.Position - position).Magnitude
                if distance <= self.abilities.whirlwind.radius then
                    self:DealDamageToEnemy(enemy, self.abilities.whirlwind.damage)
                    
                    -- Эффект удара
                    self:CreateSlashEffect(enemy.PrimaryPart.Position)
                end
            end
        end
    end
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.whirlwind.manaCost
    self.abilities.whirlwind.lastUsed = tick()
    
    -- Звуковой эффект
    self:PlayAbilitySound("whirlwind")
    
    return true, "Вихрь клинков нанесен!"
end

function Warrior:PlayWhirlwindAnimation()
    -- Здесь будет анимация вращения
    -- Можно использовать AnimationTrack или просто поворот модели
    local rootPart = self.character.HumanoidRootPart
    local startCFrame = rootPart.CFrame
    
    -- Простая анимация поворота
    for i = 1, 8 do
        rootPart.CFrame = startCFrame * CFrame.Angles(0, math.rad(45 * i), 0)
        task.wait(0.1)
    end
    
    rootPart.CFrame = startCFrame
end

function Warrior:CreateSlashEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(2, 2, 2)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 100, 100) -- Красный
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

-- Способность 3: Удар по земле
function Warrior:GroundSlam()
    if not self:CanUseAbility("groundSlam") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    local position = self.character.HumanoidRootPart.Position
    
    -- Визуальный эффект
    self:CreateShockwaveEffect(position)
    
    -- Оглушение врагов
    local enemies = workspace:FindFirstChild("Enemies")
    if enemies then
        for _, enemy in pairs(enemies:GetChildren()) do
            if enemy:FindFirstChild("PrimaryPart") then
                local distance = (enemy.PrimaryPart.Position - position).Magnitude
                if distance <= self.abilities.groundSlam.radius then
                    self:StunEnemy(enemy, self.abilities.groundSlam.stunDuration)
                end
            end
        end
    end
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.groundSlam.manaCost
    self.abilities.groundSlam.lastUsed = tick()
    
    -- Звуковой эффект
    self:PlayAbilitySound("groundSlam")
    
    return true, "Удар по земле оглушил врагов!"
end

function Warrior:CreateShockwaveEffect(position)
    local shockwave = Instance.new("Part")
    shockwave.Shape = Enum.PartType.Cylinder
    shockwave.Size = Vector3.new(0.5, 4, 4)
    shockwave.Position = position
    shockwave.Anchored = true
    shockwave.CanCollide = false
    shockwave.Material = Enum.Material.ForceField
    shockwave.Color = Color3.fromRGB(100, 100, 255) -- Синий
    shockwave.Transparency = 0.5
    shockwave.Parent = workspace
    
    -- Анимация расширения
    local tween = TweenService:Create(shockwave, TweenInfo.new(0.5), {
        Size = Vector3.new(0.5, 24, 24),
        Transparency = 1
    })
    tween:Play()
    
    Debris:AddItem(shockwave, 1)
end

function Warrior:StunEnemy(enemy, duration)
    -- Оглушаем врага
    enemy:SetAttribute("Stunned", true)
    
    local humanoid = enemy:FindFirstChild("Humanoid")
    if humanoid then
        local originalSpeed = humanoid.WalkSpeed
        humanoid.WalkSpeed = 0
        
        -- Снимаем оглушение
        task.spawn(function()
            task.wait(duration)
            if enemy and enemy:GetAttribute("Stunned") then
                enemy:SetAttribute("Stunned", false)
                if humanoid then
                    humanoid.WalkSpeed = originalSpeed
                end
            end
        end)
    end
end

-- Ультимейт: Знамя Непокорности
function Warrior:BannerOfDefiance()
    if not self:CanUseAbility("banner") then
        return false, "Способность на перезарядке или недостаточно маны"
    end
    
    local position = self.character.HumanoidRootPart.Position
    
    -- Создание знамени
    local banner = self:CreateBannerModel(position)
    
    -- Бафф союзников
    local duration = self.abilities.banner.duration
    local startTime = tick()
    
    task.spawn(function()
        while tick() - startTime < duration do
            local players = Players:GetPlayers()
            for _, player in pairs(players) do
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local distance = (player.Character.HumanoidRootPart.Position - position).Magnitude
                    if distance <= self.abilities.banner.buffRadius then
                        -- Применяем баффы
                        player.Character:SetAttribute("DamageBoost", 1.3)
                        player.Character:SetAttribute("DefenseBoost", 1.5)
                    end
                end
            end
            task.wait(1)
        end
        
        -- Удаление баффов
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                player.Character:SetAttribute("DamageBoost", 1)
                player.Character:SetAttribute("DefenseBoost", 1)
            end
        end
        
        -- Удаление знамени
        if banner then
            banner:Destroy()
        end
    end)
    
    -- Расход маны и установка кулдауна
    self.stats.mana = self.stats.mana - self.abilities.banner.manaCost
    self.abilities.banner.lastUsed = tick()
    
    -- Звуковой эффект
    self:PlayAbilitySound("banner")
    
    return true, "Знамя Непокорности установлено!"
end

function Warrior:CreateBannerModel(position)
    local banner = Instance.new("Model")
    banner.Name = "WarriorBanner"
    
    -- Флагшток
    local pole = Instance.new("Part")
    pole.Name = "Pole"
    pole.Size = Vector3.new(1, 8, 1)
    pole.Position = position
    pole.Anchored = true
    pole.Material = Enum.Material.Wood
    pole.Color = Color3.fromRGB(139, 69, 19)
    pole.Parent = banner
    
    -- Флаг
    local flag = Instance.new("Part")
    flag.Name = "Flag"
    flag.Size = Vector3.new(4, 2, 0.1)
    flag.Position = position + Vector3.new(2, 4, 0)
    flag.Anchored = true
    flag.Material = Enum.Material.Fabric
    flag.Color = Color3.fromRGB(255, 215, 0) -- Золотой
    flag.Parent = banner
    
    -- Световой эффект
    local light = Instance.new("PointLight")
    light.Brightness = 3
    light.Range = 30
    light.Color = Color3.fromRGB(255, 215, 0)
    light.Parent = pole
    
    banner.PrimaryPart = pole
    banner.Parent = workspace
    
    return banner
end

-- Вспомогательные функции
function Warrior:CanUseAbility(abilityName)
    local ability = self.abilities[abilityName]
    if not ability then return false end
    
    local currentTime = tick()
    local timeSinceLastUse = currentTime - ability.lastUsed
    
    return timeSinceLastUse >= ability.cooldown and self.stats.mana >= ability.manaCost
end

function Warrior:DealDamageToEnemy(enemy, damage)
    local humanoid = enemy:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:TakeDamage(damage)
        
        -- Показ урона
        self:ShowDamageNumber(enemy.PrimaryPart.Position, damage)
    end
end

function Warrior:ShowDamageNumber(position, damage)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Adornee = Instance.new("Part")
    billboardGui.Adornee.Position = position
    billboardGui.Adornee.Anchored = true
    billboardGui.Adornee.CanCollide = false
    billboardGui.Adornee.Transparency = 1
    billboardGui.Adornee.Parent = workspace
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = tostring(damage)
    textLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = billboardGui
    
    billboardGui.Parent = workspace
    
    -- Анимация исчезновения
    local tween = TweenService:Create(textLabel, TweenInfo.new(1), {
        TextTransparency = 1,
        Position = UDim2.new(0, 0, -1, 0)
    })
    tween:Play()
    
    Debris:AddItem(billboardGui, 1)
end

function Warrior:PlayAbilitySound(abilityName)
    -- Здесь будет воспроизведение звуков способностей
    print("[Warrior] Playing sound for ability:", abilityName)
end

function Warrior:OnDeath()
    print("[Warrior] Player", self.player.Name, "died")
    
    -- Остановка регенерации маны
    if self.manaRegenConnection then
        self.manaRegenConnection:Disconnect()
        self.manaRegenConnection = nil
    end
end

function Warrior:GetAbilityCooldown(abilityName)
    local ability = self.abilities[abilityName]
    if not ability then return 0 end
    
    local currentTime = tick()
    local timeSinceLastUse = currentTime - ability.lastUsed
    local remainingCooldown = ability.cooldown - timeSinceLastUse
    
    return math.max(0, remainingCooldown)
end

function Warrior:GetManaPercentage()
    return self.stats.mana / self.stats.maxMana
end

function Warrior:Destroy()
    if self.manaRegenConnection then
        self.manaRegenConnection:Disconnect()
    end
    
    self.isInitialized = false
end

return Warrior