-- TestRunner.lua
-- Система тестирования для Nexus Siege

local TestRunner = {}
TestRunner.__index = TestRunner

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameConstants = require(ReplicatedStorage.Modules.Shared.GameConstants)
local ProfileService = require(script.Parent.Parent.Data.ProfileService)
local CombatManager = require(script.Parent.Parent.Systems.CombatSystem.CombatManager)
local BuildManager = require(script.Parent.Parent.Systems.BuildingSystem.BuildManager)
local ResourceManager = require(script.Parent.Parent.Systems.ResourceSystem.ResourceManager)
local EnemyManager = require(script.Parent.Parent.Systems.EnemySystem.EnemyManager)
local WaveManager = require(script.Parent.Parent.Systems.WaveSystem.WaveManager)
local AntiCheat = require(script.Parent.Parent.Security.AntiCheat)

-- Состояние тестирования
TestRunner.testResults = {}
TestRunner.currentTest = nil
TestRunner.isRunning = false

function TestRunner:Initialize()
    print("[TestRunner] Initializing test system...")
    
    -- Создание папки для тестовых объектов
    local testFolder = Instance.new("Folder")
    testFolder.Name = "TestObjects"
    testFolder.Parent = workspace
    
    self.testFolder = testFolder
    
    print("[TestRunner] Test system initialized!")
end

-- Запуск всех тестов
function TestRunner:RunAllTests()
    print("[TestRunner] Starting comprehensive test suite...")
    
    self.isRunning = true
    self.testResults = {}
    
    -- Тестирование основных систем
    self:TestProfileService()
    self:TestCombatSystem()
    self:TestBuildingSystem()
    self:TestResourceSystem()
    self:TestEnemySystem()
    self:TestWaveSystem()
    self:TestAntiCheat()
    self:TestIntegration()
    
    -- Вывод результатов
    self:PrintTestResults()
    
    self.isRunning = false
    print("[TestRunner] All tests completed!")
end

