-- AssetManager.lua
-- Система управления активами для Nexus Siege

local AssetManager = {}
AssetManager.__index = AssetManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- Состояние
AssetManager.assets = {}
AssetManager.loadedAssets = {}
AssetManager.assetCache = {}

function AssetManager:Initialize()
    print("[AssetManager] Initializing asset system...")
    
    -- Создание структуры папок для активов
    self:CreateAssetFolders()
    
    -- Загрузка базовых активов
    self:LoadBaseAssets()
    
    print("[AssetManager] Asset system initialized!")
end

-- Создание структуры папок для активов
function AssetManager:CreateAssetFolders()
    local assetFolders = {
        "Models",
        "Textures", 
        "Sounds",
        "Particles",
        "Animations",
        "UI"
    }
    
    for _, folderName in ipairs(assetFolders) do
        local folder = ReplicatedStorage:FindFirstChild(folderName)
        if not folder then
            folder = Instance.new("Folder")
            folder.Name = folderName
            folder.Parent = ReplicatedStorage
        end
    end
end

-- Загрузка базовых активов
function AssetManager:LoadBaseAssets()
    -- Создание базовых моделей врагов
    self:CreateEnemyModels()
    
    -- Создание базовых структур
    self:CreateStructureModels()
    
    -- Создание базовых эффектов
    self:CreateEffectModels()
    
    -- Создание базовых звуков
    self:CreateBaseSounds()
    
    -- Создание базовых текстур
    self:CreateBaseTextures()
end

-- Создание моделей врагов
function AssetManager:CreateEnemyModels()
    local enemiesFolder = ReplicatedStorage:FindFirstChild("Models")
    if not enemiesFolder then return end
    
    local enemyModels = {
        Goblin = {
            size = Vector3.new(2, 4, 1),
            color = Color3.fromRGB(0, 255, 0),
            material = Enum.Material.Plastic
        },
        Orc = {
            size = Vector3.new(3, 5, 2),
            color = Color3.fromRGB(255, 0, 0),
            material = Enum.Material.Plastic
        },
        Troll = {
            size = Vector3.new(4, 6, 2),
            color = Color3.fromRGB(128, 0, 128),
            material = Enum.Material.Plastic
        },
        Dragon = {
            size = Vector3.new(6, 8, 4),
            color = Color3.fromRGB(255, 165, 0),
            material = Enum.Material.Plastic
        },
        Skeleton = {
            size = Vector3.new(2, 4, 1),
            color = Color3.fromRGB(255, 255, 255),
            material = Enum.Material.Plastic
        },
        Demon = {
            size = Vector3.new(3, 5, 2),
            color = Color3.fromRGB(139, 0, 0),
            material = Enum.Material.Plastic
        }
    }
    
    for enemyName, properties in pairs(enemyModels) do
        local model = Instance.new("Model")
        model.Name = enemyName
        
        local primaryPart = Instance.new("Part")
        primaryPart.Name = "PrimaryPart"
        primaryPart.Size = properties.size
        primaryPart.Color = properties.color
        primaryPart.Material = properties.material
        primaryPart.Anchored = false
        primaryPart.CanCollide = true
        primaryPart.Parent = model
        
        -- Humanoid для врага
        local humanoid = Instance.new("Humanoid")
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.Parent = model
        
        model.PrimaryPart = primaryPart
        model.Parent = enemiesFolder
        
        self.assets[enemyName] = model
    end
end

