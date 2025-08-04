-- TextureManager.lua
-- Система управления текстурами и материалами

local TextureManager = {}
TextureManager.__index = TextureManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Состояние
TextureManager.textures = {}
TextureManager.materials = {}
TextureManager.textureCache = {}

function TextureManager:Initialize()
    print("[TextureManager] Initializing texture manager...")
    
    -- Создание базовых текстур
    self:CreateBaseTextures()
    
    -- Создание материалов
    self:CreateMaterials()
    
    print("[TextureManager] Texture manager initialized!")
end

-- Создание базовых текстур
function TextureManager:CreateBaseTextures()
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return end
    
    self.textures = {
        -- Деревянные текстуры
        Wood = {
            Oak = {
                color = Color3.fromRGB(139, 69, 19),
                material = Enum.Material.Wood,
                roughness = 0.8
            },
            Pine = {
                color = Color3.fromRGB(160, 82, 45),
                material = Enum.Material.Wood,
                roughness = 0.7
            },
            DarkWood = {
                color = Color3.fromRGB(101, 67, 33),
                material = Enum.Material.Wood,
                roughness = 0.9
            }
        },
        
        -- Каменные текстуры
        Stone = {
            Granite = {
                color = Color3.fromRGB(128, 128, 128),
                material = Enum.Material.Rock,
                roughness = 0.9
            },
            Marble = {
                color = Color3.fromRGB(220, 220, 220),
                material = Enum.Material.Slate,
                roughness = 0.3
            },
            Obsidian = {
                color = Color3.fromRGB(20, 20, 20),
                material = Enum.Material.Rock,
                roughness = 0.1
            }
        },
        
        -- Металлические текстуры
        Metal = {
            Iron = {
                color = Color3.fromRGB(169, 169, 169),
                material = Enum.Material.Metal,
                roughness = 0.6
            },
            Gold = {
                color = Color3.fromRGB(255, 215, 0),
                material = Enum.Material.Metal,
                roughness = 0.2
            },
            Steel = {
                color = Color3.fromRGB(192, 192, 192),
                material = Enum.Material.Metal,
                roughness = 0.4
            }
        },
        
        -- Магические текстуры
        Magic = {
            Crystal = {
                color = Color3.fromRGB(138, 43, 226),
                material = Enum.Material.Glass,
                roughness = 0.1,
                transparency = 0.3
            },
            Ice = {
                color = Color3.fromRGB(173, 216, 230),
                material = Enum.Material.Ice,
                roughness = 0.2,
                transparency = 0.5
            },
            Fire = {
                color = Color3.fromRGB(255, 69, 0),
                material = Enum.Material.Neon,
                roughness = 0.0,
                emission = 0.8
            }
        },
        
        -- Природные текстуры
        Nature = {
            Grass = {
                color = Color3.fromRGB(34, 139, 34),
                material = Enum.Material.Grass,
                roughness = 0.8
            },
            Dirt = {
                color = Color3.fromRGB(139, 69, 19),
                material = Enum.Material.Sand,
                roughness = 0.9
            },
            Water = {
                color = Color3.fromRGB(0, 191, 255),
                material = Enum.Material.Water,
                roughness = 0.1,
                transparency = 0.7
            }
        }
    }
    
    -- Создание объектов текстур
    for category, textures in pairs(self.textures) do
        for textureName, properties in pairs(textures) do
            local texture = Instance.new("Texture")
            texture.Name = textureName
            texture.Parent = texturesFolder
            
            -- Здесь можно добавить реальные текстуры
            -- texture.Texture = "rbxassetid://..."
            
            self.textureCache[textureName] = texture
        end
    end
end

