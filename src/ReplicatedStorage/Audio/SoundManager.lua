-- SoundManager.lua
-- Полная система управления звуками и музыкой

local SoundManager = {}
SoundManager.__index = SoundManager

-- Импорт зависимостей
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")

-- Состояние
SoundManager.sounds = {}
SoundManager.music = {}
SoundManager.currentMusic = nil
SoundManager.volume = 0.5
SoundManager.musicVolume = 0.3
SoundManager.soundEnabled = true
SoundManager.musicEnabled = true

function SoundManager:Initialize()
    print("[SoundManager] Initializing sound system...")
    
    -- Создание звуковых эффектов
    self:CreateSoundEffects()
    
    -- Создание музыкальных треков
    self:CreateMusicTracks()
    
    -- Настройка громкости
    self:SetVolume(self.volume)
    self:SetMusicVolume(self.musicVolume)
    
    print("[SoundManager] Sound system initialized!")
end

-- Создание звуковых эффектов
function SoundManager:CreateSoundEffects()
    self.sounds = {
        -- Боевые звуки
        combat = {
            attack = self:CreateSound("Attack", 0.6),
            hit = self:CreateSound("Hit", 0.5),
            crit = self:CreateSound("Crit", 0.7),
            block = self:CreateSound("Block", 0.4),
            dodge = self:CreateSound("Dodge", 0.3)
        },
        
        -- Звуки строительства
        building = {
            build = self:CreateSound("Build", 0.5),
            demolish = self:CreateSound("Demolish", 0.6),
            upgrade = self:CreateSound("Upgrade", 0.4),
            repair = self:CreateSound("Repair", 0.3)
        },
        
        -- Звуки ресурсов
        resources = {
            gather = self:CreateSound("Gather", 0.4),
            collect = self:CreateSound("Collect", 0.3),
            mine = self:CreateSound("Mine", 0.5),
            chop = self:CreateSound("Chop", 0.4)
        },
        
        -- Звуки способностей
        abilities = {
            warrior_attack = self:CreateSound("WarriorAttack", 0.7),
            warrior_defend = self:CreateSound("WarriorDefend", 0.5),
            engineer_build = self:CreateSound("EngineerBuild", 0.6),
            engineer_turret = self:CreateSound("EngineerTurret", 0.5),
            heal = self:CreateSound("Heal", 0.4),
            ultimate = self:CreateSound("Ultimate", 0.8)
        },
        
        -- Звуки UI
        ui = {
            button_click = self:CreateSound("ButtonClick", 0.3),
            menu_open = self:CreateSound("MenuOpen", 0.4),
            menu_close = self:CreateSound("MenuClose", 0.3),
            notification = self:CreateSound("Notification", 0.4),
            achievement = self:CreateSound("Achievement", 0.6)
        },
        
        -- Звуки окружения
        environment = {
            wind = self:CreateSound("Wind", 0.2, true),
            fire = self:CreateSound("Fire", 0.3, true),
            water = self:CreateSound("Water", 0.2, true),
            footsteps = self:CreateSound("Footsteps", 0.4)
        },
        
        -- Звуки врагов
        enemies = {
            spawn = self:CreateSound("EnemySpawn", 0.5),
            death = self:CreateSound("EnemyDeath", 0.6),
            attack = self:CreateSound("EnemyAttack", 0.5),
            roar = self:CreateSound("EnemyRoar", 0.7)
        },
        
        -- Звуки волн
        waves = {
            wave_start = self:CreateSound("WaveStart", 0.8),
            wave_end = self:CreateSound("WaveEnd", 0.7),
            wave_victory = self:CreateSound("WaveVictory", 0.9),
            wave_defeat = self:CreateSound("WaveDefeat", 0.6)
        }
    }
end

-- Создание музыкальных треков
function SoundManager:CreateMusicTracks()
    self.music = {
        -- Основная музыка
        main_theme = self:CreateMusic("MainTheme", 0.4, true),
        battle_music = self:CreateMusic("BattleMusic", 0.5, true),
        victory_music = self:CreateMusic("VictoryMusic", 0.6, false),
        defeat_music = self:CreateMusic("DefeatMusic", 0.4, false),
        
        -- Музыка для разных ситуаций
        menu_music = self:CreateMusic("MenuMusic", 0.3, true),
        building_music = self:CreateMusic("BuildingMusic", 0.3, true),
        exploration_music = self:CreateMusic("ExplorationMusic", 0.3, true),
        
        -- Интенсивная музыка
        boss_music = self:CreateMusic("BossMusic", 0.7, true),
        final_wave_music = self:CreateMusic("FinalWaveMusic", 0.8, true)
    }
end

-- Создание звука
function SoundManager:CreateSound(name, volume, looped)
    local sound = Instance.new("Sound")
    sound.Name = name
    sound.Volume = volume or 0.5
    sound.Looped = looped or false
    sound.Parent = SoundService
    
    -- Здесь можно добавить реальные звуковые файлы
    -- sound.SoundId = "rbxassetid://..."
    
    return sound
end

