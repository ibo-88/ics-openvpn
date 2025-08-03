-- NotificationSystem.lua
-- Система уведомлений для клиентской части

local NotificationSystem = {}
NotificationSystem.__index = NotificationSystem

-- Импорт зависимостей
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Состояние
NotificationSystem.activeNotifications = {}
NotificationSystem.notificationQueue = {}
NotificationSystem.maxNotifications = 5
NotificationSystem.notificationHeight = 60
NotificationSystem.notificationSpacing = 10

function NotificationSystem:Initialize()
    print("[NotificationSystem] Initializing...")
    
    -- Создание контейнера для уведомлений
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "NotificationGui"
    screenGui.Parent = playerGui
    
    self.screenGui = screenGui
    
    -- Подключение к Remote Event
    local remote = ReplicatedStorage.Remotes.UI:WaitForChild("ShowNotification")
    remote.OnClientEvent:Connect(function(message, type, duration)
        self:ShowNotification(message, type, duration)
    end)
    
    print("[NotificationSystem] Initialized successfully!")
end

-- Показ уведомления
function NotificationSystem:ShowNotification(message, type, duration)
    if not self.screenGui then
        warn("[NotificationSystem] ScreenGui not initialized")
        return
    end
    
    -- Создание уведомления
    local notification = self:CreateNotification(message, type)
    notification.Parent = self.screenGui
    
    -- Добавление в активные уведомления
    table.insert(self.activeNotifications, notification)
    
    -- Позиционирование уведомлений
    self:UpdateNotificationPositions()
    
    -- Анимация появления
    self:AnimateNotificationIn(notification)
    
    -- Автоматическое удаление
    task.spawn(function()
        task.wait(duration or 3)
        self:RemoveNotification(notification)
    end)
end

-- Создание уведомления
function NotificationSystem:CreateNotification(message, type)
    local notification = Instance.new("Frame")
    notification.Name = "Notification"
    notification.Size = UDim2.new(0, 300, 0, self.notificationHeight)
    notification.Position = UDim2.new(1, -320, 0, 10) -- Начинает за пределами экрана
    notification.BackgroundColor3 = self:GetNotificationColor(type)
    notification.BorderSizePixel = 0
    notification.Parent = self.screenGui
    
    -- Скругление углов
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = notification
    
    -- Тень
    local shadow = Instance.new("Frame")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 4, 1, 4)
    shadow.Position = UDim2.new(0, -2, 0, -2)
    shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    shadow.BackgroundTransparency = 0.5
    shadow.BorderSizePixel = 0
    shadow.ZIndex = notification.ZIndex - 1
    shadow.Parent = notification
    
    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 8)
    shadowCorner.Parent = shadow
    
    -- Иконка
    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(0, 30, 1, 0)
    icon.Position = UDim2.new(0, 10, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = self:GetNotificationIcon(type)
    icon.TextColor3 = Color3.fromRGB(255, 255, 255)
    icon.TextScaled = true
    icon.Font = Enum.Font.GothamBold
    icon.Parent = notification
    
    -- Текст уведомления
    local textLabel = Instance.new("TextLabel")
    textLabel.Name = "Text"
    textLabel.Size = UDim2.new(1, -50, 1, 0)
    textLabel.Position = UDim2.new(0, 50, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = message
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notification
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0, 20, 0, 20)
    closeButton.Position = UDim2.new(1, -25, 0, 5)
    closeButton.BackgroundTransparency = 1
    closeButton.Text = "×"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = notification
    
    -- Обработчик закрытия
    closeButton.MouseButton1Click:Connect(function()
        self:RemoveNotification(notification)
    end)
    
    return notification
end

-- Получение цвета уведомления
function NotificationSystem:GetNotificationColor(type)
    local colors = {
        success = Color3.fromRGB(46, 204, 113),   -- Зеленый
        error = Color3.fromRGB(231, 76, 60),      -- Красный
        warning = Color3.fromRGB(241, 196, 15),   -- Желтый
        info = Color3.fromRGB(52, 152, 219),      -- Синий
        default = Color3.fromRGB(52, 73, 94)      -- Серый
    }
    
    return colors[type] or colors.default
end

-- Получение иконки уведомления
function NotificationSystem:GetNotificationIcon(type)
    local icons = {
        success = "✓",
        error = "✗",
        warning = "⚠",
        info = "ℹ",
        default = "•"
    }
    
    return icons[type] or icons.default
end

-- Анимация появления уведомления
function NotificationSystem:AnimateNotificationIn(notification)
    -- Начальная позиция (за пределами экрана)
    notification.Position = UDim2.new(1, -320, 0, 10)
    notification.BackgroundTransparency = 1
    
    -- Анимация появления
    local tween = TweenService:Create(notification, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -310, 0, 10),
        BackgroundTransparency = 0
    })
    tween:Play()
