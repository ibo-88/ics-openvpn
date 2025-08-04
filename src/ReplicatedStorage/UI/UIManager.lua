-- UIManager.lua
-- Полная система управления UI для Nexus Siege

local UIManager = {}
UIManager.__index = UIManager

-- Импорт зависимостей
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Состояние
UIManager.player = Players.LocalPlayer
UIManager.playerGui = UIManager.player:WaitForChild("PlayerGui")
UIManager.uiElements = {}
UIManager.activeMenus = {}
UIManager.notifications = {}

function UIManager:Initialize()
    print("[UIManager] Initializing UI system...")
    
    -- Создание основного UI
    self:CreateMainHUD()
    self:CreateAbilityBar()
    self:CreateResourceFrame()
    self:CreateWaveInfo()
    self:CreateClassSelectionMenu()
    self:CreateSettingsMenu()
    self:CreateInventoryMenu()
    self:CreateAchievementMenu()
    self:CreateShopMenu()
    self:CreateGameOverScreen()
    
    -- Подключение к RemoteEvents
    self:ConnectToRemotes()
    
    print("[UIManager] UI system initialized!")
end

-- Создание основного HUD
function UIManager:CreateMainHUD()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainHUD"
    screenGui.Parent = self.playerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = screenGui
    
    -- Верхняя панель
    local topPanel = Instance.new("Frame")
    topPanel.Name = "TopPanel"
    topPanel.Size = UDim2.new(1, 0, 0.1, 0)
    topPanel.Position = UDim2.new(0, 0, 0, 0)
    topPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    topPanel.BackgroundTransparency = 0.5
    topPanel.Parent = mainFrame
    
    -- Информация о волне
    local waveInfo = Instance.new("TextLabel")
    waveInfo.Name = "WaveInfo"
    waveInfo.Size = UDim2.new(0.3, 0, 1, 0)
    waveInfo.Position = UDim2.new(0, 10, 0, 0)
    waveInfo.BackgroundTransparency = 1
    waveInfo.Text = "Волна: 0/10"
    waveInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    waveInfo.TextScaled = true
    waveInfo.Font = Enum.Font.GothamBold
    waveInfo.Parent = topPanel
    
    -- Здоровье Нексуса
    local nexusHealth = Instance.new("TextLabel")
    nexusHealth.Name = "NexusHealth"
    nexusHealth.Size = UDim2.new(0.3, 0, 1, 0)
    nexusHealth.Position = UDim2.new(0.35, 0, 0, 0)
    nexusHealth.BackgroundTransparency = 1
    nexusHealth.Text = "Нексус: 100%"
    nexusHealth.TextColor3 = Color3.fromRGB(0, 255, 0)
    nexusHealth.TextScaled = true
    nexusHealth.Font = Enum.Font.GothamBold
    nexusHealth.Parent = topPanel
    
    -- Время матча
    local matchTime = Instance.new("TextLabel")
    matchTime.Name = "MatchTime"
    matchTime.Size = UDim2.new(0.3, 0, 1, 0)
    matchTime.Position = UDim2.new(0.7, 0, 0, 0)
    matchTime.BackgroundTransparency = 1
    matchTime.Text = "Время: 00:00"
    matchTime.TextColor3 = Color3.fromRGB(255, 255, 255)
    matchTime.TextScaled = true
    matchTime.Font = Enum.Font.GothamBold
    matchTime.Parent = topPanel
    
    self.uiElements.mainHUD = screenGui
end

