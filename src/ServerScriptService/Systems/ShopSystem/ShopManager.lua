-- ShopManager.lua
-- Полная система магазина с покупками за опыт и валюту

local ShopManager = {}
ShopManager.__index = ShopManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local EconomyManager = require(script.Parent.Parent.EconomySystem.EconomyManager)
local InventoryManager = require(script.Parent.Parent.InventorySystem.InventoryManager)
local ProgressionManager = require(script.Parent.Parent.ProgressionSystem.ProgressionManager)

-- Состояние
ShopManager.shops = {}
ShopManager.dailyOffers = {}
ShopManager.weeklyOffers = {}
ShopManager.specialOffers = {}

function ShopManager:Initialize()
    print("[ShopManager] Initializing shop system...")
    
    -- Инициализация магазинов
    self:InitializeShops()
    self:InitializeDailyOffers()
    self:InitializeWeeklyOffers()
    self:InitializeSpecialOffers()
    
    -- Запуск обновления предложений
    self:StartOfferUpdates()
    
    print("[ShopManager] Shop system initialized!")
end

-- Инициализация магазинов
function ShopManager:InitializeShops()
    self.shops = {
        -- Магазин за золото
        gold_shop = {
            name = "Магазин за золото",
            currency = "gold",
            items = {
                -- Оружие
                basic_sword = {price = 100, category = "weapon", level = 1},
                iron_sword = {price = 500, category = "weapon", level = 5},
                crystal_sword = {price = 2000, category = "weapon", level = 10},
                
                -- Броня
                leather_armor = {price = 150, category = "armor", level = 2},
                iron_armor = {price = 750, category = "armor", level = 6},
                crystal_armor = {price = 3000, category = "armor", level = 12},
                
                -- Зелья
                health_potion = {price = 50, category = "potion", level = 1},
                mana_potion = {price = 75, category = "potion", level = 2},
                strength_potion = {price = 200, category = "potion", level = 5},
                
                -- Материалы
                wood = {price = 10, category = "material", level = 1},
                stone = {price = 15, category = "material", level = 1},
                iron = {price = 50, category = "material", level = 3},
                crystal = {price = 200, category = "material", level = 8},
                
                -- Инструменты
                repair_kit = {price = 300, category = "tool", level = 4},
                teleport_scroll = {price = 500, category = "consumable", level = 7}
            }
        },
        
        -- Магазин за драгоценные камни
        gem_shop = {
            name = "Премиум магазин",
            currency = "gems",
            items = {
                -- Премиум оружие
                premium_sword = {price = 50, category = "weapon", level = 5},
                premium_crystal_sword = {price = 150, category = "weapon", level = 10},
                premium_legendary_sword = {price = 500, category = "weapon", level = 15},
                
                -- Премиум броня
                premium_armor = {price = 75, category = "armor", level = 6},
                premium_crystal_armor = {price = 200, category = "armor", level = 12},
                premium_legendary_armor = {price = 600, category = "armor", level = 18},
                
                -- Премиум зелья
                premium_health_potion = {price = 10, category = "potion", level = 1},
                premium_mana_potion = {price = 15, category = "potion", level = 2},
                premium_strength_potion = {price = 25, category = "potion", level = 5},
                
                -- Редкие материалы
                dragon_scale = {price = 100, category = "material", level = 20},
                legendary_core = {price = 300, category = "material", level = 15},
                
                -- Уникальные предметы
                unique_title = {price = 200, category = "cosmetic", level = 10},
                prestige_token = {price = 500, category = "special", level = 100},
                experience_boost = {price = 100, category = "boost", level = 1}
            }
        },
        
        -- Магазин за опыт
        experience_shop = {
            name = "Магазин за опыт",
            currency = "experience",
            items = {
                -- Очки навыков
                skill_point = {price = 1000, category = "progression", level = 1},
                skill_point_pack = {price = 5000, category = "progression", level = 1, quantity = 5},
                
                -- Ускорения
                experience_boost_1h = {price = 500, category = "boost", level = 1, duration = 3600},
                experience_boost_3h = {price = 1200, category = "boost", level = 1, duration = 10800},
                experience_boost_24h = {price = 8000, category = "boost", level = 1, duration = 86400},
                
                -- Специальные предметы
                reset_skill_points = {price = 2000, category = "special", level = 10},
                unlock_class = {price = 5000, category = "special", level = 5},
                
                -- Косметика
                title_veteran = {price = 3000, category = "cosmetic", level = 20},
                title_legend = {price = 10000, category = "cosmetic", level = 50},
                title_god = {price = 25000, category = "cosmetic", level = 100}
            }
        },
        
        -- Магазин за честь (PvP валюта)
        honor_shop = {
            name = "Магазин чести",
            currency = "honor",
            items = {
                -- PvP оружие
                honor_sword = {price = 1000, category = "weapon", level = 10},
                honor_bow = {price = 1200, category = "weapon", level = 12},
                
                -- PvP броня
                honor_armor = {price = 1500, category = "armor", level = 12},
                honor_helmet = {price = 800, category = "armor", level = 10},
                
                -- PvP зелья
                honor_health_potion = {price = 100, category = "potion", level = 5},
                honor_mana_potion = {price = 150, category = "potion", level = 5},
                
                -- PvP косметика
                title_warrior = {price = 5000, category = "cosmetic", level = 15},
                title_champion = {price = 15000, category = "cosmetic", level = 30},
                title_gladiator = {price = 30000, category = "cosmetic", level = 50}
            }
        },
        
        -- Магазин за достижения
        achievement_shop = {
            name = "Магазин достижений",
            currency = "achievement_points",
            items = {
                -- Уникальные предметы
                achievement_sword = {price = 100, category = "weapon", level = 10},
                achievement_armor = {price = 150, category = "armor", level = 12},
                
                -- Косметика достижений
                title_achiever = {price = 50, category = "cosmetic", level = 5},
                title_collector = {price = 100, category = "cosmetic", level = 10},
                title_master = {price = 200, category = "cosmetic", level = 20},
                
                -- Специальные эффекты
                particle_effect_golden = {price = 300, category = "cosmetic", level = 15},
                particle_effect_rainbow = {price = 500, category = "cosmetic", level = 25}
            }
        }
    }
