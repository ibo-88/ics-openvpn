-- ProgressionManager.lua
-- Полная система прогрессии игроков

local ProgressionManager = {}
ProgressionManager.__index = ProgressionManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local EconomyManager = require(script.Parent.Parent.EconomySystem.EconomyManager)
local InventoryManager = require(script.Parent.Parent.InventorySystem.InventoryManager)
local AchievementManager = require(script.Parent.Parent.AchievementSystem.AchievementManager)

-- Состояние
ProgressionManager.progressionData = {}
ProgressionManager.skillTrees = {}
ProgressionManager.prestigeSystem = {}
ProgressionManager.battlePass = {}

function ProgressionManager:Initialize()
    print("[ProgressionManager] Initializing progression system...")
    
    -- Инициализация систем прогрессии
    self:InitializeProgressionData()
    self:InitializeSkillTrees()
    self:InitializePrestigeSystem()
    self:InitializeBattlePass()
    
    print("[ProgressionManager] Progression system initialized!")
end

-- Инициализация данных прогрессии
function ProgressionManager:InitializeProgressionData()
    self.progressionData = {
        -- Основные характеристики
        baseStats = {
            maxLevel = 100,
            experiencePerLevel = 1000,
            experienceMultiplier = 1.2,
            maxPrestige = 10,
            prestigeBonus = 0.1 -- 10% бонус за престиж
        },
        
        -- Награды за уровни
        levelRewards = {
            [5] = {gold = 100, gems = 5, items = {"health_potion", "mana_potion"}},
            [10] = {gold = 250, gems = 10, items = {"iron_sword", "leather_armor"}},
            [15] = {gold = 500, gems = 20, items = {"crystal_sword", "iron_armor"}},
            [20] = {gold = 1000, gems = 50, items = {"legendary_sword", "crystal_armor"}},
            [25] = {gold = 2000, gems = 100, items = {"teleport_scroll", "repair_kit"}},
            [30] = {gold = 3500, gems = 150, items = {"strength_potion", "magic_crystal"}},
            [40] = {gold = 5000, gems = 250, items = {"legendary_core", "dragon_scale"}},
            [50] = {gold = 7500, gems = 400, items = {"legendary_sword", "legendary_armor"}},
            [75] = {gold = 15000, gems = 750, items = {"legendary_core", "dragon_scale"}},
            [100] = {gold = 25000, gems = 1000, items = {"legendary_sword", "legendary_armor", "legendary_core"}}
        },
        
        -- Награды за волны
        waveRewards = {
            [5] = {gold = 200, gems = 10, experience = 500, items = {"health_potion", "mana_potion"}},
            [10] = {gold = 500, gems = 25, experience = 1000, items = {"iron_sword", "leather_armor"}},
            [15] = {gold = 1000, gems = 50, experience = 2000, items = {"crystal_sword", "iron_armor"}},
            [20] = {gold = 2000, gems = 100, experience = 4000, items = {"legendary_sword", "crystal_armor"}},
            [25] = {gold = 3500, gems = 175, experience = 6000, items = {"teleport_scroll", "repair_kit"}},
            [30] = {gold = 5000, gems = 250, experience = 8000, items = {"strength_potion", "magic_crystal"}},
            [40] = {gold = 7500, gems = 375, experience = 12000, items = {"legendary_core", "dragon_scale"}},
            [50] = {gold = 10000, gems = 500, experience = 15000, items = {"legendary_sword", "legendary_armor"}},
            [75] = {gold = 20000, gems = 1000, experience = 25000, items = {"legendary_core", "dragon_scale"}},
            [100] = {gold = 30000, gems = 1500, experience = 35000, items = {"legendary_sword", "legendary_armor", "legendary_core"}}
        },
        
        -- Награды за престиж
        prestigeRewards = {
            [1] = {gold = 5000, gems = 100, items = {"prestige_token", "experience_boost"}},
            [2] = {gold = 7500, gems = 150, items = {"prestige_token", "experience_boost", "skill_point"}},
            [3] = {gold = 10000, gems = 200, items = {"prestige_token", "experience_boost", "skill_point", "legendary_core"}},
            [4] = {gold = 15000, gems = 300, items = {"prestige_token", "experience_boost", "skill_point", "legendary_core", "dragon_scale"}},
            [5] = {gold = 20000, gems = 400, items = {"prestige_token", "experience_boost", "skill_point", "legendary_core", "dragon_scale", "unique_title"}}
        }
    }