-- Создание панели способностей
function UIManager:CreateAbilityBar()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AbilityBar"
    screenGui.Parent = self.playerGui
    
    local abilityFrame = Instance.new("Frame")
    abilityFrame.Name = "AbilityFrame"
    abilityFrame.Size = UDim2.new(0.4, 0, 0.15, 0)
    abilityFrame.Position = UDim2.new(0.3, 0, 0.8, 0)
    abilityFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    abilityFrame.BackgroundTransparency = 0.5
    abilityFrame.Parent = screenGui
    
    -- Кнопка способности 1
    local ability1 = Instance.new("TextButton")
    ability1.Name = "Ability1"
    ability1.Size = UDim2.new(0.2, 0, 0.8, 0)
    ability1.Position = UDim2.new(0.05, 0, 0.1, 0)
    ability1.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ability1.Text = "Атака"
    ability1.TextColor3 = Color3.fromRGB(255, 255, 255)
    ability1.TextScaled = true
    ability1.Font = Enum.Font.GothamBold
    ability1.Parent = abilityFrame
    
    -- Кнопка способности 2
    local ability2 = Instance.new("TextButton")
    ability2.Name = "Ability2"
    ability2.Size = UDim2.new(0.2, 0, 0.8, 0)
    ability2.Position = UDim2.new(0.3, 0, 0.1, 0)
    ability2.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    ability2.Text = "Защита"
    ability2.TextColor3 = Color3.fromRGB(255, 255, 255)
    ability2.TextScaled = true
    ability2.Font = Enum.Font.GothamBold
    ability2.Parent = abilityFrame
    
    -- Кнопка способности 3
    local ability3 = Instance.new("TextButton")
    ability3.Name = "Ability3"
    ability3.Size = UDim2.new(0.2, 0, 0.8, 0)
    ability3.Position = UDim2.new(0.55, 0, 0.1, 0)
    ability3.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    ability3.Text = "Исцеление"
    ability3.TextColor3 = Color3.fromRGB(255, 255, 255)
    ability3.TextScaled = true
    ability3.Font = Enum.Font.GothamBold
    ability3.Parent = abilityFrame
    
    -- Кнопка способности 4
    local ability4 = Instance.new("TextButton")
    ability4.Name = "Ability4"
    ability4.Size = UDim2.new(0.2, 0, 0.8, 0)
    ability4.Position = UDim2.new(0.8, 0, 0.1, 0)
    ability4.BackgroundColor3 = Color3.fromRGB(255, 0, 255)
    ability4.Text = "Ультима"
    ability4.TextColor3 = Color3.fromRGB(255, 255, 255)
    ability4.TextScaled = true
    ability4.Font = Enum.Font.GothamBold
    ability4.Parent = abilityFrame
    
    -- Подключение событий
    ability1.MouseButton1Click:Connect(function()
        self:UseAbility(1)
    end)
    
    ability2.MouseButton1Click:Connect(function()
        self:UseAbility(2)
    end)
    
    ability3.MouseButton1Click:Connect(function()
        self:UseAbility(3)
    end)
    
    ability4.MouseButton1Click:Connect(function()
        self:UseAbility(4)
    end)
    
    self.uiElements.abilityBar = screenGui
end

