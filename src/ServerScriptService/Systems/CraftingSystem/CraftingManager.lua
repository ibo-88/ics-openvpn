-- CraftingManager.lua
-- Полная система крафтинга предметов

local CraftingManager = {}
CraftingManager.__index = CraftingManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local InventoryManager = require(script.Parent.Parent.InventorySystem.InventoryManager)
local EconomyManager = require(script.Parent.Parent.EconomySystem.EconomyManager)

-- Состояние
CraftingManager.recipes = {}
CraftingManager.craftingStations = {}
CraftingManager.craftingSettings = {}

function CraftingManager:Initialize()
    print("[CraftingManager] Initializing crafting system...")
    
    -- Инициализация рецептов
    self:InitializeRecipes()
    
    -- Инициализация станций крафтинга
    self:InitializeCraftingStations()
    
    -- Инициализация настроек крафтинга
    self:InitializeCraftingSettings()
    
    print("[CraftingManager] Crafting system initialized!")
end

-- Инициализация рецептов
function CraftingManager:InitializeRecipes()
    self.recipes = {
        -- Оружие
        weapons = {
            basic_sword = {
                name = "Базовый меч",
                category = "weapon",
                rarity = "common",
                level = 1,
                ingredients = {
                    {itemId = "iron", quantity = 3},
                    {itemId = "wood", quantity = 2}
                },
                result = {
                    itemId = "basic_sword",
                    quantity = 1,
                    stats = {damage = 20, attackSpeed = 1.0}
                },
                craftingTime = 5,
                experience = 10
            },
            
            iron_sword = {
                name = "Железный меч",
                category = "weapon",
                rarity = "uncommon",
                level = 5,
                ingredients = {
                    {itemId = "iron", quantity = 5},
                    {itemId = "wood", quantity = 3},
                    {itemId = "crystal", quantity = 1}
                },
                result = {
                    itemId = "iron_sword",
                    quantity = 1,
                    stats = {damage = 35, attackSpeed = 1.1}
                },
                craftingTime = 10,
                experience = 25
            },
            
            crystal_sword = {
                name = "Кристальный меч",
                category = "weapon",
                rarity = "rare",
                level = 10,
                ingredients = {
                    {itemId = "iron", quantity = 8},
                    {itemId = "crystal", quantity = 3},
                    {itemId = "gems", quantity = 2}
                },
                result = {
                    itemId = "crystal_sword",
                    quantity = 1,
                    stats = {damage = 50, attackSpeed = 1.2, magicDamage = 20}
                },
                craftingTime = 20,
                experience = 50
            },
            
            basic_bow = {
                name = "Базовый лук",
                category = "weapon",
                rarity = "common",
                level = 3,
                ingredients = {
                    {itemId = "wood", quantity = 4},
                    {itemId = "iron", quantity = 1}
                },
                result = {
                    itemId = "basic_bow",
                    quantity = 1,
                    stats = {damage = 25, attackSpeed = 1.5, range = 40}
                },
                craftingTime = 8,
                experience = 15
            }
        },
        
        -- Броня
        armor = {
            leather_armor = {
                name = "Кожаная броня",
                category = "armor",
                rarity = "common",
                level = 2,
                ingredients = {
                    {itemId = "wood", quantity = 3},
                    {itemId = "iron", quantity = 1}
                },
                result = {
                    itemId = "leather_armor",
                    quantity = 1,
                    stats = {defense = 15, health = 20}
                },
                craftingTime = 6,
                experience = 12
            },
            
            iron_armor = {
                name = "Железная броня",
                category = "armor",
                rarity = "uncommon",
                level = 6,
                ingredients = {
                    {itemId = "iron", quantity = 6},
                    {itemId = "crystal", quantity = 1}
                },
                result = {
                    itemId = "iron_armor",
                    quantity = 1,
                    stats = {defense = 30, health = 40}
                },
                craftingTime = 12,
                experience = 30
            },
            
            crystal_armor = {
                name = "Кристальная броня",
                category = "armor",
                rarity = "rare",
                level = 12,
                ingredients = {
                    {itemId = "iron", quantity = 10},
                    {itemId = "crystal", quantity = 4},
                    {itemId = "gems", quantity = 3}
                },
                result = {
                    itemId = "crystal_armor",
                    quantity = 1,
                    stats = {defense = 45, health = 60, magicResist = 20}
                },
                craftingTime = 25,
                experience = 60
            }
        },
        
        -- Зелья
        potions = {
            health_potion = {
                name = "Зелье здоровья",
                category = "consumable",
                rarity = "common",
                level = 1,
                ingredients = {
                    {itemId = "wood", quantity = 2},
                    {itemId = "crystal", quantity = 1}
                },
                result = {
                    itemId = "health_potion",
                    quantity = 2,
                    effect = {heal = 50}
                },
                craftingTime = 3,
                experience = 5
            },
            
            mana_potion = {
                name = "Зелье маны",
                category = "consumable",
                rarity = "common",
                level = 2,
                ingredients = {
                    {itemId = "crystal", quantity = 2},
                    {itemId = "iron", quantity = 1}
                },
                result = {
                    itemId = "mana_potion",
                    quantity = 2,
                    effect = {mana = 50}
                },
                craftingTime = 4,
                experience = 8
            },
            
            strength_potion = {
                name = "Зелье силы",
                category = "consumable",
                rarity = "uncommon",
                level = 5,
                ingredients = {
                    {itemId = "crystal", quantity = 3},
                    {itemId = "iron", quantity = 2},
                    {itemId = "gems", quantity = 1}
                },
                result = {
                    itemId = "strength_potion",
                    quantity = 1,
                    effect = {strength = 20, duration = 300}
                },
                craftingTime = 8,
                experience = 20
            }
        },
        
        -- Строительные материалы
        materials = {
            reinforced_wood = {
                name = "Укрепленное дерево",
                category = "material",
                rarity = "uncommon",
                level = 3,
                ingredients = {
                    {itemId = "wood", quantity = 5},
                    {itemId = "iron", quantity = 1}
                },
                result = {
                    itemId = "reinforced_wood",
                    quantity = 3,
                    stats = {durability = 150}
                },
                craftingTime = 5,
                experience = 10
            },
            
            reinforced_stone = {
                name = "Укрепленный камень",
                category = "material",
                rarity = "uncommon",
                level = 4,
                ingredients = {
                    {itemId = "stone", quantity = 5},
                    {itemId = "iron", quantity = 2}
                },
                result = {
                    itemId = "reinforced_stone",
                    quantity = 3,
                    stats = {durability = 200}
                },
                craftingTime = 6,
                experience = 12
            },
            
            magic_crystal = {
                name = "Магический кристалл",
                category = "material",
                rarity = "rare",
                level = 8,
                ingredients = {
                    {itemId = "crystal", quantity = 3},
                    {itemId = "gems", quantity = 2}
                },
                result = {
                    itemId = "magic_crystal",
                    quantity = 1,
                    stats = {magicPower = 50}
                },
                craftingTime = 15,
                experience = 35
            }
        },
        
        -- Специальные предметы
        special = {
            repair_kit = {
                name = "Ремонтный набор",
                category = "tool",
                rarity = "uncommon",
                level = 4,
                ingredients = {
                    {itemId = "iron", quantity = 3},
                    {itemId = "wood", quantity = 2},
                    {itemId = "crystal", quantity = 1}
                },
                result = {
                    itemId = "repair_kit",
                    quantity = 1,
                    effect = {repair = 100}
                },
                craftingTime = 7,
                experience = 15
            },
            
            teleport_scroll = {
                name = "Свиток телепортации",
                category = "consumable",
                rarity = "rare",
                level = 7,
                ingredients = {
                    {itemId = "crystal", quantity = 4},
                    {itemId = "gems", quantity = 3}
                },
                result = {
                    itemId = "teleport_scroll",
                    quantity = 1,
                    effect = {teleport = true}
                },
                craftingTime = 12,
                experience = 30
            },
            
            legendary_core = {
                name = "Легендарное ядро",
                category = "material",
                rarity = "legendary",
                level = 15,
                ingredients = {
                    {itemId = "crystal", quantity = 10},
                    {itemId = "gems", quantity = 10},
                    {itemId = "magic_crystal", quantity = 3}
                },
                result = {
                    itemId = "legendary_core",
                    quantity = 1,
                    stats = {power = 1000}
                },
                craftingTime = 60,
                experience = 200
            }
        }
    }
