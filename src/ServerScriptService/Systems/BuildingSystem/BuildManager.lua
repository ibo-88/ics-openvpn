-- BuildManager.lua
-- Управление строительством

local BuildManager = {}
BuildManager.__index = BuildManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local ProfileService = require(script.Parent.Parent.Data.ProfileService)
local ResourceManager = require(script.Parent.Parent.ResourceSystem.ResourceManager)

-- Состояние
BuildManager.playerBuildings = {}
BuildManager.buildingLimits = {}
BuildManager.buildableAreas = {}

function BuildManager:Initialize()
    print("[BuildManager] Initializing...")
    
    -- Создание контейнера для построек
    local buildingsFolder = Instance.new("Folder")
    buildingsFolder.Name = "Buildings"
    buildingsFolder.Parent = workspace
    
    self.buildingsFolder = buildingsFolder
    
    -- Инициализация зон строительства
    self:InitializeBuildableAreas()
    
    -- Инициализация лимитов строительства
    self:InitializeBuildingLimits()
    
    print("[BuildManager] Initialized successfully!")
end

-- Инициализация зон строительства
function BuildManager:InitializeBuildableAreas()
    for areaName, areaData in pairs(GameConstants.BuildableAreas) do
        self.buildableAreas[areaName] = {
            radius = areaData.radius,
            maxWalls = areaData.maxWalls,
            maxTowers = areaData.maxTowers,
            currentWalls = 0,
            currentTowers = 0
        }
    end
end

-- Инициализация лимитов строительства
function BuildManager:InitializeBuildingLimits()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        self.playerBuildings[player] = {
            walls = 0,
            towers = 0,
            structures = {}
        }
    end
end

-- Строительство структуры
function BuildManager:BuildStructure(player, structureType, position)
    if not player or not structureType or not position then
        warn("[BuildManager] Invalid parameters for building")
        return false, "Неверные параметры строительства"
    end
    
    -- Проверка типа структуры
    local structureData = GameConstants.Walls[structureType] or GameConstants.Towers[structureType]
    if not structureData then
        return false, "Неизвестный тип структуры: " .. structureType
    end
    
    -- Проверка зоны строительства
    local buildableArea = self:GetBuildableArea(position)
    if not buildableArea then
        return false, "Строительство в этой зоне запрещено"
    end
    
    -- Проверка лимитов строительства
    local limitCheck = self:CheckBuildingLimits(player, structureType, buildableArea)
    if not limitCheck.success then
        return false, limitCheck.message
    end
    
    -- Проверка ресурсов
    local resourceCheck = self:CheckPlayerResources(player, structureData.cost)
    if not resourceCheck.success then
        return false, resourceCheck.message
    end
    
    -- Проверка требований
    local requirementCheck = self:CheckStructureRequirements(player, structureData)
    if not requirementCheck.success then
        return false, requirementCheck.message
    end
    
    -- Создание структуры
    local structure = self:CreateStructure(structureType, position, player)
    if not structure then
        return false, "Ошибка создания структуры"
    end
    
    -- Списание ресурсов
    ResourceManager:SpendPlayerResources(player, structureData.cost)
    
    -- Обновление лимитов
    self:UpdateBuildingLimits(player, structureType, buildableArea)
    
    -- Добавление в список построек игрока
    table.insert(self.playerBuildings[player].structures, structure)
    
    -- Уведомление игрока
    self:NotifyPlayer(player, "Построено: " .. structureType, "success")
    
    print("[BuildManager] Player", player.Name, "built", structureType, "at", position)
    return true, "Структура успешно построена"
end

-- Получение зоны строительства
function BuildManager:GetBuildableArea(position)
    local distanceFromCenter = position.Magnitude
    
    for areaName, areaData in pairs(self.buildableAreas) do
        if distanceFromCenter <= areaData.radius then
            return areaName
        end
    end
    
    return nil
end

-- Проверка лимитов строительства
function BuildManager:CheckBuildingLimits(player, structureType, buildableArea)
    local areaData = self.buildableAreas[buildableArea]
    local playerData = self.playerBuildings[player]
    
    if not areaData or not playerData then
        return {success = false, message = "Ошибка данных строительства"}
    end
    
    -- Проверка лимитов зоны
    if structureType:find("Wall") then
        if areaData.currentWalls >= areaData.maxWalls then
            return {success = false, message = "Достигнут лимит стен в этой зоне"}
        end
    elseif structureType:find("Tower") then
        if areaData.currentTowers >= areaData.maxTowers then
            return {success = false, message = "Достигнут лимит башен в этой зоне"}
        end
    end
    
    -- Проверка лимитов игрока
    if playerData.walls >= 100 then
        return {success = false, message = "Достигнут лимит стен"}
    end
    
    if playerData.towers >= 50 then
        return {success = false, message = "Достигнут лимит башен"}
    end
    
    return {success = true}
