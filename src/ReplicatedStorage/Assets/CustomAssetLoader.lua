-- CustomAssetLoader.lua
-- Система загрузки кастомных активов для Nexus Siege

local CustomAssetLoader = {}
CustomAssetLoader.__index = CustomAssetLoader

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")
local HttpService = game:GetService("HttpService")

-- Состояние
CustomAssetLoader.assetIds = {}
CustomAssetLoader.loadedAssets = {}
CustomAssetLoader.loadingQueue = {}

function CustomAssetLoader:Initialize()
    print("[CustomAssetLoader] Initializing custom asset loader...")
    
    -- Инициализация Asset ID для кастомных моделей
    self:InitializeAssetIds()
    
    print("[CustomAssetLoader] Custom asset loader initialized!")
end

-- Инициализация Asset ID
function CustomAssetLoader:InitializeAssetIds()
    self.assetIds = {
        -- Модели врагов (примеры ID - замените на реальные)
        enemies = {
            Goblin = 123456789, -- Замените на реальный ID
            Orc = 987654321,
            Troll = 456789123,
            Dragon = 789123456,
            Skeleton = 321654987,
            Demon = 654987321
        },
        
        -- Модели структур
        structures = {
            WoodWall = 111222333,
            StoneWall = 444555666,
            ReinforcedWall = 777888999,
            ArcherTower = 123123123,
            CatapultTower = 456456456,
            IceTower = 789789789,
            CrystalTower = 321321321
        },
        
        -- Звуки
        sounds = {
            Attack = 111111111,
            Build = 222222222,
            Gather = 333333333,
            LevelUp = 444444444,
            Achievement = 555555555,
            WaveStart = 666666666,
            WaveEnd = 777777777,
            EnemyDeath = 888888888,
            PlayerDeath = 999999999,
            NexusDamage = 101010101
        },
        
        -- Текстуры
        textures = {
            WoodTexture = 202020202,
            StoneTexture = 303030303,
            MetalTexture = 404040404,
            CrystalTexture = 505050505,
            GrassTexture = 606060606,
            DirtTexture = 707070707
        }
    }
end

-- Загрузка модели по Asset ID
function CustomAssetLoader:LoadModel(assetId, modelName)
    if not assetId or assetId == 0 then
        warn("[CustomAssetLoader] Invalid asset ID for model:", modelName)
        return nil
    end
    
    local success, result = pcall(function()
        return InsertService:LoadAsset(assetId)
    end)
    
    if success and result then
        local model = result:GetChildren()[1]
        if model and model:IsA("Model") then
            model.Name = modelName
            model.Parent = ReplicatedStorage.Models
            result:Destroy()
            
            self.loadedAssets[modelName] = model
            print("[CustomAssetLoader] Successfully loaded model:", modelName)
            return model
        else
            warn("[CustomAssetLoader] Asset is not a model:", modelName)
            result:Destroy()
        end
    else
        warn("[CustomAssetLoader] Failed to load model:", modelName, "Error:", result)
    end
    
    return nil
end

-- Загрузка звука по Asset ID
function CustomAssetLoader:LoadSound(assetId, soundName)
    if not assetId or assetId == 0 then
        warn("[CustomAssetLoader] Invalid asset ID for sound:", soundName)
        return nil
    end
    
    local success, result = pcall(function()
        return InsertService:LoadAsset(assetId)
    end)
    
    if success and result then
        local sound = result:GetChildren()[1]
        if sound and sound:IsA("Sound") then
            sound.Name = soundName
            sound.Parent = ReplicatedStorage.Sounds
            result:Destroy()
            
            self.loadedAssets[soundName] = sound
            print("[CustomAssetLoader] Successfully loaded sound:", soundName)
            return sound
        else
            warn("[CustomAssetLoader] Asset is not a sound:", soundName)
            result:Destroy()
        end
    else
        warn("[CustomAssetLoader] Failed to load sound:", soundName, "Error:", result)
    end
    
    return nil
end

