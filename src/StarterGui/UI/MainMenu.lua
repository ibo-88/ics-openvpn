-- MainMenu.lua
-- Главное меню с доступом ко всем системам

local MainMenu = {}
MainMenu.__index = MainMenu

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Переменные
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mainMenu = nil
local isOpen = false

-- Remote Events
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local UI = Remotes:WaitForChild("UI")

function MainMenu:Initialize()
    print("[MainMenu] Initializing main menu...")
    
    -- Создание интерфейса
    self:CreateMainMenu()
    
    -- Подключение событий
    self:ConnectEvents()
    
    print("[MainMenu] Main menu initialized!")
end

function MainMenu:CreateMainMenu()
    -- Основной экран
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainMenu"
    screenGui.Parent = playerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0.8, 0, 0.9, 0)
    mainFrame.Position = UDim2.new(0.1, 0, 0.05, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    mainFrame.BorderSizePixel = 0
    mainFrame.Visible = false
    mainFrame.Parent = screenGui
    
    -- Заголовок
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Size = UDim2.new(1, 0, 0.1, 0)
    titleLabel.Position = UDim2.new(0, 0, 0, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    titleLabel.BorderSizePixel = 0
    titleLabel.Text = "NEXUS SIEGE - ГЛАВНОЕ МЕНЮ"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Parent = mainFrame
    
    -- Кнопка закрытия
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Size = UDim2.new(0.05, 0, 0.05, 0)
    closeButton.Position = UDim2.new(0.95, 0, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.GothamBold
    closeButton.Parent = mainFrame
    
    -- Контейнер для кнопок
    local buttonContainer = Instance.new("Frame")
    buttonContainer.Name = "ButtonContainer"
    buttonContainer.Size = UDim2.new(0.8, 0, 0.8, 0)
    buttonContainer.Position = UDim2.new(0.1, 0, 0.15, 0)
    buttonContainer.BackgroundTransparency = 1
    buttonContainer.Parent = mainFrame
    
    -- Создание кнопок меню
    self:CreateMenuButtons(buttonContainer)
    
    mainMenu = screenGui
end

function MainMenu:CreateMenuButtons(container)
    local buttons = {
        {name = "Прогресс", icon = "📈", action = "progression"},
        {name = "Навыки", icon = "⚔️", action = "skills"},
        {name = "Магазин", icon = "🛒", action = "shop"},
        {name = "Инвентарь", icon = "🎒", action = "inventory"},
        {name = "Достижения", icon = "🏆", action = "achievements"},
        {name = "Крафтинг", icon = "🔨", action = "crafting"},
        {name = "Боевой пропуск", icon = "🎫", action = "battlepass"},
        {name = "Престиж", icon = "⭐", action = "prestige"},
        {name = "Статистика", icon = "📊", action = "statistics"},
        {name = "Настройки", icon = "⚙️", action = "settings"}
    }
    
    local buttonSize = UDim2.new(0.3, 0, 0.15, 0)
    local padding = 0.02
    
    for i, buttonData in pairs(buttons) do
        local row = math.ceil(i / 3)
        local col = ((i - 1) % 3) + 1
        
        local button = Instance.new("TextButton")
        button.Name = buttonData.name
        button.Size = buttonSize
        button.Position = UDim2.new(
            (col - 1) * (buttonSize.X.Scale + padding),
            0,
            (row - 1) * (buttonSize.Y.Scale + padding),
            0
        )
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        button.BorderSizePixel = 0
        button.Text = buttonData.icon .. "\n" .. buttonData.name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextScaled = true
        button.Font = Enum.Font.Gotham
        button.Parent = container
        
        -- Анимация при наведении
        button.MouseEnter:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(80, 80, 100)
            }):Play()
        end)
        
        button.MouseLeave:Connect(function()
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            }):Play()
        end)
        
        -- Обработка клика
        button.MouseButton1Click:Connect(function()
            self:HandleMenuAction(buttonData.action)
        end)
    end
end