-- Создание моделей структур
function AssetManager:CreateStructureModels()
    local structuresFolder = ReplicatedStorage:FindFirstChild("Models")
    if not structuresFolder then return end
    
    local structureModels = {
        WoodWall = {
            size = Vector3.new(10, 10, 2),
            color = Color3.fromRGB(139, 69, 19),
            material = Enum.Material.Wood
        },
        StoneWall = {
            size = Vector3.new(10, 10, 2),
            color = Color3.fromRGB(128, 128, 128),
            material = Enum.Material.Rock
        },
        ReinforcedWall = {
            size = Vector3.new(10, 10, 2),
            color = Color3.fromRGB(64, 64, 64),
            material = Enum.Material.Concrete
        },
        ArcherTower = {
            size = Vector3.new(8, 15, 8),
            color = Color3.fromRGB(139, 69, 19),
            material = Enum.Material.Wood
        },
        CatapultTower = {
            size = Vector3.new(10, 12, 10),
            color = Color3.fromRGB(128, 128, 128),
            material = Enum.Material.Rock
        },
        IceTower = {
            size = Vector3.new(8, 15, 8),
            color = Color3.fromRGB(173, 216, 230),
            material = Enum.Material.Ice
        },
        CrystalTower = {
            size = Vector3.new(8, 15, 8),
            color = Color3.fromRGB(138, 43, 226),
            material = Enum.Material.Glass
        }
    }
    
    for structureName, properties in pairs(structureModels) do
        local model = Instance.new("Model")
        model.Name = structureName
        
        local primaryPart = Instance.new("Part")
        primaryPart.Name = "PrimaryPart"
        primaryPart.Size = properties.size
        primaryPart.Color = properties.color
        primaryPart.Material = properties.material
        primaryPart.Anchored = true
        primaryPart.CanCollide = true
        primaryPart.Parent = model
        
        model.PrimaryPart = primaryPart
        model.Parent = structuresFolder
        
        self.assets[structureName] = model
    end
end

-- Создание моделей эффектов
function AssetManager:CreateEffectModels()
    local effectsFolder = ReplicatedStorage:FindFirstChild("Models")
    if not effectsFolder then return end
    
    local effectModels = {
        Explosion = {
            size = Vector3.new(5, 5, 5),
            color = Color3.fromRGB(255, 0, 0),
            material = Enum.Material.ForceField,
            shape = Enum.PartType.Ball
        },
        HealAura = {
            size = Vector3.new(8, 8, 8),
            color = Color3.fromRGB(0, 255, 0),
            material = Enum.Material.ForceField,
            shape = Enum.PartType.Ball
        },
        MagicBolt = {
            size = Vector3.new(1, 1, 1),
            color = Color3.fromRGB(138, 43, 226),
            material = Enum.Material.ForceField,
            shape = Enum.PartType.Ball
        },
        Shield = {
            size = Vector3.new(6, 6, 6),
            color = Color3.fromRGB(0, 255, 255),
            material = Enum.Material.ForceField,
            shape = Enum.PartType.Ball
        }
    }
    
    for effectName, properties in pairs(effectModels) do
        local model = Instance.new("Model")
        model.Name = effectName
        
        local primaryPart = Instance.new("Part")
        primaryPart.Name = "PrimaryPart"
        primaryPart.Size = properties.size
        primaryPart.Color = properties.color
        primaryPart.Material = properties.material
        primaryPart.Shape = properties.shape
        primaryPart.Anchored = true
        primaryPart.CanCollide = false
        primaryPart.Transparency = 0.5
        primaryPart.Parent = model
        
        model.PrimaryPart = primaryPart
        model.Parent = effectsFolder
        
        self.assets[effectName] = model
    end
end

-- Создание базовых звуков
function AssetManager:CreateBaseSounds()
    local soundsFolder = ReplicatedStorage:FindFirstChild("Sounds")
    if not soundsFolder then return end
    
    local baseSounds = {
        "Attack",
        "Build", 
        "Gather",
        "LevelUp",
        "Achievement",
        "WaveStart",
        "WaveEnd",
        "EnemyDeath",
        "PlayerDeath",
        "NexusDamage"
    }
    
    for _, soundName in ipairs(baseSounds) do
        local sound = Instance.new("Sound")
        sound.Name = soundName
        sound.Volume = 0.5
        sound.Parent = soundsFolder
        
        -- Здесь можно добавить реальные звуковые файлы
        -- sound.SoundId = "rbxassetid://..."
    end
end

