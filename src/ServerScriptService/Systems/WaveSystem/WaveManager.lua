-- WaveManager.lua
-- Управление волнами врагов

local WaveManager = {}
WaveManager.__index = WaveManager

function WaveManager:Initialize()
    print("[WaveManager] Initialized")
end

function WaveManager:StartWave(waveNumber)
    print("[WaveManager] Starting wave:", waveNumber)
    -- TODO: Реализовать спавн врагов
end

function WaveManager:EndWave(waveNumber)
    print("[WaveManager] Ending wave:", waveNumber)
    -- TODO: Очистка врагов
end

return setmetatable({}, WaveManager)