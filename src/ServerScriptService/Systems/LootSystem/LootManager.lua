-- LootManager.lua
-- Полная система лута и дропа предметов

local LootManager = {}
LootManager.__index = LootManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local EconomyManager = require(script.Parent.Parent.EconomySystem.EconomyManager)
local InventoryManager = require(script.Parent.Parent.InventorySystem.InventoryManager)

-- Состояние
LootManager.lootTables = {}
LootManager.activeLoot = {}
LootManager.lootSettings = {}

function LootManager:Initialize()
    print("[LootManager] Initializing loot system...")
    
    -- Инициализация таблиц лута
    self:InitializeLootTables()
    
    -- Инициализация настроек лута
    self:InitializeLootSettings()
    
    print("[LootManager] Loot system initialized!")
end

-- Инициализация таблиц лута
function LootManager:InitializeLootTables()
    self.lootTables = {
        -- Лут с обычных врагов
        common_enemy = {
            guaranteed = {
                {itemId = "wood", minQuantity = 1, maxQuantity = 3, chance = 100},
                {itemId = "stone", minQuantity = 1, maxQuantity = 2, chance = 100}
            },
            possible = {
                {itemId = "iron", minQuantity = 1, maxQuantity = 1, chance = 30},
                {itemId = "health_potion", minQuantity = 1, maxQuantity = 1, chance = 20},
                {itemId = "gold", minQuantity = 5, maxQuantity = 15, chance = 50}
            },
            rare = {
                {itemId = "crystal", minQuantity = 1, maxQuantity = 1, chance = 5},
                {itemId = "sword", minQuantity = 1, maxQuantity = 1, chance = 2},
                {itemId = "gems", minQuantity = 1, maxQuantity = 3, chance = 1}
            }
        },
        
        -- Лут с элитных врагов
        elite_enemy = {
            guaranteed = {
                {itemId = "wood", minQuantity = 2, maxQuantity = 5, chance = 100},
                {itemId = "stone", minQuantity = 2, maxQuantity = 4, chance = 100},
                {itemId = "iron", minQuantity = 1, maxQuantity = 2, chance = 100}
            },
            possible = {
                {itemId = "crystal", minQuantity = 1, maxQuantity = 2, chance = 40},
                {itemId = "health_potion", minQuantity = 1, maxQuantity = 2, chance = 60},
                {itemId = "mana_potion", minQuantity = 1, maxQuantity = 1, chance = 40},
                {itemId = "gold", minQuantity = 15, maxQuantity = 35, chance = 80}
            },
            rare = {
                {itemId = "axe", minQuantity = 1, maxQuantity = 1, chance = 10},
                {itemId = "leather_armor", minQuantity = 1, maxQuantity = 1, chance = 8},
                {itemId = "gems", minQuantity = 2, maxQuantity = 5, chance = 5},
                {itemId = "strength_potion", minQuantity = 1, maxQuantity = 1, chance = 15}
            }
        },
        
        -- Лут с боссов
        boss_enemy = {
            guaranteed = {
                {itemId = "wood", minQuantity = 5, maxQuantity = 10, chance = 100},
                {itemId = "stone", minQuantity = 5, maxQuantity = 8, chance = 100},
                {itemId = "iron", minQuantity = 3, maxQuantity = 6, chance = 100},
                {itemId = "crystal", minQuantity = 2, maxQuantity = 4, chance = 100}
            },
            possible = {
                {itemId = "health_potion", minQuantity = 2, maxQuantity = 4, chance = 100},
                {itemId = "mana_potion", minQuantity = 2, maxQuantity = 3, chance = 80},
                {itemId = "strength_potion", minQuantity = 1, maxQuantity = 2, chance = 60},
                {itemId = "gold", minQuantity = 50, maxQuantity = 100, chance = 100}
            },
            rare = {
                {itemId = "bow", minQuantity = 1, maxQuantity = 1, chance = 25},
                {itemId = "chain_armor", minQuantity = 1, maxQuantity = 1, chance = 20},
                {itemId = "gems", minQuantity = 5, maxQuantity = 10, chance = 15},
                {itemId = "plate_armor", minQuantity = 1, maxQuantity = 1, chance = 5}
            },
            legendary = {
                {itemId = "legendary_sword", minQuantity = 1, maxQuantity = 1, chance = 1},
                {itemId = "legendary_armor", minQuantity = 1, maxQuantity = 1, chance = 1},
                {itemId = "dragon_scale", minQuantity = 1, maxQuantity = 3, chance = 0.5}
            }
        },
        
        -- Лут с ресурсных нод
        resource_node = {
            wood_node = {
                guaranteed = {
                    {itemId = "wood", minQuantity = 3, maxQuantity = 8, chance = 100}
                },
                possible = {
                    {itemId = "gold", minQuantity = 1, maxQuantity = 5, chance = 20}
                }
            },
            stone_node = {
                guaranteed = {
                    {itemId = "stone", minQuantity = 3, maxQuantity = 8, chance = 100}
                },
                possible = {
                    {itemId = "iron", minQuantity = 1, maxQuantity = 2, chance = 30},
                    {itemId = "gold", minQuantity = 2, maxQuantity = 8, chance = 25}
                }
            },
            iron_node = {
                guaranteed = {
                    {itemId = "iron", minQuantity = 2, maxQuantity = 6, chance = 100}
                },
                possible = {
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 1, chance = 15},
                    {itemId = "gold", minQuantity = 5, maxQuantity = 15, chance = 40}
                }
            },
            crystal_node = {
                guaranteed = {
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 3, chance = 100}
                },
                possible = {
                    {itemId = "gems", minQuantity = 1, maxQuantity = 2, chance = 10},
                    {itemId = "gold", minQuantity = 10, maxQuantity = 25, chance = 60}
                }
            }
        },
        
        -- Лут с сундуков
        chest = {
            common_chest = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 10, maxQuantity = 30, chance = 100}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 1, maxQuantity = 2, chance = 70},
                    {itemId = "wood", minQuantity = 2, maxQuantity = 5, chance = 60},
                    {itemId = "stone", minQuantity = 2, maxQuantity = 4, chance = 50}
                },
                rare = {
                    {itemId = "iron", minQuantity = 1, maxQuantity = 2, chance = 20},
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 1, chance = 10}
                }
            },
            rare_chest = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 25, maxQuantity = 60, chance = 100},
                    {itemId = "gems", minQuantity = 1, maxQuantity = 3, chance = 100}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 2, maxQuantity = 4, chance = 80},
                    {itemId = "mana_potion", minQuantity = 1, maxQuantity = 2, chance = 70},
                    {itemId = "iron", minQuantity = 2, maxQuantity = 4, chance = 60},
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 2, chance = 40}
                },
                rare = {
                    {itemId = "sword", minQuantity = 1, maxQuantity = 1, chance = 30},
                    {itemId = "leather_armor", minQuantity = 1, maxQuantity = 1, chance = 25},
                    {itemId = "strength_potion", minQuantity = 1, maxQuantity = 1, chance = 35}
                }
            },
            legendary_chest = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 100, maxQuantity = 200, chance = 100},
                    {itemId = "gems", minQuantity = 5, maxQuantity = 10, chance = 100}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 5, maxQuantity = 10, chance = 100},
                    {itemId = "mana_potion", minQuantity = 3, maxQuantity = 6, chance = 90},
                    {itemId = "strength_potion", minQuantity = 2, maxQuantity = 4, chance = 80},
                    {itemId = "crystal", minQuantity = 3, maxQuantity = 6, chance = 70}
                },
                rare = {
                    {itemId = "bow", minQuantity = 1, maxQuantity = 1, chance = 50},
                    {itemId = "chain_armor", minQuantity = 1, maxQuantity = 1, chance = 40},
                    {itemId = "plate_armor", minQuantity = 1, maxQuantity = 1, chance = 20}
                },
                legendary = {
                    {itemId = "legendary_sword", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "legendary_armor", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "dragon_scale", minQuantity = 1, maxQuantity = 2, chance = 2}
                }
            }
        },
        
        -- Лут с волн
        wave_reward = {
            wave_5 = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 50, maxQuantity = 100, chance = 100},
                    {itemId = "gems", minQuantity = 2, maxQuantity = 5, chance = 100}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 3, maxQuantity = 6, chance = 100},
                    {itemId = "iron", minQuantity = 3, maxQuantity = 6, chance = 80},
                    {itemId = "crystal", minQuantity = 2, maxQuantity = 4, chance = 60}
                }
            },
            wave_10 = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 100, maxQuantity = 200, chance = 100},
                    {itemId = "gems", minQuantity = 5, maxQuantity = 10, chance = 100}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 5, maxQuantity = 10, chance = 100},
                    {itemId = "mana_potion", minQuantity = 3, maxQuantity = 6, chance = 100},
                    {itemId = "strength_potion", minQuantity = 2, maxQuantity = 4, chance = 80},
                    {itemId = "crystal", minQuantity = 4, maxQuantity = 8, chance = 80}
                },
                rare = {
                    {itemId = "sword", minQuantity = 1, maxQuantity = 1, chance = 40},
                    {itemId = "leather_armor", minQuantity = 1, maxQuantity = 1, chance = 35}
                }
            },
            wave_20 = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 200, maxQuantity = 400, chance = 100},
                    {itemId = "gems", minQuantity = 10, maxQuantity = 20, chance = 100}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 10, maxQuantity = 20, chance = 100},
                    {itemId = "mana_potion", minQuantity = 6, maxQuantity = 12, chance = 100},
                    {itemId = "strength_potion", minQuantity = 4, maxQuantity = 8, chance = 100},
                    {itemId = "crystal", minQuantity = 8, maxQuantity = 16, chance = 100}
                },
                rare = {
                    {itemId = "bow", minQuantity = 1, maxQuantity = 1, chance = 60},
                    {itemId = "chain_armor", minQuantity = 1, maxQuantity = 1, chance = 50},
                    {itemId = "plate_armor", minQuantity = 1, maxQuantity = 1, chance = 30}
                },
                legendary = {
                    {itemId = "legendary_sword", minQuantity = 1, maxQuantity = 1, chance = 10},
                    {itemId = "legendary_armor", minQuantity = 1, maxQuantity = 1, chance = 10}
                }
            }
        }
    }