end

-- Инициализация ежедневных предложений
function ShopManager:InitializeDailyOffers()
    self.dailyOffers = {
        -- Случайные предложения каждый день
        offers = {
            {itemId = "legendary_sword", originalPrice = 5000, discountPrice = 2500, currency = "gold"},
            {itemId = "crystal_armor", originalPrice = 3000, discountPrice = 1500, currency = "gold"},
            {itemId = "premium_health_potion", originalPrice = 10, discountPrice = 5, currency = "gems"},
            {itemId = "experience_boost_3h", originalPrice = 1200, discountPrice = 600, currency = "experience"},
            {itemId = "dragon_scale", originalPrice = 100, discountPrice = 50, currency = "gems"},
            {itemId = "skill_point_pack", originalPrice = 5000, discountPrice = 2500, currency = "experience"}
        },
        
        -- Время обновления (каждый день в 00:00)
        updateTime = 86400,
        lastUpdate = os.time()
    }
end

-- Инициализация еженедельных предложений
function ShopManager:InitializeWeeklyOffers()
    self.weeklyOffers = {
        -- Специальные предложения каждую неделю
        offers = {
            {itemId = "legendary_core", originalPrice = 300, discountPrice = 150, currency = "gems"},
            {itemId = "premium_legendary_sword", originalPrice = 500, discountPrice = 250, currency = "gems"},
            {itemId = "prestige_token", originalPrice = 500, discountPrice = 250, currency = "gems"},
            {itemId = "unique_title", originalPrice = 200, discountPrice = 100, currency = "gems"},
            {itemId = "title_god", originalPrice = 25000, discountPrice = 12500, currency = "experience"},
            {itemId = "reset_skill_points", originalPrice = 2000, discountPrice = 1000, currency = "experience"}
        },
        
        -- Время обновления (каждую неделю)
        updateTime = 604800,
        lastUpdate = os.time()
    }
