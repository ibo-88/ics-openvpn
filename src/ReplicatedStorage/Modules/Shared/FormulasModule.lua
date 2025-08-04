-- FormulasModule.lua
-- Модуль с формулами для расчета урона, защиты и других игровых механик

local Formulas = {}

-- Расчет финального урона
function Formulas.CalculateDamage(attacker, target, baseDamage, damageType)
    -- Шаг 1: Базовый урон с модификаторами атакующего
    local attackPower = attacker.stats.attackPower or 1
    local critChance = attacker.stats.critChance or 0.05
    local critMultiplier = attacker.stats.critMultiplier or 2
    
    -- Проверка крита
    local isCrit = math.random() < critChance
    local damage = baseDamage * attackPower
    if isCrit then
        damage = damage * critMultiplier
    end
    
    -- Шаг 2: Применение защиты цели
    local armor = target.stats.armor or 0
    local magicResist = target.stats.magicResist or 0
    
    local damageReduction = 0
    if damageType == "Physical" then
        -- Формула брони: damage = damage * (100 / (100 + armor))
        damageReduction = 100 / (100 + armor)
    elseif damageType == "Magic" then
        -- Формула магического сопротивления
        damageReduction = 100 / (100 + magicResist)
    elseif damageType == "True" then
        -- Чистый урон игнорирует защиту
        damageReduction = 1
    end
    
    damage = damage * damageReduction
    
    -- Шаг 3: Применение уязвимостей/сопротивлений
    local vulnerability = target.vulnerabilities and target.vulnerabilities[damageType] or 1
    damage = damage * vulnerability
    
    -- Шаг 4: Случайный разброс ±10%
    local variance = 0.9 + (math.random() * 0.2)
    damage = damage * variance
    
    return math.floor(damage), isCrit
end

-- Расчет урона по области (AOE)
function Formulas.CalculateAOEDamage(centerDamage, distance, maxRadius)
    -- Урон уменьшается линейно от центра
    local falloff = math.max(0, 1 - (distance / maxRadius))
    return centerDamage * falloff
end

-- Расчет лечения
function Formulas.CalculateHealing(healer, target, baseHeal)
    local healPower = healer.stats.healPower or 1
    local healReceived = target.stats.healReceived or 1
    
    local healing = baseHeal * healPower * healReceived
    
    -- Не может превысить максимальное здоровье
    local missingHealth = target.maxHealth - target.currentHealth
    return math.min(healing, missingHealth)
end

-- Расчет скорости атаки
function Formulas.CalculateAttackSpeed(baseAttackSpeed, attackSpeedBonus)
    -- Максимальная скорость атаки - 2.5 атаки в секунду
    local finalSpeed = baseAttackSpeed * (1 + attackSpeedBonus)
    return math.min(finalSpeed, 2.5)
end

-- Расчет опыта за убийство врага
function Formulas.CalculateExperience(enemyLevel, playerLevel)
    local baseExp = 10 + (enemyLevel * 5)
    local levelDifference = enemyLevel - playerLevel
    
    if levelDifference > 0 then
        -- Бонус за убийство более сильного врага
        baseExp = baseExp * (1 + (levelDifference * 0.1))
    elseif levelDifference < -5 then
        -- Штраф за убийство слабого врага
        baseExp = baseExp * math.max(0.1, 1 + (levelDifference * 0.05))
    end
    
    return math.floor(baseExp)
end

-- Расчет наград за волну
function Formulas.CalculateWaveReward(waveNumber, playerContribution, totalContribution)
    local baseReward = 50 + (waveNumber * 25)
    local contributionPercentage = playerContribution / totalContribution
    
    -- Минимальная награда 10% от базовой
    contributionPercentage = math.max(0.1, contributionPercentage)
    
    return math.floor(baseReward * contributionPercentage)
end

-- Расчет стоимости улучшения
function Formulas.CalculateUpgradeCost(baseCost, currentLevel, maxLevel)
    local costMultiplier = 1 + (currentLevel * 0.5)
    return math.floor(baseCost * costMultiplier)
end

-- Расчет времени строительства
function Formulas.CalculateBuildTime(baseTime, builderClass, hasUpgrades)
    local timeMultiplier = 1
    
    -- Бонус инженера
    if builderClass == "Engineer" then
        timeMultiplier = timeMultiplier * 0.7
    end
    
    -- Бонусы от улучшений
    if hasUpgrades then
        timeMultiplier = timeMultiplier * 0.9
    end
    
    return math.max(1, math.floor(baseTime * timeMultiplier))
end

