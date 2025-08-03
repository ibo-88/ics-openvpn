-- InventoryManager.lua
-- Полная система управления инвентарем

local InventoryManager = {}
InventoryManager.__index = InventoryManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)

-- Состояние
InventoryManager.inventories = {}
InventoryManager.maxSlots = 50
InventoryManager.maxStackSize = 999

function InventoryManager:Initialize()
    print("[InventoryManager] Initializing inventory system...")
    
    -- Инициализация инвентарей игроков
    self:InitializePlayerInventories()
    
    print("[InventoryManager] Inventory system initialized!")
end

-- Инициализация инвентарей игроков
function InventoryManager:InitializePlayerInventories()
    -- Инвентари будут создаваться при подключении игроков
    self.inventories = {}
end

-- Создание инвентаря для игрока
function InventoryManager:CreatePlayerInventory(player)
    local profile = ProfileService:GetProfile(player)
    if not profile then return nil end
    
    local inventory = {
        player = player,
        slots = {},
        maxSlots = self.maxSlots,
        maxStackSize = self.maxStackSize,
        equipped = {
            weapon = nil,
            armor = nil,
            accessory = nil
        }
    }
    
    -- Инициализация слотов
    for i = 1, inventory.maxSlots do
        inventory.slots[i] = {
            itemId = nil,
            quantity = 0,
            durability = 100,
            enchantments = {}
        }
    end
    
    -- Загрузка данных из профиля
    if profile.data.inventory then
        inventory.slots = profile.data.inventory.slots or inventory.slots
        inventory.equipped = profile.data.inventory.equipped or inventory.equipped
    end
    
    self.inventories[player.UserId] = inventory
    
    return inventory
end

-- Получение инвентаря игрока
function InventoryManager:GetPlayerInventory(player)
    if not player then return nil end
    
    local inventory = self.inventories[player.UserId]
    if not inventory then
        inventory = self:CreatePlayerInventory(player)
    end
    
    return inventory
end

-- Добавление предмета в инвентарь
function InventoryManager:AddItem(player, itemId, quantity, durability, enchantments)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false, "Инвентарь не найден" end
    
    quantity = quantity or 1
    durability = durability or 100
    enchantments = enchantments or {}
    
    -- Поиск существующего стека
    for i, slot in pairs(inventory.slots) do
        if slot.itemId == itemId and slot.quantity < self.maxStackSize then
            local spaceInStack = self.maxStackSize - slot.quantity
            local amountToAdd = math.min(quantity, spaceInStack)
            
            slot.quantity = slot.quantity + amountToAdd
            quantity = quantity - amountToAdd
            
            if quantity <= 0 then
                self:SaveInventory(player)
                return true, "Предмет добавлен"
            end
        end
    end
    
    -- Поиск пустого слота
    while quantity > 0 do
        local emptySlot = self:FindEmptySlot(inventory)
        if not emptySlot then
            return false, "Инвентарь полон"
        end
        
        local amountToAdd = math.min(quantity, self.maxStackSize)
        emptySlot.itemId = itemId
        emptySlot.quantity = amountToAdd
        emptySlot.durability = durability
        emptySlot.enchantments = enchantments
        
        quantity = quantity - amountToAdd
    end
    
    self:SaveInventory(player)
    return true, "Предмет добавлен"
end

-- Удаление предмета из инвентаря
function InventoryManager:RemoveItem(player, itemId, quantity)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false, "Инвентарь не найден" end
    
    quantity = quantity or 1
    local remainingToRemove = quantity
    
    -- Поиск предметов для удаления
    for i = #inventory.slots, 1, -1 do
        local slot = inventory.slots[i]
        if slot.itemId == itemId and slot.quantity > 0 then
            local amountToRemove = math.min(remainingToRemove, slot.quantity)
            slot.quantity = slot.quantity - amountToRemove
            remainingToRemove = remainingToRemove - amountToRemove
            
            -- Очистка пустого слота
            if slot.quantity <= 0 then
                slot.itemId = nil
                slot.quantity = 0
                slot.durability = 100
                slot.enchantments = {}
            end
            
            if remainingToRemove <= 0 then
                self:SaveInventory(player)
                return true, "Предмет удален"
            end
        end
    end
    
    if remainingToRemove > 0 then
        return false, "Недостаточно предметов"
    end
    
    self:SaveInventory(player)
    return true, "Предмет удален"
end

-- Проверка наличия предмета
function InventoryManager:HasItem(player, itemId, quantity)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false end
    
    quantity = quantity or 1
    local totalQuantity = 0
    
    for _, slot in pairs(inventory.slots) do
        if slot.itemId == itemId then
            totalQuantity = totalQuantity + slot.quantity
            if totalQuantity >= quantity then
                return true
            end
        end
    end
    
    return false
end

-- Получение количества предмета
function InventoryManager:GetItemCount(player, itemId)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return 0 end
    
    local totalQuantity = 0
    
    for _, slot in pairs(inventory.slots) do
        if slot.itemId == itemId then
            totalQuantity = totalQuantity + slot.quantity
        end
    end
    
    return totalQuantity
end