-- Создание фрейма ресурсов
function UIManager:CreateResourceFrame()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ResourceFrame"
    screenGui.Parent = self.playerGui
    
    local resourceFrame = Instance.new("Frame")
    resourceFrame.Name = "ResourceFrame"
    resourceFrame.Size = UDim2.new(0.2, 0, 0.3, 0)
    resourceFrame.Position = UDim2.new(0.8, 0, 0.1, 0)
    resourceFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    resourceFrame.BackgroundTransparency = 0.5
    resourceFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.2, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Ресурсы"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = resourceFrame
    
    -- Дерево
    local woodLabel = Instance.new("TextLabel")
    woodLabel.Name = "Wood"
    woodLabel.Size = UDim2.new(1, 0, 0.15, 0)
    woodLabel.Position = UDim2.new(0, 0, 0.25, 0)
    woodLabel.BackgroundTransparency = 1
    woodLabel.Text = "Дерево: 0"
    woodLabel.TextColor3 = Color3.fromRGB(139, 69, 19)
    woodLabel.TextScaled = true
    woodLabel.Font = Enum.Font.Gotham
    woodLabel.Parent = resourceFrame
    
    -- Камень
    local stoneLabel = Instance.new("TextLabel")
    stoneLabel.Name = "Stone"
    stoneLabel.Size = UDim2.new(1, 0, 0.15, 0)
    stoneLabel.Position = UDim2.new(0, 0, 0.45, 0)
    stoneLabel.BackgroundTransparency = 1
    stoneLabel.Text = "Камень: 0"
    stoneLabel.TextColor3 = Color3.fromRGB(128, 128, 128)
    stoneLabel.TextScaled = true
    stoneLabel.Font = Enum.Font.Gotham
    stoneLabel.Parent = resourceFrame
    
    -- Металл
    local metalLabel = Instance.new("TextLabel")
    metalLabel.Name = "Metal"
    metalLabel.Size = UDim2.new(1, 0, 0.15, 0)
    metalLabel.Position = UDim2.new(0, 0, 0.65, 0)
    metalLabel.BackgroundTransparency = 1
    metalLabel.Text = "Металл: 0"
    metalLabel.TextColor3 = Color3.fromRGB(192, 192, 192)
    metalLabel.TextScaled = true
    metalLabel.Font = Enum.Font.Gotham
    metalLabel.Parent = resourceFrame
    
    -- Кристалл
    local crystalLabel = Instance.new("TextLabel")
    crystalLabel.Name = "Crystal"
    crystalLabel.Size = UDim2.new(1, 0, 0.15, 0)
    crystalLabel.Position = UDim2.new(0, 0, 0.85, 0)
    crystalLabel.BackgroundTransparency = 1
    crystalLabel.Text = "Кристалл: 0"
    crystalLabel.TextColor3 = Color3.fromRGB(138, 43, 226)
    crystalLabel.TextScaled = true
    crystalLabel.Font = Enum.Font.Gotham
    crystalLabel.Parent = resourceFrame
    
    self.uiElements.resourceFrame = screenGui
end

-- Создание информации о волне
function UIManager:CreateWaveInfo()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "WaveInfo"
    screenGui.Parent = self.playerGui
    
    local waveFrame = Instance.new("Frame")
    waveFrame.Name = "WaveFrame"
    waveFrame.Size = UDim2.new(0.3, 0, 0.2, 0)
    waveFrame.Position = UDim2.new(0.35, 0, 0.4, 0)
    waveFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    waveFrame.BackgroundTransparency = 0.7
    waveFrame.Visible = false
    waveFrame.Parent = screenGui
    
    local waveText = Instance.new("TextLabel")
    waveText.Name = "WaveText"
    waveText.Size = UDim2.new(1, 0, 1, 0)
    waveText.Position = UDim2.new(0, 0, 0, 0)
    waveText.BackgroundTransparency = 1
    waveText.Text = "Волна 1 Начинается!"
    waveText.TextColor3 = Color3.fromRGB(255, 255, 0)
    waveText.TextScaled = true
    waveText.Font = Enum.Font.GothamBold
    waveText.Parent = waveFrame
    
    self.uiElements.waveInfo = screenGui
end