end

-- Инициализация специальных предложений
function ShopManager:InitializeSpecialOffers()
    self.specialOffers = {
        -- Сезонные предложения
        seasonal = {
            halloween = {
                name = "Хэллоуин",
                items = {
                    {itemId = "pumpkin_sword", price = 1000, currency = "gold"},
                    {itemId = "ghost_armor", price = 1500, currency = "gold"},
                    {itemId = "spooky_potion", price = 200, currency = "gems"}
                }
            },
            
            christmas = {
                name = "Рождество",
                items = {
                    {itemId = "snow_sword", price = 1000, currency = "gold"},
                    {itemId = "ice_armor", price = 1500, currency = "gold"},
                    {itemId = "christmas_potion", price = 200, currency = "gems"}
                }
            },
            
            easter = {
                name = "Пасха",
                items = {
                    {itemId = "egg_sword", price = 1000, currency = "gold"},
                    {itemId = "bunny_armor", price = 1500, currency = "gold"},
                    {itemId = "easter_potion", price = 200, currency = "gems"}
                }
            }
        },
        
        -- Событийные предложения
        event = {
            boss_raid = {
                name = "Рейд на босса",
                items = {
                    {itemId = "boss_slayer_sword", price = 2000, currency = "gold"},
                    {itemId = "boss_armor", price = 3000, currency = "gold"},
                    {itemId = "boss_potion", price = 500, currency = "gems"}
                }
            },
            
            pvp_tournament = {
                name = "PvP турнир",
                items = {
                    {itemId = "tournament_sword", price = 1500, currency = "honor"},
                    {itemId = "tournament_armor", price = 2000, currency = "honor"},
                    {itemId = "tournament_title", price = 5000, currency = "honor"}
                }
            }
        }
    }
end

-- Покупка предмета
function ShopManager:PurchaseItem(player, shopId, itemId, quantity)
    quantity = quantity or 1
    
    local shop = self.shops[shopId]
    if not shop then
        return false, "Магазин не найден"
    end
    
    local item = shop.items[itemId]
    if not item then
        return false, "Предмет не найден"
    end
    
    -- Проверка уровня игрока
    local playerData = ProfileService:GetPlayerData(player)
    if playerData.level < item.level then
        return false, "Недостаточный уровень: " .. item.level
    end
    
    local totalPrice = item.price * quantity
    local currency = shop.currency
    
    -- Проверка наличия валюты
    if not EconomyManager:HasCurrency(player, currency, totalPrice) then
        return false, "Недостаточно " .. currency
    end
    
    -- Списание валюты
    EconomyManager:SpendCurrency(player, currency, totalPrice, "Покупка " .. itemId)
    
    -- Добавление предмета в инвентарь
    local actualQuantity = item.quantity or quantity
    local success = InventoryManager:AddItem(player, itemId, actualQuantity)
    
    if not success then
        -- Возврат валюты при неудаче
        EconomyManager:AddCurrency(player, currency, totalPrice, "Возврат за неудачную покупку")
        return false, "Не удалось добавить предмет в инвентарь"
    end
    
    -- Логирование покупки
    self:LogPurchase(player, shopId, itemId, quantity, totalPrice, currency)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Покупка успешна: " .. itemId .. " x" .. actualQuantity, "success")
    
    return true, "Покупка выполнена успешно"
end

