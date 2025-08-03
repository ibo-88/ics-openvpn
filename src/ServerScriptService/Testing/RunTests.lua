-- RunTests.lua
-- Скрипт для запуска всех тестов Nexus Siege

local TestRunner = require(script.Parent.TestRunner)

print("🧪 Запуск тестирования Nexus Siege...")
print("=" .. string.rep("=", 50))

-- Инициализация тестовой системы
print("📋 Инициализация тестовой системы...")
TestRunner:Initialize()

-- Запуск всех тестов
print("🚀 Запуск всех тестов...")
TestRunner:RunAllTests()

-- Тест производительности
print("⚡ Запуск теста производительности...")
TestRunner:PerformanceTest()

-- Очистка тестовых объектов
print("🧹 Очистка тестовых объектов...")
TestRunner:Cleanup()

print("=" .. string.rep("=", 50))
print("✅ Тестирование завершено!")
print("🎯 Nexus Siege готов к запуску!")

-- Автоматический запуск через 5 секунд
task.wait(5)
print("🚀 Запуск игры...")