end

-- Инициализация деревьев навыков
function ProgressionManager:InitializeSkillTrees()
    self.skillTrees = {
        -- Дерево воина
        warrior = {
            name = "Воин",
            skills = {
                -- Атака
                attack_mastery = {
                    name = "Мастерство атаки",
                    description = "Увеличивает урон на 10%",
                    cost = 1,
                    maxLevel = 5,
                    effect = {damage = 10},
                    requirements = {}
                },
                
                critical_strike = {
                    name = "Критический удар",
                    description = "Увеличивает шанс критического удара на 5%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {criticalChance = 5},
                    requirements = {attack_mastery = 2}
                },
                
                weapon_specialization = {
                    name = "Специализация оружия",
                    description = "Увеличивает урон мечей на 15%",
                    cost = 3,
                    maxLevel = 2,
                    effect = {swordDamage = 15},
                    requirements = {attack_mastery = 3, critical_strike = 1}
                },
                
                -- Защита
                armor_mastery = {
                    name = "Мастерство брони",
                    description = "Увеличивает защиту на 10%",
                    cost = 1,
                    maxLevel = 5,
                    effect = {defense = 10},
                    requirements = {}
                },
                
                health_boost = {
                    name = "Увеличение здоровья",
                    description = "Увеличивает максимальное здоровье на 20",
                    cost = 2,
                    maxLevel = 3,
                    effect = {health = 20},
                    requirements = {armor_mastery = 2}
                },
                
                -- Способности
                ability_mastery = {
                    name = "Мастерство способностей",
                    description = "Уменьшает перезарядку способностей на 10%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {abilityCooldown = -10},
                    requirements = {}
                },
                
                ultimate_warrior = {
                    name = "Ультимативный воин",
                    description = "Увеличивает все характеристики на 20%",
                    cost = 5,
                    maxLevel = 1,
                    effect = {allStats = 20},
                    requirements = {attack_mastery = 5, armor_mastery = 5, ability_mastery = 3}
                }
            }
        },
        
        -- Дерево инженера
        engineer = {
            name = "Инженер",
            skills = {
                -- Строительство
                building_mastery = {
                    name = "Мастерство строительства",
                    description = "Уменьшает стоимость строительства на 10%",
                    cost = 1,
                    maxLevel = 5,
                    effect = {buildingCost = -10},
                    requirements = {}
                },
                
                structure_durability = {
                    name = "Прочность конструкций",
                    description = "Увеличивает прочность построек на 20%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {structureDurability = 20},
                    requirements = {building_mastery = 2}
                },
                
                turret_efficiency = {
                    name = "Эффективность турелей",
                    description = "Увеличивает урон турелей на 15%",
                    cost = 3,
                    maxLevel = 2,
                    effect = {turretDamage = 15},
                    requirements = {building_mastery = 3, structure_durability = 1}
                },
                
                -- Ремонт
                repair_mastery = {
                    name = "Мастерство ремонта",
                    description = "Увеличивает эффективность ремонта на 20%",
                    cost = 1,
                    maxLevel = 5,
                    effect = {repairEfficiency = 20},
                    requirements = {}
                },
                
                auto_repair = {
                    name = "Авторемонт",
                    description = "Автоматически ремонтирует постройки",
                    cost = 3,
                    maxLevel = 1,
                    effect = {autoRepair = true},
                    requirements = {repair_mastery = 5}
                },
                
                -- Крафтинг
                crafting_mastery = {
                    name = "Мастерство крафтинга",
                    description = "Увеличивает шанс успеха крафтинга на 10%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {craftingSuccess = 10},
                    requirements = {}
                },
                
                ultimate_engineer = {
                    name = "Ультимативный инженер",
                    description = "Увеличивает все характеристики на 20%",
                    cost = 5,
                    maxLevel = 1,
                    effect = {allStats = 20},
                    requirements = {building_mastery = 5, repair_mastery = 5, crafting_mastery = 3}
                }
            }
        },
        
        -- Универсальное дерево
        universal = {
            name = "Универсальное",
            skills = {
                -- Экономика
                gold_finder = {
                    name = "Искатель золота",
                    description = "Увеличивает получаемое золото на 10%",
                    cost = 1,
                    maxLevel = 5,
                    effect = {goldGain = 10},
                    requirements = {}
                },
                
                gem_finder = {
                    name = "Искатель драгоценностей",
                    description = "Увеличивает получаемые драгоценные камни на 10%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {gemGain = 10},
                    requirements = {gold_finder = 2}
                },
                
                -- Опыт
                experience_boost = {
                    name = "Ускорение опыта",
                    description = "Увеличивает получаемый опыт на 15%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {experienceGain = 15},
                    requirements = {}
                },
                
                -- Инвентарь
                inventory_expansion = {
                    name = "Расширение инвентаря",
                    description = "Увеличивает размер инвентаря на 5 слотов",
                    cost = 3,
                    maxLevel = 2,
                    effect = {inventorySlots = 5},
                    requirements = {}
                },
                
                -- Удача
                luck_boost = {
                    name = "Увеличение удачи",
                    description = "Увеличивает удачу на 10%",
                    cost = 2,
                    maxLevel = 3,
                    effect = {luck = 10},
                    requirements = {}
                },
                
                -- Универсальный мастер
                universal_master = {
                    name = "Универсальный мастер",
                    description = "Увеличивает все характеристики на 15%",
                    cost = 5,
                    maxLevel = 1,
                    effect = {allStats = 15},
                    requirements = {gold_finder = 5, experience_boost = 3, luck_boost = 3}
                }
            }
        }
    }
