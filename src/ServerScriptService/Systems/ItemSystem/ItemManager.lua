-- ItemManager.lua
-- Полная система предметов с качествами, зачарованиями и модификаторами

local ItemManager = {}
ItemManager.__index = ItemManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)

-- Состояние
ItemManager.items = {}
ItemManager.qualities = {}
ItemManager.enchantments = {}
ItemManager.modifiers = {}
ItemManager.itemSettings = {}

function ItemManager:Initialize()
    print("[ItemManager] Initializing item system...")
    
    -- Инициализация предметов
    self:InitializeItems()
    
    -- Инициализация качеств
    self:InitializeQualities()
    
    -- Инициализация зачарований
    self:InitializeEnchantments()
    
    -- Инициализация модификаторов
    self:InitializeModifiers()
    
    -- Инициализация настроек
    self:InitializeItemSettings()
    
    print("[ItemManager] Item system initialized!")
end

-- Инициализация предметов
function ItemManager:InitializeItems()
    self.items = {
        -- Оружие
        weapons = {
            basic_sword = {
                name = "Базовый меч",
                type = "weapon",
                category = "sword",
                rarity = "common",
                level = 1,
                baseStats = {
                    damage = 20,
                    attackSpeed = 1.0,
                    range = 3
                },
                description = "Простой меч для начинающих воинов",
                model = "BasicSword",
                icon = "sword_icon"
            },
            
            iron_sword = {
                name = "Железный меч",
                type = "weapon",
                category = "sword",
                rarity = "uncommon",
                level = 5,
                baseStats = {
                    damage = 35,
                    attackSpeed = 1.1,
                    range = 3
                },
                description = "Надежный железный меч",
                model = "IronSword",
                icon = "iron_sword_icon"
            },
            
            crystal_sword = {
                name = "Кристальный меч",
                type = "weapon",
                category = "sword",
                rarity = "rare",
                level = 10,
                baseStats = {
                    damage = 50,
                    attackSpeed = 1.2,
                    range = 3,
                    magicDamage = 20
                },
                description = "Магический меч с кристальной силой",
                model = "CrystalSword",
                icon = "crystal_sword_icon"
            },
            
            legendary_sword = {
                name = "Легендарный меч",
                type = "weapon",
                category = "sword",
                rarity = "legendary",
                level = 15,
                baseStats = {
                    damage = 80,
                    attackSpeed = 1.3,
                    range = 4,
                    magicDamage = 40,
                    criticalChance = 25
                },
                description = "Древний меч легендарной силы",
                model = "LegendarySword",
                icon = "legendary_sword_icon"
            },
            
            basic_bow = {
                name = "Базовый лук",
                type = "weapon",
                category = "bow",
                rarity = "common",
                level = 3,
                baseStats = {
                    damage = 25,
                    attackSpeed = 1.5,
                    range = 40
                },
                description = "Простой лук для дальнего боя",
                model = "BasicBow",
                icon = "bow_icon"
            },
            
            magic_bow = {
                name = "Магический лук",
                type = "weapon",
                category = "bow",
                rarity = "rare",
                level = 12,
                baseStats = {
                    damage = 45,
                    attackSpeed = 1.6,
                    range = 50,
                    magicDamage = 30
                },
                description = "Лук, заряженный магической энергией",
                model = "MagicBow",
                icon = "magic_bow_icon"
            }
        },
        
        -- Броня
        armor = {
            leather_armor = {
                name = "Кожаная броня",
                type = "armor",
                category = "body",
                rarity = "common",
                level = 2,
                baseStats = {
                    defense = 15,
                    health = 20
                },
                description = "Легкая кожаная броня",
                model = "LeatherArmor",
                icon = "leather_armor_icon"
            },
            
            iron_armor = {
                name = "Железная броня",
                type = "armor",
                category = "body",
                rarity = "uncommon",
                level = 6,
                baseStats = {
                    defense = 30,
                    health = 40
                },
                description = "Надежная железная броня",
                model = "IronArmor",
                icon = "iron_armor_icon"
            },
            
            crystal_armor = {
                name = "Кристальная броня",
                type = "armor",
                category = "body",
                rarity = "rare",
                level = 12,
                baseStats = {
                    defense = 45,
                    health = 60,
                    magicResist = 20
                },
                description = "Броня с кристальной защитой",
                model = "CrystalArmor",
                icon = "crystal_armor_icon"
            },
            
            legendary_armor = {
                name = "Легендарная броня",
                type = "armor",
                category = "body",
                rarity = "legendary",
                level = 18,
                baseStats = {
                    defense = 70,
                    health = 100,
                    magicResist = 40,
                    dodgeChance = 15
                },
                description = "Древняя броня легендарной защиты",
                model = "LegendaryArmor",
                icon = "legendary_armor_icon"
            }
        },
        
        -- Зелья
        potions = {
            health_potion = {
                name = "Зелье здоровья",
                type = "consumable",
                category = "potion",
                rarity = "common",
                level = 1,
                effect = {
                    heal = 50,
                    duration = 0
                },
                description = "Восстанавливает 50 здоровья",
                icon = "health_potion_icon",
                stackable = true,
                maxStack = 99
            },
            
            mana_potion = {
                name = "Зелье маны",
                type = "consumable",
                category = "potion",
                rarity = "common",
                level = 2,
                effect = {
                    mana = 50,
                    duration = 0
                },
                description = "Восстанавливает 50 маны",
                icon = "mana_potion_icon",
                stackable = true,
                maxStack = 99
            },
            
            strength_potion = {
                name = "Зелье силы",
                type = "consumable",
                category = "potion",
                rarity = "uncommon",
                level = 5,
                effect = {
                    strength = 20,
                    duration = 300
                },
                description = "Увеличивает силу на 5 минут",
                icon = "strength_potion_icon",
                stackable = true,
                maxStack = 99
            },
            
            legendary_potion = {
                name = "Легендарное зелье",
                type = "consumable",
                category = "potion",
                rarity = "legendary",
                level = 20,
                effect = {
                    heal = 200,
                    mana = 200,
                    strength = 50,
                    defense = 30,
                    duration = 600
                },
                description = "Мощное зелье всех эффектов",
                icon = "legendary_potion_icon",
                stackable = true,
                maxStack = 10
            }
        },
        
        -- Материалы
        materials = {
            wood = {
                name = "Дерево",
                type = "material",
                category = "resource",
                rarity = "common",
                level = 1,
                description = "Базовый строительный материал",
                icon = "wood_icon",
                stackable = true,
                maxStack = 999
            },
            
            stone = {
                name = "Камень",
                type = "material",
                category = "resource",
                rarity = "common",
                level = 1,
                description = "Прочный строительный материал",
                icon = "stone_icon",
                stackable = true,
                maxStack = 999
            },
            
            iron = {
                name = "Железо",
                type = "material",
                category = "resource",
                rarity = "uncommon",
                level = 3,
                description = "Металл для оружия и брони",
                icon = "iron_icon",
                stackable = true,
                maxStack = 999
            },
            
            crystal = {
                name = "Кристалл",
                type = "material",
                category = "resource",
                rarity = "rare",
                level = 8,
                description = "Магический кристалл",
                icon = "crystal_icon",
                stackable = true,
                maxStack = 999
            },
            
            dragon_scale = {
                name = "Чешуя дракона",
                type = "material",
                category = "resource",
                rarity = "legendary",
                level = 20,
                description = "Редкая чешуя дракона",
                icon = "dragon_scale_icon",
                stackable = true,
                maxStack = 99
            }
        },
        
        -- Специальные предметы
        special = {
            repair_kit = {
                name = "Ремонтный набор",
                type = "tool",
                category = "repair",
                rarity = "uncommon",
                level = 4,
                effect = {
                    repair = 100
                },
                description = "Восстанавливает прочность предметов",
                icon = "repair_kit_icon",
                stackable = true,
                maxStack = 50
            },
            
            teleport_scroll = {
                name = "Свиток телепортации",
                type = "consumable",
                category = "scroll",
                rarity = "rare",
                level = 7,
                effect = {
                    teleport = true
                },
                description = "Телепортирует к базе",
                icon = "teleport_scroll_icon",
                stackable = true,
                maxStack = 20
            },
            
            legendary_core = {
                name = "Легендарное ядро",
                type = "material",
                category = "core",
                rarity = "legendary",
                level = 15,
                description = "Мощное ядро энергии",
                icon = "legendary_core_icon",
                stackable = true,
                maxStack = 10
            }
        }
    }
