-- EconomyManager.lua
-- Полная система экономики и магазина

local EconomyManager = {}
EconomyManager.__index = EconomyManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)

-- Состояние
EconomyManager.currencies = {}
EconomyManager.items = {}
EconomyManager.shopItems = {}
EconomyManager.transactions = {}
EconomyManager.economySettings = {}

function EconomyManager:Initialize()
    print("[EconomyManager] Initializing economy system...")
    
    -- Инициализация валют
    self:InitializeCurrencies()
    
    -- Инициализация предметов
    self:InitializeItems()
    
    -- Инициализация магазина
    self:InitializeShop()
    
    -- Инициализация настроек экономики
    self:InitializeEconomySettings()
    
    print("[EconomyManager] Economy system initialized!")
end

-- Инициализация валют
function EconomyManager:InitializeCurrencies()
    self.currencies = {
        gold = {
            name = "Золото",
            symbol = "G",
            color = Color3.fromRGB(255, 215, 0),
            description = "Основная валюта игры"
        },
        gems = {
            name = "Кристаллы",
            symbol = "C",
            color = Color3.fromRGB(138, 43, 226),
            description = "Премиум валюта"
        },
        experience = {
            name = "Опыт",
            symbol = "XP",
            color = Color3.fromRGB(0, 255, 0),
            description = "Опыт для повышения уровня"
        },
        honor = {
            name = "Честь",
            symbol = "H",
            color = Color3.fromRGB(255, 0, 0),
            description = "Валюта за достижения"
        }
    }
end

-- Инициализация предметов
function EconomyManager:InitializeItems()
    self.items = {
        -- Оружие
        weapons = {
            sword = {
                name = "Меч",
                type = "weapon",
                rarity = "common",
                price = {gold = 100},
                stats = {damage = 25, attackSpeed = 1.0},
                description = "Обычный меч"
            },
            axe = {
                name = "Топор",
                type = "weapon",
                rarity = "uncommon",
                price = {gold = 250},
                stats = {damage = 35, attackSpeed = 0.8},
                description = "Мощный топор"
            },
            bow = {
                name = "Лук",
                type = "weapon",
                rarity = "rare",
                price = {gold = 500, gems = 10},
                stats = {damage = 30, attackSpeed = 1.2, range = 50},
                description = "Дальнобойный лук"
            }
        },
        
        -- Броня
        armor = {
            leather_armor = {
                name = "Кожаная броня",
                type = "armor",
                rarity = "common",
                price = {gold = 150},
                stats = {defense = 15},
                description = "Легкая кожаная броня"
            },
            chain_armor = {
                name = "Кольчужная броня",
                type = "armor",
                rarity = "uncommon",
                price = {gold = 300},
                stats = {defense = 25},
                description = "Надежная кольчужная броня"
            },
            plate_armor = {
                name = "Латная броня",
                type = "armor",
                rarity = "rare",
                price = {gold = 600, gems = 15},
                stats = {defense = 40},
                description = "Тяжелая латная броня"
            }
        },
        
        -- Зелья
        potions = {
            health_potion = {
                name = "Зелье здоровья",
                type = "consumable",
                rarity = "common",
                price = {gold = 50},
                effect = {heal = 50},
                description = "Восстанавливает 50 здоровья"
            },
            mana_potion = {
                name = "Зелье маны",
                type = "consumable",
                rarity = "common",
                price = {gold = 50},
                effect = {mana = 50},
                description = "Восстанавливает 50 маны"
            },
            strength_potion = {
                name = "Зелье силы",
                type = "consumable",
                rarity = "uncommon",
                price = {gold = 100},
                effect = {strength = 20, duration = 300},
                description = "Увеличивает силу на 20 на 5 минут"
            }
        },
        
        -- Материалы
        materials = {
            wood = {
                name = "Дерево",
                type = "material",
                rarity = "common",
                price = {gold = 10},
                description = "Базовый строительный материал"
            },
            stone = {
                name = "Камень",
                type = "material",
                rarity = "common",
                price = {gold = 15},
                description = "Прочный строительный материал"
            },
            iron = {
                name = "Железо",
                type = "material",
                rarity = "uncommon",
                price = {gold = 25},
                description = "Металл для оружия и брони"
            },
            crystal = {
                name = "Кристалл",
                type = "material",
                rarity = "rare",
                price = {gold = 100, gems = 5},
                description = "Магический кристалл"
            }
        }
    }
end

-- Инициализация магазина
function EconomyManager:InitializeShop()
    self.shopItems = {
        -- Обычный магазин
        regular = {
            health_potion = {price = {gold = 50}, stock = -1},
            mana_potion = {price = {gold = 50}, stock = -1},
            wood = {price = {gold = 10}, stock = -1},
            stone = {price = {gold = 15}, stock = -1},
            iron = {price = {gold = 25}, stock = -1}
        },
        
        -- Премиум магазин
        premium = {
            strength_potion = {price = {gems = 5}, stock = -1},
            crystal = {price = {gems = 10}, stock = -1},
            bow = {price = {gems = 20}, stock = 1},
            plate_armor = {price = {gems = 30}, stock = 1}
        },
        
        -- Магазин достижений
        achievement = {
            honor_sword = {price = {honor = 100}, stock = 1},
            honor_armor = {price = {honor = 150}, stock = 1},
            honor_potion = {price = {honor = 25}, stock = -1}
        }
    }