-- Покупка со скидкой
function ShopManager:PurchaseDiscountedItem(player, offerType, itemId, quantity)
    quantity = quantity or 1
    
    local offers = {}
    if offerType == "daily" then
        offers = self.dailyOffers.offers
    elseif offerType == "weekly" then
        offers = self.weeklyOffers.offers
    else
        return false, "Неверный тип предложения"
    end
    
    -- Поиск предложения
    local offer = nil
    for _, o in pairs(offers) do
        if o.itemId == itemId then
            offer = o
            break
        end
    end
    
    if not offer then
        return false, "Предложение не найдено"
    end
    
    local totalPrice = offer.discountPrice * quantity
    local currency = offer.currency
    
    -- Проверка наличия валюты
    if not EconomyManager:HasCurrency(player, currency, totalPrice) then
        return false, "Недостаточно " .. currency
    end
    
    -- Списание валюты
    EconomyManager:SpendCurrency(player, currency, totalPrice, "Покупка со скидкой " .. itemId)
    
    -- Добавление предмета в инвентарь
    local success = InventoryManager:AddItem(player, itemId, quantity)
    
    if not success then
        -- Возврат валюты при неудаче
        EconomyManager:AddCurrency(player, currency, totalPrice, "Возврат за неудачную покупку")
        return false, "Не удалось добавить предмет в инвентарь"
    end
    
    -- Логирование покупки
    self:LogPurchase(player, offerType .. "_shop", itemId, quantity, totalPrice, currency)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Покупка со скидкой: " .. itemId .. " x" .. quantity, "success")
    
    return true, "Покупка со скидкой выполнена успешно"
end

-- Покупка специального предложения
function ShopManager:PurchaseSpecialOffer(player, category, eventName, itemId, quantity)
    quantity = quantity or 1
    
    local specialOffers = self.specialOffers[category]
    if not specialOffers or not specialOffers[eventName] then
        return false, "Специальное предложение не найдено"
    end
    
    local event = specialOffers[eventName]
    
    -- Поиск предмета
    local item = nil
    for _, i in pairs(event.items) do
        if i.itemId == itemId then
            item = i
            break
        end
    end
    
    if not item then
        return false, "Предмет не найден"
    end
    
    local totalPrice = item.price * quantity
    local currency = item.currency
    
    -- Проверка наличия валюты
    if not EconomyManager:HasCurrency(player, currency, totalPrice) then
        return false, "Недостаточно " .. currency
    end
    
    -- Списание валюты
    EconomyManager:SpendCurrency(player, currency, totalPrice, "Покупка специального предложения " .. itemId)
    
    -- Добавление предмета в инвентарь
    local success = InventoryManager:AddItem(player, itemId, quantity)
    
    if not success then
        -- Возврат валюты при неудаче
        EconomyManager:AddCurrency(player, currency, totalPrice, "Возврат за неудачную покупку")
        return false, "Не удалось добавить предмет в инвентарь"
    end
    
    -- Логирование покупки
    self:LogPurchase(player, "special_" .. eventName, itemId, quantity, totalPrice, currency)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Покупка специального предложения: " .. itemId .. " x" .. quantity, "success")
    
    return true, "Покупка специального предложения выполнена успешно"
end

-- Получение информации о магазине
function ShopManager:GetShopInfo(shopId)
    local shop = self.shops[shopId]
    if not shop then return nil end
    
    local shopInfo = {
        name = shop.name,
        currency = shop.currency,
        items = {}
    }
    
    for itemId, itemData in pairs(shop.items) do
        table.insert(shopInfo.items, {
            id = itemId,
            price = itemData.price,
            category = itemData.category,
            level = itemData.level,
            quantity = itemData.quantity
        })
    end
    
    return shopInfo
end

-- Получение всех магазинов
function ShopManager:GetAllShops()
    local shops = {}
    
    for shopId, shop in pairs(self.shops) do
        shops[shopId] = {
            name = shop.name,
            currency = shop.currency,
            itemCount = 0
        }
        
        for _ in pairs(shop.items) do
            shops[shopId].itemCount = shops[shopId].itemCount + 1
        end
    end
    
    return shops
