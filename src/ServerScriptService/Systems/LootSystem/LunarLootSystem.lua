-- LunarLootSystem.lua
-- Система лута с луной и временными событиями

local LunarLootSystem = {}
LunarLootSystem.__index = LunarLootSystem

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local AdvancedLootManager = require(script.Parent.Parent.LootSystem.AdvancedLootManager)
local RareLootEvents = require(script.Parent.Parent.LootSystem.RareLootEvents)

-- Состояние
LunarLootSystem.lunarPhases = {}
LunarLootSystem.currentPhase = "full_moon"
LunarLootSystem.phaseTimer = 0
LunarLootSystem.temporaryEvents = {}
LunarLootSystem.activeTemporaryEvents = {}
LunarLootSystem.lunarEffects = {}

function LunarLootSystem:Initialize()
    print("[LunarLootSystem] Initializing lunar loot system...")
    
    self:InitializeLunarPhases()
    self:InitializeTemporaryEvents()
    self:InitializeLunarEffects()
    self:StartLunarCycle()
    
    print("[LunarLootSystem] Lunar loot system initialized!")
end

function LunarLootSystem:InitializeLunarPhases()
    self.lunarPhases = {
        new_moon = {
            name = "Новолуние",
            description = "Темная ночь, редкие твари становятся активнее",
            duration = 600, -- 10 минут
            effects = {
                rareEnemySpawnRate = 3.0, -- В 3 раза больше редких врагов
                lootMultiplier = 1.5,
                experienceMultiplier = 1.3,
                darkVision = true, -- Игроки видят в темноте
                shadowCreatures = true -- Появляются тени
            },
            lootBonus = {
                shadowEssence = {chance = 25, quantity = {1, 3}},
                darkCrystal = {chance = 15, quantity = {1, 2}},
                nightmareFragment = {chance = 5, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(20, 20, 40),
                ambientLight = 0.2,
                particleColor = Color3.fromRGB(100, 0, 200)
            }
        },
        
        waxing_crescent = {
            name = "Растущий серп",
            description = "Луна начинает расти, магия усиливается",
            duration = 600,
            effects = {
                magicPower = 1.5, -- Усиление магических способностей
                manaRegeneration = 2.0,
                spellDamage = 1.3,
                crystalGrowth = true -- Кристаллы растут быстрее
            },
            lootBonus = {
                magicEssence = {chance = 30, quantity = {2, 4}},
                growingCrystal = {chance = 20, quantity = {1, 3}},
                spellScroll = {chance = 10, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(40, 30, 60),
                ambientLight = 0.4,
                particleColor = Color3.fromRGB(150, 100, 255)
            }
        },
        
        first_quarter = {
            name = "Первая четверть",
            description = "Половина луны видна, баланс между светом и тьмой",
            duration = 600,
            effects = {
                balanceBonus = 1.2, -- Бонус к сбалансированным действиям
                hybridLoot = true, -- Смешанный лут
                dualElement = true -- Двойные стихии
            },
            lootBonus = {
                balanceEssence = {chance = 25, quantity = {1, 3}},
                hybridCrystal = {chance = 20, quantity = {1, 2}},
                dualScroll = {chance = 8, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(60, 50, 80),
                ambientLight = 0.6,
                particleColor = Color3.fromRGB(200, 150, 255)
            }
        },
        
        waxing_gibbous = {
            name = "Растущая луна",
            description = "Луна почти полная, силы добра усиливаются",
            duration = 600,
            effects = {
                holyPower = 1.4, -- Усиление святых способностей
                healingBonus = 1.5,
                lightDamage = 1.3,
                purification = true -- Очищение от негативных эффектов
            },
            lootBonus = {
                holyEssence = {chance = 30, quantity = {2, 4}},
                lightCrystal = {chance = 20, quantity = {1, 3}},
                healingScroll = {chance = 12, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(80, 70, 100),
                ambientLight = 0.8,
                particleColor = Color3.fromRGB(255, 200, 255)
            }
        },
        
        full_moon = {
            name = "Полнолуние",
            description = "Луна полная, все силы достигают пика",
            duration = 600,
            effects = {
                allMultipliers = 2.0, -- Все множители x2
                legendaryChance = 5.0, -- 5% шанс легендарных предметов
                rareEnemySpawnRate = 5.0, -- В 5 раз больше редких врагов
                moonBlessing = true, -- Благословение луны
                transformation = true -- Возможность трансформации
            },
            lootBonus = {
                moonEssence = {chance = 50, quantity = {3, 6}},
                legendaryFragment = {chance = 20, quantity = {1, 2}},
                moonCrystal = {chance = 30, quantity = {2, 4}},
                transformationScroll = {chance = 5, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(100, 90, 120),
                ambientLight = 1.0,
                particleColor = Color3.fromRGB(255, 255, 255)
            }
        },
        
        waning_gibbous = {
            name = "Убывающая луна",
            description = "Луна начинает убывать, силы ослабевают",
            duration = 600,
            effects = {
                powerDecay = 0.8, -- Ослабление сил
                reflection = true, -- Время размышлений
                wisdomBonus = 1.3 -- Бонус к мудрости
            },
            lootBonus = {
                wisdomEssence = {chance = 25, quantity = {1, 3}},
                reflectionCrystal = {chance = 15, quantity = {1, 2}},
                wisdomScroll = {chance = 10, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(80, 70, 100),
                ambientLight = 0.8,
                particleColor = Color3.fromRGB(255, 200, 255)
            }
        },
        
        last_quarter = {
            name = "Последняя четверть",
            description = "Половина луны скрыта, время перемен",
            duration = 600,
            effects = {
                changeBonus = 1.2, -- Бонус к переменам
                transformationChance = 1.5,
                evolution = true -- Эволюция предметов
            },
            lootBonus = {
                changeEssence = {chance = 20, quantity = {1, 3}},
                evolutionCrystal = {chance = 15, quantity = {1, 2}},
                evolutionScroll = {chance = 8, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(60, 50, 80),
                ambientLight = 0.6,
                particleColor = Color3.fromRGB(200, 150, 255)
            }
        },
        
        waning_crescent = {
            name = "Убывающий серп",
            description = "Луна почти невидима, время покоя",
            duration = 600,
            effects = {
                restBonus = 1.4, -- Бонус к отдыху
                meditation = true, -- Медитация
                innerPeace = true -- Внутренний покой
            },
            lootBonus = {
                peaceEssence = {chance = 25, quantity = {1, 3}},
                meditationCrystal = {chance = 20, quantity = {1, 2}},
                peaceScroll = {chance = 10, quantity = {1, 1}}
            },
            visualEffects = {
                skyColor = Color3.fromRGB(40, 30, 60),
                ambientLight = 0.4,
                particleColor = Color3.fromRGB(150, 100, 255)
            }
        }
    }
end

function LunarLootSystem:InitializeTemporaryEvents()
    self.temporaryEvents = {
        -- События, связанные с луной
        lunar_eclipse = {
            name = "Лунное затмение",
            description = "Луна скрыта тенью, темные силы усиливаются",
            duration = 300, -- 5 минут
            chance = 5, -- 5% шанс каждые 30 минут
            cooldown = 1800, -- 30 минут
            effects = {
                darkPower = 3.0, -- Темные силы x3
                shadowCreatures = true,
                nightmareRealm = true,
                legendaryChance = 10.0 -- 10% шанс легендарных предметов
            },
            rewards = {
                guaranteed = {
                    {itemId = "shadow_essence", minQuantity = 5, maxQuantity = 10, chance = 100},
                    {itemId = "nightmare_fragment", minQuantity = 2, maxQuantity = 5, chance = 100}
                },
                possible = {
                    {itemId = "dark_legendary", minQuantity = 1, maxQuantity = 1, chance = 15},
                    {itemId = "shadow_crystal", minQuantity = 3, maxQuantity = 8, chance = 50}
                }
            }
        },
        
        blood_moon = {
            name = "Кровавая луна",
            description = "Луна окрашена в красный цвет, кровожадные твари активны",
            duration = 240, -- 4 минуты
            chance = 3, -- 3% шанс каждые 45 минут
            cooldown = 2700, -- 45 минут
            effects = {
                bloodlust = 2.5, -- Кровожадность x2.5
                vampireCreatures = true,
                bloodMagic = true,
                lifeSteal = true
            },
            rewards = {
                guaranteed = {
                    {itemId = "blood_essence", minQuantity = 3, maxQuantity = 7, chance = 100},
                    {itemId = "vampire_fang", minQuantity = 1, maxQuantity = 3, chance = 100}
                },
                possible = {
                    {itemId = "blood_crystal", minQuantity = 2, maxQuantity = 5, chance = 40},
                    {itemId = "life_steal_scroll", minQuantity = 1, maxQuantity = 1, chance = 20}
                }
            }
        },
        
        blue_moon = {
            name = "Голубая луна",
            description = "Редкое явление, магическая сила достигает пика",
            duration = 180, -- 3 минуты
            chance = 2, -- 2% шанс каждые 60 минут
            cooldown = 3600, -- 60 минут
            effects = {
                magicPower = 4.0, -- Магическая сила x4
                spellMastery = true,
                arcaneKnowledge = true,
                legendaryChance = 20.0 -- 20% шанс легендарных предметов
            },
            rewards = {
                guaranteed = {
                    {itemId = "blue_essence", minQuantity = 5, maxQuantity = 10, chance = 100},
                    {itemId = "arcane_crystal", minQuantity = 3, maxQuantity = 6, chance = 100}
                },
                possible = {
                    {itemId = "legendary_spell", minQuantity = 1, maxQuantity = 1, chance = 25},
                    {itemId = "mastery_scroll", minQuantity = 1, maxQuantity = 1, chance = 30}
                }
            }
        },
        
        harvest_moon = {
            name = "Урожайная луна",
            description = "Луна благословляет урожай, ресурсы изобильны",
            duration = 360, -- 6 минут
            chance = 8, -- 8% шанс каждые 20 минут
            cooldown = 1200, -- 20 минут
            effects = {
                resourceMultiplier = 4.0, -- Ресурсы x4
                harvestBlessing = true,
                fertility = true,
                growthAcceleration = true
            },
            rewards = {
                guaranteed = {
                    {itemId = "harvest_essence", minQuantity = 4, maxQuantity = 8, chance = 100},
                    {itemId = "fertility_crystal", minQuantity = 2, maxQuantity = 4, chance = 100}
                },
                possible = {
                    {itemId = "growth_scroll", minQuantity = 1, maxQuantity = 2, chance = 35},
                    {itemId = "blessing_crystal", minQuantity = 3, maxQuantity = 6, chance = 45}
                }
            }
        }
    }
end

function LunarLootSystem:InitializeLunarEffects()
    self.lunarEffects = {
        -- Визуальные эффекты для разных фаз
        visualEffects = {
            new_moon = {
                skyColor = Color3.fromRGB(20, 20, 40),
                ambientLight = 0.2,
                particleColor = Color3.fromRGB(100, 0, 200),
                fogDensity = 0.8
            },
            full_moon = {
                skyColor = Color3.fromRGB(100, 90, 120),
                ambientLight = 1.0,
                particleColor = Color3.fromRGB(255, 255, 255),
                fogDensity = 0.1
            }
        },
        
        -- Звуковые эффекты
        soundEffects = {
            new_moon = "DarkAmbience",
            full_moon = "BrightAmbience",
            lunar_eclipse = "EclipseSound",
            blood_moon = "BloodMoonSound"
        }
    }
end

function LunarLootSystem:StartLunarCycle()
    task.spawn(function()
        while true do
            self:UpdateLunarPhase()
            self:CheckTemporaryEvents()
            task.wait(60) -- Обновление каждую минуту
        end
    end)
end

function LunarLootSystem:UpdateLunarPhase()
    local currentTime = os.time()
    local phaseDuration = 600 -- 10 минут на фазу
    local totalPhases = 8
    
    local phaseIndex = math.floor((currentTime % (phaseDuration * totalPhases)) / phaseDuration) + 1
    local phaseNames = {"new_moon", "waxing_crescent", "first_quarter", "waxing_gibbous", 
                       "full_moon", "waning_gibbous", "last_quarter", "waning_crescent"}
    
    local newPhase = phaseNames[phaseIndex]
    
    if newPhase ~= self.currentPhase then
        self:ChangeLunarPhase(newPhase)
    end
end

function LunarLootSystem:ChangeLunarPhase(phaseName)
    print("[LunarLootSystem] Changing lunar phase to:", phaseName)
    
    local phaseData = self.lunarPhases[phaseName]
    if not phaseData then return end
    
    self.currentPhase = phaseName
    
    -- Уведомление всех игроков
    self:NotifyAllPlayers(phaseData.name, phaseData.description, "lunar", 5)
    
    -- Применение эффектов фазы
    self:ApplyLunarPhaseEffects(phaseData)
    
    -- Изменение визуальных эффектов
    self:ApplyVisualEffects(phaseData.visualEffects)
end

function LunarLootSystem:ApplyLunarPhaseEffects(phaseData)
    -- Применение множителей
    if phaseData.effects.lootMultiplier then
        AdvancedLootManager.lootMultiplier = phaseData.effects.lootMultiplier
    end
    
    if phaseData.effects.experienceMultiplier then
        -- Интеграция с ProgressionManager
    end
    
    if phaseData.effects.allMultipliers then
        AdvancedLootManager.lootMultiplier = phaseData.effects.allMultipliers
        -- Применение других множителей
    end
    
    -- Специальные эффекты
    if phaseData.effects.rareEnemySpawnRate then
        -- Увеличение спавна редких врагов
    end
    
    if phaseData.effects.legendaryChance then
        AdvancedLootManager.legendaryChance = phaseData.effects.legendaryChance
    end
end

function LunarLootSystem:ApplyVisualEffects(visualEffects)
    -- Изменение цвета неба
    local lighting = game.Lighting
    if visualEffects.skyColor then
        lighting.Ambient = visualEffects.skyColor
    end
    
    if visualEffects.ambientLight then
        lighting.Brightness = visualEffects.ambientLight
    end
    
    -- Создание частиц в небе
    self:CreateLunarParticles(visualEffects.particleColor)
end

function LunarLootSystem:CreateLunarParticles(particleColor)
    -- Удаление старых частиц
    local existingParticles = workspace:FindFirstChild("LunarParticles")
    if existingParticles then
        existingParticles:Destroy()
    end
    
    -- Создание новых частиц
    local particleContainer = Instance.new("Part")
    particleContainer.Name = "LunarParticles"
    particleContainer.Size = Vector3.new(0.1, 0.1, 0.1)
    particleContainer.Position = Vector3.new(0, 100, 0)
    particleContainer.Anchored = true
    particleContainer.CanCollide = false
    particleContainer.Transparency = 1
    particleContainer.Parent = workspace
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(particleColor)
    particleEmitter.Size = NumberSequence.new(1, 0)
    particleEmitter.Speed = NumberRange.new(5, 15)
    particleEmitter.Rate = 20
    particleEmitter.Lifetime = NumberRange.new(3, 6)
    particleEmitter.SpreadAngle = Vector2.new(180, 180)
    particleEmitter.Parent = particleContainer
end

function LunarLootSystem:CheckTemporaryEvents()
    local currentTime = os.time()
    
    for eventName, eventData in pairs(self.temporaryEvents) do
        local lastTrigger = self.eventTimers[eventName] or 0
        
        if currentTime - lastTrigger >= eventData.cooldown then
            if math.random(1, 100) <= eventData.chance then
                self:TriggerTemporaryEvent(eventName, eventData)
                self.eventTimers[eventName] = currentTime
            end
        end
    end
end

function LunarLootSystem:TriggerTemporaryEvent(eventName, eventData)
    print("[LunarLootSystem] Triggering temporary event:", eventName)
    
    -- Уведомление всех игроков
    self:NotifyAllPlayers(eventData.name, eventData.description, "lunar_event", 5)
    
    -- Активация события
    self.activeTemporaryEvents[eventName] = {
        data = eventData,
        startTime = os.time(),
        endTime = os.time() + eventData.duration,
        active = true
    }
    
    -- Применение эффектов события
    self:ApplyTemporaryEventEffects(eventData)
    
    -- Запуск таймера окончания
    task.spawn(function()
        task.wait(eventData.duration)
        self:EndTemporaryEvent(eventName, eventData)
    end)
end

function LunarLootSystem:ApplyTemporaryEventEffects(eventData)
    -- Применение эффектов в зависимости от типа события
    if eventData.effects.darkPower then
        AdvancedLootManager.lootMultiplier = eventData.effects.darkPower
    end
    
    if eventData.effects.magicPower then
        -- Применение магических эффектов
    end
    
    if eventData.effects.bloodlust then
        -- Применение эффектов кровожадности
    end
    
    if eventData.effects.resourceMultiplier then
        -- Применение множителя ресурсов
    end
    
    if eventData.effects.legendaryChance then
        AdvancedLootManager.legendaryChance = eventData.effects.legendaryChance
    end
end

function LunarLootSystem:EndTemporaryEvent(eventName, eventData)
    print("[LunarLootSystem] Ending temporary event:", eventName)
    
    -- Уведомление всех игроков
    self:NotifyAllPlayers(eventData.name .. " завершено!", "Лунное событие закончилось", "info", 3)
    
    -- Деактивация события
    self.activeTemporaryEvents[eventName] = nil
    
    -- Сброс эффектов события
    self:ResetTemporaryEventEffects()
    
    -- Выдача наград
    self:GiveTemporaryEventRewards(eventData.rewards)
end

function LunarLootSystem:ResetTemporaryEventEffects()
    -- Сброс всех временных эффектов
    AdvancedLootManager.lootMultiplier = 1.0
    AdvancedLootManager.legendaryChance = 0.5
end

function LunarLootSystem:GiveTemporaryEventRewards(rewards)
    for _, player in pairs(game.Players:GetPlayers()) do
        local playerLoot = {}
        
        -- Генерация гарантированных наград
        if rewards.guaranteed then
            for _, item in pairs(rewards.guaranteed) do
                if math.random(1, 100) <= item.chance then
                    local quantity = math.random(item.minQuantity, item.maxQuantity)
                    table.insert(playerLoot, {
                        itemId = item.itemId,
                        quantity = quantity,
                        quality = "lunar"
                    })
                end
            end
        end
        
        -- Генерация возможных наград
        if rewards.possible then
            for _, item in pairs(rewards.possible) do
                if math.random(1, 100) <= item.chance then
                    local quantity = math.random(item.minQuantity, item.maxQuantity)
                    table.insert(playerLoot, {
                        itemId = item.itemId,
                        quantity = quantity,
                        quality = "lunar"
                    })
                end
            end
        end
        
        -- Выдача наград игроку
        if #playerLoot > 0 then
            AdvancedLootManager:CreatePhysicalLootWithEffects(playerLoot, player.Character.HumanoidRootPart.Position)
            self:NotifyPlayer(player, "Получены лунные награды!", "lunar_reward", 3)
        end
    end
end

function LunarLootSystem:GenerateLunarLoot(player, baseLoot)
    local currentPhaseData = self.lunarPhases[self.currentPhase]
    if not currentPhaseData then return baseLoot end
    
    local lunarLoot = baseLoot or {}
    
    -- Добавление лунных бонусов
    for itemId, bonusData in pairs(currentPhaseData.lootBonus) do
        if math.random(1, 100) <= bonusData.chance then
            local quantity = math.random(bonusData.quantity[1], bonusData.quantity[2])
            table.insert(lunarLoot, {
                itemId = itemId,
                quantity = quantity,
                quality = "lunar",
                lunarPhase = self.currentPhase
            })
        end
    end
    
    return lunarLoot
end

function LunarLootSystem:GetCurrentPhase()
    return self.currentPhase, self.lunarPhases[self.currentPhase]
end

function LunarLootSystem:GetActiveTemporaryEvents()
    return self.activeTemporaryEvents
end

function LunarLootSystem:GetLunarPhaseData(phaseName)
    return self.lunarPhases[phaseName]
end

function LunarLootSystem:GetTemporaryEventData(eventName)
    return self.temporaryEvents[eventName]
end

function LunarLootSystem:NotifyAllPlayers(title, message, type, duration)
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    
    for _, player in pairs(game.Players:GetPlayers()) do
        showNotification:FireClient(player, title, type, duration)
    end
end

function LunarLootSystem:NotifyPlayer(player, message, type, duration)
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, type, duration)
end

return LunarLootSystem