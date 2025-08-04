-- RareLootEvents.lua
-- Система случайных событий и редких дропов

local RareLootEvents = {}
RareLootEvents.__index = RareLootEvents

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local AdvancedLootManager = require(script.Parent.Parent.LootSystem.AdvancedLootManager)
local SpecificEnemyManager = require(script.Parent.Parent.EnemySystem.SpecificEnemyManager)

-- Состояние
RareLootEvents.rareEvents = {}
RareLootEvents.activeEvents = {}
RareLootEvents.eventTimers = {}
RareLootEvents.rareDrops = {}

function RareLootEvents:Initialize()
    print("[RareLootEvents] Initializing rare loot events system...")
    
    self:InitializeRareEvents()
    self:InitializeRareDrops()
    self:StartEventScheduler()
    
    print("[RareLootEvents] Rare loot events system initialized!")
end

function RareLootEvents:InitializeRareEvents()
    self.rareEvents = {
        -- События с редкими врагами
        rare_enemy_spawn = {
            name = "Появление редкого врага",
            description = "В мире появился редкий враг!",
            duration = 300, -- 5 минут
            chance = 15, -- 15% шанс каждые 10 минут
            cooldown = 600, -- 10 минут
            effects = {
                spawnRareEnemy = true,
                lootMultiplier = 2.0,
                experienceMultiplier = 1.5
            },
            rewards = {
                guaranteed = {
                    {itemId = "rare_essence", minQuantity = 1, maxQuantity = 3, chance = 100},
                    {itemId = "gems", minQuantity = 5, maxQuantity = 15, chance = 100}
                },
                possible = {
                    {itemId = "legendary_fragment", minQuantity = 1, maxQuantity = 1, chance = 25},
                    {itemId = "mystery_box", minQuantity = 1, maxQuantity = 1, chance = 50}
                }
            }
        },
        
        -- События с сокровищами
        treasure_hunt = {
            name = "Охота за сокровищами",
            description = "Появились загадочные сундуки с сокровищами!",
            duration = 180, -- 3 минуты
            chance = 20, -- 20% шанс каждые 8 минут
            cooldown = 480, -- 8 минут
            effects = {
                spawnTreasureChests = true,
                chestCount = 5,
                lootMultiplier = 1.8,
                goldMultiplier = 2.0
            },
            rewards = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 100, maxQuantity = 300, chance = 100},
                    {itemId = "treasure_map", minQuantity = 1, maxQuantity = 1, chance = 100}
                },
                possible = {
                    {itemId = "ancient_coin", minQuantity = 1, maxQuantity = 5, chance = 40},
                    {itemId = "crystal", minQuantity = 3, maxQuantity = 8, chance = 60}
                }
            }
        },
        
        -- События с ресурсами
        resource_boom = {
            name = "Бум ресурсов",
            description = "Ресурсные ноды дают больше ресурсов!",
            duration = 240, -- 4 минуты
            chance = 25, -- 25% шанс каждые 6 минут
            cooldown = 360, -- 6 минут
            effects = {
                resourceMultiplier = 3.0,
                resourceRespawnTime = 0.5, -- Быстрое возрождение
                rareResourceChance = 50 -- 50% шанс редких ресурсов
            },
            rewards = {
                guaranteed = {
                    {itemId = "resource_boost", minQuantity = 1, maxQuantity = 2, chance = 100}
                },
                possible = {
                    {itemId = "crystal", minQuantity = 2, maxQuantity = 5, chance = 70},
                    {itemId = "gems", minQuantity = 2, maxQuantity = 8, chance = 30}
                }
            }
        },
        
        -- События с опытом
        experience_bonanza = {
            name = "Бонус опыта",
            description = "Получайте в 2 раза больше опыта!",
            duration = 300, -- 5 минут
            chance = 18, -- 18% шанс каждые 12 минут
            cooldown = 720, -- 12 минут
            effects = {
                experienceMultiplier = 2.0,
                skillPointChance = 25, -- 25% шанс получить очки навыков
                levelUpBonus = true
            },
            rewards = {
                guaranteed = {
                    {itemId = "experience_potion", minQuantity = 2, maxQuantity = 5, chance = 100}
                },
                possible = {
                    {itemId = "skill_point", minQuantity = 1, maxQuantity = 2, chance = 30},
                    {itemId = "level_up_scroll", minQuantity = 1, maxQuantity = 1, chance = 15}
                }
            }
        },
        
        -- События с золотом
        gold_rush = {
            name = "Золотая лихорадка",
            description = "Все враги дают больше золота!",
            duration = 200, -- 3.3 минуты
            chance = 22, -- 22% шанс каждые 10 минут
            cooldown = 600, -- 10 минут
            effects = {
                goldMultiplier = 3.0,
                goldDropChance = 100, -- 100% шанс дропа золота
                rareGoldChance = 20 -- 20% шанс редкого золота
            },
            rewards = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 200, maxQuantity = 500, chance = 100},
                    {itemId = "gold_boost", minQuantity = 1, maxQuantity = 1, chance = 100}
                },
                possible = {
                    {itemId = "gold_bar", minQuantity = 1, maxQuantity = 3, chance = 25},
                    {itemId = "gems", minQuantity = 3, maxQuantity = 10, chance = 40}
                }
            }
        },
        
        -- События с легендарными предметами
        legendary_hunt = {
            name = "Охота за легендарными предметами",
            description = "Шанс получить легендарные предметы увеличен!",
            duration = 180, -- 3 минуты
            chance = 8, -- 8% шанс каждые 15 минут
            cooldown = 900, -- 15 минут
            effects = {
                legendaryChance = 10, -- 10% шанс легендарных предметов
                epicChance = 25, -- 25% шанс эпических предметов
                rareChance = 50 -- 50% шанс редких предметов
            },
            rewards = {
                guaranteed = {
                    {itemId = "legendary_scroll", minQuantity = 1, maxQuantity = 1, chance = 100}
                },
                possible = {
                    {itemId = "legendary_fragment", minQuantity = 2, maxQuantity = 5, chance = 60},
                    {itemId = "epic_essence", minQuantity = 3, maxQuantity = 8, chance = 80}
                }
            }
        }
    }
