-- AssetEditor.lua
-- Инструмент для редактирования и настройки активов

local AssetEditor = {}
AssetEditor.__index = AssetEditor

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- Импорт других систем
local AssetManager = require(ReplicatedStorage.Assets.AssetManager)
local ModelBuilder = require(ReplicatedStorage.Assets.ModelBuilder)
local TextureManager = require(ReplicatedStorage.Assets.TextureManager)

-- Состояние
AssetEditor.activeEditor = nil
AssetEditor.selectedObjects = {}
AssetEditor.editHistory = {}
AssetEditor.maxHistorySize = 50

function AssetEditor:Initialize()
    print("[AssetEditor] Initializing asset editor...")
    
    -- Инициализация зависимых систем
    AssetManager:Initialize()
    ModelBuilder:Initialize()
    TextureManager:Initialize()
    
    print("[AssetEditor] Asset editor initialized!")
end

-- Создание редактора моделей
function AssetEditor:CreateModelEditor()
    local editor = {
        mode = "select",
        selectedModel = nil,
        selectedPart = nil,
        tools = {}
    }
    
    -- Инструменты редактора
    editor.tools = {
        select = function(model, part)
            editor.selectedModel = model
            editor.selectedPart = part
            self:HighlightObject(part)
        end,
        
        move = function(part, newPosition)
            if part then
                self:AddToHistory("move", part, {position = part.Position})
                part.Position = newPosition
            end
        end,
        
        resize = function(part, newSize)
            if part then
                self:AddToHistory("resize", part, {size = part.Size})
                part.Size = newSize
            end
        end,
        
        rotate = function(part, newRotation)
            if part then
                self:AddToHistory("rotate", part, {rotation = part.Orientation})
                part.Orientation = newRotation
            end
        end,
        
        color = function(part, newColor)
            if part then
                self:AddToHistory("color", part, {color = part.Color})
                part.Color = newColor
            end
        end,
        
        material = function(part, newMaterial)
            if part then
                self:AddToHistory("material", part, {material = part.Material})
                part.Material = newMaterial
            end
        end
    }
    
    self.activeEditor = editor
    return editor
end

-- Создание редактора текстур
function AssetEditor:CreateTextureEditor()
    local editor = {
        mode = "paint",
        selectedTexture = nil,
        brushSize = 1,
        brushColor = Color3.fromRGB(255, 255, 255),
        tools = {}
    }
    
    -- Инструменты редактора текстур
    editor.tools = {
        paint = function(object, position)
            if object and object:IsA("BasePart") then
                TextureManager:ApplyTexture(object, editor.selectedTexture, "Custom")
            end
        end,
        
        fill = function(object)
            if object and object:IsA("BasePart") then
                TextureManager:ApplyMaterial(object, "Custom", "Basic")
            end
        end,
        
        gradient = function(object, startColor, endColor)
            if object and object:IsA("BasePart") then
                local gradientTexture = TextureManager:CreateGradientTexture("Gradient_" .. tick(), {startColor, endColor})
                if gradientTexture then
                    TextureManager:ApplyTexture(object, gradientTexture.Name, "Custom")
                end
            end
        end
    }
    
    return editor
end

