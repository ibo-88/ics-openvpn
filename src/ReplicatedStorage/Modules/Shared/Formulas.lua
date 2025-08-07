-- Formulas.lua
-- Модуль формул для расчета игровых механик Nexus Siege

local Formulas = {}

-- Константы для формул
local BASE_MULTIPLIERS = {
    DAMAGE = 1.0,
    HEALTH = 1.0,
    ARMOR = 1.0,
    SPEED = 1.0,
    EXPERIENCE = 1.0,
    GOLD = 1.0
}

local LEVEL_SCALING = {
    DAMAGE_PER_LEVEL = 1.15,
    HEALTH_PER_LEVEL = 1.12,
    ARMOR_PER_LEVEL = 1.08,
    EXPERIENCE_PER_LEVEL = 1.25,
    GOLD_PER_LEVEL = 1.18
}

-- Формулы урона
function Formulas.CalculateDamage(baseDamage, level, weaponMultiplier, classMultiplier, buffs)
    local damage = baseDamage or 10
    local levelMultiplier = math.pow(LEVEL_SCALING.DAMAGE_PER_LEVEL, level - 1)
    local totalMultiplier = (weaponMultiplier or 1.0) * (classMultiplier or 1.0)
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "damage" then
            totalMultiplier = totalMultiplier * (1 + buff.value)
        end
    end
    
    return math.floor(damage * levelMultiplier * totalMultiplier * BASE_MULTIPLIERS.DAMAGE)
end

function Formulas.CalculateArmorDamage(damage, armor, penetration)
    local effectiveArmor = math.max(0, armor - (penetration or 0))
    local damageReduction = effectiveArmor / (effectiveArmor + 100)
    return math.floor(damage * (1 - damageReduction))
end

-- Формулы здоровья
function Formulas.CalculateMaxHealth(baseHealth, level, classMultiplier, buffs)
    local health = baseHealth or 100
    local levelMultiplier = math.pow(LEVEL_SCALING.HEALTH_PER_LEVEL, level - 1)
    local totalMultiplier = classMultiplier or 1.0
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "health" then
            totalMultiplier = totalMultiplier * (1 + buff.value)
        end
    end
    
    return math.floor(health * levelMultiplier * totalMultiplier * BASE_MULTIPLIERS.HEALTH)
end

function Formulas.CalculateHealthRegeneration(maxHealth, level, buffs)
    local baseRegen = maxHealth * 0.01 -- 1% от макс здоровья в секунду
    local levelBonus = level * 0.5
    local totalRegen = baseRegen + levelBonus
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "regen" then
            totalRegen = totalRegen * (1 + buff.value)
        end
    end
    
    return math.floor(totalRegen)
end

-- Формулы брони
function Formulas.CalculateArmor(baseArmor, level, classMultiplier, equipment, buffs)
    local armor = baseArmor or 0
    local levelMultiplier = math.pow(LEVEL_SCALING.ARMOR_PER_LEVEL, level - 1)
    local totalMultiplier = classMultiplier or 1.0
    
    -- Бонус от экипировки
    local equipmentBonus = 0
    for _, item in pairs(equipment or {}) do
        if item.armor then
            equipmentBonus = equipmentBonus + item.armor
        end
    end
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "armor" then
            totalMultiplier = totalMultiplier * (1 + buff.value)
        end
    end
    
    return math.floor((armor * levelMultiplier + equipmentBonus) * totalMultiplier * BASE_MULTIPLIERS.ARMOR)
end

-- Формулы скорости
function Formulas.CalculateSpeed(baseSpeed, level, classMultiplier, equipment, buffs)
    local speed = baseSpeed or 16
    local totalMultiplier = classMultiplier or 1.0
    
    -- Бонус от экипировки
    local equipmentBonus = 0
    for _, item in pairs(equipment or {}) do
        if item.speed then
            equipmentBonus = equipmentBonus + item.speed
        end
    end
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "speed" then
            totalMultiplier = totalMultiplier * (1 + buff.value)
        end
    end
    
    return math.floor((speed + equipmentBonus) * totalMultiplier * BASE_MULTIPLIERS.SPEED)
end