-- Создание меню выбора класса
function UIManager:CreateClassSelectionMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClassSelection"
    screenGui.Parent = self.playerGui
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
    menuFrame.Position = UDim2.new(0.2, 0, 0.15, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuFrame.BackgroundTransparency = 0.1
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Выберите класс"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Кнопка Воина
    local warriorButton = Instance.new("TextButton")
    warriorButton.Name = "WarriorButton"
    warriorButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    warriorButton.Position = UDim2.new(0.05, 0, 0.2, 0)
    warriorButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    warriorButton.Text = "Воин\nВысокий урон\nНизкая защита"
    warriorButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    warriorButton.TextScaled = true
    warriorButton.Font = Enum.Font.Gotham
    warriorButton.Parent = menuFrame
    
    -- Кнопка Инженера
    local engineerButton = Instance.new("TextButton")
    engineerButton.Name = "EngineerButton"
    engineerButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    engineerButton.Position = UDim2.new(0.55, 0, 0.2, 0)
    engineerButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    engineerButton.Text = "Инженер\nСтроительство\nТурели"
    engineerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    engineerButton.TextScaled = true
    engineerButton.Font = Enum.Font.Gotham
    engineerButton.Parent = menuFrame
    
    -- Подключение событий
    warriorButton.MouseButton1Click:Connect(function()
        self:SelectClass("Warrior")
    end)
    
    engineerButton.MouseButton1Click:Connect(function()
        self:SelectClass("Engineer")
    end)
    
    self.uiElements.classSelection = screenGui
end

-- Создание меню настроек
function UIManager:CreateSettingsMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SettingsMenu"
    screenGui.Parent = self.playerGui
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0.5, 0, 0.6, 0)
    menuFrame.Position = UDim2.new(0.25, 0, 0.2, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuFrame.BackgroundTransparency = 0.1
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Настройки"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Громкость звука
    local volumeLabel = Instance.new("TextLabel")
    volumeLabel.Name = "VolumeLabel"
    volumeLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
    volumeLabel.Position = UDim2.new(0.1, 0, 0.2, 0)
    volumeLabel.BackgroundTransparency = 1
    volumeLabel.Text = "Громкость звука: 50%"
    volumeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    volumeLabel.TextScaled = true
    volumeLabel.Font = Enum.Font.Gotham
    volumeLabel.Parent = menuFrame
    
    local volumeSlider = Instance.new("TextButton")
    volumeSlider.Name = "VolumeSlider"
    volumeSlider.Size = UDim2.new(0.8, 0, 0.05, 0)
    volumeSlider.Position = UDim2.new(0.1, 0, 0.3, 0)
    volumeSlider.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    volumeSlider.Text = ""
    volumeSlider.Parent = menuFrame
    
    -- Качество графики
    local graphicsLabel = Instance.new("TextLabel")
    graphicsLabel.Name = "GraphicsLabel"
    graphicsLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
    graphicsLabel.Position = UDim2.new(0.1, 0, 0.4, 0)
    graphicsLabel.BackgroundTransparency = 1
    graphicsLabel.Text = "Качество графики: Высокое"
    graphicsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    graphicsLabel.TextScaled = true
    graphicsLabel.Font = Enum.Font.Gotham
    graphicsLabel.Parent = menuFrame
    
    local graphicsButton = Instance.new("TextButton")
    graphicsButton.Name = "GraphicsButton"
    graphicsButton.Size = UDim2.new(0.4, 0, 0.08, 0)
    graphicsButton.Position = UDim2.new(0.3, 0, 0.5, 0)
    graphicsButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    graphicsButton.Text = "Изменить"
    graphicsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    graphicsButton.TextScaled = true
    graphicsButton.Font = Enum.Font.Gotham
    graphicsButton.Parent = menuFrame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.2, 0, 0.08, 0)
    closeButton.Position = UDim2.new(0.4, 0, 0.8, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "Закрыть"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.Gotham
    closeButton.Parent = menuFrame
    
    -- Подключение событий
    closeButton.MouseButton1Click:Connect(function()
        self:HideMenu("SettingsMenu")
    end)
    
    self.uiElements.settingsMenu = screenGui
end

-- Создание меню инвентаря
function UIManager:CreateInventoryMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "InventoryMenu"
    screenGui.Parent = self.playerGui
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0.7, 0, 0.8, 0)
    menuFrame.Position = UDim2.new(0.15, 0, 0.1, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuFrame.BackgroundTransparency = 0.1
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Инвентарь"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Список предметов
    local itemsFrame = Instance.new("ScrollingFrame")
    itemsFrame.Name = "ItemsFrame"
    itemsFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
    itemsFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    itemsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    itemsFrame.BackgroundTransparency = 0.5
    itemsFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    itemsFrame.Parent = menuFrame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.2, 0, 0.08, 0)
    closeButton.Position = UDim2.new(0.4, 0, 0.9, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "Закрыть"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.Gotham
    closeButton.Parent = menuFrame
    
    closeButton.MouseButton1Click:Connect(function()
        self:HideMenu("InventoryMenu")
    end)
    
    self.uiElements.inventoryMenu = screenGui
end

-- Создание меню достижений
function UIManager:CreateAchievementMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AchievementMenu"
    screenGui.Parent = self.playerGui
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0.7, 0, 0.8, 0)
    menuFrame.Position = UDim2.new(0.15, 0, 0.1, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuFrame.BackgroundTransparency = 0.1
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Достижения"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Список достижений
    local achievementsFrame = Instance.new("ScrollingFrame")
    achievementsFrame.Name = "AchievementsFrame"
    achievementsFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
    achievementsFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    achievementsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    achievementsFrame.BackgroundTransparency = 0.5
    achievementsFrame.CanvasSize = UDim2.new(0, 0, 3, 0)
    achievementsFrame.Parent = menuFrame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.2, 0, 0.08, 0)
    closeButton.Position = UDim2.new(0.4, 0, 0.9, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "Закрыть"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.Gotham
    closeButton.Parent = menuFrame
    
    closeButton.MouseButton1Click:Connect(function()
        self:HideMenu("AchievementMenu")
    end)
    
    self.uiElements.achievementMenu = screenGui
end

-- Создание магазина
function UIManager:CreateShopMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ShopMenu"
    screenGui.Parent = self.playerGui
    
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0.8, 0, 0.8, 0)
    menuFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuFrame.BackgroundTransparency = 0.1
    menuFrame.Visible = false
    menuFrame.Parent = screenGui
    
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Магазин"
    title.TextColor3 = Color3.fromRGB(255, 215, 0)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Список товаров
    local itemsFrame = Instance.new("ScrollingFrame")
    itemsFrame.Name = "ItemsFrame"
    itemsFrame.Size = UDim2.new(0.9, 0, 0.7, 0)
    itemsFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
    itemsFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    itemsFrame.BackgroundTransparency = 0.5
    itemsFrame.CanvasSize = UDim2.new(0, 0, 2, 0)
    itemsFrame.Parent = menuFrame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.2, 0, 0.08, 0)
    closeButton.Position = UDim2.new(0.4, 0, 0.9, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "Закрыть"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.Gotham
    closeButton.Parent = menuFrame
    
    closeButton.MouseButton1Click:Connect(function()
        self:HideMenu("ShopMenu")
    end)
    
    self.uiElements.shopMenu = screenGui
end

-- Создание экрана окончания игры
function UIManager:CreateGameOverScreen()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "GameOverScreen"
    screenGui.Parent = self.playerGui
    
    local gameOverFrame = Instance.new("Frame")
    gameOverFrame.Name = "GameOverFrame"
    gameOverFrame.Size = UDim2.new(1, 0, 1, 0)
    gameOverFrame.Position = UDim2.new(0, 0, 0, 0)
    gameOverFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    gameOverFrame.BackgroundTransparency = 0.3
    gameOverFrame.Visible = false
    gameOverFrame.Parent = screenGui
    
    local gameOverText = Instance.new("TextLabel")
    gameOverText.Name = "GameOverText"
    gameOverText.Size = UDim2.new(0.8, 0, 0.2, 0)
    gameOverText.Position = UDim2.new(0.1, 0, 0.3, 0)
    gameOverText.BackgroundTransparency = 1
    gameOverText.Text = "Игра Окончена!"
    gameOverText.TextColor3 = Color3.fromRGB(255, 0, 0)
    gameOverText.TextScaled = true
    gameOverText.Font = Enum.Font.GothamBold
    gameOverText.Parent = gameOverFrame
    
    local resultText = Instance.new("TextLabel")
    resultText.Name = "ResultText"
    resultText.Size = UDim2.new(0.8, 0, 0.1, 0)
    resultText.Position = UDim2.new(0.1, 0, 0.5, 0)
    resultText.BackgroundTransparency = 1
    resultText.Text = "Результат: Победа!"
    resultText.TextColor3 = Color3.fromRGB(255, 255, 255)
    resultText.TextScaled = true
    resultText.Font = Enum.Font.Gotham
    resultText.Parent = gameOverFrame
    
    local restartButton = Instance.new("TextButton")
    restartButton.Name = "RestartButton"
    restartButton.Size = UDim2.new(0.3, 0, 0.1, 0)
    restartButton.Position = UDim2.new(0.35, 0, 0.7, 0)
    restartButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    restartButton.Text = "Начать заново"
    restartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    restartButton.TextScaled = true
    restartButton.Font = Enum.Font.GothamBold
    restartButton.Parent = gameOverFrame
    
    restartButton.MouseButton1Click:Connect(function()
        self:HideGameOverScreen()
    end)
    
    self.uiElements.gameOverScreen = screenGui
end

-- Подключение к RemoteEvents
function UIManager:ConnectToRemotes()
    local remotes = ReplicatedStorage:WaitForChild("Remotes")
    
    -- Обновление ресурсов
    local updateResources = remotes.UI:WaitForChild("UpdateResources")
    updateResources.OnClientEvent:Connect(function(resources)
        self:UpdateResources(resources)
    end)
    
    -- Показ уведомлений
    local showNotification = remotes.UI:WaitForChild("ShowNotification")
    showNotification.OnClientEvent:Connect(function(message, type, duration)
        self:ShowNotification(message, type, duration)
    end)
    
    -- Окончание волны
    local waveEnded = remotes.UI:WaitForChild("WaveEnded")
    waveEnded.OnClientEvent:Connect(function(waveNumber, result)
        self:ShowWaveEnd(waveNumber, result)
    end)
end

-- Использование способности
function UIManager:UseAbility(abilityNumber)
    local remotes = ReplicatedStorage:WaitForChild("Remotes")
    local useAbility = remotes.Combat:WaitForChild("UseAbility")
    
    local abilityNames = {"Attack", "Defend", "Heal", "Ultimate"}
    useAbility:FireServer(abilityNames[abilityNumber])
end

-- Выбор класса
function UIManager:SelectClass(className)
    local remotes = ReplicatedStorage:WaitForChild("Remotes")
    local selectClass = remotes.UI:WaitForChild("SelectClass")
    
    selectClass:FireServer(className)
    self:HideMenu("ClassSelection")
end

-- Обновление ресурсов
function UIManager:UpdateResources(resources)
    local resourceFrame = self.uiElements.resourceFrame.ResourceFrame
    
    if resources.wood then
        resourceFrame.Wood.Text = "Дерево: " .. resources.wood
    end
    
    if resources.stone then
        resourceFrame.Stone.Text = "Камень: " .. resources.stone
    end
    
    if resources.metal then
        resourceFrame.Metal.Text = "Металл: " .. resources.metal
    end
    
    if resources.crystal then
        resourceFrame.Crystal.Text = "Кристалл: " .. resources.crystal
    end
end

-- Показ уведомления
function UIManager:ShowNotification(message, type, duration)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "Notification_" .. tick()
    screenGui.Parent = self.playerGui
    
    local notificationFrame = Instance.new("Frame")
    notificationFrame.Name = "NotificationFrame"
    notificationFrame.Size = UDim2.new(0.4, 0, 0.1, 0)
    notificationFrame.Position = UDim2.new(0.3, 0, 0.1, 0)
    notificationFrame.BackgroundColor3 = self:GetNotificationColor(type)
    notificationFrame.BackgroundTransparency = 0.2
    notificationFrame.Parent = screenGui
    
    local notificationText = Instance.new("TextLabel")
    notificationText.Name = "NotificationText"
    notificationText.Size = UDim2.new(1, 0, 1, 0)
    notificationText.Position = UDim2.new(0, 0, 0, 0)
    notificationText.BackgroundTransparency = 1
    notificationText.Text = message
    notificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
    notificationText.TextScaled = true
    notificationText.Font = Enum.Font.GothamBold
    notificationText.Parent = notificationFrame
    
    -- Анимация появления
    local tween = TweenService:Create(notificationFrame, TweenInfo.new(0.5), {
        Position = UDim2.new(0.3, 0, 0.05, 0)
    })
    tween:Play()
    
    -- Автоматическое удаление
    task.wait(duration or 3)
    
    local fadeTween = TweenService:Create(notificationFrame, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    })
    fadeTween:Play()
    
    fadeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end