end

-- Инициализация станций крафтинга
function CraftingManager:InitializeCraftingStations()
    self.craftingStations = {
        -- Базовая кузница
        basic_forge = {
            name = "Базовая кузница",
            position = Vector3.new(0, 5, 0),
            recipes = {"weapons", "armor"},
            maxLevel = 5,
            efficiency = 1.0
        },
        
        -- Продвинутая кузница
        advanced_forge = {
            name = "Продвинутая кузница",
            position = Vector3.new(10, 5, 0),
            recipes = {"weapons", "armor", "materials"},
            maxLevel = 10,
            efficiency = 1.5
        },
        
        -- Алхимическая лаборатория
        alchemy_lab = {
            name = "Алхимическая лаборатория",
            position = Vector3.new(-10, 5, 0),
            recipes = {"potions", "special"},
            maxLevel = 8,
            efficiency = 1.2
        },
        
        -- Магическая мастерская
        magic_workshop = {
            name = "Магическая мастерская",
            position = Vector3.new(0, 5, 10),
            recipes = {"weapons", "armor", "potions", "special", "materials"},
            maxLevel = 15,
            efficiency = 2.0
        }
    }
end

-- Инициализация настроек крафтинга
function CraftingManager:InitializeCraftingSettings()
    self.craftingSettings = {
        -- Настройки качества
        qualitySettings = {
            common = {successRate = 100, bonusChance = 0},
            uncommon = {successRate = 95, bonusChance = 5},
            rare = {successRate = 85, bonusChance = 10},
            epic = {successRate = 70, bonusChance = 15},
            legendary = {successRate = 50, bonusChance = 20}
        },
        
        -- Настройки опыта
        experienceSettings = {
            baseExperience = 10,
            levelMultiplier = 1.5,
            rarityMultiplier = {
                common = 1.0,
                uncommon = 1.5,
                rare = 2.0,
                epic = 3.0,
                legendary = 5.0
            }
        },
        
        -- Настройки времени
        timeSettings = {
            baseTime = 5,
            levelMultiplier = 1.2,
            stationEfficiency = true
        }
    }