end

-- Инициализация качеств
function ItemManager:InitializeQualities()
    self.qualities = {
        common = {
            name = "Обычное",
            color = Color3.fromRGB(255, 255, 255),
            multiplier = 1.0,
            enchantmentSlots = 0,
            dropChance = 70
        },
        
        uncommon = {
            name = "Необычное",
            color = Color3.fromRGB(0, 255, 0),
            multiplier = 1.2,
            enchantmentSlots = 1,
            dropChance = 20
        },
        
        rare = {
            name = "Редкое",
            color = Color3.fromRGB(0, 100, 255),
            multiplier = 1.5,
            enchantmentSlots = 2,
            dropChance = 7
        },
        
        epic = {
            name = "Эпическое",
            color = Color3.fromRGB(255, 0, 255),
            multiplier = 2.0,
            enchantmentSlots = 3,
            dropChance = 2.5
        },
        
        legendary = {
            name = "Легендарное",
            color = Color3.fromRGB(255, 165, 0),
            multiplier = 3.0,
            enchantmentSlots = 4,
            dropChance = 0.5
        }
    }
end

-- Инициализация зачарований
function ItemManager:InitializeEnchantments()
    self.enchantments = {
        -- Зачарования оружия
        weapon = {
            sharpness = {
                name = "Острота",
                description = "Увеличивает урон",
                effect = {damage = 10},
                rarity = "common",
                maxLevel = 5
            },
            
            speed = {
                name = "Скорость",
                description = "Увеличивает скорость атаки",
                effect = {attackSpeed = 0.1},
                rarity = "uncommon",
                maxLevel = 3
            },
            
            critical = {
                name = "Критический удар",
                description = "Увеличивает шанс критического удара",
                effect = {criticalChance = 5},
                rarity = "rare",
                maxLevel = 3
            },
            
            fire = {
                name = "Огненное зачарование",
                description = "Добавляет огненный урон",
                effect = {fireDamage = 15},
                rarity = "epic",
                maxLevel = 2
            },
            
            lightning = {
                name = "Молния",
                description = "Добавляет электрический урон",
                effect = {lightningDamage = 20},
                rarity = "epic",
                maxLevel = 2
            },
            
            life_steal = {
                name = "Кража жизни",
                description = "Восстанавливает здоровье при атаке",
                effect = {lifeSteal = 5},
                rarity = "legendary",
                maxLevel = 1
            }
        },
        
        -- Зачарования брони
        armor = {
            protection = {
                name = "Защита",
                description = "Увеличивает защиту",
                effect = {defense = 5},
                rarity = "common",
                maxLevel = 5
            },
            
            health = {
                name = "Здоровье",
                description = "Увеличивает максимальное здоровье",
                effect = {health = 10},
                rarity = "uncommon",
                maxLevel = 3
            },
            
            magic_resist = {
                name = "Сопротивление магии",
                description = "Увеличивает сопротивление магии",
                effect = {magicResist = 5},
                rarity = "rare",
                maxLevel = 3
            },
            
            dodge = {
                name = "Уклонение",
                description = "Увеличивает шанс уклонения",
                effect = {dodgeChance = 3},
                rarity = "epic",
                maxLevel = 2
            },
            
            regeneration = {
                name = "Регенерация",
                description = "Восстанавливает здоровье со временем",
                effect = {healthRegen = 2},
                rarity = "legendary",
                maxLevel = 1
            }
        },
        
        -- Универсальные зачарования
        universal = {
            durability = {
                name = "Прочность",
                description = "Увеличивает прочность предмета",
                effect = {durability = 50},
                rarity = "common",
                maxLevel = 3
            },
            
            luck = {
                name = "Удача",
                description = "Увеличивает удачу",
                effect = {luck = 5},
                rarity = "rare",
                maxLevel = 2
            },
            
            experience = {
                name = "Опыт",
                description = "Увеличивает получаемый опыт",
                effect = {experienceGain = 10},
                rarity = "epic",
                maxLevel = 1
            }
        }
    }
