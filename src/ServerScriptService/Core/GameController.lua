-- GameController.lua
-- Главный контроллер игры Nexus Siege

local GameController = {}

-- Импорт систем
local WaveManager = require(ServerScriptService.Systems.WaveSystem.WaveManager)
local ResourceManager = require(ServerScriptService.Systems.ResourceSystem.ResourceManager)
local BuildManager = require(ServerScriptService.Systems.BuildingSystem.BuildManager)
local CombatManager = require(ServerScriptService.Systems.CombatSystem.CombatManager)
local EnemyManager = require(ServerScriptService.Systems.EnemySystem.EnemyManager)
local AntiCheat = require(ServerScriptService.Security.AntiCheat)
local ProfileService = require(ServerScriptService.Data.ProfileService)

-- Remotes
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = {
    UseAbility = ReplicatedStorage.Remotes.Combat:FindFirstChild("UseAbility"),
    BuildStructure = ReplicatedStorage.Remotes.Building:FindFirstChild("BuildStructure"),
    GatherResource = ReplicatedStorage.Remotes.Resources:FindFirstChild("GatherResource"),
    SelectClass = ReplicatedStorage.Remotes.UI:FindFirstChild("SelectClass"),
}

-- Состояние игры
GameController.State = {
    Phase = GameConstants.Phases.WAITING,
    Wave = 0,
    Players = {},
    NexusHealth = GameConstants.NEXUS.MAX_HEALTH,
    MatchTime = 0,
    IsGameActive = false,
    StartTime = 0
}

-- События
GameController.Events = {
    PhaseChanged = Instance.new("BindableEvent"),
    WaveStarted = Instance.new("BindableEvent"),
    WaveEnded = Instance.new("BindableEvent"),
    GameEnded = Instance.new("BindableEvent"),
    PlayerJoined = Instance.new("BindableEvent"),
    PlayerLeft = Instance.new("BindableEvent")
}

function GameController:Initialize()
    print("[GameController] Initializing Nexus Siege...")
    
    -- Инициализация систем
    ProfileService:Initialize()
    EnemyManager:Initialize()
    WaveManager:Initialize()
    ResourceManager:Initialize()
    BuildManager:Initialize()
    CombatManager:Initialize()
    AntiCheat:Initialize()
    
    -- Создание Нексуса
    self:CreateNexus()
    
    -- События игроков
    Players.PlayerAdded:Connect(function(player)
        self:OnPlayerJoined(player)
    end)
    Players.PlayerRemoving:Connect(function(player)
        self:OnPlayerLeft(player)
    end)
    
    -- Подключение Remotes
    self:ConnectRemotes()
    
    -- Запуск игрового цикла
    self:StartGameLoop()
    
    print("[GameController] Initialization completed!")
end

-- Создание Нексуса
function GameController:CreateNexus()
    local nexus = Instance.new("Model")
    nexus.Name = "Nexus"
    nexus.Parent = workspace
    
    -- Основная часть Нексуса
    local primaryPart = Instance.new("Part")
    primaryPart.Name = "PrimaryPart"
    primaryPart.Size = GameConstants.NEXUS.SIZE
    primaryPart.Position = GameConstants.NEXUS.POSITION
    primaryPart.Anchored = true
    primaryPart.CanCollide = true
    primaryPart.Material = Enum.Material.Neon
    primaryPart.Color = Color3.fromRGB(0, 255, 255) -- Голубой
    primaryPart.Parent = nexus
    
    -- Humanoid для здоровья
    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = GameConstants.NEXUS.MAX_HEALTH
    humanoid.Health = GameConstants.NEXUS.MAX_HEALTH
    humanoid.Parent = nexus
    
    -- Установка PrimaryPart
    nexus.PrimaryPart = primaryPart
    
    -- Атрибуты Нексуса
    nexus:SetAttribute("IsNexus", true)
    nexus:SetAttribute("MaxHealth", GameConstants.NEXUS.MAX_HEALTH)
    
    -- Подключение события смерти Нексуса
    humanoid.Died:Connect(function()
        self:OnNexusDestroyed()
    end)
    
    print("[GameController] Nexus created at", GameConstants.NEXUS.POSITION)
