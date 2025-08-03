-- GameController.lua
-- Главный контроллер игры Nexus Siege

local GameController = {}

-- Импорт систем
local WaveManager = require(ServerScriptService.Systems.WaveSystem.WaveManager)
local ResourceManager = require(ServerScriptService.Systems.ResourceSystem.ResourceManager)
local BuildManager = require(ServerScriptService.Systems.BuildingSystem.BuildManager)
local CombatManager = require(ServerScriptService.Systems.CombatSystem.CombatManager)
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
    WaveManager:Initialize()
    ResourceManager:Initialize()
    BuildManager:Initialize()
    CombatManager:Initialize()
    AntiCheat:Initialize()
    ProfileService:Initialize()
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
end

function GameController:InitializeSystems()
    -- Здесь будут инициализированы все системы
    -- WaveManager, ResourceManager, BuildingSystem и т.д.
    print("[GameController] Systems initialized")
end

function GameController:StartGameLoop()
    print("[GameController] Starting game loop...")
    
    -- Ожидание игроков
    while #Players:GetPlayers() < GameConstants.MIN_PLAYERS_TO_START do
        wait(1)
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
    if Remotes.UseAbility then
        Remotes.UseAbility.OnServerEvent:Connect(function(player, abilityNumber)
            print("[Remote] UseAbility from", player.Name, abilityNumber)
            -- TODO: Проверка класса, кулдауна, маны и вызов способности
        end)
    end
    if Remotes.BuildStructure then
        Remotes.BuildStructure.OnServerEvent:Connect(function(player, structureType, position)
            print("[Remote] BuildStructure from", player.Name, structureType, position)
            BuildManager:BuildStructure(player, structureType, position)
        end)
    end
    if Remotes.GatherResource then
        Remotes.GatherResource.OnServerEvent:Connect(function(player, resourceType, amount)
            print("[Remote] GatherResource from", player.Name, resourceType, amount)
            ResourceManager:GatherResource(player, resourceType, amount)
        end)
    end
    if Remotes.SelectClass then
        Remotes.SelectClass.OnServerEvent:Connect(function(player, className)
            print("[Remote] SelectClass from", player.Name, className)
            self:SetPlayerClass(player, className)
        end)
    end
end

-- Инициализация при загрузке
GameController:Initialize()

return GameController