end

-- Инициализация настроек лута
function LootManager:InitializeLootSettings()
    self.lootSettings = {
        -- Множители лута
        multipliers = {
            common = 1.0,
            uncommon = 1.2,
            rare = 1.5,
            epic = 2.0,
            legendary = 3.0
        },
        
        -- Настройки дропа
        dropSettings = {
            maxLootPerDrop = 10,
            lootLifetime = 60, -- секунды
            autoCollectDistance = 10,
            lootSpreadRadius = 3
        },
        
        -- Настройки качества
        qualitySettings = {
            common = {chance = 70, color = Color3.fromRGB(255, 255, 255)},
            uncommon = {chance = 20, color = Color3.fromRGB(0, 255, 0)},
            rare = {chance = 7, color = Color3.fromRGB(0, 100, 255)},
            epic = {chance = 2.5, color = Color3.fromRGB(255, 0, 255)},
            legendary = {chance = 0.5, color = Color3.fromRGB(255, 165, 0)}
        }
    }
end

-- Генерация лута
function LootManager:GenerateLoot(lootTableName, position, rarity)
    local lootTable = self.lootTables[lootTableName]
    if not lootTable then
        warn("[LootManager] Loot table not found:", lootTableName)
        return {}
    end
    
    local loot = {}
    rarity = rarity or "common"
    
    -- Генерация гарантированного лута
    if lootTable.guaranteed then
        for _, item in pairs(lootTable.guaranteed) do
            if math.random(1, 100) <= item.chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "common"
                })
            end
        end
    end
    
    -- Генерация возможного лута
    if lootTable.possible then
        for _, item in pairs(lootTable.possible) do
            if math.random(1, 100) <= item.chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "uncommon"
                })
            end
        end
    end
    
    -- Генерация редкого лута
    if lootTable.rare then
        for _, item in pairs(lootTable.rare) do
            if math.random(1, 100) <= item.chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "rare"
                })
            end
        end
    end
    
    -- Генерация легендарного лута
    if lootTable.legendary then
        for _, item in pairs(lootTable.legendary) do
            if math.random(1, 100) <= item.chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "legendary"
                })
            end
        end
    end
    
    -- Применение множителей
    loot = self:ApplyLootMultipliers(loot, rarity)
    
    return loot