end

-- Проверка ресурсов игрока
function BuildManager:CheckPlayerResources(player, cost)
    local playerResources = ResourceManager:GetPlayerResources(player)
    
    for resourceType, amount in pairs(cost) do
        if not playerResources[resourceType] or playerResources[resourceType] < amount then
            return {
                success = false,
                message = "Недостаточно " .. resourceType .. " (нужно: " .. amount .. ")"
            }
        end
    end
    
    return {success = true}
end

-- Проверка требований структуры
function BuildManager:CheckStructureRequirements(player, structureData)
    if not structureData.requirement then
        return {success = true}
    end
    
    local playerData = self.playerBuildings[player]
    local hasRequirement = false
    
    for _, structure in ipairs(playerData.structures) do
        if structure.Name == structureData.requirement then
            hasRequirement = true
            break
        end
    end
    
    if not hasRequirement then
        return {
            success = false,
            message = "Требуется построить: " .. structureData.requirement
        }
    end
    
    return {success = true}
end

-- Создание структуры
function BuildManager:CreateStructure(structureType, position, player)
    local structureData = GameConstants.Walls[structureType] or GameConstants.Towers[structureType]
    
    local structure = Instance.new("Model")
    structure.Name = structureType
    structure.Parent = self.buildingsFolder
    
    -- Создание основной части
    local base = Instance.new("Part")
    base.Name = "Base"
    base.Size = structureData.size or Vector3.new(10, 10, 2)
    base.Position = position
    base.Anchored = true
    base.CanCollide = true
    base.Material = self:GetStructureMaterial(structureType)
    base.Color = self:GetStructureColor(structureType)
    base.Parent = structure
    
    -- Установка PrimaryPart
    structure.PrimaryPart = base
    
    -- Добавление атрибутов
    structure:SetAttribute("StructureType", structureType)
    structure:SetAttribute("Owner", player.Name)
    structure:SetAttribute("Health", structureData.health or 1000)
    structure:SetAttribute("MaxHealth", structureData.health or 1000)
    structure:SetAttribute("BuiltAt", tick())
    
    -- Специальные атрибуты для башен
    if structureType:find("Tower") then
        local towerLevel = structureData.levels and structureData.levels[1] or structureData
        structure:SetAttribute("Damage", towerLevel.damage or 25)
        structure:SetAttribute("AttackSpeed", towerLevel.attackSpeed or 1.5)
        structure:SetAttribute("Range", towerLevel.range or 20)
        structure:SetAttribute("LastAttack", 0)
        structure:SetAttribute("Level", 1)
        
        -- Запуск логики башни
        self:StartTowerLogic(structure)
    end
    
    -- Создание эффекта строительства
    self:CreateBuildEffect(position, structureType)
    
    return structure
end

-- Получение материала структуры
function BuildManager:GetStructureMaterial(structureType)
    local materials = {
        WoodWall = Enum.Material.Wood,
        StoneWall = Enum.Material.Rock,
        ReinforcedWall = Enum.Material.Concrete,
        ArcherTower = Enum.Material.Wood,
        CatapultTower = Enum.Material.Rock,
        IceTower = Enum.Material.Ice,
        CrystalTower = Enum.Material.Glass
    }
    
    return materials[structureType] or Enum.Material.Plastic
end

-- Получение цвета структуры
function BuildManager:GetStructureColor(structureType)
    local colors = {
        WoodWall = Color3.fromRGB(139, 69, 19),      -- Коричневый
        StoneWall = Color3.fromRGB(128, 128, 128),   -- Серый
        ReinforcedWall = Color3.fromRGB(64, 64, 64), -- Темно-серый
        ArcherTower = Color3.fromRGB(139, 69, 19),   -- Коричневый
        CatapultTower = Color3.fromRGB(128, 128, 128), -- Серый
        IceTower = Color3.fromRGB(173, 216, 230),    -- Светло-голубой
        CrystalTower = Color3.fromRGB(138, 43, 226)  -- Фиолетовый
    }
    
    return colors[structureType] or Color3.fromRGB(255, 255, 255)
end

-- Запуск логики башни
function BuildManager:StartTowerLogic(tower)
    task.spawn(function()
        while tower and tower.Parent do
            local currentTime = tick()
            local lastAttack = tower:GetAttribute("LastAttack") or 0
            local attackSpeed = tower:GetAttribute("AttackSpeed") or 1
            
            if currentTime - lastAttack >= 1 / attackSpeed then
                -- Поиск врагов в радиусе
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then
                    local closestEnemy = nil
                    local closestDistance = math.huge
                    local range = tower:GetAttribute("Range") or 20
                    
                    for _, enemy in pairs(enemies:GetChildren()) do
                        if enemy:FindFirstChild("PrimaryPart") then
                            local distance = (enemy.PrimaryPart.Position - tower.PrimaryPart.Position).Magnitude
                            if distance <= range and distance < closestDistance then
                                closestEnemy = enemy
                                closestDistance = distance
                            end
                        end
                    end
                    
                    -- Атака врага
                    if closestEnemy then
                        self:TowerAttack(tower, closestEnemy)
                        tower:SetAttribute("LastAttack", currentTime)
                    end
                end
            end
            
            task.wait(0.1)
        end
    end)