-- Создание музыки
function SoundManager:CreateMusic(name, volume, looped)
    local music = Instance.new("Sound")
    music.Name = name
    music.Volume = volume or 0.3
    music.Looped = looped or true
    music.Parent = SoundService
    
    -- Здесь можно добавить реальные музыкальные файлы
    -- music.SoundId = "rbxassetid://..."
    
    return music
end

-- Воспроизведение звука
function SoundManager:PlaySound(category, soundName, position)
    if not self.soundEnabled then return end
    
    local sound = self.sounds[category] and self.sounds[category][soundName]
    if not sound then
        warn("[SoundManager] Sound not found:", category, soundName)
        return
    end
    
    -- Создание копии звука для позиционного воспроизведения
    if position then
        local soundClone = sound:Clone()
        soundClone.Position = position
        soundClone.Parent = workspace
        soundClone:Play()
        
        -- Удаление после воспроизведения
        soundClone.Ended:Connect(function()
            soundClone:Destroy()
        end)
    else
        sound:Play()
    end
end

-- Воспроизведение музыки
function SoundManager:PlayMusic(musicName, fadeIn)
    if not self.musicEnabled then return end
    
    local music = self.music[musicName]
    if not music then
        warn("[SoundManager] Music not found:", musicName)
        return
    end
    
    -- Остановка текущей музыки
    if self.currentMusic and self.currentMusic ~= music then
        self:StopMusic(fadeIn)
    end
    
    self.currentMusic = music
    
    if fadeIn then
        music.Volume = 0
        music:Play()
        
        local tween = TweenService:Create(music, TweenInfo.new(fadeIn), {
            Volume = self.musicVolume
        })
        tween:Play()
    else
        music:Play()
    end
end

-- Остановка музыки
function SoundManager:StopMusic(fadeOut)
    if not self.currentMusic then return end
    
    if fadeOut then
        local tween = TweenService:Create(self.currentMusic, TweenInfo.new(fadeOut), {
            Volume = 0
        })
        tween:Play()
        
        tween.Completed:Connect(function()
            self.currentMusic:Stop()
            self.currentMusic.Volume = self.musicVolume
            self.currentMusic = nil
        end)
    else
        self.currentMusic:Stop()
        self.currentMusic = nil
    end
end

-- Пауза музыки
function SoundManager:PauseMusic()
    if self.currentMusic then
        self.currentMusic:Pause()
    end
end

-- Возобновление музыки
function SoundManager:ResumeMusic()
    if self.currentMusic then
        self.currentMusic:Resume()
    end
end

-- Установка громкости звуков
function SoundManager:SetVolume(volume)
    self.volume = math.clamp(volume, 0, 1)
    
    for category, sounds in pairs(self.sounds) do
        for _, sound in pairs(sounds) do
            sound.Volume = sound.Volume * self.volume
        end
    end
end

-- Установка громкости музыки
function SoundManager:SetMusicVolume(volume)
    self.musicVolume = math.clamp(volume, 0, 1)
    
    for _, music in pairs(self.music) do
        music.Volume = music.Volume * self.musicVolume
    end
    
    if self.currentMusic then
        self.currentMusic.Volume = self.musicVolume
    end
end

-- Включение/выключение звуков
function SoundManager:SetSoundEnabled(enabled)
    self.soundEnabled = enabled
    
    if not enabled then
        -- Остановка всех звуков
        for category, sounds in pairs(self.sounds) do
            for _, sound in pairs(sounds) do
                sound:Stop()
            end
        end
    end
end

-- Включение/выключение музыки
function SoundManager:SetMusicEnabled(enabled)
    self.musicEnabled = enabled
    
    if not enabled then
        self:StopMusic()
    end
end

-- Воспроизведение боевых звуков
function SoundManager:PlayCombatSound(soundName, position)
    self:PlaySound("combat", soundName, position)
end

-- Воспроизведение звуков строительства
function SoundManager:PlayBuildingSound(soundName, position)
    self:PlaySound("building", soundName, position)
end

-- Воспроизведение звуков ресурсов
function SoundManager:PlayResourceSound(soundName, position)
    self:PlaySound("resources", soundName, position)
end

-- Воспроизведение звуков способностей
function SoundManager:PlayAbilitySound(soundName, position)
    self:PlaySound("abilities", soundName, position)
end

-- Воспроизведение звуков UI
function SoundManager:PlayUISound(soundName)
    self:PlaySound("ui", soundName)
end

-- Воспроизведение звуков окружения
function SoundManager:PlayEnvironmentSound(soundName, position)
    self:PlaySound("environment", soundName, position)
end

-- Воспроизведение звуков врагов
function SoundManager:PlayEnemySound(soundName, position)
    self:PlaySound("enemies", soundName, position)
end

-- Воспроизведение звуков волн
function SoundManager:PlayWaveSound(soundName)
    self:PlaySound("waves", soundName)
end

-- Создание позиционного звука
function SoundManager:CreatePositionalSound(soundName, position, volume, maxDistance)
    if not self.soundEnabled then return end
    
    local sound = Instance.new("Sound")
    sound.Name = soundName
    sound.Volume = volume or 0.5
    sound.Position = position
    sound.MaxDistance = maxDistance or 100
    sound.Parent = workspace
    
    -- Здесь можно добавить реальные звуковые файлы
    -- sound.SoundId = "rbxassetid://..."
    
    sound:Play()
    
    sound.Ended:Connect(function()
        sound:Destroy()
    end)
    
    return sound