end

-- Инициализация модификаторов
function ItemManager:InitializeModifiers()
    self.modifiers = {
        -- Модификаторы урона
        damage = {
            small = {min = 1, max = 5, chance = 30},
            medium = {min = 5, max = 15, chance = 15},
            large = {min = 15, max = 30, chance = 5}
        },
        
        -- Модификаторы защиты
        defense = {
            small = {min = 1, max = 3, chance = 30},
            medium = {min = 3, max = 8, chance = 15},
            large = {min = 8, max = 15, chance = 5}
        },
        
        -- Модификаторы здоровья
        health = {
            small = {min = 5, max = 15, chance = 25},
            medium = {min = 15, max = 30, chance = 10},
            large = {min = 30, max = 50, chance = 3}
        },
        
        -- Модификаторы скорости
        speed = {
            small = {min = 0.05, max = 0.1, chance = 20},
            medium = {min = 0.1, max = 0.2, chance = 8},
            large = {min = 0.2, max = 0.3, chance = 2}
        }
    }
end

-- Инициализация настроек
function ItemManager:InitializeItemSettings()
    self.itemSettings = {
        -- Настройки генерации
        generation = {
            maxEnchantments = 4,
            maxModifiers = 3,
            qualityChance = {
                common = 70,
                uncommon = 20,
                rare = 7,
                epic = 2.5,
                legendary = 0.5
            }
        },
        
        -- Настройки зачарований
        enchantment = {
            successRate = {
                common = 100,
                uncommon = 90,
                rare = 75,
                epic = 60,
                legendary = 40
            },
            costMultiplier = {
                common = 1.0,
                uncommon = 1.5,
                rare = 2.0,
                epic = 3.0,
                legendary = 5.0
            }
        }
    }