end

-- Обработка смерти Нексуса
function GameController:OnNexusDestroyed()
    print("[GameController] Nexus destroyed! Game Over!")
    
    -- Изменение состояния игры
    self.State.IsGameActive = false
    self.State.Phase = GameConstants.Phases.DEFEAT
    
    -- Уведомление всех игроков
    for _, player in pairs(Players:GetPlayers()) do
        self:NotifyPlayer(player, "Нексус разрушен! Игра окончена!", "error", 10)
    end
    
    -- Запуск события окончания игры
    self.Events.GameEnded:Fire("Defeat")
    
    -- Ожидание перед перезапуском
    task.wait(10)
    self:RestartGame()
end

-- Перезапуск игры
function GameController:RestartGame()
    print("[GameController] Restarting game...")
    
    -- Сброс состояния
    self.State.Phase = GameConstants.Phases.WAITING
    self.State.Wave = 0
    self.State.NexusHealth = GameConstants.NEXUS.MAX_HEALTH
    self.State.MatchTime = 0
    self.State.IsGameActive = false
    self.State.StartTime = 0
    
    -- Очистка врагов
    EnemyManager:ClearAllEnemies()
    
    -- Восстановление Нексуса
    local nexus = workspace:FindFirstChild("Nexus")
    if nexus then
        local humanoid = nexus:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = GameConstants.NEXUS.MAX_HEALTH
        end
    end
    
    -- Перезапуск игрового цикла
    self:StartGameLoop()
end

-- Обработка присоединения игрока
function GameController:OnPlayerJoined(player)
    print("[GameController] Player joined:", player.Name)
    
    -- Ожидание загрузки персонажа
    player.CharacterAdded:Connect(function(character)
        self:OnCharacterSpawned(player, character)
    end)
    
    -- Если персонаж уже существует
    if player.Character then
        self:OnCharacterSpawned(player, player.Character)
    end
    
    -- Запуск события
    self.Events.PlayerJoined:Fire(player)
    
    -- Проверка готовности к старту
    if #Players:GetPlayers() >= GameConstants.MIN_PLAYERS_TO_START and not self.State.IsGameActive then
        self:StartMatch()
    end
end

-- Обработка выхода игрока
function GameController:OnPlayerLeft(player)
    print("[GameController] Player left:", player.Name)
    
    -- Очистка данных игрока
    ResourceManager:CleanupPlayer(player)
    BuildManager:CleanupPlayer(player)
    
    -- Запуск события
    self.Events.PlayerLeft:Fire(player)
    
    -- Проверка окончания игры
    if #Players:GetPlayers() < GameConstants.MIN_PLAYERS_TO_START and self.State.IsGameActive then
        self:EndMatch("Not enough players")
    end
end

-- Обработка спавна персонажа
function GameController:OnCharacterSpawned(player, character)
    print("[GameController] Character spawned for:", player.Name)
    
    -- Настройка персонажа
    self:SetupCharacter(player, character)
    
    -- Выдача инструментов
    self:GiveStartingTools(player)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Добро пожаловать в Nexus Siege!", "info", 5)
end

-- Настройка персонажа
function GameController:SetupCharacter(player, character)
    local humanoid = character:FindFirstChild("Humanoid")
    if humanoid then
        -- Получение данных игрока
        local playerData = ProfileService:GetPlayerData(player)
        local classStats = self:GetClassStats(playerData.selectedClass)
        
        -- Применение характеристик класса
        humanoid.MaxHealth = classStats.health or 100
        humanoid.Health = humanoid.MaxHealth
        humanoid.WalkSpeed = classStats.speed or 16
        humanoid.JumpPower = 50
        
        -- Установка атрибутов
        character:SetAttribute("PlayerClass", playerData.selectedClass)
        character:SetAttribute("PlayerLevel", playerData.level)
    end
end