end

-- Получение ежедневных предложений
function ShopManager:GetDailyOffers()
    return self.dailyOffers.offers
end

-- Получение еженедельных предложений
function ShopManager:GetWeeklyOffers()
    return self.weeklyOffers.offers
end

-- Получение специальных предложений
function ShopManager:GetSpecialOffers(category)
    if category then
        return self.specialOffers[category]
    else
        return self.specialOffers
    end
end

-- Обновление предложений
function ShopManager:UpdateOffers()
    local currentTime = os.time()
    
    -- Обновление ежедневных предложений
    if currentTime - self.dailyOffers.lastUpdate >= self.dailyOffers.updateTime then
        self:ShuffleDailyOffers()
        self.dailyOffers.lastUpdate = currentTime
        print("[ShopManager] Daily offers updated")
    end
    
    -- Обновление еженедельных предложений
    if currentTime - self.weeklyOffers.lastUpdate >= self.weeklyOffers.updateTime then
        self:ShuffleWeeklyOffers()
        self.weeklyOffers.lastUpdate = currentTime
        print("[ShopManager] Weekly offers updated")
    end
end

-- Перемешивание ежедневных предложений
function ShopManager:ShuffleDailyOffers()
    local allItems = {
        "legendary_sword", "crystal_armor", "premium_health_potion", "experience_boost_3h",
        "dragon_scale", "skill_point_pack", "iron_sword", "leather_armor",
        "health_potion", "mana_potion", "wood", "stone", "iron", "crystal"
    }
    
    local currencies = {"gold", "gems", "experience"}
    local newOffers = {}
    
    for i = 1, 6 do
        local itemId = allItems[math.random(1, #allItems)]
        local currency = currencies[math.random(1, #currencies)]
        local originalPrice = math.random(50, 5000)
        local discount = math.random(30, 70) / 100
        
        table.insert(newOffers, {
            itemId = itemId,
            originalPrice = originalPrice,
            discountPrice = math.floor(originalPrice * discount),
            currency = currency
        })
    end
    
    self.dailyOffers.offers = newOffers
end

-- Перемешивание еженедельных предложений
function ShopManager:ShuffleWeeklyOffers()
    local allItems = {
        "legendary_core", "premium_legendary_sword", "prestige_token", "unique_title",
        "title_god", "reset_skill_points", "premium_legendary_armor", "dragon_scale",
        "crystal_sword", "iron_armor", "strength_potion", "repair_kit"
    }
    
    local currencies = {"gems", "experience"}
    local newOffers = {}
    
    for i = 1, 6 do
        local itemId = allItems[math.random(1, #allItems)]
        local currency = currencies[math.random(1, #currencies)]
        local originalPrice = math.random(100, 25000)
        local discount = math.random(40, 60) / 100
        
        table.insert(newOffers, {
            itemId = itemId,
            originalPrice = originalPrice,
            discountPrice = math.floor(originalPrice * discount),
            currency = currency
        })
    end
    
    self.weeklyOffers.offers = newOffers
end

-- Запуск обновления предложений
function ShopManager:StartOfferUpdates()
    task.spawn(function()
        while true do
            self:UpdateOffers()
            task.wait(3600) -- Проверка каждый час
        end
    end)
end

-- Логирование покупки
function ShopManager:LogPurchase(player, shopId, itemId, quantity, price, currency)
    print("[ShopManager] Purchase:", player.Name, "bought", itemId, "x" .. quantity, "for", price, currency, "from", shopId)
    
    -- Здесь можно добавить сохранение в базу данных или отправку аналитики
end

-- Уведомление игрока
function ShopManager:NotifyPlayer(player, message, type)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, type, 3)
end

-- Очистка системы магазина
function ShopManager:Cleanup()
    self.shops = {}
    self.dailyOffers = {}
    self.weeklyOffers = {}
    self.specialOffers = {}
end

return ShopManager