end

-- Атака башни
function BuildManager:TowerAttack(tower, enemy)
    local damage = tower:GetAttribute("Damage") or 25
    local towerType = tower:GetAttribute("StructureType")
    
    -- Импорт CombatManager для нанесения урона
    local CombatManager = require(script.Parent.Parent.CombatSystem.CombatManager)
    CombatManager:DealDamage(tower, enemy, damage, "Physical")
    
    -- Создание эффекта выстрела
    self:CreateTowerShotEffect(tower.PrimaryPart.Position, enemy.PrimaryPart.Position, towerType)
end

-- Создание эффекта строительства
function BuildManager:CreateBuildEffect(position, structureType)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(1, 1, 1)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = self:GetStructureColor(structureType)
    effect.Transparency = 0.3
    effect.Parent = workspace
    
    -- Анимация строительства
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(2), {
        Size = Vector3.new(20, 20, 20),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 2)
end

-- Создание эффекта выстрела башни
function BuildManager:CreateTowerShotEffect(startPos, endPos, towerType)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(0.5, 0.5, 0.5)
    effect.Position = startPos
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Parent = workspace
    
    -- Настройка цвета в зависимости от типа башни
    if towerType:find("Ice") then
        effect.Color = Color3.fromRGB(173, 216, 230) -- Голубой
    elseif towerType:find("Crystal") then
        effect.Color = Color3.fromRGB(138, 43, 226) -- Фиолетовый
    else
        effect.Color = Color3.fromRGB(255, 255, 0) -- Желтый
    end
    
    effect.Transparency = 0.5
    
    -- Анимация выстрела
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(0.5), {
        Position = endPos,
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 0.5)
end

-- Обновление лимитов строительства
function BuildManager:UpdateBuildingLimits(player, structureType, buildableArea)
    local playerData = self.playerBuildings[player]
    local areaData = self.buildableAreas[buildableArea]
    
    if structureType:find("Wall") then
        playerData.walls = playerData.walls + 1
        areaData.currentWalls = areaData.currentWalls + 1
    elseif structureType:find("Tower") then
        playerData.towers = playerData.towers + 1
        areaData.currentTowers = areaData.currentTowers + 1
    end
end

-- Уведомление игрока
function BuildManager:NotifyPlayer(player, message, type)
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local remote = ReplicatedStorage.Remotes.UI:FindFirstChild("ShowNotification")
    
    if remote then
        remote:FireClient(player, message, type, 3)
    end
end

-- Получение построек игрока
function BuildManager:GetPlayerBuildings(player)
    return self.playerBuildings[player] or {walls = 0, towers = 0, structures = {}}
end

-- Удаление постройки
function BuildManager:DestroyStructure(structure, player)
    if not structure or not structure.Parent then
        return false
    end
    
    -- Удаление из списка построек игрока
    local playerData = self.playerBuildings[player]
    if playerData then
        for i, playerStructure in ipairs(playerData.structures) do
            if playerStructure == structure then
                table.remove(playerData.structures, i)
                break
            end
        end
        
        -- Обновление счетчиков
        local structureType = structure:GetAttribute("StructureType")
        if structureType:find("Wall") then
            playerData.walls = math.max(0, playerData.walls - 1)
        elseif structureType:find("Tower") then
            playerData.towers = math.max(0, playerData.towers - 1)
        end
    end
    
    -- Создание эффекта разрушения
    self:CreateDestroyEffect(structure.PrimaryPart.Position)
    
    -- Удаление структуры
    structure:Destroy()
    
    return true
end

-- Создание эффекта разрушения
function BuildManager:CreateDestroyEffect(position)
    local effect = Instance.new("Part")
    effect.Shape = Enum.PartType.Ball
    effect.Size = Vector3.new(2, 2, 2)
    effect.Position = position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.ForceField
    effect.Color = Color3.fromRGB(255, 0, 0)
    effect.Transparency = 0.3
    effect.Parent = workspace
    
    -- Анимация разрушения
    local tween = game:GetService("TweenService"):Create(effect, TweenInfo.new(1), {
        Size = Vector3.new(15, 15, 15),
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление
    game:GetService("Debris"):AddItem(effect, 1)
end

-- Очистка при выходе игрока
function BuildManager:CleanupPlayer(player)
    self.playerBuildings[player] = nil
end

return setmetatable({}, BuildManager)