-- Формулы опыта
function Formulas.CalculateExperienceGain(baseExp, level, enemyLevel, buffs)
    local exp = baseExp or 10
    local levelDifference = enemyLevel - level
    
    -- Множитель за разницу уровней
    local levelMultiplier = 1.0
    if levelDifference > 0 then
        levelMultiplier = 1.0 + (levelDifference * 0.1)
    elseif levelDifference < -5 then
        levelMultiplier = math.max(0.1, 1.0 + (levelDifference * 0.05))
    end
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "experience" then
            levelMultiplier = levelMultiplier * (1 + buff.value)
        end
    end
    
    return math.floor(exp * levelMultiplier * BASE_MULTIPLIERS.EXPERIENCE)
end

function Formulas.CalculateLevelExperience(level)
    return math.floor(100 * math.pow(LEVEL_SCALING.EXPERIENCE_PER_LEVEL, level - 1))
end

-- Формулы золота
function Formulas.CalculateGoldGain(baseGold, level, enemyLevel, buffs)
    local gold = baseGold or 5
    local levelDifference = enemyLevel - level
    
    -- Множитель за разницу уровней
    local levelMultiplier = 1.0
    if levelDifference > 0 then
        levelMultiplier = 1.0 + (levelDifference * 0.15)
    elseif levelDifference < -5 then
        levelMultiplier = math.max(0.1, 1.0 + (levelDifference * 0.08))
    end
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "gold" then
            levelMultiplier = levelMultiplier * (1 + buff.value)
        end
    end
    
    return math.floor(gold * levelMultiplier * BASE_MULTIPLIERS.GOLD)
end

-- Формулы крафтинга
function Formulas.CalculateCraftingTime(baseTime, level, stationLevel, buffs)
    local time = baseTime or 5
    local levelReduction = math.max(0.1, 1.0 - (level * 0.02))
    local stationBonus = math.max(0.1, 1.0 - (stationLevel * 0.05))
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "crafting_speed" then
            time = time * (1 - buff.value)
        end
    end
    
    return math.max(0.5, time * levelReduction * stationBonus)
end

function Formulas.CalculateCraftingSuccess(baseChance, level, stationLevel, buffs)
    local chance = baseChance or 0.8
    local levelBonus = math.min(0.2, level * 0.01)
    local stationBonus = math.min(0.15, stationLevel * 0.03)
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "crafting_success" then
            chance = chance + buff.value
        end
    end
    
    return math.min(1.0, chance + levelBonus + stationBonus)
end

-- Формулы строительства
function Formulas.CalculateBuildTime(baseTime, level, buffs)
    local time = baseTime or 3
    local levelReduction = math.max(0.1, 1.0 - (level * 0.015))
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "build_speed" then
            time = time * (1 - buff.value)
        end
    end
    
    return math.max(0.5, time * levelReduction)
end

function Formulas.CalculateBuildCost(baseCost, level, buffs)
    local cost = baseCost or 10
    local levelReduction = math.max(0.5, 1.0 - (level * 0.02))
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "build_cost" then
            cost = cost * (1 - buff.value)
        end
    end
    
    return math.floor(cost * levelReduction)
end

-- Формулы ресурсов
function Formulas.CalculateResourceGather(baseAmount, level, toolLevel, buffs)
    local amount = baseAmount or 1
    local levelBonus = level * 0.1
    local toolBonus = toolLevel * 0.2
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "gathering" then
            amount = amount * (1 + buff.value)
        end
    end
    
    return math.floor(amount + levelBonus + toolBonus)
end

function Formulas.CalculateGatherTime(baseTime, level, toolLevel, buffs)
    local time = baseTime or 2
    local levelReduction = math.max(0.1, 1.0 - (level * 0.01))
    local toolReduction = math.max(0.1, 1.0 - (toolLevel * 0.05))
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "gather_speed" then
            time = time * (1 - buff.value)
        end
    end
    
    return math.max(0.2, time * levelReduction * toolReduction)
end

-- Формулы волн
function Formulas.CalculateWaveDifficulty(waveNumber, playerCount)
    local baseDifficulty = 1.0 + (waveNumber * 0.2)
    local playerMultiplier = math.max(0.5, 1.0 + (playerCount * 0.1))
    return baseDifficulty * playerMultiplier