end

-- Инициализация системы престижа
function ProgressionManager:InitializePrestigeSystem()
    self.prestigeSystem = {
        -- Требования для престижа
        requirements = {
            level = 100,
            experience = 100000,
            wavesCompleted = 50,
            enemiesKilled = 1000
        },
        
        -- Бонусы престижа
        bonuses = {
            experienceGain = 0.1, -- 10% за каждый престиж
            goldGain = 0.05, -- 5% за каждый престиж
            gemGain = 0.05, -- 5% за каждый престиж
            skillPoints = 5, -- 5 очков навыков за престиж
            uniqueItems = true -- Доступ к уникальным предметам
        },
        
        -- Уникальные предметы престижа
        uniqueItems = {
            prestige_sword = {
                name = "Меч престижа",
                rarity = "legendary",
                stats = {damage = 100, criticalChance = 25, prestigeBonus = 10}
            },
            prestige_armor = {
                name = "Броня престижа",
                rarity = "legendary",
                stats = {defense = 80, health = 150, prestigeBonus = 10}
            },
            prestige_crown = {
                name = "Корона престижа",
                rarity = "legendary",
                stats = {allStats = 20, prestigeBonus = 15}
            }
        }
    }
end

-- Инициализация боевого пропуска
function ProgressionManager:InitializeBattlePass()
    self.battlePass = {
        -- Уровни боевого пропуска
        levels = {
            [1] = {experience = 100, rewards = {gold = 50, gems = 2}},
            [5] = {experience = 500, rewards = {gold = 100, gems = 5, items = {"health_potion"}}},
            [10] = {experience = 1000, rewards = {gold = 200, gems = 10, items = {"iron_sword"}}},
            [15] = {experience = 1500, rewards = {gold = 300, gems = 15, items = {"crystal_sword"}}},
            [20] = {experience = 2000, rewards = {gold = 500, gems = 25, items = {"legendary_sword"}}},
            [25] = {experience = 2500, rewards = {gold = 750, gems = 35, items = {"legendary_armor"}}},
            [30] = {experience = 3000, rewards = {gold = 1000, gems = 50, items = {"legendary_core"}}},
            [35] = {experience = 3500, rewards = {gold = 1250, gems = 60, items = {"dragon_scale"}}},
            [40] = {experience = 4000, rewards = {gold = 1500, gems = 75, items = {"unique_title"}}},
            [50] = {experience = 5000, rewards = {gold = 2000, gems = 100, items = {"legendary_sword", "legendary_armor", "legendary_core"}}}
        },
        
        -- Премиум награды
        premiumRewards = {
            [1] = {gold = 100, gems = 5, items = {"premium_health_potion"}},
            [5] = {gold = 200, gems = 10, items = {"premium_sword"}},
            [10] = {gold = 400, gems = 20, items = {"premium_armor"}},
            [15] = {gold = 600, gems = 30, items = {"premium_crystal_sword"}},
            [20] = {gold = 1000, gems = 50, items = {"premium_legendary_sword"}},
            [25] = {gold = 1500, gems = 75, items = {"premium_legendary_armor"}},
            [30] = {gold = 2000, gems = 100, items = {"premium_legendary_core"}},
            [35] = {gold = 2500, gems = 125, items = {"premium_dragon_scale"}},
            [40] = {gold = 3000, gems = 150, items = {"premium_unique_title"}},
            [50] = {gold = 4000, gems = 200, items = {"premium_legendary_set"}}
        }
    }