end

-- Создание предмета
function ItemManager:CreateItem(itemId, quality, level, enchantments, modifiers)
    local baseItem = self:GetItemInfo(itemId)
    if not baseItem then return nil end
    
    quality = quality or "common"
    level = level or baseItem.level
    
    local item = {
        id = itemId,
        name = baseItem.name,
        type = baseItem.type,
        category = baseItem.category,
        rarity = baseItem.rarity,
        quality = quality,
        level = level,
        enchantments = enchantments or {},
        modifiers = modifiers or {},
        durability = 100,
        createdAt = os.time()
    }
    
    -- Расчет статистик
    item.stats = self:CalculateItemStats(baseItem, quality, level, enchantments, modifiers)
    
    return item
end

-- Расчет статистик предмета
function ItemManager:CalculateItemStats(baseItem, quality, level, enchantments, modifiers)
    local stats = {}
    
    -- Базовые статистики
    if baseItem.baseStats then
        for stat, value in pairs(baseItem.baseStats) do
            stats[stat] = value
        end
    end
    
    -- Множитель качества
    local qualityMultiplier = self.qualities[quality].multiplier
    for stat, value in pairs(stats) do
        if type(value) == "number" then
            stats[stat] = value * qualityMultiplier
        end
    end
    
    -- Множитель уровня
    local levelMultiplier = 1 + (level - baseItem.level) * 0.1
    for stat, value in pairs(stats) do
        if type(value) == "number" then
            stats[stat] = value * levelMultiplier
        end
    end
    
    -- Зачарования
    for _, enchantment in pairs(enchantments) do
        local enchantInfo = self:GetEnchantmentInfo(enchantment.id)
        if enchantInfo then
            for stat, value in pairs(enchantInfo.effect) do
                stats[stat] = (stats[stat] or 0) + value * enchantment.level
            end
        end
    end
    
    -- Модификаторы
    for _, modifier in pairs(modifiers) do
        if stats[modifier.stat] then
            stats[modifier.stat] = stats[modifier.stat] + modifier.value
        end
    end
    
    return stats
end

-- Генерация случайного предмета
function ItemManager:GenerateRandomItem(itemId, minLevel, maxLevel)
    local baseItem = self:GetItemInfo(itemId)
    if not baseItem then return nil end
    
    -- Определение качества
    local quality = self:DetermineQuality()
    
    -- Определение уровня
    local level = math.random(minLevel or baseItem.level, maxLevel or baseItem.level)
    
    -- Генерация зачарований
    local enchantments = self:GenerateRandomEnchantments(baseItem, quality)
    
    -- Генерация модификаторов
    local modifiers = self:GenerateRandomModifiers(baseItem, quality)
    
    return self:CreateItem(itemId, quality, level, enchantments, modifiers)
end

-- Определение качества
function ItemManager:DetermineQuality()
    local roll = math.random(1, 100)
    local cumulative = 0
    
    for quality, chance in pairs(self.itemSettings.generation.qualityChance) do
        cumulative = cumulative + chance
        if roll <= cumulative then
            return quality
        end
    end
    
    return "common"
end