end

-- Создание звукового эффекта с задержкой
function SoundManager:PlayDelayedSound(category, soundName, delay, position)
    task.wait(delay)
    self:PlaySound(category, soundName, position)
end

-- Создание последовательности звуков
function SoundManager:PlaySoundSequence(sounds, delays)
    for i, soundData in ipairs(sounds) do
        local delay = delays and delays[i] or 0
        self:PlayDelayedSound(soundData.category, soundData.name, delay, soundData.position)
    end
end

-- Создание случайного звука из категории
function SoundManager:PlayRandomSound(category, position)
    if not self.sounds[category] then return end
    
    local soundNames = {}
    for soundName, _ in pairs(self.sounds[category]) do
        table.insert(soundNames, soundName)
    end
    
    if #soundNames > 0 then
        local randomSound = soundNames[math.random(1, #soundNames)]
        self:PlaySound(category, randomSound, position)
    end
end

-- Создание звукового эффекта с изменением высоты
function SoundManager:PlaySoundWithPitch(category, soundName, pitch, position)
    if not self.soundEnabled then return end
    
    local sound = self.sounds[category] and self.sounds[category][soundName]
    if not sound then return end
    
    local soundClone = sound:Clone()
    soundClone.PlaybackSpeed = pitch or 1
    soundClone.Position = position
    soundClone.Parent = workspace
    soundClone:Play()
    
    soundClone.Ended:Connect(function()
        soundClone:Destroy()
    end)
end

-- Создание звукового эффекта с фильтрами
function SoundManager:PlaySoundWithFilter(category, soundName, filterType, position)
    if not self.soundEnabled then return end
    
    local sound = self.sounds[category] and self.sounds[category][soundName]
    if not sound then return end
    
    local soundClone = sound:Clone()
    soundClone.Position = position
    soundClone.Parent = workspace
    
    -- Применение фильтра
    if filterType == "lowpass" then
        local lowpass = Instance.new("LowpassSoundEffect")
        lowpass.Frequency = 1000
        lowpass.Parent = soundClone
    elseif filterType == "highpass" then
        local highpass = Instance.new("HighpassSoundEffect")
        highpass.Frequency = 1000
        highpass.Parent = soundClone
    elseif filterType == "reverb" then
        local reverb = Instance.new("ReverbSoundEffect")
        reverb.DecayTime = 1
        reverb.Parent = soundClone
    end
    
    soundClone:Play()
    
    soundClone.Ended:Connect(function()
        soundClone:Destroy()
    end)
end

-- Получение информации о звуке
function SoundManager:GetSoundInfo(category, soundName)
    local sound = self.sounds[category] and self.sounds[category][soundName]
    if not sound then return nil end
    
    return {
        name = sound.Name,
        volume = sound.Volume,
        looped = sound.Looped,
        playing = sound.IsPlaying,
        timePosition = sound.TimePosition,
        duration = sound.TimeLength
    }
end

-- Получение информации о музыке
function SoundManager:GetMusicInfo(musicName)
    local music = self.music[musicName]
    if not music then return nil end
    
    return {
        name = music.Name,
        volume = music.Volume,
        looped = music.Looped,
        playing = music.IsPlaying,
        timePosition = music.TimePosition,
        duration = music.TimeLength
    }
end

-- Получение списка всех звуков
function SoundManager:GetAllSounds()
    local allSounds = {}
    
    for category, sounds in pairs(self.sounds) do
        allSounds[category] = {}
        for soundName, sound in pairs(sounds) do
            table.insert(allSounds[category], {
                name = soundName,
                volume = sound.Volume,
                looped = sound.Looped
            })
        end
    end
    
    return allSounds
end

-- Получение списка всей музыки
function SoundManager:GetAllMusic()
    local allMusic = {}
    
    for musicName, music in pairs(self.music) do
        table.insert(allMusic, {
            name = musicName,
            volume = music.Volume,
            looped = music.Looped,
            playing = music.IsPlaying
        })
    end
    
    return allMusic
end

-- Очистка всех звуков
function SoundManager:StopAllSounds()
    for category, sounds in pairs(self.sounds) do
        for _, sound in pairs(sounds) do
            sound:Stop()
        end
    end
end

-- Очистка системы звуков
function SoundManager:Cleanup()
    -- Остановка всех звуков
    self:StopAllSounds()
    
    -- Остановка музыки
    self:StopMusic()
    
    -- Удаление звуков
    for category, sounds in pairs(self.sounds) do
        for _, sound in pairs(sounds) do
            if sound and sound.Parent then
                sound:Destroy()
            end
        end
    end
    
    -- Удаление музыки
    for _, music in pairs(self.music) do
        if music and music.Parent then
            music:Destroy()
        end
    end
    
    self.sounds = {}
    self.music = {}
    self.currentMusic = nil
end

return SoundManager