-- Создание базовых текстур
function AssetManager:CreateBaseTextures()
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return end
    
    local baseTextures = {
        "WoodTexture",
        "StoneTexture", 
        "MetalTexture",
        "CrystalTexture",
        "GrassTexture",
        "DirtTexture"
    }
    
    for _, textureName in ipairs(baseTextures) do
        local texture = Instance.new("Texture")
        texture.Name = textureName
        texture.Parent = texturesFolder
        
        -- Здесь можно добавить реальные текстуры
        -- texture.Texture = "rbxassetid://..."
    end
end

-- Получение модели по имени
function AssetManager:GetModel(modelName)
    if self.assetCache[modelName] then
        return self.assetCache[modelName]:Clone()
    end
    
    local model = self.assets[modelName]
    if model then
        self.assetCache[modelName] = model
        return model:Clone()
    end
    
    warn("[AssetManager] Model not found:", modelName)
    return nil
end

-- Создание врага с моделью
function AssetManager:CreateEnemy(enemyType, position)
    local model = self:GetModel(enemyType)
    if not model then
        -- Создание базовой модели врага
        model = Instance.new("Model")
        model.Name = enemyType
        
        local primaryPart = Instance.new("Part")
        primaryPart.Name = "PrimaryPart"
        primaryPart.Size = Vector3.new(2, 4, 1)
        primaryPart.Position = position
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
    else
        model.PrimaryPart.Position = position
    end
    
    return model
end

-- Создание структуры с моделью
function AssetManager:CreateStructure(structureType, position)
    local model = self:GetModel(structureType)
    if not model then
        -- Создание базовой модели структуры
        model = Instance.new("Model")
        model.Name = structureType
        
        local primaryPart = Instance.new("Part")
        primaryPart.Name = "PrimaryPart"
        primaryPart.Size = Vector3.new(10, 10, 2)
        primaryPart.Position = position
        primaryPart.Color = Color3.fromRGB(128, 128, 128)
        primaryPart.Material = Enum.Material.Plastic
        primaryPart.Anchored = true
        primaryPart.CanCollide = true
        primaryPart.Parent = model
        
        model.PrimaryPart = primaryPart
    else
        model.PrimaryPart.Position = position
    end
    
    return model
end

-- Создание эффекта с моделью
function AssetManager:CreateEffect(effectType, position)
    local model = self:GetModel(effectType)
    if not model then
        -- Создание базового эффекта
        model = Instance.new("Model")
        model.Name = effectType
        
        local primaryPart = Instance.new("Part")
        primaryPart.Name = "PrimaryPart"
        primaryPart.Size = Vector3.new(5, 5, 5)
        primaryPart.Position = position
        primaryPart.Color = Color3.fromRGB(255, 255, 0)
        primaryPart.Material = Enum.Material.ForceField
        primaryPart.Shape = Enum.PartType.Ball
        primaryPart.Anchored = true
        primaryPart.CanCollide = false
        primaryPart.Transparency = 0.5
        primaryPart.Parent = model
        
        model.PrimaryPart = primaryPart
    else
        model.PrimaryPart.Position = position
    end
    
    return model
end

-- Воспроизведение звука
function AssetManager:PlaySound(soundName, position)
    local soundsFolder = ReplicatedStorage:FindFirstChild("Sounds")
    if not soundsFolder then return end
    
    local sound = soundsFolder:FindFirstChild(soundName)
    if sound then
        local soundClone = sound:Clone()
        soundClone.Position = position
        soundClone.Parent = workspace
        soundClone:Play()
        
        -- Удаление звука после воспроизведения
        soundClone.Ended:Connect(function()
            soundClone:Destroy()
        end)
    end
end

-- Применение текстуры к объекту
function AssetManager:ApplyTexture(object, textureName)
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return end
    
    local texture = texturesFolder:FindFirstChild(textureName)
    if texture and object:IsA("BasePart") then
        object.Material = Enum.Material.Plastic
        -- object.TextureID = texture.Texture -- если есть реальная текстура
    end