-- Выделение объекта
function AssetEditor:HighlightObject(object)
    if not object then return end
    
    -- Удаление предыдущего выделения
    for _, obj in pairs(self.selectedObjects) do
        if obj.highlight then
            obj.highlight:Destroy()
        end
    end
    
    self.selectedObjects = {}
    
    -- Создание нового выделения
    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.fromRGB(255, 255, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.Parent = object
    
    table.insert(self.selectedObjects, {
        object = object,
        highlight = highlight
    })
end

-- Добавление в историю изменений
function AssetEditor:AddToHistory(action, object, oldValues)
    if #self.editHistory >= self.maxHistorySize then
        table.remove(self.editHistory, 1)
    end
    
    table.insert(self.editHistory, {
        action = action,
        object = object,
        oldValues = oldValues,
        timestamp = tick()
    })
end

-- Отмена последнего действия
function AssetEditor:Undo()
    if #self.editHistory == 0 then
        print("[AssetEditor] No actions to undo")
        return false
    end
    
    local lastAction = table.remove(self.editHistory)
    
    if lastAction.action == "move" then
        lastAction.object.Position = lastAction.oldValues.position
    elseif lastAction.action == "resize" then
        lastAction.object.Size = lastAction.oldValues.size
    elseif lastAction.action == "rotate" then
        lastAction.object.Orientation = lastAction.oldValues.rotation
    elseif lastAction.action == "color" then
        lastAction.object.Color = lastAction.oldValues.color
    elseif lastAction.action == "material" then
        lastAction.object.Material = lastAction.oldValues.material
    end
    
    print("[AssetEditor] Undid action:", lastAction.action)
    return true
end

-- Создание модели из шаблона с редактором
function AssetEditor:CreateModelWithEditor(templateName, category, position)
    local model = ModelBuilder:CreateModelFromTemplate(templateName, category, position)
    if not model then return nil end
    
    local editor = self:CreateModelEditor()
    editor.tools.select(model, model.PrimaryPart)
    
    return model, editor
end

-- Редактирование существующей модели
function AssetEditor:EditExistingModel(model)
    if not model or not model:IsA("Model") then
        warn("[AssetEditor] Invalid model for editing")
        return nil
    end
    
    local editor = self:CreateModelEditor()
    editor.tools.select(model, model.PrimaryPart)
    
    return editor
end

-- Создание кастомной модели с редактором
function AssetEditor:CreateCustomModelWithEditor(modelName, partsData, position)
    local model = ModelBuilder:CreateCustomModel(modelName, partsData, position)
    if not model then return nil end
    
    local editor = self:CreateModelEditor()
    editor.tools.select(model, model.PrimaryPart)
    
    return model, editor
end

-- Массовое редактирование объектов
function AssetEditor:BatchEditObjects(objects, editFunction)
    if not objects or #objects == 0 then
        warn("[AssetEditor] No objects provided for batch edit")
        return false
    end
    
    for _, object in pairs(objects) do
        if object and object:IsA("BasePart") then
            editFunction(object)
        end
    end
    
    print("[AssetEditor] Batch edit completed on", #objects, "objects")
    return true
end

-- Создание анимированной модели
function AssetEditor:CreateAnimatedModel(modelName, partsData, animations, position)
    local model = ModelBuilder:CreateCustomModel(modelName, partsData, position)
    if not model then return nil end
    
    -- Применение анимаций
    for partName, animationData in pairs(animations) do
        local part = model:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            self:ApplyPartAnimation(part, animationData)
        end
    end
    
    return model
end

-- Применение анимации к части
function AssetEditor:ApplyPartAnimation(part, animationData)
    if not part or not part:IsA("BasePart") then return end
    
    if animationData.rotation then
        local tween = TweenService:Create(part, TweenInfo.new(animationData.duration or 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Orientation = animationData.rotation
        })
        tween:Play()
    end
    
    if animationData.scale then
        local tween = TweenService:Create(part, TweenInfo.new(animationData.duration or 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Size = part.Size * animationData.scale
        })
        tween:Play()
    end
    
    if animationData.color then
        local tween = TweenService:Create(part, TweenInfo.new(animationData.duration or 2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
            Color = animationData.color
        })
        tween:Play()
    end
end

-- Создание составной модели с редактором
function AssetEditor:CreateCompositeModelWithEditor(modelName, subModels, position)
    local model = ModelBuilder:CreateCompositeModel(modelName, subModels, position)
    if not model then return nil end
    
    local editor = self:CreateModelEditor()
    editor.tools.select(model, model.PrimaryPart)
    
    return model, editor
end

-- Экспорт модели
function AssetEditor:ExportModel(model)
    if not model or not model:IsA("Model") then
        warn("[AssetEditor] Invalid model for export")
        return nil
    end
    
    local exportData = {
        name = model.Name,
        parts = {},
        humanoid = nil,
        welds = {}
    }
    
    -- Экспорт частей
    for _, part in pairs(model:GetDescendants()) do
        if part:IsA("BasePart") then
            exportData.parts[part.Name] = {
                type = part.ClassName,
                size = part.Size,
                color = part.Color,
                material = part.Material,
                position = part.Position - model.PrimaryPart.Position,
                transparency = part.Transparency,
                shape = part.Shape
            }
        elseif part:IsA("Humanoid") then
            exportData.humanoid = {
                maxHealth = part.MaxHealth,
                health = part.Health
            }
        elseif part:IsA("WeldConstraint") then
            table.insert(exportData.welds, {
                from = part.Part0.Name,
                to = part.Part1.Name,
                offset = part.C0.Position
            })
        end
    end
    
    return exportData
end

-- Импорт модели
function AssetEditor:ImportModel(importData, position)
    if not importData or not importData.parts then
        warn("[AssetEditor] Invalid import data")
        return nil
    end
    
    local model = Instance.new("Model")
    model.Name = importData.name or "ImportedModel"
    model.Parent = workspace
    
    local parts = {}
    
    -- Создание частей
    for partName, partData in pairs(importData.parts) do
        local part = Instance.new(partData.type or "Part")
        part.Name = partName
        part.Size = partData.size
        part.Color = partData.color
        part.Material = partData.material
        part.Position = position + partData.position
        part.Transparency = partData.transparency or 0
        part.Parent = model
        
        if partData.shape then
            part.Shape = partData.shape
        end
        
        parts[partName] = part
    end
    
    -- Создание Humanoid
    if importData.humanoid then
        local humanoid = Instance.new("Humanoid")
        humanoid.MaxHealth = importData.humanoid.maxHealth
        humanoid.Health = importData.humanoid.health
        humanoid.Parent = model
    end
    
    -- Создание соединений
    for _, weldData in ipairs(importData.welds or {}) do
        if parts[weldData.from] and parts[weldData.to] then
            local weld = Instance.new("WeldConstraint")
            weld.Part0 = parts[weldData.from]
            weld.Part1 = parts[weldData.to]
            weld.C0 = CFrame.new(weldData.offset)
            weld.Parent = model
        end
    end
    
    -- Установка PrimaryPart
    local firstPart = next(parts)
    if firstPart then
        model.PrimaryPart = parts[firstPart]
    end
    
    return model
end

-- Очистка редактора
function AssetEditor:ClearEditor()
    -- Удаление выделений
    for _, obj in pairs(self.selectedObjects) do
        if obj.highlight then
            obj.highlight:Destroy()
        end
    end
    
    self.selectedObjects = {}
    self.activeEditor = nil
    self.editHistory = {}
    
    print("[AssetEditor] Editor cleared")
end

-- Получение статистики редактора
function AssetEditor:GetEditorStats()
    return {
        selectedObjects = #self.selectedObjects,
        historySize = #self.editHistory,
        maxHistorySize = self.maxHistorySize,
        activeEditor = self.activeEditor ~= nil
    }
end

-- Создание пресета модели
function AssetEditor:CreateModelPreset(presetName, modelData)
    if not presetName or not modelData then
        warn("[AssetEditor] Invalid preset data")
        return false
    end
    
    -- Сохранение пресета в ModelBuilder
    return ModelBuilder:SaveModelAsTemplate(modelData, presetName, "Custom")
end

-- Применение пресета к модели
function AssetEditor:ApplyModelPreset(model, presetName, category)
    if not model or not model:IsA("Model") then
        warn("[AssetEditor] Invalid model for preset application")
        return false
    end
    
    local template = ModelBuilder.templates[category] and ModelBuilder.templates[category][presetName]
    if not template then
        warn("[AssetEditor] Preset not found:", presetName)
        return false
    end
    
    -- Применение свойств пресета
    for partName, partData in pairs(template.parts) do
        local part = model:FindFirstChild(partName)
        if part and part:IsA("BasePart") then
            part.Size = partData.size
            part.Color = partData.color
            part.Material = partData.material
            if partData.transparency then
                part.Transparency = partData.transparency
            end
        end
    end
    
    return true
end

return AssetEditor