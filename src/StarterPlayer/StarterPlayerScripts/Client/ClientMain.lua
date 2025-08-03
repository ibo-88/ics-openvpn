-- ClientMain.lua
-- Главный клиентский скрипт для Nexus Siege

local ClientMain = {}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Модули
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)

-- Состояние клиента
ClientMain.State = {
    currentClass = nil,
    selectedAbility = nil,
    isBuilding = false,
    buildPreview = nil,
    cameraMode = "Follow", -- Follow, Build, Combat
    uiVisible = true
}

-- Remotes
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = {
    UseAbility = ReplicatedStorage.Remotes.Combat:FindFirstChild("UseAbility"),
    BuildStructure = ReplicatedStorage.Remotes.Building:FindFirstChild("BuildStructure"),
    GatherResource = ReplicatedStorage.Remotes.Resources:FindFirstChild("GatherResource"),
    SelectClass = ReplicatedStorage.Remotes.UI:FindFirstChild("SelectClass"),
}

-- UI элементы
local UI = {
    mainHUD = nil,
    abilityBar = nil,
    resourceDisplay = nil,
    classSelection = nil,
    buildMenu = nil
}

function ClientMain:Initialize()
    print("[ClientMain] Initializing...")
    
    -- Инициализация RemoteEvents
    self:InitializeRemotes()
    
    -- Создание UI
    self:CreateUI()
    
    -- Подключение событий
    self:ConnectEvents()
    
    -- Инициализация систем
    self:InitializeSystems()
    
    print("[ClientMain] Initialized successfully")
end

function ClientMain:InitializeRemotes()
    -- Здесь будут инициализированы RemoteEvents
    -- Remotes.UseAbility = ReplicatedStorage.Remotes.Combat.UseAbility
    -- Remotes.BuildStructure = ReplicatedStorage.Remotes.Building.BuildStructure
    -- и т.д.
    
    print("[ClientMain] Remotes initialized")
end

function ClientMain:CreateUI()
    -- Создание основного HUD
    self:CreateMainHUD()
    
    -- Создание панели способностей
    self:CreateAbilityBar()
    
    -- Создание отображения ресурсов
    self:CreateResourceDisplay()
    
    -- Создание меню выбора класса
    self:CreateClassSelection()
    
    -- Создание меню строительства
    self:CreateBuildMenu()
end