end

-- Применение множителей лута
function LootManager:ApplyLootMultipliers(loot, rarity)
    local multiplier = self.lootSettings.multipliers[rarity] or 1.0
    
    for _, item in pairs(loot) do
        item.quantity = math.floor(item.quantity * multiplier)
    end
    
    return loot
end

-- Создание физического лута в мире
function LootManager:CreatePhysicalLoot(loot, position)
    if not loot or #loot == 0 then return end
    
    local lootContainer = Instance.new("Part")
    lootContainer.Name = "LootContainer"
    lootContainer.Position = position
    lootContainer.Size = Vector3.new(2, 1, 2)
    lootContainer.Anchored = true
    lootContainer.CanCollide = true
    lootContainer.Material = Enum.Material.Neon
    lootContainer.Color = Color3.fromRGB(255, 215, 0)
    lootContainer.Parent = workspace
    
    -- Добавление свечения
    local pointLight = Instance.new("PointLight")
    pointLight.Color = Color3.fromRGB(255, 215, 0)
    pointLight.Range = 10
    pointLight.Brightness = 2
    pointLight.Parent = lootContainer
    
    -- Создание UI для отображения лута
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 100)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = lootContainer
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = billboardGui
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = "Лут"
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold
    textLabel.Parent = frame
    
    -- Сохранение данных лута
    local lootData = {
        container = lootContainer,
        items = loot,
        createdAt = os.time()
    }
    
    table.insert(self.activeLoot, lootData)
    
    -- Подключение события сбора
    lootContainer.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = game.Players:GetPlayerFromCharacter(character)
        
        if player then
            self:CollectLoot(player, lootData)
        end
    end)
    
    -- Автоматическое удаление через время
    task.spawn(function()
        task.wait(self.lootSettings.dropSettings.lootLifetime)
        self:RemoveLoot(lootData)
    end)
    
    return lootContainer