-- Расчет эффективности добычи ресурсов
function Formulas.CalculateGatherEfficiency(baseEfficiency, gathererClass, toolQuality)
    local efficiency = baseEfficiency
    
    -- Бонус шахтера
    if gathererClass == "Miner" then
        efficiency = efficiency * 1.5
    end
    
    -- Бонус от качества инструмента
    if toolQuality then
        efficiency = efficiency * (1 + (toolQuality * 0.2))
    end
    
    return efficiency
end

-- Расчет дистанции атаки
function Formulas.CalculateAttackRange(baseRange, weaponType, upgrades)
    local range = baseRange
    
    -- Модификаторы по типу оружия
    if weaponType == "Bow" then
        range = range * 1.5
    elseif weaponType == "Staff" then
        range = range * 1.3
    elseif weaponType == "Sword" then
        range = range * 0.8
    end
    
    -- Бонусы от улучшений
    if upgrades and upgrades.range then
        range = range * (1 + upgrades.range)
    end
    
    return range
end

-- Расчет критического урона
function Formulas.CalculateCriticalDamage(baseDamage, critChance, critMultiplier, luck)
    local finalCritChance = critChance + (luck * 0.01)
    finalCritChance = math.min(finalCritChance, 0.95) -- Максимум 95%
    
    local isCrit = math.random() < finalCritChance
    local damage = baseDamage
    
    if isCrit then
        damage = damage * critMultiplier
    end
    
    return damage, isCrit
end

-- Расчет брони
function Formulas.CalculateArmor(baseArmor, armorType, upgrades)
    local armor = baseArmor
    
    -- Модификаторы по типу брони
    if armorType == "Heavy" then
        armor = armor * 1.5
    elseif armorType == "Light" then
        armor = armor * 0.7
    end
    
    -- Бонусы от улучшений
    if upgrades and upgrades.armor then
        armor = armor * (1 + upgrades.armor)
    end
    
    return armor
end

-- Расчет скорости передвижения
function Formulas.CalculateMovementSpeed(baseSpeed, equipment, buffs, debuffs)
    local speed = baseSpeed
    
    -- Модификаторы от экипировки
    if equipment and equipment.boots then
        speed = speed * equipment.boots.speedMultiplier
    end
    
    -- Баффы
    if buffs then
        for _, buff in pairs(buffs) do
            if buff.type == "Speed" then
                speed = speed * (1 + buff.value)
            end
        end
    end
    
    -- Дебаффы
    if debuffs then
        for _, debuff in pairs(debuffs) do
            if debuff.type == "Slow" then
                speed = speed * (1 - debuff.value)
            end
        end
    end
    
    -- Ограничения
    speed = math.max(5, speed) -- Минимум 5
    speed = math.min(50, speed) -- Максимум 50
    
    return speed
end

-- Расчет времени действия эффектов
function Formulas.CalculateEffectDuration(baseDuration, resistance, potency)
    local duration = baseDuration
    
    -- Сопротивление к эффектам
    if resistance then
        duration = duration * (1 - resistance)
    end
    
    -- Сила эффекта
    if potency then
        duration = duration * (1 + potency)
    end
    
    return math.max(0.5, duration) -- Минимум 0.5 секунды
end

-- Расчет урона по башням
function Formulas.CalculateTowerDamage(baseDamage, towerLevel, targetType, upgrades)
    local damage = baseDamage
    
    -- Бонус от уровня башни
    damage = damage * (1 + (towerLevel - 1) * 0.3)
    
    -- Модификаторы по типу цели
    if targetType == "Flying" then
        damage = damage * 1.2
    elseif targetType == "Armored" then
        damage = damage * 0.8
    end
    
    -- Бонусы от улучшений
    if upgrades and upgrades.damage then
        damage = damage * (1 + upgrades.damage)
    end
    
    return damage
end

-- Расчет здоровья башни
function Formulas.CalculateTowerHealth(baseHealth, towerLevel, upgrades)
    local health = baseHealth
    
    -- Бонус от уровня башни
    health = health * (1 + (towerLevel - 1) * 0.5)
    
    -- Бонусы от улучшений
    if upgrades and upgrades.health then
        health = health * (1 + upgrades.health)
    end
    
    return health
end

-- Расчет стоимости ремонта
function Formulas.CalculateRepairCost(maxHealth, currentHealth, repairEfficiency)
    local missingHealth = maxHealth - currentHealth
    local baseCost = missingHealth * 0.1 -- 10% от максимального здоровья
    
    -- Эффективность ремонта
    if repairEfficiency then
        baseCost = baseCost / repairEfficiency
    end
    
    return math.floor(baseCost)
end

return Formulas