-- Генерация случайных зачарований
function ItemManager:GenerateRandomEnchantments(baseItem, quality)
    local enchantments = {}
    local maxSlots = self.qualities[quality].enchantmentSlots
    
    if maxSlots <= 0 then return enchantments end
    
    local availableEnchantments = {}
    
    -- Сбор доступных зачарований
    if baseItem.type == "weapon" then
        for id, enchant in pairs(self.enchantments.weapon) do
            table.insert(availableEnchantments, {id = id, info = enchant})
        end
    elseif baseItem.type == "armor" then
        for id, enchant in pairs(self.enchantments.armor) do
            table.insert(availableEnchantments, {id = id, info = enchant})
        end
    end
    
    -- Добавление универсальных зачарований
    for id, enchant in pairs(self.enchantments.universal) do
        table.insert(availableEnchantments, {id = id, info = enchant})
    end
    
    -- Выбор зачарований
    local slotsUsed = 0
    while slotsUsed < maxSlots and #availableEnchantments > 0 do
        local index = math.random(1, #availableEnchantments)
        local enchantData = availableEnchantments[index]
        
        if enchantData.info.rarity == quality or 
           (enchantData.info.rarity == "common" and quality ~= "common") then
            local level = math.random(1, enchantData.info.maxLevel)
            table.insert(enchantments, {
                id = enchantData.id,
                level = level,
                name = enchantData.info.name
            })
            slotsUsed = slotsUsed + 1
        end
        
        table.remove(availableEnchantments, index)
    end
    
    return enchantments
end

-- Генерация случайных модификаторов
function ItemManager:GenerateRandomModifiers(baseItem, quality)
    local modifiers = {}
    local maxModifiers = self.itemSettings.generation.maxModifiers
    
    local modifierTypes = {"damage", "defense", "health", "speed"}
    
    for i = 1, maxModifiers do
        if math.random(1, 100) <= 30 then -- 30% шанс модификатора
            local modifierType = modifierTypes[math.random(1, #modifierTypes)]
            local modifierData = self.modifiers[modifierType]
            
            if modifierData then
                local size = "small"
                if math.random(1, 100) <= 20 then size = "medium" end
                if math.random(1, 100) <= 5 then size = "large" end
                
                local value = math.random(modifierData[size].min, modifierData[size].max)
                table.insert(modifiers, {
                    stat = modifierType,
                    value = value,
                    size = size
                })
            end
        end
    end
    
    return modifiers
end

-- Получение информации о предмете
function ItemManager:GetItemInfo(itemId)
    for category, items in pairs(self.items) do
        if items[itemId] then
            return items[itemId]
        end
    end
    return nil
end

-- Получение информации о зачаровании
function ItemManager:GetEnchantmentInfo(enchantmentId)
    for category, enchantments in pairs(self.enchantments) do
        if enchantments[enchantmentId] then
            return enchantments[enchantmentId]
        end
    end
    return nil
end

-- Получение информации о качестве
function ItemManager:GetQualityInfo(quality)
    return self.qualities[quality]
end

-- Получение всех предметов
function ItemManager:GetAllItems()
    local allItems = {}
    
    for category, items in pairs(self.items) do
        allItems[category] = {}
        for itemId, item in pairs(items) do
            table.insert(allItems[category], {
                id = itemId,
                name = item.name,
                type = item.type,
                category = item.category,
                rarity = item.rarity,
                level = item.level,
                description = item.description
            })
        end
    end
    
    return allItems
end

-- Получение предметов по типу
function ItemManager:GetItemsByType(itemType)
    local items = {}
    
    for category, categoryItems in pairs(self.items) do
        for itemId, item in pairs(categoryItems) do
            if item.type == itemType then
                table.insert(items, {
                    id = itemId,
                    name = item.name,
                    type = item.type,
                    category = item.category,
                    rarity = item.rarity,
                    level = item.level
                })
            end
        end
    end
    
    return items
end

-- Получение предметов по уровню
function ItemManager:GetItemsByLevel(minLevel, maxLevel)
    local items = {}
    
    for category, categoryItems in pairs(self.items) do
        for itemId, item in pairs(categoryItems) do
            if item.level >= minLevel and item.level <= maxLevel then
                table.insert(items, {
                    id = itemId,
                    name = item.name,
                    type = item.type,
                    category = item.category,
                    rarity = item.rarity,
                    level = item.level
                })
            end
        end
    end
    
    return items
end

-- Получение предметов по редкости
function ItemManager:GetItemsByRarity(rarity)
    local items = {}
    
    for category, categoryItems in pairs(self.items) do
        for itemId, item in pairs(categoryItems) do
            if item.rarity == rarity then
                table.insert(items, {
                    id = itemId,
                    name = item.name,
                    type = item.type,
                    category = item.category,
                    rarity = item.rarity,
                    level = item.level
                })
            end
        end
    end
    
    return items
end

-- Очистка системы предметов
function ItemManager:Cleanup()
    self.items = {}
    self.qualities = {}
    self.enchantments = {}
    self.modifiers = {}
    self.itemSettings = {}
end

return ItemManager