function ClientMain:CreateMainHUD()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MainHUD"
    screenGui.Parent = player.PlayerGui
    
    -- Основной контейнер
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(1, 0, 1, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = screenGui
    
    -- Верхняя панель
    local topPanel = Instance.new("Frame")
    topPanel.Name = "TopPanel"
    topPanel.Size = UDim2.new(1, 0, 0, 60)
    topPanel.Position = UDim2.new(0, 0, 0, 0)
    topPanel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    topPanel.BackgroundTransparency = 0.5
    topPanel.Parent = mainFrame
    
    -- Информация о волне
    local waveInfo = Instance.new("TextLabel")
    waveInfo.Name = "WaveInfo"
    waveInfo.Size = UDim2.new(0, 200, 1, 0)
    waveInfo.Position = UDim2.new(0, 10, 0, 0)
    waveInfo.BackgroundTransparency = 1
    waveInfo.Text = "Волна: 0/10"
    waveInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    waveInfo.TextScaled = true
    waveInfo.Font = Enum.Font.GothamBold
    waveInfo.Parent = topPanel
    
    -- Информация о фазе
    local phaseInfo = Instance.new("TextLabel")
    phaseInfo.Name = "PhaseInfo"
    phaseInfo.Size = UDim2.new(0, 200, 1, 0)
    phaseInfo.Position = UDim2.new(0, 220, 0, 0)
    phaseInfo.BackgroundTransparency = 1
    phaseInfo.Text = "День"
    phaseInfo.TextColor3 = Color3.fromRGB(255, 255, 255)
    phaseInfo.TextScaled = true
    phaseInfo.Font = Enum.Font.GothamBold
    phaseInfo.Parent = topPanel
    
    -- Здоровье Нексуса
    local nexusHealth = Instance.new("TextLabel")
    nexusHealth.Name = "NexusHealth"
    nexusHealth.Size = UDim2.new(0, 200, 1, 0)
    nexusHealth.Position = UDim2.new(0, 430, 0, 0)
    nexusHealth.BackgroundTransparency = 1
    nexusHealth.Text = "Нексус: 10000/10000"
    nexusHealth.TextColor3 = Color3.fromRGB(255, 255, 255)
    nexusHealth.TextScaled = true
    nexusHealth.Font = Enum.Font.GothamBold
    nexusHealth.Parent = topPanel
    
    UI.mainHUD = screenGui
end

function ClientMain:CreateAbilityBar()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AbilityBar"
    screenGui.Parent = player.PlayerGui
    
    -- Контейнер способностей
    local abilityFrame = Instance.new("Frame")
    abilityFrame.Name = "AbilityFrame"
    abilityFrame.Size = UDim2.new(0, 400, 0, 80)
    abilityFrame.Position = UDim2.new(0.5, -200, 1, -100)
    abilityFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    abilityFrame.BackgroundTransparency = 0.5
    abilityFrame.Parent = screenGui
    
    -- Способности (1-4)
    for i = 1, 4 do
        local abilityButton = Instance.new("TextButton")
        abilityButton.Name = "Ability" .. i
        abilityButton.Size = UDim2.new(0, 80, 0, 80)
        abilityButton.Position = UDim2.new(0, (i-1) * 90 + 20, 0, 0)
        abilityButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        abilityButton.BorderSizePixel = 2
        abilityButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
        abilityButton.Text = tostring(i)
        abilityButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        abilityButton.TextScaled = true
        abilityButton.Font = Enum.Font.GothamBold
        abilityButton.Parent = abilityFrame
        
        -- Кулдаун оверлей
        local cooldownOverlay = Instance.new("Frame")
        cooldownOverlay.Name = "CooldownOverlay"
        cooldownOverlay.Size = UDim2.new(1, 0, 1, 0)
        cooldownOverlay.Position = UDim2.new(0, 0, 0, 0)
        cooldownOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        cooldownOverlay.BackgroundTransparency = 0.7
        cooldownOverlay.Visible = false
        cooldownOverlay.Parent = abilityButton
        
        -- Текст кулдауна
        local cooldownText = Instance.new("TextLabel")
        cooldownText.Name = "CooldownText"
        cooldownText.Size = UDim2.new(1, 0, 1, 0)
        cooldownText.Position = UDim2.new(0, 0, 0, 0)
        cooldownText.BackgroundTransparency = 1
        cooldownText.Text = ""
        cooldownText.TextColor3 = Color3.fromRGB(255, 255, 255)
        cooldownText.TextScaled = true
        cooldownText.Font = Enum.Font.GothamBold
        cooldownText.Parent = abilityButton
        
        -- Подключение события нажатия
        abilityButton.MouseButton1Click:Connect(function()
            self:UseAbility(i)
        end)
    end
    
    UI.abilityBar = screenGui
end

function ClientMain:CreateResourceDisplay()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ResourceDisplay"
    screenGui.Parent = player.PlayerGui
    
    -- Контейнер ресурсов
    local resourceFrame = Instance.new("Frame")
    resourceFrame.Name = "ResourceFrame"
    resourceFrame.Size = UDim2.new(0, 300, 0, 120)
    resourceFrame.Position = UDim2.new(0, 10, 0, 70)
    resourceFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    resourceFrame.BackgroundTransparency = 0.5
    resourceFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Ресурсы"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = resourceFrame
    
    -- Ресурсы
    local resources = {"Wood", "Stone", "Crystal"}
    local colors = {
        Wood = Color3.fromRGB(139, 90, 43),
        Stone = Color3.fromRGB(128, 128, 128),
        Crystal = Color3.fromRGB(150, 50, 255)
    }
    
    for i, resource in ipairs(resources) do
        local resourceLabel = Instance.new("TextLabel")
        resourceLabel.Name = resource .. "Label"
        resourceLabel.Size = UDim2.new(1, 0, 0, 25)
        resourceLabel.Position = UDim2.new(0, 0, 0, 30 + (i-1) * 30)
        resourceLabel.BackgroundTransparency = 1
        resourceLabel.Text = resource .. ": 0"
        resourceLabel.TextColor3 = colors[resource]
        resourceLabel.TextScaled = true
        resourceLabel.Font = Enum.Font.Gotham
        resourceLabel.TextXAlignment = Enum.TextXAlignment.Left
        resourceLabel.Parent = resourceFrame
    end
    
    UI.resourceDisplay = screenGui
end

function ClientMain:CreateClassSelection()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClassSelection"
    screenGui.Parent = player.PlayerGui
    screenGui.Enabled = false
    
    -- Затемнение
    local overlay = Instance.new("Frame")
    overlay.Name = "Overlay"
    overlay.Size = UDim2.new(1, 0, 1, 0)
    overlay.Position = UDim2.new(0, 0, 0, 0)
    overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    overlay.BackgroundTransparency = 0.5
    overlay.Parent = screenGui
    
    -- Основное меню
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0, 600, 0, 400)
    menuFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
    menuFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    menuFrame.BorderSizePixel = 3
    menuFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
    menuFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Выберите класс"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Кнопки классов
    local classes = {
        {name = "Warrior", color = Color3.fromRGB(255, 100, 100)},
        {name = "Engineer", color = Color3.fromRGB(100, 100, 255)},
        {name = "Miner", color = Color3.fromRGB(100, 255, 100)}
    }
    
    for i, classData in ipairs(classes) do
        local classButton = Instance.new("TextButton")
        classButton.Name = classData.name .. "Button"
        classButton.Size = UDim2.new(0, 150, 0, 60)
        classButton.Position = UDim2.new(0, 50 + (i-1) * 200, 0, 100)
        classButton.BackgroundColor3 = classData.color
        classButton.BorderSizePixel = 2
        classButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
        classButton.Text = classData.name
        classButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        classButton.TextScaled = true
        classButton.Font = Enum.Font.GothamBold
        classButton.Parent = menuFrame
        
        -- Подключение события
        classButton.MouseButton1Click:Connect(function()
            self:SelectClass(classData.name)
        end)
    end
    
    UI.classSelection = screenGui