-- Поиск пустого слота
function InventoryManager:FindEmptySlot(inventory)
    for i, slot in pairs(inventory.slots) do
        if not slot.itemId or slot.quantity <= 0 then
            return slot
        end
    end
    return nil
end

-- Перемещение предмета между слотами
function InventoryManager:MoveItem(player, fromSlot, toSlot)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false, "Инвентарь не найден" end
    
    if fromSlot < 1 or fromSlot > #inventory.slots or 
       toSlot < 1 or toSlot > #inventory.slots then
        return false, "Неверный номер слота"
    end
    
    local from = inventory.slots[fromSlot]
    local to = inventory.slots[toSlot]
    
    -- Если слоты одинаковые
    if fromSlot == toSlot then
        return false, "Слоты одинаковые"
    end
    
    -- Если целевой слот пустой
    if not to.itemId or to.quantity <= 0 then
        to.itemId = from.itemId
        to.quantity = from.quantity
        to.durability = from.durability
        to.enchantments = from.enchantments
        
        from.itemId = nil
        from.quantity = 0
        from.durability = 100
        from.enchantments = {}
    else
        -- Если предметы одинаковые, объединяем стеки
        if to.itemId == from.itemId then
            local spaceInStack = self.maxStackSize - to.quantity
            local amountToMove = math.min(from.quantity, spaceInStack)
            
            to.quantity = to.quantity + amountToMove
            from.quantity = from.quantity - amountToMove
            
            if from.quantity <= 0 then
                from.itemId = nil
                from.quantity = 0
                from.durability = 100
                from.enchantments = {}
            end
        else
            -- Меняем местами
            local temp = {
                itemId = from.itemId,
                quantity = from.quantity,
                durability = from.durability,
                enchantments = from.enchantments
            }
            
            from.itemId = to.itemId
            from.quantity = to.quantity
            from.durability = to.durability
            from.enchantments = to.enchantments
            
            to.itemId = temp.itemId
            to.quantity = temp.quantity
            to.durability = temp.durability
            to.enchantments = temp.enchantments
        end
    end
    
    self:SaveInventory(player)
    return true, "Предмет перемещен"
end

-- Экипировка предмета
function InventoryManager:EquipItem(player, slotIndex, equipmentType)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false, "Инвентарь не найден" end
    
    if slotIndex < 1 or slotIndex > #inventory.slots then
        return false, "Неверный номер слота"
    end
    
    local slot = inventory.slots[slotIndex]
    if not slot.itemId or slot.quantity <= 0 then
        return false, "Слот пустой"
    end
    
    -- Проверка типа предмета
    if equipmentType and not self:IsItemType(slot.itemId, equipmentType) then
        return false, "Неверный тип предмета"
    end
    
    -- Снятие текущего экипированного предмета
    local currentEquipped = inventory.equipped[equipmentType]
    if currentEquipped then
        self:AddItem(player, currentEquipped.itemId, currentEquipped.quantity, 
                    currentEquipped.durability, currentEquipped.enchantments)
    end
    
    -- Экипировка нового предмета
    inventory.equipped[equipmentType] = {
        itemId = slot.itemId,
        quantity = 1,
        durability = slot.durability,
        enchantments = slot.enchantments
    }
    
    -- Удаление предмета из слота
    slot.quantity = slot.quantity - 1
    if slot.quantity <= 0 then
        slot.itemId = nil
        slot.quantity = 0
        slot.durability = 100
        slot.enchantments = {}
    end
    
    self:SaveInventory(player)
    return true, "Предмет экипирован"
end

-- Снятие экипированного предмета
function InventoryManager:UnequipItem(player, equipmentType)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false, "Инвентарь не найден" end
    
    local equipped = inventory.equipped[equipmentType]
    if not equipped then
        return false, "Предмет не экипирован"
    end
    
    -- Добавление предмета обратно в инвентарь
    local success = self:AddItem(player, equipped.itemId, equipped.quantity, 
                                equipped.durability, equipped.enchantments)
    
    if success then
        inventory.equipped[equipmentType] = nil
        self:SaveInventory(player)
        return true, "Предмет снят"
    else
        return false, "Инвентарь полон"
    end
end

-- Использование предмета
function InventoryManager:UseItem(player, slotIndex)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false, "Инвентарь не найден" end
    
    if slotIndex < 1 or slotIndex > #inventory.slots then
        return false, "Неверный номер слота"
    end
    
    local slot = inventory.slots[slotIndex]
    if not slot.itemId or slot.quantity <= 0 then
        return false, "Слот пустой"
    end
    
    -- Проверка типа предмета (расходуемый)
    if not self:IsItemType(slot.itemId, "consumable") then
        return false, "Предмет нельзя использовать"
    end
    
    -- Применение эффекта предмета
    local success = self:ApplyItemEffect(player, slot.itemId)
    
    if success then
        -- Удаление одного предмета из стека
        slot.quantity = slot.quantity - 1
        if slot.quantity <= 0 then
            slot.itemId = nil
            slot.quantity = 0
            slot.durability = 100
            slot.enchantments = {}
        end
        
        self:SaveInventory(player)
        return true, "Предмет использован"
    else
        return false, "Не удалось использовать предмет"
    end