-- Выдача начальных инструментов
function GameController:GiveStartingTools(player)
    local character = player.Character
    if not character then return end
    
    -- Создание инструментов
    local tools = {
        {name = "Axe", toolType = "Tool"},
        {name = "Pickaxe", toolType = "Tool"},
        {name = "CrystalPick", toolType = "Tool"}
    }
    
    for _, toolData in ipairs(tools) do
        local tool = Instance.new(toolData.toolType)
        tool.Name = toolData.name
        tool.Parent = character
    end
end

-- Получение характеристик класса
function GameController:GetClassStats(className)
    local classStats = {
        Warrior = {
            health = 200,
            speed = 14,
            damage = 30,
            armor = 20
        },
        Engineer = {
            health = 150,
            speed = 16,
            damage = 20,
            armor = 10
        },
        Miner = {
            health = 175,
            speed = 18,
            damage = 25,
            armor = 15
        }
    }
    
    return classStats[className] or classStats.Warrior
end

-- Уведомление игрока
function GameController:NotifyPlayer(player, message, type, duration)
    local remote = Remotes.ShowNotification
    if remote then
        remote:FireClient(player, message, type, duration or 3)
    end
end

function GameController:StartGameLoop()
    print("[GameController] Starting game loop...")
    
    -- Ожидание игроков
    while #Players:GetPlayers() < GameConstants.MIN_PLAYERS_TO_START do
        task.wait(1)
    end
    
    -- Начало матча
    self:StartMatch()
end

function GameController:StartMatch()
    print("[GameController] Starting match!")
    
    self.State.IsGameActive = true
    self.State.StartTime = tick()
    
    -- Фаза подготовки
    self:ChangePhase(GameConstants.Phases.PREPARATION)
    self:WaitForPhase(GameConstants.PhaseDurations.PREPARATION)
    
    -- Основной игровой цикл
    for wave = 1, GameConstants.TOTAL_WAVES do
        self.State.Wave = wave
        print("[GameController] Starting wave", wave)
        
        -- День
        self:ChangePhase(GameConstants.Phases.DAY)
        self:WaitForPhase(GameConstants.PhaseDurations.DAY)
        
        -- Переход к ночи
        self:ChangePhase(GameConstants.Phases.TRANSITION_TO_NIGHT)
        self:WaitForPhase(GameConstants.PhaseDurations.TRANSITION_TO_NIGHT)
        
        -- Ночь
        self:ChangePhase(GameConstants.Phases.NIGHT)
        local waveDuration = GameConstants.PhaseDurations.NIGHT_BASE + 
                           (wave - 1) * GameConstants.PhaseDurations.NIGHT_PER_WAVE
        
        -- Запуск волны
        self:StartWave(wave)
        
        -- Ожидание окончания волны
        local startTime = tick()
        while tick() - startTime < waveDuration do
            if self.State.NexusHealth <= 0 then
                self:EndMatch(false)
                return
            end
            wait(1)
        end
        
        -- Завершение волны
        self:EndWave(wave)
        
        -- Проверка победы
        if wave == GameConstants.TOTAL_WAVES and self.State.NexusHealth > 0 then
            self:EndMatch(true)
            return
        end
        
        -- Затишье между волнами
        self:ChangePhase(GameConstants.Phases.INTERMISSION)
        self:WaitForPhase(GameConstants.PhaseDurations.INTERMISSION)
    end
end

function GameController:ChangePhase(newPhase)
    print("[GameController] Changing phase to:", newPhase)
    
    local oldPhase = self.State.Phase
    self.State.Phase = newPhase
    
    -- Уведомление всех систем о смене фазы
    self.Events.PhaseChanged:Fire(oldPhase, newPhase)
    
    -- Специфичные действия для каждой фазы
    if newPhase == GameConstants.Phases.DAY then
        self:OnDayPhaseStart()
    elseif newPhase == GameConstants.Phases.NIGHT then
        self:OnNightPhaseStart()
    elseif newPhase == GameConstants.Phases.TRANSITION_TO_NIGHT then
        self:OnTransitionToNight()
    end
end

function GameController:WaitForPhase(duration)
    local startTime = tick()
    while tick() - startTime < duration do
        if not self.State.IsGameActive then
            return
        end
        wait(1)
    end