-- Создание материалов
function TextureManager:CreateMaterials()
    self.materials = {
        -- Базовые материалы
        Basic = {
            Plastic = {
                material = Enum.Material.Plastic,
                color = Color3.fromRGB(255, 255, 255),
                roughness = 0.5
            },
            Wood = {
                material = Enum.Material.Wood,
                color = Color3.fromRGB(139, 69, 19),
                roughness = 0.8
            },
            Metal = {
                material = Enum.Material.Metal,
                color = Color3.fromRGB(192, 192, 192),
                roughness = 0.4
            },
            Rock = {
                material = Enum.Material.Rock,
                color = Color3.fromRGB(128, 128, 128),
                roughness = 0.9
            }
        },
        
        -- Специальные материалы
        Special = {
            Neon = {
                material = Enum.Material.Neon,
                color = Color3.fromRGB(255, 0, 255),
                roughness = 0.0,
                emission = 1.0
            },
            Glass = {
                material = Enum.Material.Glass,
                color = Color3.fromRGB(255, 255, 255),
                roughness = 0.1,
                transparency = 0.5
            },
            Ice = {
                material = Enum.Material.Ice,
                color = Color3.fromRGB(173, 216, 230),
                roughness = 0.2,
                transparency = 0.3
            },
            ForceField = {
                material = Enum.Material.ForceField,
                color = Color3.fromRGB(0, 255, 255),
                roughness = 0.0,
                transparency = 0.7
            }
        }
    }
end

-- Применение текстуры к объекту
function TextureManager:ApplyTexture(object, textureName, category)
    if not object or not object:IsA("BasePart") then
        warn("[TextureManager] Invalid object for texture application")
        return false
    end
    
    local textureData = self.textures[category] and self.textures[category][textureName]
    if not textureData then
        warn("[TextureManager] Texture not found:", textureName, "in category:", category)
        return false
    end
    
    -- Применение свойств текстуры
    object.Material = textureData.material
    object.Color = textureData.color
    
    if textureData.roughness then
        object.Roughness = textureData.roughness
    end
    
    if textureData.transparency then
        object.Transparency = textureData.transparency
    end
    
    if textureData.emission then
        object.Emission = textureData.emission
    end
    
    -- Применение текстуры если есть
    local texture = self.textureCache[textureName]
    if texture and texture.Texture ~= "" then
        object.TextureID = texture.Texture
    end
    
    return true
end

-- Применение материала к объекту
function TextureManager:ApplyMaterial(object, materialName, category)
    if not object or not object:IsA("BasePart") then
        warn("[TextureManager] Invalid object for material application")
        return false
    end
    
    local materialData = self.materials[category] and self.materials[category][materialName]
    if not materialData then
        warn("[TextureManager] Material not found:", materialName, "in category:", category)
        return false
    end
    
    -- Применение свойств материала
    object.Material = materialData.material
    object.Color = materialData.color
    
    if materialData.roughness then
        object.Roughness = materialData.roughness
    end
    
    if materialData.transparency then
        object.Transparency = materialData.transparency
    end
    
    if materialData.emission then
        object.Emission = materialData.emission
    end
    
    return true
end

-- Создание кастомной текстуры
function TextureManager:CreateCustomTexture(textureName, properties)
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return nil end
    
    local texture = Instance.new("Texture")
    texture.Name = textureName
    
    if properties.textureId then
        texture.Texture = properties.textureId
    end
    
    if properties.color then
        texture.Color3 = properties.color
    end
    
    if properties.transparency then
        texture.Transparency = properties.transparency
    end
    
    texture.Parent = texturesFolder
    
    self.textureCache[textureName] = texture
    print("[TextureManager] Custom texture created:", textureName)
    
    return texture
end

-- Создание анимированной текстуры
function TextureManager:CreateAnimatedTexture(textureName, animationData)
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return nil end
    
    local texture = Instance.new("Texture")
    texture.Name = textureName
    texture.Parent = texturesFolder
    
    -- Анимация цвета
    if animationData.colorAnimation then
        local tween = TweenService:Create(texture, TweenInfo.new(animationData.duration or 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Color3 = animationData.colorAnimation.to
        })
        tween:Play()
    end
    
    -- Анимация прозрачности
    if animationData.transparencyAnimation then
        local tween = TweenService:Create(texture, TweenInfo.new(animationData.duration or 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Transparency = animationData.transparencyAnimation.to
        })
        tween:Play()
    end
    
    self.textureCache[textureName] = texture
    print("[TextureManager] Animated texture created:", textureName)
    
    return texture