end

function RareLootEvents:InitializeRareDrops()
    self.rareDrops = {
        -- Редкие дропы с обычных врагов
        common_rare_drops = {
            legendary_sword = {
                name = "Легендарный меч",
                chance = 0.1, -- 0.1% шанс
                rarity = "legendary",
                effects = {
                    damage = 100,
                    criticalChance = 25,
                    specialAbility = "legendary_strike"
                }
            },
            ancient_coin = {
                name = "Древняя монета",
                chance = 1.0, -- 1% шанс
                rarity = "rare",
                effects = {
                    goldValue = 1000,
                    collectionBonus = true
                }
            },
            mystery_box = {
                name = "Таинственная коробка",
                chance = 2.0, -- 2% шанс
                rarity = "rare",
                effects = {
                    randomReward = true,
                    guaranteedRare = true
                }
            }
        },
        
        -- Редкие дропы с элитных врагов
        elite_rare_drops = {
            dragon_scale = {
                name = "Чешуя дракона",
                chance = 5.0, -- 5% шанс
                rarity = "epic",
                effects = {
                    armor = 50,
                    fireResistance = true
                }
            },
            crystal_heart = {
                name = "Кристальное сердце",
                chance = 3.0, -- 3% шанс
                rarity = "epic",
                effects = {
                    manaRegeneration = 10,
                    spellPower = 25
                }
            },
            berserker_rage = {
                name = "Ярость берсерка",
                chance = 4.0, -- 4% шанс
                rarity = "epic",
                effects = {
                    damageBonus = 50,
                    speedBonus = 20
                }
            }
        },
        
        -- Редкие дропы с боссов
        boss_rare_drops = {
            crown_of_kings = {
                name = "Корона королей",
                chance = 10.0, -- 10% шанс
                rarity = "legendary",
                effects = {
                    allStats = 25,
                    leadership = true,
                    royalAura = true
                }
            },
            dragon_essence = {
                name = "Сущность дракона",
                chance = 15.0, -- 15% шанс
                rarity = "legendary",
                effects = {
                    fireBreath = true,
                    dragonForm = true,
                    elementalResistance = 50
                }
            },
            ancient_relic = {
                name = "Древняя реликвия",
                chance = 8.0, -- 8% шанс
                rarity = "legendary",
                effects = {
                    timeManipulation = true,
                    realityBend = true,
                    infinitePower = true
                }
            }
        }
    }
end

function RareLootEvents:StartEventScheduler()
    task.spawn(function()
        while true do
            self:CheckAndTriggerEvents()
            task.wait(60) -- Проверка каждую минуту
        end
    end)
end

