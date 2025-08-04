-- ModelBuilder.lua
-- Инструмент для создания и редактирования моделей

local ModelBuilder = {}
ModelBuilder.__index = ModelBuilder

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Состояние
ModelBuilder.templates = {}
ModelBuilder.activeBuilders = {}

function ModelBuilder:Initialize()
    print("[ModelBuilder] Initializing model builder...")
    
    -- Создание шаблонов моделей
    self:CreateModelTemplates()
    
    print("[ModelBuilder] Model builder initialized!")
end

-- Создание шаблонов моделей
function ModelBuilder:CreateModelTemplates()
    self.templates = {
        -- Шаблоны врагов
        enemies = {
            BasicEnemy = {
                parts = {
                    body = {
                        type = "Part",
                        size = Vector3.new(2, 4, 1),
                        color = Color3.fromRGB(255, 0, 0),
                        material = Enum.Material.Plastic,
                        position = Vector3.new(0, 2, 0)
                    },
                    head = {
                        type = "Part",
                        size = Vector3.new(1, 1, 1),
                        color = Color3.fromRGB(255, 200, 200),
                        material = Enum.Material.Plastic,
                        position = Vector3.new(0, 4.5, 0)
                    }
                },
                humanoid = true,
                weldConnections = {
                    {from = "head", to = "body", offset = Vector3.new(0, 2.5, 0)}
                }
            },
            
            FlyingEnemy = {
                parts = {
                    body = {
                        type = "Part",
                        size = Vector3.new(3, 2, 3),
                        color = Color3.fromRGB(0, 0, 255),
                        material = Enum.Material.Plastic,
                        position = Vector3.new(0, 5, 0)
                    },
                    wing1 = {
                        type = "Part",
                        size = Vector3.new(2, 0.5, 1),
                        color = Color3.fromRGB(100, 100, 255),
                        material = Enum.Material.Plastic,
                        position = Vector3.new(-2, 5, 0)
                    },
                    wing2 = {
                        type = "Part",
                        size = Vector3.new(2, 0.5, 1),
                        color = Color3.fromRGB(100, 100, 255),
                        material = Enum.Material.Plastic,
                        position = Vector3.new(2, 5, 0)
                    }
                },
                humanoid = true,
                weldConnections = {
                    {from = "wing1", to = "body", offset = Vector3.new(-2.5, 0, 0)},
                    {from = "wing2", to = "body", offset = Vector3.new(2.5, 0, 0)}
                }
            }
        },
        
        -- Шаблоны структур
        structures = {
            BasicTower = {
                parts = {
                    base = {
                        type = "Part",
                        size = Vector3.new(8, 2, 8),
                        color = Color3.fromRGB(128, 128, 128),
                        material = Enum.Material.Rock,
                        position = Vector3.new(0, 1, 0)
                    },
                    tower = {
                        type = "Part",
                        size = Vector3.new(6, 10, 6),
                        color = Color3.fromRGB(100, 100, 100),
                        material = Enum.Material.Rock,
                        position = Vector3.new(0, 7, 0)
                    },
                    top = {
                        type = "Part",
                        size = Vector3.new(4, 2, 4),
                        color = Color3.fromRGB(80, 80, 80),
                        material = Enum.Material.Rock,
                        position = Vector3.new(0, 13, 0)
                    }
                },
                humanoid = false,
                weldConnections = {
                    {from = "tower", to = "base", offset = Vector3.new(0, 6, 0)},
                    {from = "top", to = "tower", offset = Vector3.new(0, 6, 0)}
                }
            },
            
            Wall = {
                parts = {
                    wall = {
                        type = "Part",
                        size = Vector3.new(10, 10, 2),
                        color = Color3.fromRGB(139, 69, 19),
                        material = Enum.Material.Wood,
                        position = Vector3.new(0, 5, 0)
                    }
                },
                humanoid = false,
                weldConnections = {}
            }
        },
        
        -- Шаблоны эффектов
        effects = {
            Explosion = {
                parts = {
                    core = {
                        type = "Part",
                        size = Vector3.new(5, 5, 5),
                        color = Color3.fromRGB(255, 0, 0),
                        material = Enum.Material.ForceField,
                        shape = Enum.PartType.Ball,
                        position = Vector3.new(0, 0, 0)
                    }
                },
                humanoid = false,
                weldConnections = {},
                animated = true
            },
            
            MagicAura = {
                parts = {
                    aura = {
                        type = "Part",
                        size = Vector3.new(8, 8, 8),
                        color = Color3.fromRGB(138, 43, 226),
                        material = Enum.Material.ForceField,
                        shape = Enum.PartType.Ball,
                        position = Vector3.new(0, 0, 0)
                    }
                },
                humanoid = false,
                weldConnections = {},
                animated = true
            }
        }
    }