-- Загрузка текстуры по Asset ID
function CustomAssetLoader:LoadTexture(assetId, textureName)
    if not assetId or assetId == 0 then
        warn("[CustomAssetLoader] Invalid asset ID for texture:", textureName)
        return nil
    end
    
    local success, result = pcall(function()
        return InsertService:LoadAsset(assetId)
    end)
    
    if success and result then
        local texture = result:GetChildren()[1]
        if texture and texture:IsA("Texture") then
            texture.Name = textureName
            texture.Parent = ReplicatedStorage.Textures
            result:Destroy()
            
            self.loadedAssets[textureName] = texture
            print("[CustomAssetLoader] Successfully loaded texture:", textureName)
            return texture
        else
            warn("[CustomAssetLoader] Asset is not a texture:", textureName)
            result:Destroy()
        end
    else
        warn("[CustomAssetLoader] Failed to load texture:", textureName, "Error:", result)
    end
    
    return nil
end

-- Загрузка всех активов
function CustomAssetLoader:LoadAllAssets()
    print("[CustomAssetLoader] Loading all custom assets...")
    
    -- Загрузка моделей врагов
    for enemyName, assetId in pairs(self.assetIds.enemies) do
        self:LoadModel(assetId, enemyName)
    end
    
    -- Загрузка моделей структур
    for structureName, assetId in pairs(self.assetIds.structures) do
        self:LoadModel(assetId, structureName)
    end
    
    -- Загрузка звуков
    for soundName, assetId in pairs(self.assetIds.sounds) do
        self:LoadSound(assetId, soundName)
    end
    
    -- Загрузка текстур
    for textureName, assetId in pairs(self.assetIds.textures) do
        self:LoadTexture(assetId, textureName)
    end
    
    print("[CustomAssetLoader] All assets loaded!")
end

-- Загрузка активов по категории
function CustomAssetLoader:LoadAssetsByCategory(category)
    if not self.assetIds[category] then
        warn("[CustomAssetLoader] Unknown category:", category)
        return
    end
    
    print("[CustomAssetLoader] Loading assets for category:", category)
    
    for assetName, assetId in pairs(self.assetIds[category]) do
        if category == "enemies" or category == "structures" then
            self:LoadModel(assetId, assetName)
        elseif category == "sounds" then
            self:LoadSound(assetId, assetName)
        elseif category == "textures" then
            self:LoadTexture(assetId, assetName)
        end
    end
end

-- Асинхронная загрузка активов
function CustomAssetLoader:LoadAssetsAsync()
    print("[CustomAssetLoader] Starting async asset loading...")
    
    task.spawn(function()
        for category, assets in pairs(self.assetIds) do
            for assetName, assetId in pairs(assets) do
                if category == "enemies" or category == "structures" then
                    self:LoadModel(assetId, assetName)
                elseif category == "sounds" then
                    self:LoadSound(assetId, assetName)
                elseif category == "textures" then
                    self:LoadTexture(assetId, assetName)
                end
                
                -- Небольшая задержка между загрузками
                task.wait(0.1)
            end
        end
        
        print("[CustomAssetLoader] Async asset loading completed!")
    end)
end

-- Получение загруженного актива
function CustomAssetLoader:GetLoadedAsset(assetName)
    return self.loadedAssets[assetName]
end

-- Проверка, загружен ли актив
function CustomAssetLoader:IsAssetLoaded(assetName)
    return self.loadedAssets[assetName] ~= nil
end

-- Получение списка загруженных активов
function CustomAssetLoader:GetLoadedAssetsList()
    local loadedList = {}
    
    for assetName, asset in pairs(self.loadedAssets) do
        table.insert(loadedList, {
            name = assetName,
            type = asset.ClassName,
            loaded = true
        })
    end
    
    return loadedList
end

-- Добавление нового Asset ID
function CustomAssetLoader:AddAssetId(category, assetName, assetId)
    if not self.assetIds[category] then
        self.assetIds[category] = {}
    end
    
    self.assetIds[category][assetName] = assetId
    print("[CustomAssetLoader] Added asset ID:", assetName, "=", assetId, "to category:", category)
end

-- Удаление Asset ID
function CustomAssetLoader:RemoveAssetId(category, assetName)
    if self.assetIds[category] and self.assetIds[category][assetName] then
        self.assetIds[category][assetName] = nil
        print("[CustomAssetLoader] Removed asset ID:", assetName, "from category:", category)
    end
end