end

-- Инициализация настроек экономики
function EconomyManager:InitializeEconomySettings()
    self.economySettings = {
        -- Множители цен
        priceMultipliers = {
            common = 1.0,
            uncommon = 1.5,
            rare = 2.0,
            epic = 3.0,
            legendary = 5.0
        },
        
        -- Лимиты валют
        currencyLimits = {
            gold = 999999,
            gems = 99999,
            experience = 9999999,
            honor = 99999
        },
        
        -- Настройки транзакций
        transactionSettings = {
            maxTransactionAmount = 10000,
            transactionLogEnabled = true,
            antiCheatEnabled = true
        }
    }
end

-- Получение баланса игрока
function EconomyManager:GetPlayerBalance(player, currency)
    local profile = ProfileService:GetProfile(player)
    if not profile then return 0 end
    
    return profile.data.currencies[currency] or 0
end

-- Установка баланса игрока
function EconomyManager:SetPlayerBalance(player, currency, amount)
    local profile = ProfileService:GetProfile(player)
    if not profile then return false end
    
    local limit = self.economySettings.currencyLimits[currency]
    if limit then
        amount = math.clamp(amount, 0, limit)
    end
    
    profile.data.currencies[currency] = amount
    return true
end

-- Добавление валюты игроку
function EconomyManager:AddCurrency(player, currency, amount, reason)
    if amount <= 0 then return false end
    
    local currentBalance = self:GetPlayerBalance(player, currency)
    local newBalance = currentBalance + amount
    
    local success = self:SetPlayerBalance(player, currency, newBalance)
    
    if success and self.economySettings.transactionSettings.transactionLogEnabled then
        self:LogTransaction(player, "add", currency, amount, reason)
    end
    
    return success
end

-- Списание валюты у игрока
function EconomyManager:RemoveCurrency(player, currency, amount, reason)
    if amount <= 0 then return false end
    
    local currentBalance = self:GetPlayerBalance(player, currency)
    if currentBalance < amount then return false end
    
    local newBalance = currentBalance - amount
    local success = self:SetPlayerBalance(player, currency, newBalance)
    
    if success and self.economySettings.transactionSettings.transactionLogEnabled then
        self:LogTransaction(player, "remove", currency, amount, reason)
    end
    
    return success
end

-- Проверка достаточности средств
function EconomyManager:HasEnoughCurrency(player, currency, amount)
    local balance = self:GetPlayerBalance(player, currency)
    return balance >= amount
end

-- Покупка предмета
function EconomyManager:PurchaseItem(player, itemId, quantity)
    quantity = quantity or 1
    
    -- Получение информации о предмете
    local item = self:GetItemInfo(itemId)
    if not item then
        warn("[EconomyManager] Item not found:", itemId)
        return false, "Предмет не найден"
    end
    
    -- Проверка наличия в магазине
    local shopItem = self:GetShopItem(itemId)
    if not shopItem then
        return false, "Предмет недоступен в магазине"
    end
    
    -- Проверка остатка
    if shopItem.stock > 0 and shopItem.stock < quantity then
        return false, "Недостаточно товара"
    end
    
    -- Расчет общей стоимости
    local totalCost = {}
    for currency, price in pairs(shopItem.price) do
        totalCost[currency] = price * quantity
    end
    
    -- Проверка средств
    for currency, cost in pairs(totalCost) do
        if not self:HasEnoughCurrency(player, currency, cost) then
            return false, "Недостаточно " .. self.currencies[currency].name
        end
    end
    
    -- Списание валюты
    for currency, cost in pairs(totalCost) do
        local success = self:RemoveCurrency(player, currency, cost, "Покупка " .. item.name)
        if not success then
            return false, "Ошибка списания валюты"
        end
    end
    
    -- Добавление предмета в инвентарь
    local inventory = ProfileService:GetPlayerInventory(player)
    if inventory then
        inventory:AddItem(itemId, quantity)
    end
    
    -- Обновление остатка в магазине
    if shopItem.stock > 0 then
        shopItem.stock = shopItem.stock - quantity
    end
    
    -- Логирование транзакции
    self:LogTransaction(player, "purchase", itemId, quantity, "Покупка " .. item.name)
    
    return true, "Покупка успешна"
end

-- Продажа предмета
function EconomyManager:SellItem(player, itemId, quantity)
    quantity = quantity or 1
    
    -- Получение информации о предмете
    local item = self:GetItemInfo(itemId)
    if not item then
        return false, "Предмет не найден"
    end
    
    -- Проверка наличия предмета в инвентаре
    local inventory = ProfileService:GetPlayerInventory(player)
    if not inventory or not inventory:HasItem(itemId, quantity) then
        return false, "Недостаточно предметов"
    end
    
    -- Расчет стоимости продажи (обычно 50% от цены покупки)
    local sellPrice = {}
    for currency, price in pairs(item.price) do
        sellPrice[currency] = math.floor(price * 0.5 * quantity)
    end
    
    -- Удаление предмета из инвентаря
    inventory:RemoveItem(itemId, quantity)
    
    -- Добавление валюты
    for currency, amount in pairs(sellPrice) do
        self:AddCurrency(player, currency, amount, "Продажа " .. item.name)
    end
    
    -- Логирование транзакции
    self:LogTransaction(player, "sell", itemId, quantity, "Продажа " .. item.name)
    
    return true, "Продажа успешна"