-- Получение цвета уведомления
function UIManager:GetNotificationColor(type)
    if type == "success" then
        return Color3.fromRGB(0, 255, 0)
    elseif type == "error" then
        return Color3.fromRGB(255, 0, 0)
    elseif type == "warning" then
        return Color3.fromRGB(255, 255, 0)
    elseif type == "info" then
        return Color3.fromRGB(0, 255, 255)
    else
        return Color3.fromRGB(100, 100, 100)
    end
end

-- Показ окончания волны
function UIManager:ShowWaveEnd(waveNumber, result)
    local waveInfo = self.uiElements.waveInfo.WaveFrame
    local waveText = waveInfo.WaveText
    
    if result == "victory" then
        waveText.Text = "Волна " .. waveNumber .. " Завершена!\nПобеда!"
        waveText.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        waveText.Text = "Волна " .. waveNumber .. " Завершена!\nПоражение!"
        waveText.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
    
    waveInfo.Visible = true
    
    task.wait(3)
    waveInfo.Visible = false
end

-- Показ меню
function UIManager:ShowMenu(menuName)
    if self.uiElements[menuName] then
        self.uiElements[menuName].MenuFrame.Visible = true
        self.activeMenus[menuName] = true
    end
end

-- Скрытие меню
function UIManager:HideMenu(menuName)
    if self.uiElements[menuName] then
        self.uiElements[menuName].MenuFrame.Visible = false
        self.activeMenus[menuName] = false
    end