end

-- Добавление опыта игроку
function ProgressionManager:AddExperience(player, amount)
    local playerData = ProfileService:GetPlayerData(player)
    
    -- Применение бонусов престижа
    local prestigeBonus = playerData.prestige * self.prestigeSystem.bonuses.experienceGain
    local finalAmount = amount * (1 + prestigeBonus)
    
    playerData.experience = playerData.experience + finalAmount
    
    -- Проверка повышения уровня
    local newLevel = self:CalculateLevel(playerData.experience)
    if newLevel > playerData.level then
        self:LevelUp(player, newLevel)
    end
    
    -- Обновление боевого пропуска
    self:UpdateBattlePass(player, finalAmount)
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    return finalAmount
end

-- Расчет уровня по опыту
function ProgressionManager:CalculateLevel(experience)
    local level = 1
    local expNeeded = self.progressionData.baseStats.experiencePerLevel
    
    while experience >= expNeeded and level < self.progressionData.baseStats.maxLevel do
        experience = experience - expNeeded
        level = level + 1
        expNeeded = expNeeded * self.progressionData.baseStats.experienceMultiplier
    end
    
    return level
end

-- Повышение уровня
function ProgressionManager:LevelUp(player, newLevel)
    local playerData = ProfileService:GetPlayerData(player)
    local oldLevel = playerData.level
    
    playerData.level = newLevel
    playerData.skillPoints = playerData.skillPoints + 1
    
    -- Выдача наград за уровень
    local levelReward = self.progressionData.levelRewards[newLevel]
    if levelReward then
        self:GiveRewards(player, levelReward)
    end
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Уровень повышен до " .. newLevel .. "!", "success")
    
    print("[ProgressionManager] Player", player.Name, "leveled up to", newLevel)
end

-- Выдача наград за волну
function ProgressionManager:GiveWaveReward(player, waveNumber)
    local waveReward = self.progressionData.waveRewards[waveNumber]
    if waveReward then
        self:GiveRewards(player, waveReward)
        self:NotifyPlayer(player, "Награда за волну " .. waveNumber .. " получена!", "success")
    end
end

-- Выдача наград
function ProgressionManager:GiveRewards(player, rewards)
    local playerData = ProfileService:GetPlayerData(player)
    
    -- Золото
    if rewards.gold then
        EconomyManager:AddCurrency(player, "gold", rewards.gold, "Награда за прогресс")
    end
    
    -- Драгоценные камни
    if rewards.gems then
        EconomyManager:AddCurrency(player, "gems", rewards.gems, "Награда за прогресс")
    end
    
    -- Опыт
    if rewards.experience then
        self:AddExperience(player, rewards.experience)
    end
    
    -- Предметы
    if rewards.items then
        for _, itemId in pairs(rewards.items) do
            InventoryManager:AddItem(player, itemId, 1)
        end
    end
end

-- Проверка возможности престижа
function ProgressionManager:CanPrestige(player)
    local playerData = ProfileService:GetPlayerData(player)
    local requirements = self.prestigeSystem.requirements
    
    return playerData.level >= requirements.level and
           playerData.experience >= requirements.experience and
           playerData.wavesCompleted >= requirements.wavesCompleted and
           playerData.enemiesKilled >= requirements.enemiesKilled