end

-- Создание анимированного эффекта
function AssetManager:CreateAnimatedEffect(effectType, position, duration)
    local effect = self:CreateEffect(effectType, position)
    if not effect then return end
    
    effect.Parent = workspace
    
    -- Анимация появления
    local tween = TweenService:Create(effect.PrimaryPart, TweenInfo.new(duration or 2), {
        Size = effect.PrimaryPart.Size * 2,
        Transparency = 1
    })
    tween:Play()
    
    -- Удаление после анимации
    tween.Completed:Connect(function()
        effect:Destroy()
    end)
    
    return effect
end

-- Создание частиц
function AssetManager:CreateParticleSystem(particleType, position)
    local particleFolder = ReplicatedStorage:FindFirstChild("Particles")
    if not particleFolder then return end
    
    local particleSystem = Instance.new("ParticleEmitter")
    particleSystem.Parent = Instance.new("Part")
    particleSystem.Parent.Position = position
    particleSystem.Parent.Anchored = true
    particleSystem.Parent.CanCollide = false
    particleSystem.Parent.Transparency = 1
    particleSystem.Parent.Parent = workspace
    
    -- Настройка частиц в зависимости от типа
    if particleType == "Explosion" then
        particleSystem.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
        particleSystem.Size = NumberSequence.new(1, 0)
        particleSystem.Speed = NumberRange.new(10, 20)
        particleSystem.Lifetime = NumberRange.new(1, 2)
        particleSystem.Rate = 100
        particleSystem.SpreadAngle = Vector2.new(360, 360)
    elseif particleType == "Magic" then
        particleSystem.Color = ColorSequence.new(Color3.fromRGB(138, 43, 226))
        particleSystem.Size = NumberSequence.new(0.5, 0)
        particleSystem.Speed = NumberRange.new(5, 10)
        particleSystem.Lifetime = NumberRange.new(2, 3)
        particleSystem.Rate = 50
        particleSystem.SpreadAngle = Vector2.new(180, 180)
    end
    
    -- Остановка через 3 секунды
    task.wait(3)
    particleSystem.Enabled = false
    task.wait(3)
    particleSystem.Parent:Destroy()
end

-- Получение списка доступных активов
function AssetManager:GetAvailableAssets()
    local available = {
        enemies = {},
        structures = {},
        effects = {},
        sounds = {},
        textures = {}
    }
    
    -- Получение моделей врагов
    local enemiesFolder = ReplicatedStorage:FindFirstChild("Models")
    if enemiesFolder then
        for _, model in pairs(enemiesFolder:GetChildren()) do
            if model:IsA("Model") then
                if model.Name:find("Goblin") or model.Name:find("Orc") or model.Name:find("Troll") or 
                   model.Name:find("Dragon") or model.Name:find("Skeleton") or model.Name:find("Demon") then
                    table.insert(available.enemies, model.Name)
                elseif model.Name:find("Wall") or model.Name:find("Tower") then
                    table.insert(available.structures, model.Name)
                elseif model.Name:find("Explosion") or model.Name:find("Aura") or model.Name:find("Bolt") or model.Name:find("Shield") then
                    table.insert(available.effects, model.Name)
                end
            end
        end
    end
    
    -- Получение звуков
    local soundsFolder = ReplicatedStorage:FindFirstChild("Sounds")
    if soundsFolder then
        for _, sound in pairs(soundsFolder:GetChildren()) do
            if sound:IsA("Sound") then
                table.insert(available.sounds, sound.Name)
            end
        end
    end
    
    -- Получение текстур
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if texturesFolder then
        for _, texture in pairs(texturesFolder:GetChildren()) do
            if texture:IsA("Texture") then
                table.insert(available.textures, texture.Name)
            end
        end
    end
    
    return available
end

-- Очистка кэша активов
function AssetManager:ClearCache()
    self.assetCache = {}
    print("[AssetManager] Asset cache cleared")
end

return AssetManager