function RareLootEvents:CheckAndTriggerEvents()
    local currentTime = os.time()
    
    for eventName, eventData in pairs(self.rareEvents) do
        local lastTrigger = self.eventTimers[eventName] or 0
        
        if currentTime - lastTrigger >= eventData.cooldown then
            if math.random(1, 100) <= eventData.chance then
                self:TriggerEvent(eventName, eventData)
                self.eventTimers[eventName] = currentTime
            end
        end
    end
end

function RareLootEvents:TriggerEvent(eventName, eventData)
    print("[RareLootEvents] Triggering event:", eventName)
    
    -- Уведомление всех игроков
    self:NotifyAllPlayers(eventData.name, eventData.description, "event", 5)
    
    -- Активация эффектов события
    self.activeEvents[eventName] = {
        data = eventData,
        startTime = os.time(),
        endTime = os.time() + eventData.duration,
        active = true
    }
    
    -- Применение эффектов события
    self:ApplyEventEffects(eventName, eventData)
    
    -- Запуск таймера окончания события
    task.spawn(function()
        task.wait(eventData.duration)
        self:EndEvent(eventName, eventData)
    end)
end

function RareLootEvents:ApplyEventEffects(eventName, eventData)
    if eventData.effects.spawnRareEnemy then
        self:SpawnRareEnemy()
    end
    
    if eventData.effects.spawnTreasureChests then
        self:SpawnTreasureChests(eventData.effects.chestCount or 3)
    end
    
    -- Применение множителей
    if eventData.effects.lootMultiplier then
        self:SetLootMultiplier(eventData.effects.lootMultiplier)
    end
    
    if eventData.effects.experienceMultiplier then
        self:SetExperienceMultiplier(eventData.effects.experienceMultiplier)
    end
    
    if eventData.effects.goldMultiplier then
        self:SetGoldMultiplier(eventData.effects.goldMultiplier)
    end
    
    if eventData.effects.resourceMultiplier then
        self:SetResourceMultiplier(eventData.effects.resourceMultiplier)
    end
end

function RareLootEvents:EndEvent(eventName, eventData)
    print("[RareLootEvents] Ending event:", eventName)
    
    -- Уведомление всех игроков
    self:NotifyAllPlayers(eventData.name .. " завершено!", "Событие закончилось", "info", 3)
    
    -- Деактивация эффектов события
    self.activeEvents[eventName] = nil
    
    -- Сброс множителей
    self:ResetMultipliers()
    
    -- Выдача наград всем активным игрокам
    self:GiveEventRewards(eventData.rewards)
end

function RareLootEvents:SpawnRareEnemy()
    local rareEnemyTypes = {"goblin_king", "dragon"}
    local enemyType = rareEnemyTypes[math.random(1, #rareEnemyTypes)]
    
    -- Случайная позиция на карте
    local spawnPosition = Vector3.new(
        math.random(-100, 100),
        5,
        math.random(-100, 100)
    )
    
    local enemy = SpecificEnemyManager:CreateSpecificEnemy(enemyType, spawnPosition)
    
    if enemy then
        -- Уведомление о появлении редкого врага
        self:NotifyAllPlayers("Редкий враг появился!", "Найдите и победите его для наград!", "warning", 5)
    end
end

function RareLootEvents:SpawnTreasureChests(count)
    for i = 1, count do
        local chestPosition = Vector3.new(
            math.random(-80, 80),
            2,
            math.random(-80, 80)
        )
        
        self:CreateTreasureChest(chestPosition)
    end
    
    -- Уведомление о появлении сундуков
    self:NotifyAllPlayers("Сокровищные сундуки появились!", "Найдите их для получения наград!", "treasure", 5)
end

function RareLootEvents:CreateTreasureChest(position)
    local chest = Instance.new("Part")
    chest.Name = "TreasureChest"
    chest.Size = Vector3.new(2, 1.5, 1)
    chest.Position = position
    chest.Anchored = true
    chest.CanCollide = true
    chest.Material = Enum.Material.Wood
    chest.Color = Color3.fromRGB(255, 215, 0) -- Золотой цвет
    chest.Parent = workspace
    
    -- Создание свечения
    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(255, 215, 0)
    pointLight.Range = 10
    pointLight.Brightness = 3
    pointLight.Parent = chest
    
    -- Создание частиц
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
    particleEmitter.Size = NumberSequence.new(0.3, 0)
    particleEmitter.Speed = NumberRange.new(2, 5)
    particleEmitter.Rate = 10
    particleEmitter.Lifetime = NumberRange.new(1, 3)
    particleEmitter.Parent = chest
    
    -- Создание UI
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 2, 0)
    billboardGui.Parent = chest
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Сокровищный сундук"
    label.TextColor3 = Color3.fromRGB(255, 215, 0)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboardGui
    
    -- Подключение события открытия
    chest.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = game.Players:GetPlayerFromCharacter(character)
        
        if player then
            self:OpenTreasureChest(player, chest)
        end
    end)
    
    -- Автоматическое исчезновение через 3 минуты
    task.spawn(function()
        task.wait(180)
        if chest and chest.Parent then
            chest:Destroy()
        end
    end)