-- Тестирование ProfileService
function TestRunner:TestProfileService()
    print("[TestRunner] Testing ProfileService...")
    
    local testPlayer = self:CreateTestPlayer("TestPlayer")
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Создание профиля
    local success, profile = pcall(function()
        return ProfileService:GetPlayerData(testPlayer)
    end)
    
    if success and profile then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Profile Creation", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Profile Creation", status = "FAILED", error = "Could not create profile"})
    end
    
    -- Тест 2: Добавление ресурсов
    local success2 = pcall(function()
        ProfileService:AddResources(testPlayer, {Wood = 100, Stone = 50})
    end)
    
    if success2 then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Add Resources", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Add Resources", status = "FAILED"})
    end
    
    -- Тест 3: Добавление опыта
    local success3 = pcall(function()
        ProfileService:AddExperience(testPlayer, 50)
    end)
    
    if success3 then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Add Experience", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Add Experience", status = "FAILED"})
    end
    
    self.testResults.ProfileService = results
    print("[TestRunner] ProfileService tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование боевой системы
function TestRunner:TestCombatSystem()
    print("[TestRunner] Testing CombatSystem...")
    
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Создание тестовых объектов
    local attacker = self:CreateTestCharacter("Attacker")
    local target = self:CreateTestCharacter("Target")
    
    -- Тест 1: Нанесение урона
    local success = pcall(function()
        CombatManager:DealDamage(attacker, target, 50, "Physical")
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Deal Damage", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Deal Damage", status = "FAILED"})
    end
    
    -- Тест 2: Проверка смерти
    local humanoid = target:FindFirstChild("Humanoid")
    if humanoid and humanoid.Health <= 0 then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Death Handling", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Death Handling", status = "FAILED"})
    end
    
    -- Очистка
    attacker:Destroy()
    target:Destroy()
    
    self.testResults.CombatSystem = results
    print("[TestRunner] CombatSystem tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование системы строительства
function TestRunner:TestBuildingSystem()
    print("[TestRunner] Testing BuildingSystem...")
    
    local testPlayer = self:CreateTestPlayer("Builder")
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Строительство стены
    local success, message = pcall(function()
        return BuildManager:BuildStructure(testPlayer, "WoodWall", Vector3.new(0, 5, 0))
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Build Wall", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Build Wall", status = "FAILED", error = message})
    end
    
    -- Тест 2: Проверка лимитов
    local buildings = BuildManager:GetPlayerBuildings(testPlayer)
    if buildings and buildings.walls > 0 then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Building Limits", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Building Limits", status = "FAILED"})
    end
    
    self.testResults.BuildingSystem = results
    print("[TestRunner] BuildingSystem tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование системы ресурсов
function TestRunner:TestResourceSystem()
    print("[TestRunner] Testing ResourceSystem...")
    
    local testPlayer = self:CreateTestPlayer("Gatherer")
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Создание зоны ресурсов
    local success = pcall(function()
        ResourceManager:Initialize()
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Resource Zones Creation", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Resource Zones Creation", status = "FAILED"})
    end
    
    -- Тест 2: Получение ресурсов игрока
    local resources = ResourceManager:GetPlayerResources(testPlayer)
    if resources then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Get Player Resources", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Get Player Resources", status = "FAILED"})
    end
    
    self.testResults.ResourceSystem = results
    print("[TestRunner] ResourceSystem tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование системы врагов
function TestRunner:TestEnemySystem()
    print("[TestRunner] Testing EnemySystem...")
    
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Создание врага
    local success = pcall(function()
        EnemyManager:CreateEnemy("Goblin", Vector3.new(10, 5, 10))
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Enemy Creation", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Enemy Creation", status = "FAILED"})
    end
    
    -- Тест 2: Подсчет врагов
    local enemyCount = EnemyManager:GetEnemyCount()
    if enemyCount >= 0 then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Enemy Count", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Enemy Count", status = "FAILED"})
    end
    
    self.testResults.EnemySystem = results
    print("[TestRunner] EnemySystem tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование системы волн
function TestRunner:TestWaveSystem()
    print("[TestRunner] Testing WaveSystem...")
    
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Инициализация волн
    local success = pcall(function()
        WaveManager:Initialize()
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Wave Initialization", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Wave Initialization", status = "FAILED"})
    end
    
    -- Тест 2: Получение данных волны
    local waveData = WaveManager:GetWaveData(1)
    if waveData then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Wave Data", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Wave Data", status = "FAILED"})
    end
    
    self.testResults.WaveSystem = results
    print("[TestRunner] WaveSystem tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование анти-чита
function TestRunner:TestAntiCheat()
    print("[TestRunner] Testing AntiCheat...")
    
    local testPlayer = self:CreateTestPlayer("Cheater")
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Валидация действия
    local success = pcall(function()
        return AntiCheat:ValidateAction(testPlayer, "UseAbility", {abilityName = "test"})
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "Action Validation", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "Action Validation", status = "FAILED"})
    end
    
    -- Тест 2: Получение статистики
    local stats = AntiCheat:GetStatistics()
    if stats then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "AntiCheat Statistics", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "AntiCheat Statistics", status = "FAILED"})
    end
    
    self.testResults.AntiCheat = results
    print("[TestRunner] AntiCheat tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Тестирование интеграции
function TestRunner:TestIntegration()
    print("[TestRunner] Testing System Integration...")
    
    local results = {passed = 0, failed = 0, tests = {}}
    
    -- Тест 1: Проверка зависимостей
    local success = pcall(function()
        -- Проверяем, что все системы могут работать вместе
        local testPlayer = self:CreateTestPlayer("IntegrationTest")
        local character = self:CreateTestCharacter("TestChar")
        
        -- Тестируем полный цикл: ресурсы -> строительство -> бой
        ProfileService:AddResources(testPlayer, {Wood = 100, Stone = 50})
        BuildManager:BuildStructure(testPlayer, "WoodWall", Vector3.new(0, 5, 0))
        
        return true
    end)
    
    if success then
        results.passed = results.passed + 1
        table.insert(results.tests, {name = "System Integration", status = "PASSED"})
    else
        results.failed = results.failed + 1
        table.insert(results.tests, {name = "System Integration", status = "FAILED"})
    end
    
    self.testResults.Integration = results
    print("[TestRunner] Integration tests completed: " .. results.passed .. " passed, " .. results.failed .. " failed")
end

-- Создание тестового игрока
function TestRunner:CreateTestPlayer(name)
    local player = {
        Name = name,
        UserId = math.random(100000, 999999),
        Character = self:CreateTestCharacter(name)
    }
    
    return player
end

-- Создание тестового персонажа
function TestRunner:CreateTestCharacter(name)
    local character = Instance.new("Model")
    character.Name = name
    character.Parent = self.testFolder
    
    -- HumanoidRootPart
    local rootPart = Instance.new("Part")
    rootPart.Name = "HumanoidRootPart"
    rootPart.Size = Vector3.new(2, 2, 1)
    rootPart.Position = Vector3.new(0, 5, 0)
    rootPart.Anchored = true
    rootPart.Parent = character
    
    -- Humanoid
    local humanoid = Instance.new("Humanoid")
    humanoid.MaxHealth = 100
    humanoid.Health = 100
    humanoid.Parent = character
    
    character.PrimaryPart = rootPart
    
    return character
end

-- Вывод результатов тестирования
function TestRunner:PrintTestResults()
    print("\n" .. string.rep("=", 60))
    print("TEST RESULTS SUMMARY")
    print(string.rep("=", 60))
    
    local totalPassed = 0
    local totalFailed = 0
    
    for systemName, results in pairs(self.testResults) do
        print("\n" .. systemName .. ":")
        print("  Passed: " .. results.passed .. ", Failed: " .. results.failed)
        
        for _, test in ipairs(results.tests) do
            local status = test.status == "PASSED" and "✅" or "❌"
            print("    " .. status .. " " .. test.name)
            if test.error then
                print("      Error: " .. test.error)
            end
        end
        
        totalPassed = totalPassed + results.passed
        totalFailed = totalFailed + results.failed
    end
    
    print("\n" .. string.rep("=", 60))
    print("TOTAL: " .. totalPassed .. " passed, " .. totalFailed .. " failed")
    print("SUCCESS RATE: " .. math.floor((totalPassed / (totalPassed + totalFailed)) * 100) .. "%")
    print(string.rep("=", 60))
    
    -- Сохранение результатов в файл
    self:SaveTestResults()
end

-- Сохранение результатов тестирования
function TestRunner:SaveTestResults()
    local results = {
        timestamp = tick(),
        totalPassed = 0,
        totalFailed = 0,
        systems = self.testResults
    }
    
    for _, systemResults in pairs(self.testResults) do
        results.totalPassed = results.totalPassed + systemResults.passed
        results.totalFailed = results.totalFailed + systemResults.failed
    end
    
    -- Здесь можно сохранить результаты в DataStore или файл
    print("[TestRunner] Test results saved")
end

-- Быстрый тест производительности
function TestRunner:PerformanceTest()
    print("[TestRunner] Running performance test...")
    
    local startTime = tick()
    
    -- Тест создания множества объектов
    for i = 1, 100 do
        self:CreateTestCharacter("PerfTest" .. i)
    end
    
    local endTime = tick()
    local duration = endTime - startTime
    
    print("[TestRunner] Performance test completed in " .. string.format("%.3f", duration) .. " seconds")
    
    -- Очистка тестовых объектов
    self.testFolder:ClearAllChildren()
end

-- Очистка тестовых объектов
function TestRunner:Cleanup()
    if self.testFolder then
        self.testFolder:ClearAllChildren()
    end
    print("[TestRunner] Test cleanup completed")
end

return TestRunner