end

function ClientMain:CreateBuildMenu()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "BuildMenu"
    screenGui.Parent = player.PlayerGui
    screenGui.Enabled = false
    
    -- Контейнер меню
    local menuFrame = Instance.new("Frame")
    menuFrame.Name = "MenuFrame"
    menuFrame.Size = UDim2.new(0, 300, 0, 400)
    menuFrame.Position = UDim2.new(1, -320, 0.5, -200)
    menuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    menuFrame.BackgroundTransparency = 0.3
    menuFrame.Parent = screenGui
    
    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Строительство"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = menuFrame
    
    -- Список построек
    local structures = {"WoodWall", "StoneWall", "ArcherTower", "CatapultTower"}
    
    for i, structure in ipairs(structures) do
        local structureButton = Instance.new("TextButton")
        structureButton.Name = structure .. "Button"
        structureButton.Size = UDim2.new(1, -20, 0, 60)
        structureButton.Position = UDim2.new(0, 10, 0, 50 + (i-1) * 70)
        structureButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        structureButton.BorderSizePixel = 1
        structureButton.BorderColor3 = Color3.fromRGB(100, 100, 100)
        structureButton.Text = structure
        structureButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        structureButton.TextScaled = true
        structureButton.Font = Enum.Font.Gotham
        structureButton.Parent = menuFrame
        
        -- Подключение события
        structureButton.MouseButton1Click:Connect(function()
            self:SelectStructure(structure)
        end)
    end
    
    UI.buildMenu = screenGui
end

function ClientMain:ConnectEvents()
    -- Обработка ввода
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        
        if input.KeyCode == Enum.KeyCode.One then
            self:UseAbility(1)
        elseif input.KeyCode == Enum.KeyCode.Two then
            self:UseAbility(2)
        elseif input.KeyCode == Enum.KeyCode.Three then
            self:UseAbility(3)
        elseif input.KeyCode == Enum.KeyCode.Four then
            self:UseAbility(4)
        elseif input.KeyCode == Enum.KeyCode.B then
            self:ToggleBuildMenu()
        elseif input.KeyCode == Enum.KeyCode.Escape then
            self:CloseAllMenus()
        end
    end)
    
    -- Обработка мыши
    UserInputService.MouseButton1Click:Connect(function()
        if self.State.isBuilding then
            self:PlaceStructure()
        end
    end)
    
    -- Обработка движения мыши
    UserInputService.MouseMoved:Connect(function(x, y)
        if self.State.isBuilding then
            self:UpdateBuildPreview(x, y)
        end
    end)
    
    -- Обработка изменения персонажа
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        self:OnCharacterChanged()
    end)
end

function ClientMain:InitializeSystems()
    -- Инициализация систем камеры, ввода и т.д.
    print("[ClientMain] Systems initialized")
end

function ClientMain:UseAbility(abilityNumber)
    if not self.State.currentClass then
        print("[ClientMain] No class selected")
        return
    end
    if Remotes.UseAbility then
        Remotes.UseAbility:FireServer(abilityNumber)
    else
        warn("[ClientMain] UseAbility remote not found")
    end
end

function ClientMain:SelectClass(className)
    print("[ClientMain] Selecting class:", className)
    if Remotes.SelectClass then
        Remotes.SelectClass:FireServer(className)
    else
        warn("[ClientMain] SelectClass remote not found")
    end
    self:ShowClassSelection(false)
    self:UpdateAbilityBar(className)
end

function ClientMain:ToggleBuildMenu()
    if not UI.buildMenu then return end
    
    local isEnabled = UI.buildMenu.Enabled
    UI.buildMenu.Enabled = not isEnabled
    
    if not isEnabled then
        self.State.isBuilding = true
        self.State.cameraMode = "Build"
    else
        self.State.isBuilding = false
        self.State.cameraMode = "Follow"
        self:ClearBuildPreview()
    end
end

function ClientMain:SelectStructure(structureName)
    print("[ClientMain] Selected structure:", structureName)
    self.State.selectedStructure = structureName
    self:CreateBuildPreview()