-- Сохранение конфигурации Asset ID в JSON
function CustomAssetLoader:SaveAssetIdsToJson()
    local success, json = pcall(function()
        return HttpService:JSONEncode(self.assetIds)
    end)
    
    if success then
        -- Здесь можно сохранить JSON в файл или DataStore
        print("[CustomAssetLoader] Asset IDs configuration saved to JSON")
        return json
    else
        warn("[CustomAssetLoader] Failed to save asset IDs to JSON:", json)
        return nil
    end
end

-- Загрузка конфигурации Asset ID из JSON
function CustomAssetLoader:LoadAssetIdsFromJson(jsonString)
    local success, assetIds = pcall(function()
        return HttpService:JSONDecode(jsonString)
    end)
    
    if success then
        self.assetIds = assetIds
        print("[CustomAssetLoader] Asset IDs configuration loaded from JSON")
        return true
    else
        warn("[CustomAssetLoader] Failed to load asset IDs from JSON:", assetIds)
        return false
    end
end

-- Создание базовых моделей (если кастомные не загружены)
function CustomAssetLoader:CreateFallbackModels()
    print("[CustomAssetLoader] Creating fallback models...")
    
    local modelsFolder = ReplicatedStorage:FindFirstChild("Models")
    if not modelsFolder then return end
    
    -- Создание базовых моделей врагов
    local enemyTypes = {"Goblin", "Orc", "Troll", "Dragon", "Skeleton", "Demon"}
    for _, enemyType in ipairs(enemyTypes) do
        if not self:IsAssetLoaded(enemyType) then
            self:CreateBasicEnemyModel(enemyType)
        end
    end
    
    -- Создание базовых моделей структур
    local structureTypes = {"WoodWall", "StoneWall", "ReinforcedWall", "ArcherTower", "CatapultTower", "IceTower", "CrystalTower"}
    for _, structureType in ipairs(structureTypes) do
        if not self:IsAssetLoaded(structureType) then
            self:CreateBasicStructureModel(structureType)
        end
    end
end

-- Создание базовой модели врага
function CustomAssetLoader:CreateBasicEnemyModel(enemyType)
    local modelsFolder = ReplicatedStorage:FindFirstChild("Models")
    if not modelsFolder then return end
    
    local model = Instance.new("Model")
    model.Name = enemyType
    
    local primaryPart = Instance.new("Part")
    primaryPart.Name = "PrimaryPart"
    primaryPart.Size = Vector3.new(2, 4, 1)
    primaryPart.Color = Color3.fromRGB(255, 0, 0)
    primaryPart.Material = Enum.Material.Plastic
    primaryPart.Anchored = false
    primaryPart.CanCollide = true
    primaryPart.Parent = model
    
    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = 100
    humanoid.Health = 100
    humanoid.Parent = model
    
    model.PrimaryPart = primaryPart
    model.Parent = modelsFolder
    
    self.loadedAssets[enemyType] = model
    print("[CustomAssetLoader] Created fallback model for:", enemyType)
end

-- Создание базовой модели структуры
function CustomAssetLoader:CreateBasicStructureModel(structureType)
    local modelsFolder = ReplicatedStorage:FindFirstChild("Models")
    if not modelsFolder then return end
    
    local model = Instance.new("Model")
    model.Name = structureType
    
    local primaryPart = Instance.new("Part")
    primaryPart.Name = "PrimaryPart"
    primaryPart.Size = Vector3.new(10, 10, 2)
    primaryPart.Color = Color3.fromRGB(128, 128, 128)
    primaryPart.Material = Enum.Material.Plastic
    primaryPart.Anchored = true
    primaryPart.CanCollide = true
    primaryPart.Parent = model
    
    model.PrimaryPart = primaryPart
    model.Parent = modelsFolder
    
    self.loadedAssets[structureType] = model
    print("[CustomAssetLoader] Created fallback model for:", structureType)
end

-- Очистка загруженных активов
function CustomAssetLoader:ClearLoadedAssets()
    for assetName, asset in pairs(self.loadedAssets) do
        if asset and asset.Parent then
            asset:Destroy()
        end
    end
    
    self.loadedAssets = {}
    print("[CustomAssetLoader] All loaded assets cleared")
end

return CustomAssetLoader