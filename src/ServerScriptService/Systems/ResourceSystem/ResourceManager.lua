-- ResourceManager.lua
-- Управление ресурсами на сервере

local ResourceManager = {}
ResourceManager.__index = ResourceManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local ProfileService = require(script.Parent.Parent.Data.ProfileService)
local LootManager = require(script.Parent.Parent.LootSystem.LootManager)

-- Состояние
ResourceManager.resourceNodes = {}
ResourceManager.playerGathering = {}

function ResourceManager:Initialize()
    print("[ResourceManager] Initializing...")
    
    -- Создание зон ресурсов
    self:CreateResourceZones()
    
    print("[ResourceManager] Initialized successfully!")
end

-- Создание зон ресурсов
function ResourceManager:CreateResourceZones()
    for zoneName, zoneData in pairs(GameConstants.ResourceZones) do
        self:CreateResourceZone(zoneName, zoneData)
    end
end

-- Создание зоны ресурсов
function ResourceManager:CreateResourceZone(zoneName, zoneData)
    local zoneFolder = Instance.new("Folder")
    zoneFolder.Name = zoneName .. "Zone"
    zoneFolder.Parent = workspace
    
    -- Создание нескольких узлов ресурсов в зоне
    local nodeCount = 10
    for i = 1, nodeCount do
        local angle = (i / nodeCount) * 2 * math.pi
        local radius = math.random(zoneData.radius * 0.3, zoneData.radius)
        
        local position = zoneData.center + Vector3.new(
            math.cos(angle) * radius,
            0,
            math.sin(angle) * radius
        )
        
        self:CreateResourceNode(zoneData.resourceType, position, zoneData.respawnTime)
    end
    
    print("[ResourceManager] Created resource zone:", zoneName)
end

-- Создание узла ресурсов
function ResourceManager:CreateResourceNode(resourceType, position, respawnTime)
    local node = Instance.new("Part")
    node.Name = resourceType .. "Node"
    node.Size = Vector3.new(4, 4, 4)
    node.Position = position
    node.Anchored = true
    node.CanCollide = true
    node.Material = self:GetResourceMaterial(resourceType)
    node.Color = self:GetResourceColor(resourceType)
    node.Parent = workspace
    
    -- Добавление атрибутов
    node:SetAttribute("ResourceType", resourceType)
    node:SetAttribute("RemainingAmount", 100)
    node:SetAttribute("MaxAmount", 100)
    node:SetAttribute("RespawnTime", respawnTime or 120)
    node:SetAttribute("IsActive", true)
    
    -- Добавление в список узлов
    table.insert(self.resourceNodes, node)
    
    -- Подключение события касания
    node.Touched:Connect(function(hit)
        self:HandleResourceTouch(node, hit)
    end)
    
    return node
end

-- Получение материала ресурса
function ResourceManager:GetResourceMaterial(resourceType)
    local materials = {
        Wood = Enum.Material.Wood,
        Stone = Enum.Material.Rock,
        Crystal = Enum.Material.Glass
    }
    
    return materials[resourceType] or Enum.Material.Plastic
end

-- Получение цвета ресурса
function ResourceManager:GetResourceColor(resourceType)
    local colors = {
        Wood = Color3.fromRGB(139, 69, 19),    -- Коричневый
        Stone = Color3.fromRGB(128, 128, 128), -- Серый
        Crystal = Color3.fromRGB(138, 43, 226) -- Фиолетовый
    }
    
    return colors[resourceType] or Color3.fromRGB(255, 255, 255)
end

-- Обработка касания ресурса
function ResourceManager:HandleResourceTouch(node, hit)
    local character = hit.Parent
    local player = game:GetService("Players"):GetPlayerFromCharacter(character)
    
    if not player then return end
    
    -- Проверка, не собирает ли уже игрок ресурс
    if self.playerGathering[player] then return end
    
    -- Проверка активности узла
    if not node:GetAttribute("IsActive") then return end
    
    -- Начало сбора ресурса
    self:StartResourceGathering(player, node)
end

-- Начало сбора ресурса
function ResourceManager:StartResourceGathering(player, node)
    local resourceType = node:GetAttribute("ResourceType")
    local resourceData = GameConstants.Resources[resourceType]
    
    if not resourceData then return end
    
    -- Проверка инструмента
    if not self:HasRequiredTool(player, resourceData.toolRequired) then
        self:NotifyPlayer(player, "Нужен инструмент: " .. resourceData.toolRequired, "warning")
        return
    end
    
    -- Установка флага сбора
    self.playerGathering[player] = {
        node = node,
        startTime = tick(),
        resourceType = resourceType
    }
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Сбор " .. resourceType .. "...", "info")
    
    -- Запуск процесса сбора
    task.spawn(function()
        task.wait(resourceData.gatherTime)
        
        if self.playerGathering[player] and self.playerGathering[player].node == node then
            self:CompleteResourceGathering(player, node)
        end
    end)