end

-- Выполнение престижа
function ProgressionManager:PerformPrestige(player)
    if not self:CanPrestige(player) then
        return false, "Не выполнены требования для престижа"
    end
    
    local playerData = ProfileService:GetPlayerData(player)
    
    -- Сброс прогресса
    playerData.level = 1
    playerData.experience = 0
    playerData.prestige = playerData.prestige + 1
    
    -- Выдача очков навыков
    playerData.skillPoints = playerData.skillPoints + self.prestigeSystem.bonuses.skillPoints
    
    -- Выдача наград за престиж
    local prestigeReward = self.progressionData.prestigeRewards[playerData.prestige]
    if prestigeReward then
        self:GiveRewards(player, prestigeReward)
    end
    
    -- Выдача уникальных предметов
    if playerData.prestige <= 3 then
        for itemName, itemData in pairs(self.prestigeSystem.uniqueItems) do
            InventoryManager:AddItem(player, itemName, 1)
        end
    end
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    self:NotifyPlayer(player, "Престиж выполнен! Уровень престижа: " .. playerData.prestige, "success")
    
    return true, "Престиж выполнен успешно"
end

-- Покупка навыка
function ProgressionManager:PurchaseSkill(player, skillId, treeName)
    local playerData = ProfileService:GetPlayerData(player)
    local skillTree = self.skillTrees[treeName]
    
    if not skillTree or not skillTree.skills[skillId] then
        return false, "Навык не найден"
    end
    
    local skill = skillTree.skills[skillId]
    local currentLevel = playerData.skills[skillId] or 0
    
    if currentLevel >= skill.maxLevel then
        return false, "Навык уже максимального уровня"
    end
    
    if playerData.skillPoints < skill.cost then
        return false, "Недостаточно очков навыков"
    end
    
    -- Проверка требований
    for reqSkill, reqLevel in pairs(skill.requirements) do
        local playerSkillLevel = playerData.skills[reqSkill] or 0
        if playerSkillLevel < reqLevel then
            return false, "Не выполнены требования для навыка"
        end
    end
    
    -- Покупка навыка
    playerData.skillPoints = playerData.skillPoints - skill.cost
    playerData.skills[skillId] = currentLevel + 1
    
    -- Применение эффектов навыка
    self:ApplySkillEffects(player, skillId, skill, currentLevel + 1)
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    self:NotifyPlayer(player, "Навык '" .. skill.name .. "' улучшен!", "success")
    
    return true, "Навык успешно куплен"
end

-- Применение эффектов навыка
function ProgressionManager:ApplySkillEffects(player, skillId, skill, level)
    -- Здесь можно добавить логику применения эффектов к персонажу
    -- Например, изменение характеристик, разблокировка способностей и т.д.
    print("[ProgressionManager] Applied skill effects:", skillId, "level", level)
end

-- Обновление боевого пропуска
function ProgressionManager:UpdateBattlePass(player, experience)
    local playerData = ProfileService:GetPlayerData(player)
    
    playerData.battlePassExperience = playerData.battlePassExperience + experience
    
    -- Проверка повышения уровня боевого пропуска
    local currentLevel = playerData.battlePassLevel or 0
    local newLevel = self:CalculateBattlePassLevel(playerData.battlePassExperience)
    
    if newLevel > currentLevel then
        self:BattlePassLevelUp(player, newLevel)
    end
end

-- Расчет уровня боевого пропуска
function ProgressionManager:CalculateBattlePassLevel(experience)
    local level = 0
    local totalExp = 0
    
    for levelNum, levelData in pairs(self.battlePass.levels) do
        totalExp = totalExp + levelData.experience
        if experience >= totalExp then
            level = levelNum
        else
            break
        end
    end
    
    return level
end