end

-- Создание модели из шаблона
function ModelBuilder:CreateModelFromTemplate(templateName, category, position)
    local template = self.templates[category] and self.templates[category][templateName]
    if not template then
        warn("[ModelBuilder] Template not found:", templateName, "in category:", category)
        return nil
    end
    
    local model = Instance.new("Model")
    model.Name = templateName
    model.Parent = workspace
    
    local parts = {}
    
    -- Создание частей модели
    for partName, partData in pairs(template.parts) do
        local part = Instance.new(partData.type)
        part.Name = partName
        part.Size = partData.size
        part.Color = partData.color
        part.Material = partData.material
        part.Position = position + partData.position
        part.Anchored = true
        part.CanCollide = true
        part.Parent = model
        
        if partData.shape then
            part.Shape = partData.shape
        end
        
        if partData.transparency then
            part.Transparency = partData.transparency
        end
        
        parts[partName] = part
    end
    
    -- Создание Humanoid если нужно
    if template.humanoid then
        local humanoid = Instance.new("Humanoid")
        humanoid.MaxHealth = 100
        humanoid.Health = 100
        humanoid.Parent = model
    end
    
    -- Создание соединений между частями
    for _, connection in ipairs(template.weldConnections) do
        if parts[connection.from] and parts[connection.to] then
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = parts[connection.from]
            weld.Part1 = parts[connection.to]
            weld.C0 = CFrame.new(connection.offset)
            weld.Parent = model
        end
    end
    
    -- Установка PrimaryPart
    local firstPart = next(parts)
    if firstPart then
        model.PrimaryPart = parts[firstPart]
    end
    
    -- Анимация если нужно
    if template.animated then
        self:AnimateModel(model, templateName)
    end
    
    return model
end

-- Анимация модели
function ModelBuilder:AnimateModel(model, modelType)
    if not model.PrimaryPart then return end
    
    if modelType == "Explosion" then
        -- Анимация взрыва
        local tween = TweenService:Create(model.PrimaryPart, TweenInfo.new(2), {
            Size = model.PrimaryPart.Size * 3,
            Transparency = 1
        })
        tween:Play()
        
        tween.Completed:Connect(function()
            model:Destroy()
        end)
        
    elseif modelType == "MagicAura" then
        -- Пульсирующая анимация
        local originalSize = model.PrimaryPart.Size
        local originalTransparency = model.PrimaryPart.Transparency
        
        RunService.Heartbeat:Connect(function()
            local time = tick()
            local scale = 1 + math.sin(time * 3) * 0.2
            model.PrimaryPart.Size = originalSize * scale
            model.PrimaryPart.Transparency = originalTransparency + math.sin(time * 2) * 0.3
        end)
    end
end

-- Создание кастомной модели
function ModelBuilder:CreateCustomModel(modelName, partsData, position)
    local model = Instance.new("Model")
    model.Name = modelName
    model.Parent = workspace
    
    local parts = {}
    
    -- Создание частей
    for partName, partData in pairs(partsData) do
        local part = Instance.new(partData.type or "Part")
        part.Name = partName
        part.Size = partData.size or Vector3.new(1, 1, 1)
        part.Color = partData.color or Color3.fromRGB(255, 255, 255)
        part.Material = partData.material or Enum.Material.Plastic
        part.Position = position + (partData.position or Vector3.new(0, 0, 0))
        part.Anchored = partData.anchored ~= false
        part.CanCollide = partData.canCollide ~= false
        part.Parent = model
        
        if partData.shape then
            part.Shape = partData.shape
        end
        
        if partData.transparency then
            part.Transparency = partData.transparency
        end
        
        parts[partName] = part
    end
    
    -- Создание Humanoid если указано
    if partsData.humanoid then
        local humanoid = Instance.new("Humanoid")
        humanoid.MaxHealth = partsData.humanoid.maxHealth or 100
        humanoid.Health = partsData.humanoid.health or 100
        humanoid.Parent = model
    end
    
    -- Создание соединений
    if partsData.welds then
        for _, weldData in ipairs(partsData.welds) do
            if parts[weldData.from] and parts[weldData.to] then
                local weld = Instance.new("WeldConstraint")
                weld.Part0 = parts[weldData.from]
                weld.Part1 = parts[weldData.to]
                weld.C0 = CFrame.new(weldData.offset or Vector3.new(0, 0, 0))
                weld.Parent = model
            end
        end
    end
    
    -- Установка PrimaryPart
    if partsData.primaryPart and parts[partsData.primaryPart] then
        model.PrimaryPart = parts[partsData.primaryPart]
    else
        local firstPart = next(parts)
        if firstPart then
            model.PrimaryPart = parts[firstPart]
        end
    end
    
    return model