function MainMenu:HandleMenuAction(action)
    print("[MainMenu] Menu action:", action)
    
    if action == "progression" then
        self:OpenProgressionMenu()
    elseif action == "skills" then
        self:OpenSkillsMenu()
    elseif action == "shop" then
        self:OpenShopMenu()
    elseif action == "inventory" then
        self:OpenInventoryMenu()
    elseif action == "achievements" then
        self:OpenAchievementsMenu()
    elseif action == "crafting" then
        self:OpenCraftingMenu()
    elseif action == "battlepass" then
        self:OpenBattlePassMenu()
    elseif action == "prestige" then
        self:OpenPrestigeMenu()
    elseif action == "statistics" then
        self:OpenStatisticsMenu()
    elseif action == "settings" then
        self:OpenSettingsMenu()
    end
end

function MainMenu:OpenProgressionMenu()
    -- Запрос данных прогресса с сервера
    local getProgress = UI:FindFirstChild("GetProgress")
    if getProgress then
        getProgress:FireServer()
    end
end

function MainMenu:OpenSkillsMenu()
    -- Запрос данных навыков с сервера
    local getSkills = UI:FindFirstChild("GetSkills")
    if getSkills then
        getSkills:FireServer()
    end
end

function MainMenu:OpenShopMenu()
    -- Запрос данных магазина с сервера
    local getShops = UI:FindFirstChild("GetShops")
    if getShops then
        getShops:FireServer()
    end
end

function MainMenu:OpenInventoryMenu()
    -- Запрос данных инвентаря с сервера
    local getInventory = UI:FindFirstChild("GetInventory")
    if getInventory then
        getInventory:FireServer()
    end
end

function MainMenu:OpenAchievementsMenu()
    -- Запрос данных достижений с сервера
    local getAchievements = UI:FindFirstChild("GetAchievements")
    if getAchievements then
        getAchievements:FireServer()
    end
end

function MainMenu:OpenCraftingMenu()
    -- Запрос данных крафтинга с сервера
    local getCrafting = UI:FindFirstChild("GetCrafting")
    if getCrafting then
        getCrafting:FireServer()
    end
end

function MainMenu:OpenBattlePassMenu()
    -- Запрос данных боевого пропуска с сервера
    local getBattlePass = UI:FindFirstChild("GetBattlePass")
    if getBattlePass then
        getBattlePass:FireServer()
    end
end

function MainMenu:OpenPrestigeMenu()
    -- Запрос данных престижа с сервера
    local getPrestige = UI:FindFirstChild("GetPrestige")
    if getPrestige then
        getPrestige:FireServer()
    end
end

function MainMenu:OpenStatisticsMenu()
    -- Запрос данных статистики с сервера
    local getStatistics = UI:FindFirstChild("GetStatistics")
    if getStatistics then
        getStatistics:FireServer()
    end
end

function MainMenu:OpenSettingsMenu()
    -- Открытие меню настроек
    print("[MainMenu] Opening settings menu...")
end

function MainMenu:ConnectEvents()
    -- Кнопка закрытия
    local closeButton = mainMenu.MainFrame.CloseButton
    closeButton.MouseButton1Click:Connect(function()
        self:Close()
    end)
    
    -- Горячая клавиша для открытия/закрытия
    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape then
            if isOpen then
                self:Close()
            else
                self:Open()
            end
        end
    end)
end

function MainMenu:Open()
    if isOpen then return end
    
    isOpen = true
    mainMenu.MainFrame.Visible = true
    
    -- Анимация появления
    local mainFrame = mainMenu.MainFrame
    mainFrame.Position = UDim2.new(0.1, 0, -0.9, 0)
    
    TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {
        Position = UDim2.new(0.1, 0, 0.05, 0)
    }):Play()
end

function MainMenu:Close()
    if not isOpen then return end
    
    isOpen = false
    
    -- Анимация исчезновения
    local mainFrame = mainMenu.MainFrame
    TweenService:Create(mainFrame, TweenInfo.new(0.3), {
        Position = UDim2.new(0.1, 0, -0.9, 0)
    }):Play()
    
    task.wait(0.3)
    mainFrame.Visible = false
end

function MainMenu:Toggle()
    if isOpen then
        self:Close()
    else
        self:Open()
    end
end

return MainMenu