end

-- Сбор лута игроком
function LootManager:CollectLoot(player, lootData)
    if not lootData or not lootData.container then return end
    
    local distance = (player.Character.HumanoidRootPart.Position - lootData.container.Position).Magnitude
    if distance > self.lootSettings.dropSettings.autoCollectDistance then return end
    
    -- Добавление предметов в инвентарь
    local collectedItems = {}
    for _, item in pairs(lootData.items) do
        local success = InventoryManager:AddItem(player, item.itemId, item.quantity)
        if success then
            table.insert(collectedItems, {
                itemId = item.itemId,
                quantity = item.quantity,
                quality = item.quality
            })
        end
    end
    
    -- Добавление валюты
    for _, item in pairs(lootData.items) do
        if item.itemId == "gold" then
            EconomyManager:AddCurrency(player, "gold", item.quantity, "Сбор лута")
        elseif item.itemId == "gems" then
            EconomyManager:AddCurrency(player, "gems", item.quantity, "Сбор лута")
        end
    end
    
    -- Уведомление игрока
    if #collectedItems > 0 then
        self:NotifyLootCollection(player, collectedItems)
    end
    
    -- Удаление лута
    self:RemoveLoot(lootData)
end

-- Уведомление о сборе лута
function LootManager:NotifyLootCollection(player, items)
    local message = "Получено:\n"
    for _, item in pairs(items) do
        local qualityColor = self.lootSettings.qualitySettings[item.quality].color
        message = message .. string.format("• %s x%d\n", item.itemId, item.quantity)
    end
    
    -- Отправка уведомления
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, "loot", 3)
end