-- Повышение уровня боевого пропуска
function ProgressionManager:BattlePassLevelUp(player, newLevel)
    local playerData = ProfileService:GetPlayerData(player)
    local oldLevel = playerData.battlePassLevel or 0
    
    playerData.battlePassLevel = newLevel
    
    -- Выдача наград
    local levelReward = self.battlePass.levels[newLevel]
    if levelReward then
        self:GiveRewards(player, levelReward)
    end
    
    -- Выдача премиум наград (если игрок купил премиум)
    if playerData.battlePassPremium and self.battlePass.premiumRewards[newLevel] then
        local premiumReward = self.battlePass.premiumRewards[newLevel]
        self:GiveRewards(player, premiumReward)
    end
    
    self:NotifyPlayer(player, "Боевой пропуск: уровень " .. newLevel .. "!", "success")
end

-- Покупка премиум боевого пропуска
function ProgressionManager:PurchaseBattlePassPremium(player)
    local playerData = ProfileService:GetPlayerData(player)
    
    if playerData.battlePassPremium then
        return false, "Премиум боевой пропуск уже куплен"
    end
    
    -- Проверка наличия драгоценных камней (например, 500)
    if not EconomyManager:HasCurrency(player, "gems", 500) then
        return false, "Недостаточно драгоценных камней"
    end
    
    -- Списание валюты
    EconomyManager:SpendCurrency(player, "gems", 500, "Покупка премиум боевого пропуска")
    
    -- Активация премиума
    playerData.battlePassPremium = true
    
    -- Выдача всех премиум наград за уже пройденные уровни
    for level = 1, playerData.battlePassLevel or 0 do
        if self.battlePass.premiumRewards[level] then
            self:GiveRewards(player, self.battlePass.premiumRewards[level])
        end
    end
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    self:NotifyPlayer(player, "Премиум боевой пропуск активирован!", "success")
    
    return true, "Премиум боевой пропуск куплен"
end

-- Получение информации о прогрессе
function ProgressionManager:GetProgressInfo(player)
    local playerData = ProfileService:GetPlayerData(player)
    
    return {
        level = playerData.level,
        experience = playerData.experience,
        experienceToNext = self:GetExperienceToNextLevel(playerData.experience),
        prestige = playerData.prestige,
        skillPoints = playerData.skillPoints,
        battlePassLevel = playerData.battlePassLevel or 0,
        battlePassExperience = playerData.battlePassExperience or 0,
        battlePassPremium = playerData.battlePassPremium or false,
        skills = playerData.skills or {},
        canPrestige = self:CanPrestige(player)
    }
end

-- Получение опыта до следующего уровня
function ProgressionManager:GetExperienceToNextLevel(currentExp)
    local level = self:CalculateLevel(currentExp)
    local expNeeded = self.progressionData.baseStats.experiencePerLevel
    
    for i = 1, level - 1 do
        expNeeded = expNeeded * self.progressionData.baseStats.experienceMultiplier
    end
    
    return expNeeded - (currentExp % expNeeded)
end

-- Получение доступных навыков
function ProgressionManager:GetAvailableSkills(player, treeName)
    local playerData = ProfileService:GetPlayerData(player)
    local skillTree = self.skillTrees[treeName]
    
    if not skillTree then return {} end
    
    local availableSkills = {}
    
    for skillId, skill in pairs(skillTree.skills) do
        local currentLevel = playerData.skills[skillId] or 0
        local canPurchase = currentLevel < skill.maxLevel and playerData.skillPoints >= skill.cost
        
        -- Проверка требований
        local requirementsMet = true
        for reqSkill, reqLevel in pairs(skill.requirements) do
            local playerSkillLevel = playerData.skills[reqSkill] or 0
            if playerSkillLevel < reqLevel then
                requirementsMet = false
                break
            end
        end
        
        table.insert(availableSkills, {
            id = skillId,
            name = skill.name,
            description = skill.description,
            cost = skill.cost,
            currentLevel = currentLevel,
            maxLevel = skill.maxLevel,
            canPurchase = canPurchase and requirementsMet,
            requirements = skill.requirements,
            effect = skill.effect
        })
    end
    
    return availableSkills
end

-- Уведомление игрока
function ProgressionManager:NotifyPlayer(player, message, type)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, type, 3)
end

-- Очистка системы прогрессии
function ProgressionManager:Cleanup()
    self.progressionData = {}
    self.skillTrees = {}
    self.prestigeSystem = {}
    self.battlePass = {}
end

return ProgressionManager