end

function RareLootEvents:OpenTreasureChest(player, chest)
    -- Генерация лута из сундука
    local loot = AdvancedLootManager:GenerateAdvancedLoot("chest.legendary_chest", chest.Position, "epic", player)
    
    -- Создание физического лута
    AdvancedLootManager:CreatePhysicalLootWithEffects(loot, chest.Position)
    
    -- Эффект открытия сундука
    self:CreateChestOpenEffect(chest)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Сундук открыт! Получены сокровища!", "success", 3)
    
    -- Удаление сундука
    chest:Destroy()
end

function RareLootEvents:CreateChestOpenEffect(chest)
    -- Создание эффекта открытия
    local effect = Instance.new("Part")
    effect.Size = Vector3.new(0.1, 0.1, 0.1)
    effect.Position = chest.Position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.Neon
    effect.Color = Color3.fromRGB(255, 215, 0)
    effect.Parent = workspace
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 215, 0))
    particleEmitter.Size = NumberSequence.new(1, 0)
    particleEmitter.Speed = NumberRange.new(10, 20)
    particleEmitter.Rate = 100
    particleEmitter.Lifetime = NumberRange.new(2, 4)
    particleEmitter.Parent = effect
    
    -- Анимация исчезновения
    TweenService:Create(effect, TweenInfo.new(3), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    }):Play()
    
    task.wait(3)
    effect:Destroy()
end

function RareLootEvents:SetLootMultiplier(multiplier)
    -- Установка множителя лута
    AdvancedLootManager.lootMultiplier = multiplier
end

function RareLootEvents:SetExperienceMultiplier(multiplier)
    -- Установка множителя опыта
    -- Здесь нужно интегрировать с ProgressionManager
end

function RareLootEvents:SetGoldMultiplier(multiplier)
    -- Установка множителя золота
    -- Здесь нужно интегрировать с EconomyManager
end

function RareLootEvents:SetResourceMultiplier(multiplier)
    -- Установка множителя ресурсов
    -- Здесь нужно интегрировать с ResourceManager
end

function RareLootEvents:ResetMultipliers()
    -- Сброс всех множителей
    AdvancedLootManager.lootMultiplier = 1.0
    -- Сброс других множителей
end

function RareLootEvents:GiveEventRewards(rewards)
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
                        quality = "rare"
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
                        quality = "rare"
                    })
                end
            end
        end
        
        -- Выдача наград игроку
        if #playerLoot > 0 then
            AdvancedLootManager:CreatePhysicalLootWithEffects(playerLoot, player.Character.HumanoidRootPart.Position)
            self:NotifyPlayer(player, "Получены награды за событие!", "reward", 3)
        end
    end
end

function RareLootEvents:GenerateRareDrop(enemyType, player)
    local dropTable = self.rareDrops[enemyType .. "_rare_drops"]
    if not dropTable then return nil end
    
    local rareDrop = nil
    
    for itemId, itemData in pairs(dropTable) do
        if math.random(1, 10000) <= itemData.chance * 100 then -- Конвертация в проценты
            rareDrop = {
                itemId = itemId,
                name = itemData.name,
                rarity = itemData.rarity,
                effects = itemData.effects
            }
            break
        end
    end
    
    return rareDrop
end

function RareLootEvents:NotifyAllPlayers(title, message, type, duration)
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    
    for _, player in pairs(game.Players:GetPlayers()) do
        showNotification:FireClient(player, title, type, duration)
    end
end

function RareLootEvents:NotifyPlayer(player, message, type, duration)
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, type, duration)
end

function RareLootEvents:GetActiveEvents()
    return self.activeEvents
end

function RareLootEvents:GetEventData(eventName)
    return self.rareEvents[eventName]
end

function RareLootEvents:GetAllEvents()
    return self.rareEvents
end

function RareLootEvents:GetRareDropData(enemyType)
    return self.rareDrops[enemyType .. "_rare_drops"]
end

return RareLootEvents