end

-- Проверка возможности крафта
function CraftingManager:CanCraft(player, recipeId, stationId)
    local recipe = self:GetRecipe(recipeId)
    if not recipe then return false, "Рецепт не найден" end
    
    local station = self.craftingStations[stationId]
    if not station then return false, "Станция не найдена" end
    
    -- Проверка уровня игрока
    local playerLevel = ProfileService:GetPlayerLevel(player)
    if playerLevel < recipe.level then
        return false, "Недостаточный уровень: " .. recipe.level
    end
    
    -- Проверка доступности рецепта на станции
    local canCraftOnStation = false
    for _, category in pairs(station.recipes) do
        if self.recipes[category] and self.recipes[category][recipeId] then
            canCraftOnStation = true
            break
        end
    end
    
    if not canCraftOnStation then
        return false, "Рецепт недоступен на этой станции"
    end
    
    -- Проверка ингредиентов
    for _, ingredient in pairs(recipe.ingredients) do
        if not InventoryManager:HasItem(player, ingredient.itemId, ingredient.quantity) then
            return false, "Недостаточно " .. ingredient.itemId
        end
    end
    
    return true, "Можно крафтить"
end

-- Начало крафта
function CraftingManager:StartCrafting(player, recipeId, stationId, quantity)
    quantity = quantity or 1
    
    local canCraft, message = self:CanCraft(player, recipeId, stationId)
    if not canCraft then
        return false, message
    end
    
    local recipe = self:GetRecipe(recipeId)
    local station = self.craftingStations[stationId]
    
    -- Списание ингредиентов
    for _, ingredient in pairs(recipe.ingredients) do
        local totalQuantity = ingredient.quantity * quantity
        InventoryManager:RemoveItem(player, ingredient.itemId, totalQuantity)
    end
    
    -- Расчет времени крафта
    local craftingTime = self:CalculateCraftingTime(recipe, station, quantity)
    
    -- Создание задачи крафта
    local craftingTask = {
        player = player,
        recipeId = recipeId,
        stationId = stationId,
        quantity = quantity,
        startTime = os.time(),
        endTime = os.time() + craftingTime,
        status = "crafting"
    }
    
    -- Запуск таймера крафта
    task.spawn(function()
        task.wait(craftingTime)
        self:CompleteCrafting(craftingTask)
    end)
    
    return true, "Крафт начат", craftingTime
end

-- Завершение крафта
function CraftingManager:CompleteCrafting(craftingTask)
    local player = craftingTask.player
    local recipe = self:GetRecipe(craftingTask.recipeId)
    
    if not player or not recipe then return end
    
    -- Проверка успеха крафта
    local successRate = self.craftingSettings.qualitySettings[recipe.rarity].successRate
    local success = math.random(1, 100) <= successRate
    
    if success then
        -- Добавление результата в инвентарь
        local resultQuantity = recipe.result.quantity * craftingTask.quantity
        InventoryManager:AddItem(player, recipe.result.itemId, resultQuantity)
        
        -- Проверка бонусного предмета
        local bonusChance = self.craftingSettings.qualitySettings[recipe.rarity].bonusChance
        if math.random(1, 100) <= bonusChance then
            InventoryManager:AddItem(player, recipe.result.itemId, 1)
            self:NotifyPlayer(player, "Бонусный предмет!", "success")
        end
        
        -- Начисление опыта
        local experience = self:CalculateExperience(recipe, craftingTask.quantity)
        ProfileService:AddExperience(player, experience)
        
        -- Уведомление об успехе
        self:NotifyPlayer(player, "Крафт завершен: " .. recipe.name, "success")
        
        -- Отслеживание статистики
        self:TrackCraftingSuccess(player, recipe)
    else
        -- Возврат части ингредиентов при неудаче
        for _, ingredient in pairs(recipe.ingredients) do
            local returnQuantity = math.floor(ingredient.quantity * craftingTask.quantity * 0.5)
            if returnQuantity > 0 then
                InventoryManager:AddItem(player, ingredient.itemId, returnQuantity)
            end
        end
        
        -- Уведомление о неудаче
        self:NotifyPlayer(player, "Крафт не удался!", "error")
        
        -- Отслеживание статистики
        self:TrackCraftingFailure(player, recipe)
    end