end

function GameController:StartWave(waveNumber)
    print("[GameController] Starting wave", waveNumber)
    
    -- Здесь будет логика запуска волны
    -- WaveManager:StartWave(waveNumber)
    
    self.Events.WaveStarted:Fire(waveNumber)
end

function GameController:EndWave(waveNumber)
    print("[GameController] Ending wave", waveNumber)
    
    -- Здесь будет логика завершения волны
    -- WaveManager:EndWave(waveNumber)
    
    self.Events.WaveEnded:Fire(waveNumber)
end

function GameController:OnDayPhaseStart()
    print("[GameController] Day phase started")
    
    -- Включение дневного освещения
    self:SetDayLighting()
    
    -- Разрешение строительства и добычи ресурсов
    self:EnableDayActivities()
    
    -- Уведомление игроков
    self:NotifyPlayers("День начался! Стройте оборону и добывайте ресурсы!")
end

function GameController:OnNightPhaseStart()
    print("[GameController] Night phase started")
    
    -- Включение ночного освещения
    self:SetNightLighting()
    
    -- Отключение строительства
    self:DisableDayActivities()
    
    -- Уведомление игроков
    self:NotifyPlayers("Ночь наступила! Защищайте Нексус!")
end

function GameController:OnTransitionToNight()
    print("[GameController] Transitioning to night")
    
    -- Звуковой сигнал
    self:PlayWarHorn()
    
    -- Телепортация игроков к Нексусу
    self:TeleportPlayersToNexus()
    
    -- Уведомление игроков
    self:NotifyPlayers("Внимание! Ночь приближается! Возвращайтесь к Нексусу!")
end

function GameController:SetDayLighting()
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 2
    lighting.Ambient = Color3.fromRGB(140, 140, 140)
    lighting.ColorShift_Top = Color3.fromRGB(255, 250, 200)
    
    -- Здесь можно добавить анимацию перехода
end

function GameController:SetNightLighting()
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 0.3
    lighting.Ambient = Color3.fromRGB(50, 50, 70)
    lighting.ColorShift_Top = Color3.fromRGB(70, 70, 150)
    
    -- Здесь можно добавить анимацию перехода
end

function GameController:PlayWarHorn()
    -- Здесь будет воспроизведение звука боевого горна
    print("[GameController] Playing war horn sound")
end

function GameController:TeleportPlayersToNexus()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.CFrame = CFrame.new(GameConstants.NEXUS.POSITION)
        end
    end
end

function GameController:EnableDayActivities()
    -- Разрешение строительства и добычи ресурсов
    print("[GameController] Day activities enabled")
end

function GameController:DisableDayActivities()
    -- Отключение строительства и добычи ресурсов
    print("[GameController] Day activities disabled")
end

function GameController:NotifyPlayers(message)
    for _, player in pairs(Players:GetPlayers()) do
        -- Здесь будет отправка уведомления игроку
        print("[GameController] Notifying", player.Name, ":", message)
    end
end

function GameController:OnPlayerJoined(player)
    print("[GameController] Player joined:", player.Name)
    
    -- Инициализация данных игрока
    self.State.Players[player] = {
        class = nil,
        resources = {Wood = 0, Stone = 0, Crystal = 0},
        contribution = 0,
        level = 1,
        experience = 0
    }
    
    -- Уведомление о присоединении игрока
    self.Events.PlayerJoined:Fire(player)
    
    -- Показ меню выбора класса
    self:ShowClassSelection(player)
end

function GameController:OnPlayerLeft(player)
    print("[GameController] Player left:", player.Name)
    
    -- Очистка данных игрока
    self.State.Players[player] = nil
    
    -- Уведомление об уходе игрока
    self.Events.PlayerLeft:Fire(player)
    
    -- Проверка, нужно ли завершить игру
    if #Players:GetPlayers() < GameConstants.MIN_PLAYERS_TO_START and self.State.IsGameActive then
        self:EndMatch(false, "Недостаточно игроков")
    end
end

function GameController:ShowClassSelection(player)
    -- Здесь будет показ меню выбора класса
    print("[GameController] Showing class selection for", player.Name)