end

-- Анимация исчезновения уведомления
function NotificationSystem:AnimateNotificationOut(notification, callback)
    local tween = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Position = UDim2.new(1, -320, 0, 10),
        BackgroundTransparency = 1
    })
    
    tween.Completed:Connect(function()
        if callback then
            callback()
        end
    end)
    
    tween:Play()
end

-- Удаление уведомления
function NotificationSystem:RemoveNotification(notification)
    -- Поиск уведомления в списке
    for i, activeNotification in ipairs(self.activeNotifications) do
        if activeNotification == notification then
            table.remove(self.activeNotifications, i)
            break
        end
    end
    
    -- Анимация исчезновения
    self:AnimateNotificationOut(notification, function()
        if notification and notification.Parent then
            notification:Destroy()
        end
        self:UpdateNotificationPositions()
    end)
end

-- Обновление позиций уведомлений
function NotificationSystem:UpdateNotificationPositions()
    for i, notification in ipairs(self.activeNotifications) do
        local targetY = 10 + (i - 1) * (self.notificationHeight + self.notificationSpacing)
        
        local tween = TweenService:Create(notification, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -310, 0, targetY)
        })
        tween:Play()
    end
end

-- Очистка всех уведомлений
function NotificationSystem:ClearAllNotifications()
    for _, notification in ipairs(self.activeNotifications) do
        if notification and notification.Parent then
            notification:Destroy()
        end
    end
    
    self.activeNotifications = {}
end

-- Показ уведомления о волне
function NotificationSystem:ShowWaveNotification(waveNumber, isStart)
    local message = isStart and ("Волна " .. waveNumber .. " началась!") or ("Волна " .. waveNumber .. " завершена!")
    local type = isStart and "warning" or "success"
    
    self:ShowNotification(message, type, 5)
end

-- Показ уведомления о ресурсах
function NotificationSystem:ShowResourceNotification(resourceType, amount, isGain)
    local prefix = isGain and "+" or "-"
    local message = prefix .. amount .. " " .. resourceType
    local type = isGain and "success" or "info"
    
    self:ShowNotification(message, type, 3)
end

-- Показ уведомления о способности
function NotificationSystem:ShowAbilityNotification(abilityName, isReady)
    local message = isReady and ("Способность " .. abilityName .. " готова!") or ("Способность " .. abilityName .. " на перезарядке")
    local type = isReady and "success" or "warning"
    
    self:ShowNotification(message, type, 2)
end

-- Показ уведомления о строительстве
function NotificationSystem:ShowBuildingNotification(structureType, success)
    local message = success and ("Построено: " .. structureType) or ("Ошибка строительства: " .. structureType)
    local type = success and "success" or "error"
    
    self:ShowNotification(message, type, 3)
end

-- Получение количества активных уведомлений
function NotificationSystem:GetActiveNotificationCount()
    return #self.activeNotifications
end

-- Проверка, есть ли место для нового уведомления
function NotificationSystem:CanShowNotification()
    return #self.activeNotifications < self.maxNotifications
end

return NotificationSystem