end

-- Завершение сбора ресурса
function ResourceManager:CompleteResourceGathering(player, node)
    local resourceType = node:GetAttribute("ResourceType")
    local resourceData = GameConstants.Resources[resourceType]
    
    -- Определение количества ресурса
    local amount = math.random(resourceData.dropAmount.min, resourceData.dropAmount.max)
    
    -- Добавление ресурса игроку
    if self:AddResourceToPlayer(player, resourceType, amount) then
        -- Уменьшение количества в узле
        local remainingAmount = node:GetAttribute("RemainingAmount") - amount
        node:SetAttribute("RemainingAmount", remainingAmount)
        
        -- Проверка истощения узла
        if remainingAmount <= 0 then
            self:DepleteResourceNode(node)
        end
        
        -- Дроп дополнительного лута с ресурсной ноды
        local nodeType = string.lower(resourceType) .. "_node"
        LootManager:DropLootFromResourceNode(nodeType, node.Position)
        
        -- Уведомление игрока
        self:NotifyPlayer(player, "+" .. amount .. " " .. resourceType, "success")
        
        -- Создание эффекта сбора
        self:CreateGatherEffect(node.Position, resourceType)
    end
    
    -- Очистка флага сбора
    self.playerGathering[player] = nil
end

-- Добавление ресурса игроку
function ResourceManager:AddResourceToPlayer(player, resourceType, amount)
    local playerData = ProfileService:GetPlayerData(player)
    
    if not playerData.resources then
        playerData.resources = {}
    end
    
    if not playerData.resources[resourceType] then
        playerData.resources[resourceType] = 0
    end
    
    local resourceData = GameConstants.Resources[resourceType]
    local maxStack = resourceData.maxStack or 999
    
    -- Проверка лимита
    if playerData.resources[resourceType] + amount > maxStack then
        amount = maxStack - playerData.resources[resourceType]
        if amount <= 0 then
            self:NotifyPlayer(player, "Инвентарь полон!", "warning")
            return false
        end
    end
    
    -- Добавление ресурса
    playerData.resources[resourceType] = playerData.resources[resourceType] + amount
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    return true
end

-- Истощение узла ресурсов
function ResourceManager:DepleteResourceNode(node)
    node:SetAttribute("IsActive", false)
    
    -- Изменение внешнего вида
    node.Color = Color3.fromRGB(100, 100, 100)
    node.Transparency = 0.5
    
    -- Восстановление через время
    local respawnTime = node:GetAttribute("RespawnTime")
    task.spawn(function()
        task.wait(respawnTime)
        self:RespawnResourceNode(node)
    end)
end

-- Восстановление узла ресурсов
function ResourceManager:RespawnResourceNode(node)
    local resourceType = node:GetAttribute("ResourceType")
    
    node:SetAttribute("RemainingAmount", node:GetAttribute("MaxAmount"))
    node:SetAttribute("IsActive", true)
    node.Color = self:GetResourceColor(resourceType)
    node.Transparency = 0
    
    print("[ResourceManager] Resource node respawned:", resourceType)
end

-- Проверка наличия инструмента
function ResourceManager:HasRequiredTool(player, toolRequired)
    local character = player.Character
    if not character then return false end
    
    local tool = character:FindFirstChild(toolRequired)
    return tool ~= nil
end

-- Уведомление игрока
function ResourceManager:NotifyPlayer(player, message, type)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        remote:FireClient(player, message, type, 3)
    end
end

-- Создание эффекта сбора
function ResourceManager:CreateGatherEffect(position, resourceType)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(2, 2, 2)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = self:GetResourceColor(resourceType)
    effect.Transparency = 0.3
    effect.Parent = workspace
    
    -- Анимация
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(1), {
        Size = Vector3.new(8, 8, 8),
        Transparency = 1,
        Position = position + Vector3.new(0, 5, 0)
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 1)
end

-- Получение ресурсов игрока
function ResourceManager:GetPlayerResources(player)
    local playerData = ProfileService:GetPlayerData(player)
    return playerData.resources or {}
end

-- Списание ресурсов игрока
function ResourceManager:SpendPlayerResources(player, resources)
    local playerData = ProfileService:GetPlayerData(player)
    
    if not playerData.resources then
        return false
    end
    
    -- Проверка наличия ресурсов
    for resourceType, amount in pairs(resources) do
        if not playerData.resources[resourceType] or playerData.resources[resourceType] < amount then
            return false
        end
    end
    
    -- Списание ресурсов
    for resourceType, amount in pairs(resources) do
        playerData.resources[resourceType] = playerData.resources[resourceType] - amount
    end
    
    -- Сохранение данных
    ProfileService:SavePlayerData(player, playerData)
    
    return true
end

-- Очистка при выходе игрока
function ResourceManager:CleanupPlayer(player)
    self.playerGathering[player] = nil
end

return setmetatable({}, ResourceManager)