end

function GameController:SetPlayerClass(player, className)
    if not self.State.Players[player] then
        return false
    end
    
    if not GameConstants.ClassStats[className] then
        return false
    end
    
    self.State.Players[player].class = className
    
    -- Применение характеристик класса
    self:ApplyClassStats(player, className)
    
    print("[GameController] Player", player.Name, "chose class:", className)
    return true
end

function GameController:ApplyClassStats(player, className)
    local stats = GameConstants.ClassStats[className]
    local character = player.Character
    
    if character and character:FindFirstChild("Humanoid") then
        local humanoid = character.Humanoid
        humanoid.MaxHealth = stats.health
        humanoid.Health = stats.health
        humanoid.WalkSpeed = stats.speed
        
        -- Установка атрибутов
        character:SetAttribute("Class", className)
        character:SetAttribute("Damage", stats.damage)
        character:SetAttribute("Armor", stats.armor)
        character:SetAttribute("AttackSpeed", stats.attackSpeed)
    end
end

function GameController:EndMatch(victory, reason)
    print("[GameController] Ending match. Victory:", victory, "Reason:", reason or "Normal")
    
    self.State.IsGameActive = false
    
    if victory then
        self:ChangePhase(GameConstants.Phases.VICTORY)
        self:ShowVictoryScreen()
    else
        self:ChangePhase(GameConstants.Phases.DEFEAT)
        self:ShowDefeatScreen(reason)
    end
    
    -- Сохранение результатов
    self:SaveMatchResults()
    
    -- Уведомление о завершении игры
    self.Events.GameEnded:Fire(victory, reason)
    
    -- Перезапуск через минуту
    wait(60)
    self:RestartServer()
end

function GameController:ShowVictoryScreen()
    print("[GameController] Showing victory screen")
    -- Здесь будет показ экрана победы
end

function GameController:ShowDefeatScreen(reason)
    print("[GameController] Showing defeat screen. Reason:", reason)
    -- Здесь будет показ экрана поражения
end

function GameController:SaveMatchResults()
    print("[GameController] Saving match results")
    -- Здесь будет сохранение результатов матча
end

function GameController:RestartServer()
    print("[GameController] Restarting server...")
    -- Здесь будет перезапуск сервера
    -- game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end

function GameController:TakeNexusDamage(damage)
    self.State.NexusHealth = math.max(0, self.State.NexusHealth - damage)
    
    if self.State.NexusHealth <= 0 then
        self:EndMatch(false, "Нексус разрушен")
    end
    
    print("[GameController] Nexus took", damage, "damage. Health:", self.State.NexusHealth)
end

function GameController:GetGameState()
    return {
        phase = self.State.Phase,
        wave = self.State.Wave,
        nexusHealth = self.State.NexusHealth,
        maxNexusHealth = GameConstants.NEXUS.MAX_HEALTH,
        matchTime = tick() - self.State.StartTime,
        playerCount = #Players:GetPlayers(),
        isGameActive = self.State.IsGameActive
    }
end

function GameController:ConnectRemotes()
    print("[GameController] Connecting Remote Events...")
    
    -- Подключение UseAbility
    if Remotes.UseAbility then
        Remotes.UseAbility.OnServerEvent:Connect(function(player, abilityName)
            self:HandleUseAbility(player, abilityName)
        end)
    end
    
    -- Подключение BuildStructure
    if Remotes.BuildStructure then
        Remotes.BuildStructure.OnServerEvent:Connect(function(player, structureType, position)
            self:HandleBuildStructure(player, structureType, position)
        end)
    end
    
    -- Подключение GatherResource
    if Remotes.GatherResource then
        Remotes.GatherResource.OnServerEvent:Connect(function(player, resourceType, amount)
            self:HandleGatherResource(player, resourceType, amount)
        end)
    end
    
    -- Подключение SelectClass
    if Remotes.SelectClass then
        Remotes.SelectClass.OnServerEvent:Connect(function(player, className)
            self:HandleSelectClass(player, className)
        end)
    end
    
    print("[GameController] Remote Events connected successfully!")
