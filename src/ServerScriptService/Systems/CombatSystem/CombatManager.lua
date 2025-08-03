-- CombatManager.lua
-- Управление боевой системой

local CombatManager = {}
CombatManager.__index = CombatManager

function CombatManager:Initialize()
    print("[CombatManager] Initialized")
end

function CombatManager:DealDamage(attacker, target, amount)
    print("[CombatManager]", attacker.Name, "deals", amount, "to", target.Name)
    -- TODO: Реализовать расчет урона
end

return setmetatable({}, CombatManager)