end

-- Применение эффекта предмета
function InventoryManager:ApplyItemEffect(player, itemId)
    -- Здесь должна быть логика применения эффектов
    -- Например, восстановление здоровья, маны и т.д.
    
    -- Временная заглушка
    if itemId == "health_potion" then
        -- Восстановление здоровья
        local character = player.Character
        if character and character:FindFirstChild("Humanoid") then
            local humanoid = character.Humanoid
            humanoid.Health = math.min(humanoid.Health + 50, humanoid.MaxHealth)
            return true
        end
    elseif itemId == "mana_potion" then
        -- Восстановление маны (если есть система маны)
        return true
    elseif itemId == "strength_potion" then
        -- Увеличение силы (если есть система баффов)
        return true
    end
    
    return false
end

-- Проверка типа предмета
function InventoryManager:IsItemType(itemId, itemType)
    -- Здесь должна быть проверка типа предмета
    -- Временная заглушка
    local itemTypes = {
        weapon = {"sword", "axe", "bow"},
        armor = {"leather_armor", "chain_armor", "plate_armor"},
        consumable = {"health_potion", "mana_potion", "strength_potion"},
        material = {"wood", "stone", "iron", "crystal"}
    }
    
    return itemTypes[itemType] and table.find(itemTypes[itemType], itemId) ~= nil
end

-- Получение экипированных предметов
function InventoryManager:GetEquippedItems(player)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return {} end
    
    return inventory.equipped
end

-- Получение содержимого инвентаря
function InventoryManager:GetInventoryContents(player)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return {} end
    
    local contents = {}
    for i, slot in pairs(inventory.slots) do
        if slot.itemId and slot.quantity > 0 then
            table.insert(contents, {
                slot = i,
                itemId = slot.itemId,
                quantity = slot.quantity,
                durability = slot.durability,
                enchantments = slot.enchantments
            })
        end
    end
    
    return contents
end

-- Получение свободного места
function InventoryManager:GetFreeSlots(player)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return 0 end
    
    local freeSlots = 0
    for _, slot in pairs(inventory.slots) do
        if not slot.itemId or slot.quantity <= 0 then
            freeSlots = freeSlots + 1
        end
    end
    
    return freeSlots
end

-- Проверка полного инвентаря
function InventoryManager:IsInventoryFull(player)
    return self:GetFreeSlots(player) == 0
end

-- Очистка инвентаря
function InventoryManager:ClearInventory(player)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false end
    
    for _, slot in pairs(inventory.slots) do
        slot.itemId = nil
        slot.quantity = 0
        slot.durability = 100
        slot.enchantments = {}
    end
    
    inventory.equipped = {
        weapon = nil,
        armor = nil,
        accessory = nil
    }
    
    self:SaveInventory(player)
    return true
end

-- Сохранение инвентаря
function InventoryManager:SaveInventory(player)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false end
    
    local profile = ProfileService:GetProfile(player)
    if not profile then return false end
    
    profile.data.inventory = {
        slots = inventory.slots,
        equipped = inventory.equipped
    }
    
    return true
end

-- Загрузка инвентаря
function InventoryManager:LoadInventory(player)
    local profile = ProfileService:GetProfile(player)
    if not profile then return false end
    
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return false end
    
    if profile.data.inventory then
        inventory.slots = profile.data.inventory.slots or inventory.slots
        inventory.equipped = profile.data.inventory.equipped or inventory.equipped
    end
    
    return true
end

-- Получение статистики инвентаря
function InventoryManager:GetInventoryStats(player)
    local inventory = self:GetPlayerInventory(player)
    if not inventory then return nil end
    
    local stats = {
        totalSlots = #inventory.slots,
        usedSlots = 0,
        freeSlots = 0,
        totalItems = 0,
        uniqueItems = 0,
        equippedItems = 0
    }
    
    local uniqueItems = {}
    
    for _, slot in pairs(inventory.slots) do
        if slot.itemId and slot.quantity > 0 then
            stats.usedSlots = stats.usedSlots + 1
            stats.totalItems = stats.totalItems + slot.quantity
            uniqueItems[slot.itemId] = true
        end
    end
    
    stats.freeSlots = stats.totalSlots - stats.usedSlots
    stats.uniqueItems = 0
    for _ in pairs(uniqueItems) do
        stats.uniqueItems = stats.uniqueItems + 1
    end
    
    for _, equipped in pairs(inventory.equipped) do
        if equipped then
            stats.equippedItems = stats.equippedItems + 1
        end
    end
    
    return stats
end

-- Очистка инвентаря игрока при выходе
function InventoryManager:CleanupPlayer(player)
    if player and self.inventories[player.UserId] then
        self:SaveInventory(player)
        self.inventories[player.UserId] = nil
    end
end

-- Очистка системы инвентаря
function InventoryManager:Cleanup()
    -- Сохранение всех инвентарей
    for userId, inventory in pairs(self.inventories) do
        if inventory.player then
            self:SaveInventory(inventory.player)
        end
    end
    
    self.inventories = {}
end

return InventoryManager