end

-- Получение информации о предмете
function EconomyManager:GetItemInfo(itemId)
    for category, items in pairs(self.items) do
        if items[itemId] then
            return items[itemId]
        end
    end
    return nil
end

-- Получение информации о товаре в магазине
function EconomyManager:GetShopItem(itemId)
    for shopType, items in pairs(self.shopItems) do
        if items[itemId] then
            return items[itemId]
        end
    end
    return nil
end

-- Получение списка товаров в магазине
function EconomyManager:GetShopItems(shopType)
    return self.shopItems[shopType] or {}
end

-- Получение списка всех предметов
function EconomyManager:GetAllItems()
    local allItems = {}
    
    for category, items in pairs(self.items) do
        allItems[category] = {}
        for itemId, item in pairs(items) do
            table.insert(allItems[category], {
                id = itemId,
                name = item.name,
                type = item.type,
                rarity = item.rarity,
                price = item.price,
                description = item.description
            })
        end
    end
    
    return allItems
end

-- Логирование транзакции
function EconomyManager:LogTransaction(player, action, item, amount, reason)
    local transaction = {
        player = player.Name,
        userId = player.UserId,
        action = action,
        item = item,
        amount = amount,
        reason = reason,
        timestamp = os.time()
    }
    
    table.insert(self.transactions, transaction)
    
    -- Ограничение размера лога
    if #self.transactions > 1000 then
        table.remove(self.transactions, 1)
    end
end

-- Получение истории транзакций игрока
function EconomyManager:GetPlayerTransactionHistory(player, limit)
    limit = limit or 50
    
    local playerTransactions = {}
    for _, transaction in pairs(self.transactions) do
        if transaction.userId == player.UserId then
            table.insert(playerTransactions, transaction)
        end
    end
    
    -- Сортировка по времени (новые сначала)
    table.sort(playerTransactions, function(a, b)
        return a.timestamp > b.timestamp
    end)
    
    -- Ограничение количества
    if #playerTransactions > limit then
        local result = {}
        for i = 1, limit do
            result[i] = playerTransactions[i]
        end
        return result
    end
    
    return playerTransactions
end

-- Создание предмета
function EconomyManager:CreateItem(itemId, itemData)
    if self:GetItemInfo(itemId) then
        warn("[EconomyManager] Item already exists:", itemId)
        return false
    end
    
    -- Определение категории
    local category = itemData.type .. "s"
    if not self.items[category] then
        self.items[category] = {}
    end
    
    self.items[category][itemId] = itemData
    return true
end

-- Добавление предмета в магазин
function EconomyManager:AddItemToShop(shopType, itemId, price, stock)
    if not self.shopItems[shopType] then
        self.shopItems[shopType] = {}
    end
    
    self.shopItems[shopType][itemId] = {
        price = price,
        stock = stock or -1
    }
end

-- Удаление предмета из магазина
function EconomyManager:RemoveItemFromShop(shopType, itemId)
    if self.shopItems[shopType] and self.shopItems[shopType][itemId] then
        self.shopItems[shopType][itemId] = nil
        return true
    end
    return false
end

-- Обновление цены предмета в магазине
function EconomyManager:UpdateShopItemPrice(shopType, itemId, newPrice)
    if self.shopItems[shopType] and self.shopItems[shopType][itemId] then
        self.shopItems[shopType][itemId].price = newPrice
        return true
    end
    return false
end

-- Обновление остатка предмета в магазине
function EconomyManager:UpdateShopItemStock(shopType, itemId, newStock)
    if self.shopItems[shopType] and self.shopItems[shopType][itemId] then
        self.shopItems[shopType][itemId].stock = newStock
        return true
    end
    return false
end

-- Получение статистики экономики
function EconomyManager:GetEconomyStats()
    local stats = {
        totalTransactions = #self.transactions,
        totalItems = 0,
        totalShopItems = 0,
        currencies = {}
    }
    
    -- Подсчет предметов
    for category, items in pairs(self.items) do
        stats.totalItems = stats.totalItems + #items
    end
    
    -- Подсчет товаров в магазине
    for shopType, items in pairs(self.shopItems) do
        stats.totalShopItems = stats.totalShopItems + #items
    end
    
    -- Информация о валютах
    for currencyId, currency in pairs(self.currencies) do
        stats.currencies[currencyId] = {
            name = currency.name,
            symbol = currency.symbol,
            color = currency.color
        }
    end
    
    return stats
end

-- Очистка системы экономики
function EconomyManager:Cleanup()
    self.currencies = {}
    self.items = {}
    self.shopItems = {}
    self.transactions = {}
    self.economySettings = {}
end

return EconomyManager