-- Удаление лута
function LootManager:RemoveLoot(lootData)
    if lootData and lootData.container then
        lootData.container:Destroy()
        
        -- Удаление из активного лута
        for i, loot in pairs(self.activeLoot) do
            if loot == lootData then
                table.remove(self.activeLoot, i)
                break
            end
        end
    end
end

-- Дроп лута с врага
function LootManager:DropLootFromEnemy(enemy, enemyType, position)
    local lootTableName = enemyType .. "_enemy"
    local loot = self:GenerateLoot(lootTableName, position)
    
    if #loot > 0 then
        -- Разброс лута вокруг позиции
        for i, item in pairs(loot) do
            local offset = Vector3.new(
                math.random(-self.lootSettings.dropSettings.lootSpreadRadius, self.lootSettings.dropSettings.lootSpreadRadius),
                0,
                math.random(-self.lootSettings.dropSettings.lootSpreadRadius, self.lootSettings.dropSettings.lootSpreadRadius)
            )
            local dropPosition = position + offset
            
            self:CreatePhysicalLoot({item}, dropPosition)
        end
    end
end

-- Дроп лута с ресурсной ноды
function LootManager:DropLootFromResourceNode(nodeType, position)
    local lootTableName = nodeType .. "_node"
    local loot = self:GenerateLoot(lootTableName, position)
    
    if #loot > 0 then
        self:CreatePhysicalLoot(loot, position)
    end
end

-- Открытие сундука
function LootManager:OpenChest(chestType, position, player)
    local lootTableName = chestType .. "_chest"
    local loot = self:GenerateLoot(lootTableName, position)
    
    if #loot > 0 then
        -- Добавление предметов напрямую в инвентарь
        for _, item in pairs(loot) do
            InventoryManager:AddItem(player, item.itemId, item.quantity)
            
            -- Добавление валюты
            if item.itemId == "gold" then
                EconomyManager:AddCurrency(player, "gold", item.quantity, "Открытие сундука")
            elseif item.itemId == "gems" then
                EconomyManager:AddCurrency(player, "gems", item.quantity, "Открытие сундука")
            end
        end
        
        -- Уведомление
        self:NotifyLootCollection(player, loot)
    end
end

-- Награда за волну
function LootManager:GiveWaveReward(waveNumber, players)
    local lootTableName = "wave_" .. waveNumber
    local lootTable = self.lootTables.wave_reward[lootTableName]
    
    if not lootTable then
        -- Использование ближайшей доступной награды
        local availableWaves = {"wave_5", "wave_10", "wave_20"}
        for _, wave in pairs(availableWaves) do
            if self.lootTables.wave_reward[wave] then
                lootTableName = wave
                lootTable = self.lootTables.wave_reward[wave]
                break
            end
        end
    end
    
    if lootTable then
        for _, player in pairs(players) do
            local loot = self:GenerateLoot(lootTableName, Vector3.new(0, 0, 0))
            
            for _, item in pairs(loot) do
                InventoryManager:AddItem(player, item.itemId, item.quantity)
                
                if item.itemId == "gold" then
                    EconomyManager:AddCurrency(player, "gold", item.quantity, "Награда за волну")
                elseif item.itemId == "gems" then
                    EconomyManager:AddCurrency(player, "gems", item.quantity, "Награда за волну")
                end
            end
            
            self:NotifyLootCollection(player, loot)
        end
    end
end

-- Получение информации о луте
function LootManager:GetLootInfo(lootTableName)
    return self.lootTables[lootTableName]
end

-- Получение активного лута
function LootManager:GetActiveLoot()
    return self.activeLoot
end

-- Очистка всего лута
function LootManager:ClearAllLoot()
    for _, lootData in pairs(self.activeLoot) do
        self:RemoveLoot(lootData)
    end
end

-- Очистка системы лута
function LootManager:Cleanup()
    self:ClearAllLoot()
    
    self.lootTables = {}
    self.activeLoot = {}
    self.lootSettings = {}
end

return LootManager