end

function Formulas.CalculateEnemyCount(waveNumber, playerCount, difficulty)
    local baseCount = 5 + (waveNumber * 2)
    local playerBonus = playerCount * 3
    local difficultyMultiplier = difficulty or 1.0
    return math.floor((baseCount + playerBonus) * difficultyMultiplier)
end

-- Формулы лута
function Formulas.CalculateLootChance(baseChance, level, luck, buffs)
    local chance = baseChance or 0.1
    local levelBonus = math.min(0.3, level * 0.01)
    local luckBonus = math.min(0.2, luck * 0.02)
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "loot_chance" then
            chance = chance + buff.value
        end
    end
    
    return math.min(1.0, chance + levelBonus + luckBonus)
end

function Formulas.CalculateRareLootChance(baseChance, level, luck, buffs)
    local chance = baseChance or 0.01
    local levelBonus = math.min(0.1, level * 0.002)
    local luckBonus = math.min(0.05, luck * 0.01)
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "rare_loot_chance" then
            chance = chance + buff.value
        end
    end
    
    return math.min(0.5, chance + levelBonus + luckBonus)
end

-- Формулы магазина
function Formulas.CalculateItemPrice(basePrice, rarity, level, demand)
    local price = basePrice or 10
    local rarityMultiplier = {
        common = 1.0,
        uncommon = 1.5,
        rare = 2.5,
        epic = 4.0,
        legendary = 8.0
    }
    
    local levelMultiplier = 1.0 + (level * 0.1)
    local demandMultiplier = demand or 1.0
    
    return math.floor(price * (rarityMultiplier[rarity] or 1.0) * levelMultiplier * demandMultiplier)
end

function Formulas.CalculateSellPrice(buyPrice, level, buffs)
    local sellPrice = buyPrice * 0.6 -- 60% от цены покупки
    local levelBonus = math.min(0.2, level * 0.01)
    
    -- Применение баффов
    for _, buff in pairs(buffs or {}) do
        if buff.type == "sell_price" then
            sellPrice = sellPrice * (1 + buff.value)
        end
    end
    
    return math.floor(sellPrice * (1 + levelBonus))
end

-- Формулы навыков
function Formulas.CalculateSkillCost(skillLevel, skillType)
    local baseCost = 1
    local levelMultiplier = math.pow(1.5, skillLevel - 1)
    local typeMultiplier = {
        warrior = 1.0,
        engineer = 1.2,
        universal = 1.5
    }
    
    return math.floor(baseCost * levelMultiplier * (typeMultiplier[skillType] or 1.0))
end

function Formulas.CalculateSkillEffect(baseEffect, skillLevel, playerLevel)
    local effect = baseEffect or 10
    local skillMultiplier = 1.0 + (skillLevel * 0.2)
    local levelBonus = math.min(0.5, playerLevel * 0.01)
    
    return math.floor(effect * skillMultiplier * (1 + levelBonus))
end

-- Формулы престижа
function Formulas.CalculatePrestigeRequirement(level)
    return math.floor(100 * math.pow(2, level - 1))
end

function Formulas.CalculatePrestigeBonus(prestigeLevel, statType)
    local baseBonus = 0.1 -- 10% за каждый престиж
    local typeMultiplier = {
        damage = 1.0,
        health = 1.0,
        armor = 1.0,
        speed = 0.5,
        experience = 1.5,
        gold = 1.2
    }
    
    return baseBonus * prestigeLevel * (typeMultiplier[statType] or 1.0)
end

-- Утилитарные функции
function Formulas.RoundToDecimal(value, decimals)
    local multiplier = math.pow(10, decimals or 0)
    return math.floor(value * multiplier + 0.5) / multiplier
end

function Formulas.Clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

function Formulas.Lerp(a, b, t)
    return a + (b - a) * t
end

function Formulas.RandomRange(min, max)
    return min + math.random() * (max - min)
end

function Formulas.RandomInt(min, max)
    return math.floor(min + math.random() * (max - min + 1))
end

return Formulas