end

-- Получение текстуры по имени
function TextureManager:GetTexture(textureName)
    return self.textureCache[textureName]
end

-- Получение списка доступных текстур
function TextureManager:GetAvailableTextures()
    local available = {}
    
    for category, textures in pairs(self.textures) do
        available[category] = {}
        for textureName, _ in pairs(textures) do
            table.insert(available[category], textureName)
        end
    end
    
    return available
end

-- Получение списка доступных материалов
function TextureManager:GetAvailableMaterials()
    local available = {}
    
    for category, materials in pairs(self.materials) do
        available[category] = {}
        for materialName, _ in pairs(materials) do
            table.insert(available[category], materialName)
        end
    end
    
    return available
end

-- Создание градиентной текстуры
function TextureManager:CreateGradientTexture(textureName, colors, direction)
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return nil end
    
    local texture = Instance.new("Texture")
    texture.Name = textureName
    
    -- Создание градиента
    local colorSequence = ColorSequence.new(colors)
    texture.Color3 = colorSequence.Keypoints[1].Value
    
    -- Анимация градиента
    local tween = TweenService:Create(texture, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
        Color3 = colorSequence.Keypoints[#colorSequence.Keypoints].Value
    })
    tween:Play()
    
    texture.Parent = texturesFolder
    self.textureCache[textureName] = texture
    
    print("[TextureManager] Gradient texture created:", textureName)
    return texture
end

-- Создание текстуры с паттерном
function TextureManager:CreatePatternTexture(textureName, patternData)
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return nil end
    
    local texture = Instance.new("Texture")
    texture.Name = textureName
    
    -- Применение паттерна
    if patternData.pattern then
        texture.Texture = patternData.pattern
    end
    
    if patternData.color then
        texture.Color3 = patternData.color
    end
    
    if patternData.transparency then
        texture.Transparency = patternData.transparency
    end
    
    texture.Parent = texturesFolder
    self.textureCache[textureName] = texture
    
    print("[TextureManager] Pattern texture created:", textureName)
    return texture
end

-- Массовое применение текстуры
function TextureManager:ApplyTextureToGroup(objects, textureName, category)
    local successCount = 0
    local totalCount = 0
    
    for _, object in pairs(objects) do
        totalCount = totalCount + 1
        if self:ApplyTexture(object, textureName, category) then
            successCount = successCount + 1
        end
    end
    
    print("[TextureManager] Applied texture to", successCount, "out of", totalCount, "objects")
    return successCount, totalCount
end

-- Создание текстуры из изображения
function TextureManager:CreateTextureFromImage(textureName, imageId)
    local texturesFolder = ReplicatedStorage:FindFirstChild("Textures")
    if not texturesFolder then return nil end
    
    local texture = Instance.new("Texture")
    texture.Name = textureName
    texture.Texture = "rbxassetid://" .. imageId
    texture.Parent = texturesFolder
    
    self.textureCache[textureName] = texture
    print("[TextureManager] Image texture created:", textureName)
    
    return texture
end

-- Очистка текстур
function TextureManager:ClearTextures()
    for textureName, texture in pairs(self.textureCache) do
        if texture and texture.Parent then
            texture:Destroy()
        end
    end
    
    self.textureCache = {}
    print("[TextureManager] All textures cleared")
end

-- Экспорт конфигурации текстур
function TextureManager:ExportTextureConfig()
    local config = {
        textures = self.textures,
        materials = self.materials
    }
    
    return config
end

-- Импорт конфигурации текстур
function TextureManager:ImportTextureConfig(config)
    if config.textures then
        self.textures = config.textures
    end
    
    if config.materials then
        self.materials = config.materials
    end
    
    print("[TextureManager] Texture configuration imported")
end

return TextureManager