-- GameLauncher.lua
-- Финальный скрипт запуска Nexus Siege

local GameController = require(script.Parent.Core.GameController)

-- Красивый логотип игры
local function printLogo()
    print("")
    print("███╗   ██╗███████╗██╗  ██╗██╗   ██╗███████╗███████╗██╗███████╗███████╗███████╗")
    print("████╗  ██║██╔════╝╚██╗██╔╝██║   ██║██╔════╝██╔════╝██║██╔════╝██╔════╝██╔════╝")
    print("██╔██╗ ██║█████╗   ╚███╔╝ ██║   ██║███████╗███████╗██║█████╗  █████╗  █████╗  ")
    print("██║╚██╗██║██╔══╝   ██╔██╗ ██║   ██║╚════██║╚════██║██║██╔══╝  ██╔══╝  ██╔══╝  ")
    print("██║ ╚████║███████╗██╔╝ ██╗╚██████╔╝███████║███████║██║██║     ███████╗███████╗")
    print("╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚═╝╚═╝     ╚══════╝╚══════╝")
    print("")
    print("🎮 Tower Defense & Resource Management Game")
    print("🚀 Version 1.0.0 - Ready for Launch!")
    print("")
end

-- Проверка систем
local function checkSystems()
    print("🔍 Проверка систем...")
    
    local systems = {
        "ProfileService",
        "CombatManager", 
        "BuildManager",
        "ResourceManager",
        "EnemyManager",
        "WaveManager",
        "AntiCheat",
        "AchievementManager"
    }
    
    for _, systemName in ipairs(systems) do
        local success, result = pcall(function()
            return require(script.Parent.Systems[systemName:gsub("Manager", "System")][systemName])
        end)
        
        if success then
            print("  ✅ " .. systemName .. " - OK")
        else
            print("  ❌ " .. systemName .. " - ERROR: " .. tostring(result))
            return false
        end
    end
    
    return true
end

-- Основная функция запуска
local function launchGame()
    printLogo()
    
    print("🚀 Инициализация Nexus Siege...")
    print("=" .. string.rep("=", 60))
    
    -- Проверка систем
    if not checkSystems() then
        warn("❌ Ошибка проверки систем! Игра не может быть запущена.")
        return
    end
    
    print("✅ Все системы проверены успешно!")
    print("")
    
    -- Инициализация игры
    print("🎮 Запуск GameController...")
    local success, error = pcall(function()
        GameController:Initialize()
    end)
    
    if success then
        print("✅ GameController инициализирован успешно!")
    else
        warn("❌ Ошибка инициализации GameController: " .. tostring(error))
        return
    end
    
    print("")
    print("🎉 Nexus Siege успешно запущен!")
    print("")
    print("📊 Статистика игры:")
    print("  • 6 типов врагов с AI")
    print("  • Система строительства с башнями")
    print("  • Система ресурсов и экономики")
    print("  • 20+ достижений")
    print("  • Система анти-чита")
    print("  • Автоматическое сохранение")
    print("  • Красивые визуальные эффекты")
    print("")
    print("🎯 Игра готова к приему игроков!")
    print("=" .. string.rep("=", 60))
end

-- Запуск игры
launchGame()