end

function ClientMain:CreateBuildPreview()
    self:ClearBuildPreview()
    
    if not self.State.selectedStructure then return end
    
    -- Создание превью постройки
    local preview = Instance.new("Part")
    preview.Name = "BuildPreview"
    preview.Size = Vector3.new(10, 10, 2)
    preview.Material = Enum.Material.ForceField
    preview.Color = Color3.fromRGB(0, 255, 0)
    preview.Transparency = 0.5
    preview.CanCollide = false
    preview.Anchored = true
    preview.Parent = workspace
    
    self.State.buildPreview = preview
end

function ClientMain:UpdateBuildPreview(x, y)
    if not self.State.buildPreview then return end
    
    -- Получение позиции в мире
    local mouseRay = workspace.CurrentCamera:ScreenPointToRay(x, y)
    local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000)
    
    if raycastResult then
        self.State.buildPreview.Position = raycastResult.Position
    end
end

function ClientMain:PlaceStructure()
    if not self.State.selectedStructure or not self.State.buildPreview then return end
    local position = self.State.buildPreview.Position
    if Remotes.BuildStructure then
        Remotes.BuildStructure:FireServer(self.State.selectedStructure, position)
    else
        warn("[ClientMain] BuildStructure remote not found")
    end
    self:ClearBuildPreview()
end

function ClientMain:ClearBuildPreview()
    if self.State.buildPreview then
        self.State.buildPreview:Destroy()
        self.State.buildPreview = nil
    end
end

function ClientMain:ShowClassSelection(show)
    if not UI.classSelection then return end
    UI.classSelection.Enabled = show
end

function ClientMain:CloseAllMenus()
    if UI.classSelection then
        UI.classSelection.Enabled = false
    end
    
    if UI.buildMenu then
        UI.buildMenu.Enabled = false
        self.State.isBuilding = false
        self.State.cameraMode = "Follow"
        self:ClearBuildPreview()
    end
end

function ClientMain:UpdateAbilityBar(className)
    -- Обновление панели способностей в зависимости от класса
    print("[ClientMain] Updating ability bar for class:", className)
end

function ClientMain:UpdateResourceDisplay(resources)
    if not UI.resourceDisplay then return end
    
    local resourceFrame = UI.resourceDisplay.ResourceDisplay.ResourceFrame
    
    for resourceName, amount in pairs(resources) do
        local label = resourceFrame:FindFirstChild(resourceName .. "Label")
        if label then
            label.Text = resourceName .. ": " .. tostring(amount)
        end
    end
end

function ClientMain:UpdateGameInfo(wave, phase, nexusHealth)
    if not UI.mainHUD then return end
    
    local mainFrame = UI.mainHUD.MainHUD.MainFrame
    local topPanel = mainFrame.TopPanel
    
    -- Обновление информации о волне
    local waveInfo = topPanel.WaveInfo
    if waveInfo then
        waveInfo.Text = "Волна: " .. tostring(wave) .. "/10"
    end
    
    -- Обновление информации о фазе
    local phaseInfo = topPanel.PhaseInfo
    if phaseInfo then
        phaseInfo.Text = phase
    end
    
    -- Обновление здоровья Нексуса
    local nexusHealthLabel = topPanel.NexusHealth
    if nexusHealthLabel then
        nexusHealthLabel.Text = "Нексус: " .. tostring(nexusHealth) .. "/10000"
    end
end

function ClientMain:OnCharacterChanged()
    print("[ClientMain] Character changed")
    -- Обновление UI и систем при смене персонажа
end

function ClientMain:ShowNotification(message, duration)
    duration = duration or 3
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 400, 0, 60)
    notification.Position = UDim2.new(0.5, -200, 0.2, 0)
    notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notification.BackgroundTransparency = 0.3
    notification.Text = message
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.TextScaled = true
    notification.Font = Enum.Font.GothamBold
    notification.Parent = screenGui
    
    -- Анимация появления
    local tween = TweenService:Create(notification, TweenInfo.new(0.5), {
        Position = UDim2.new(0.5, -200, 0.2, 0)
    })
    tween:Play()
    
    -- Удаление через время
    task.wait(duration)
    
    local fadeTween = TweenService:Create(notification, TweenInfo.new(0.5), {
        BackgroundTransparency = 1,
        TextTransparency = 1
    })
    fadeTween:Play()
    
    task.wait(0.5)
    screenGui:Destroy()
end

function ClientMain:GatherResource(resourceType, amount)
    if Remotes.GatherResource then
        Remotes.GatherResource:FireServer(resourceType, amount)
    else
        warn("[ClientMain] GatherResource remote not found")
    end
end

-- Инициализация при загрузке
ClientMain:Initialize()

return ClientMain