end

-- Редактирование существующей модели
function ModelBuilder:EditModel(model, edits)
    if not model or not model:IsA("Model") then
        warn("[ModelBuilder] Invalid model for editing")
        return false
    end
    
    -- Изменение частей
    if edits.parts then
        for partName, partEdits in pairs(edits.parts) do
            local part = model:FindFirstChild(partName)
            if part and part:IsA("BasePart") then
                if partEdits.size then
                    part.Size = partEdits.size
                end
                if partEdits.color then
                    part.Color = partEdits.color
                end
                if partEdits.material then
                    part.Material = partEdits.material
                end
                if partEdits.position then
                    part.Position = partEdits.position
                end
                if partEdits.transparency then
                    part.Transparency = partEdits.transparency
                end
            end
        end
    end
    
    -- Изменение Humanoid
    if edits.humanoid then
        local humanoid = model:FindFirstChild("Humanoid")
        if humanoid and humanoid:IsA("Humanoid") then
            if edits.humanoid.maxHealth then
                humanoid.MaxHealth = edits.humanoid.maxHealth
            end
            if edits.humanoid.health then
                humanoid.Health = edits.humanoid.health
            end
        end
    end
    
    return true
end

-- Клонирование модели
function ModelBuilder:CloneModel(originalModel, position)
    if not originalModel or not originalModel:IsA("Model") then
        warn("[ModelBuilder] Invalid model for cloning")
        return nil
    end
    
    local clone = originalModel:Clone()
    clone.Parent = workspace
    
    if position and clone.PrimaryPart then
        clone.PrimaryPart.Position = position
    end
    
    return clone
end

-- Создание составной модели
function ModelBuilder:CreateCompositeModel(modelName, subModels, position)
    local model = Instance.new("Model")
    model.Name = modelName
    model.Parent = workspace
    
    local parts = {}
    
    -- Добавление подмоделей
    for subModelName, subModelData in pairs(subModels) do
        local subModel = self:CreateModelFromTemplate(subModelData.template, subModelData.category, position + (subModelData.offset or Vector3.new(0, 0, 0)))
        if subModel then
            subModel.Name = subModelName
            subModel.Parent = model
            
            -- Сбор всех частей подмодели
            for _, part in pairs(subModel:GetDescendants()) do
                if part:IsA("BasePart") then
                    parts[subModelName .. "_" .. part.Name] = part
                end
            end
        end
    end
    
    -- Установка PrimaryPart
    local firstPart = next(parts)
    if firstPart then
        model.PrimaryPart = parts[firstPart]
    end
    
    return model
end

-- Получение списка доступных шаблонов
function ModelBuilder:GetAvailableTemplates()
    local available = {}
    
    for category, templates in pairs(self.templates) do
        available[category] = {}
        for templateName, _ in pairs(templates) do
            table.insert(available[category], templateName)
        end
    end
    
    return available
end

-- Сохранение модели как шаблона
function ModelBuilder:SaveModelAsTemplate(model, templateName, category)
    if not model or not model:IsA("Model") then
        warn("[ModelBuilder] Invalid model for saving as template")
        return false
    end
    
    if not self.templates[category] then
        self.templates[category] = {}
    end
    
    local template = {
        parts = {},
        humanoid = false,
        weldConnections = {}
    }
    
    -- Сохранение частей
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            template.parts[part.Name] = {
                type = part.ClassName,
                size = part.Size,
                color = part.Color,
                material = part.Material,
                position = part.Position - model.PrimaryPart.Position,
                transparency = part.Transparency
            }
            
            if part.Shape then
                template.parts[part.Name].shape = part.Shape
            end
        elseif part:IsA("Humanoid") then
            template.humanoid = {
                maxHealth = part.MaxHealth,
                health = part.Health
            }
        end
    end
    
    -- Сохранение соединений
    for _, weld in pairs(model:GetDescendants()) do
        if weld:IsA("WeldConstraint") then
            table.insert(template.weldConnections, {
                from = weld.Part0.Name,
                to = weld.Part1.Name,
                offset = weld.C0.Position
            })
        end
    end
    
    self.templates[category][templateName] = template
    print("[ModelBuilder] Model saved as template:", templateName, "in category:", category)
    
    return true
end

-- Очистка моделей
function ModelBuilder:CleanupModels()
    for _, builder in pairs(self.activeBuilders) do
        if builder and builder.Parent then
            builder:Destroy()
        end
    end
    
    self.activeBuilders = {}
    print("[ModelBuilder] All models cleaned up")
end

return ModelBuilder