end

-- Расчет времени крафта
function CraftingManager:CalculateCraftingTime(recipe, station, quantity)
    local baseTime = recipe.craftingTime * quantity
    local levelMultiplier = math.pow(self.craftingSettings.timeSettings.levelMultiplier, recipe.level - 1)
    
    local finalTime = baseTime * levelMultiplier
    
    if self.craftingSettings.timeSettings.stationEfficiency then
        finalTime = finalTime / station.efficiency
    end
    
    return finalTime
end

-- Расчет опыта за крафт
function CraftingManager:CalculateExperience(recipe, quantity)
    local baseExp = recipe.experience * quantity
    local rarityMultiplier = self.craftingSettings.experienceSettings.rarityMultiplier[recipe.rarity] or 1.0
    
    return math.floor(baseExp * rarityMultiplier)
end

-- Получение рецепта
function CraftingManager:GetRecipe(recipeId)
    for category, recipes in pairs(self.recipes) do
        if recipes[recipeId] then
            return recipes[recipeId]
        end
    end
    return nil
end

-- Получение всех рецептов
function CraftingManager:GetAllRecipes()
    local allRecipes = {}
    
    for category, recipes in pairs(self.recipes) do
        allRecipes[category] = {}
        for recipeId, recipe in pairs(recipes) do
            table.insert(allRecipes[category], {
                id = recipeId,
                name = recipe.name,
                category = recipe.category,
                rarity = recipe.rarity,
                level = recipe.level,
                ingredients = recipe.ingredients,
                result = recipe.result,
                craftingTime = recipe.craftingTime,
                experience = recipe.experience
            })
        end
    end
    
    return allRecipes
end

-- Получение доступных рецептов для игрока
function CraftingManager:GetAvailableRecipes(player, stationId)
    local playerLevel = ProfileService:GetPlayerLevel(player)
    local station = self.craftingStations[stationId]
    
    if not station then return {} end
    
    local availableRecipes = {}
    
    for _, category in pairs(station.recipes) do
        if self.recipes[category] then
            for recipeId, recipe in pairs(self.recipes[category]) do
                if playerLevel >= recipe.level then
                    local canCraft, _ = self:CanCraft(player, recipeId, stationId)
                    table.insert(availableRecipes, {
                        id = recipeId,
                        recipe = recipe,
                        canCraft = canCraft
                    })
                end
            end
        end
    end
    
    return availableRecipes
end

-- Получение информации о станции
function CraftingManager:GetStationInfo(stationId)
    return self.craftingStations[stationId]
end

-- Получение всех станций
function CraftingManager:GetAllStations()
    return self.craftingStations
end

-- Уведомление игрока
function CraftingManager:NotifyPlayer(player, message, type)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, type, 3)
end

-- Отслеживание успешного крафта
function LootManager:TrackCraftingSuccess(player, recipe)
    -- Здесь можно добавить статистику крафтинга
    -- Например, количество успешных крафтов, опыт и т.д.
end

-- Отслеживание неудачного крафта
function LootManager:TrackCraftingFailure(player, recipe)
    -- Здесь можно добавить статистику неудач
end

-- Создание станции крафтинга в мире
function CraftingManager:CreateCraftingStation(stationId, position)
    local station = self.craftingStations[stationId]
    if not station then return nil end
    
    local stationPart = Instance.new("Part")
    stationPart.Name = station.name
    stationPart.Position = position
    stationPart.Size = Vector3.new(4, 2, 4)
    stationPart.Anchored = true
    stationPart.CanCollide = true
    stationPart.Material = Enum.Material.Metal
    stationPart.Color = Color3.fromRGB(100, 100, 100)
    stationPart.Parent = workspace
    
    -- Добавление UI для станции
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 100)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = stationPart
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = billboardGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = station.name
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = frame
    
    return stationPart
end

-- Очистка системы крафтинга
function CraftingManager:Cleanup()
    self.recipes = {}
    self.craftingStations = {}
    self.craftingSettings = {}
end

return CraftingManager