end

-- Обработка использования способности
function GameController:HandleUseAbility(player, abilityName)
    if not player or not player.Character then
        return
    end
    
    -- Проверка анти-чита
    if not AntiCheat:ValidateAction(player, "UseAbility", {abilityName = abilityName}) then
        self:NotifyPlayer(player, "Действие отклонено анти-читом", "error")
        return
    end
    
    -- Получение класса игрока
    local playerData = ProfileService:GetPlayerData(player)
    local className = playerData.selectedClass
    
    -- Вызов способности в зависимости от класса
    if className == "Warrior" then
        self:HandleWarriorAbility(player, abilityName)
    elseif className == "Engineer" then
        self:HandleEngineerAbility(player, abilityName)
    end
end

-- Обработка способностей воина
function GameController:HandleWarriorAbility(player, abilityName)
    local character = player.Character
    if not character then return end
    
    -- Импорт класса воина
    local Warrior = require(ServerScriptService.Systems.ClassSystem.Classes.Warrior)
    local warrior = Warrior.new(character)
    
    if abilityName == "taunt" then
        warrior:TauntEnemy()
    elseif abilityName == "whirlwind" then
        warrior:Whirlwind()
    elseif abilityName == "groundSlam" then
        warrior:GroundSlam()
    elseif abilityName == "banner" then
        warrior:PlantBanner()
    end
end

-- Обработка способностей инженера
function GameController:HandleEngineerAbility(player, abilityName)
    local character = player.Character
    if not character then return end
    
    -- Импорт класса инженера
    local Engineer = require(ServerScriptService.Systems.ClassSystem.Classes.Engineer)
    local engineer = Engineer.new(character)
    
    if abilityName == "repair" then
        engineer:RepairStructure()
    elseif abilityName == "shield" then
        engineer:DeployShield()
    elseif abilityName == "miniTurret" then
        engineer:DeployMiniTurret()
    elseif abilityName == "upgrade" then
        engineer:UpgradeStructure()
    end
end

-- Обработка строительства
function GameController:HandleBuildStructure(player, structureType, position)
    if not player or not position then
        return
    end
    
    -- Проверка анти-чита
    if not AntiCheat:ValidateAction(player, "BuildStructure", {structureType = structureType, position = position}) then
        self:NotifyPlayer(player, "Строительство отклонено анти-читом", "error")
        return
    end
    
    -- Попытка строительства
    local success, message = BuildManager:BuildStructure(player, structureType, position)
    
    if success then
        self:NotifyPlayer(player, message, "success")
    else
        self:NotifyPlayer(player, message, "error")
    end
end

-- Обработка сбора ресурсов
function GameController:HandleGatherResource(player, resourceType, amount)
    if not player or not resourceType then
        return
    end
    
    -- Проверка анти-чита
    if not AntiCheat:ValidateAction(player, "GatherResource", {resourceType = resourceType, amount = amount}) then
        self:NotifyPlayer(player, "Сбор ресурсов отклонен анти-читом", "error")
        return
    end
    
    -- Сбор ресурса (основная логика в ResourceManager)
    -- Эта функция может использоваться для дополнительных проверок
end

-- Обработка выбора класса
function GameController:HandleSelectClass(player, className)
    if not player or not className then
        return
    end
    
    -- Проверка доступности класса
    local playerData = ProfileService:GetPlayerData(player)
    local hasClass = false
    
    for _, unlockedClass in ipairs(playerData.unlockedClasses) do
        if unlockedClass == unlockedClass then
            hasClass = true
            break
        end
    end
    
    if not hasClass then
        self:NotifyPlayer(player, "Класс не разблокирован: " .. className, "error")
        return
    end
    
    -- Обновление выбранного класса
    ProfileService:UpdatePlayerData(player, {selectedClass = className})
    
    -- Обновление характеристик персонажа
    if player.Character then
        self:SetupCharacter(player, player.Character)
    end
    
    self:NotifyPlayer(player, "Класс изменен на: " .. className, "success")
end

-- Инициализация при загрузке
GameController:Initialize()

return GameController