end

-- Показ экрана окончания игры
function UIManager:ShowGameOverScreen(result)
    local gameOverScreen = self.uiElements.gameOverScreen.GameOverFrame
    local resultText = gameOverScreen.ResultText
    
    resultText.Text = "Результат: " .. result
    gameOverScreen.Visible = true
end

-- Скрытие экрана окончания игры
function UIManager:HideGameOverScreen()
    self.uiElements.gameOverScreen.GameOverFrame.Visible = false
end

-- Обновление информации о волне
function UIManager:UpdateWaveInfo(waveNumber, totalWaves)
    local waveInfo = self.uiElements.mainHUD.MainFrame.TopPanel.WaveInfo
    waveInfo.Text = "Волна: " .. waveNumber .. "/" .. totalWaves
end

-- Обновление здоровья Нексуса
function UIManager:UpdateNexusHealth(health, maxHealth)
    local nexusHealth = self.uiElements.mainHUD.MainFrame.TopPanel.NexusHealth
    local percentage = math.floor((health / maxHealth) * 100)
    
    nexusHealth.Text = "Нексус: " .. percentage .. "%"
    
    if percentage > 50 then
        nexusHealth.TextColor3 = Color3.fromRGB(0, 255, 0)
    elseif percentage > 25 then
        nexusHealth.TextColor3 = Color3.fromRGB(255, 255, 0)
    else
        nexusHealth.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end

-- Обновление времени матча
function UIManager:UpdateMatchTime(time)
    local matchTime = self.uiElements.mainHUD.MainFrame.TopPanel.MatchTime
    local minutes = math.floor(time / 60)
    local seconds = math.floor(time % 60)
    
    matchTime.Text = string.format("Время: %02d:%02d", minutes, seconds)
end

-- Очистка UI
function UIManager:Cleanup()
    for _, element in pairs(self.uiElements) do
        if element and element.Parent then
            element:Destroy()
        end
    end
    
    self.uiElements = {}
    self.activeMenus = {}
    self.notifications = {}
end

return UIManager