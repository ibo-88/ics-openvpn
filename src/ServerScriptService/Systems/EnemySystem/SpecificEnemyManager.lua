-- SpecificEnemyManager.lua
-- Система специфических врагов с уникальным лутом

local SpecificEnemyManager = {}
SpecificEnemyManager.__index = SpecificEnemyManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local AdvancedLootManager = require(script.Parent.Parent.LootSystem.AdvancedLootManager)

-- Состояние
SpecificEnemyManager.specificEnemies = {}
SpecificEnemyManager.activeEnemies = {}

function SpecificEnemyManager:Initialize()
    print("[SpecificEnemyManager] Initializing specific enemy system...")
    
    self:InitializeSpecificEnemies()
    
    print("[SpecificEnemyManager] Specific enemy system initialized!")
end

function SpecificEnemyManager:InitializeSpecificEnemies()
    self.specificEnemies = {
        -- Обычные враги
        goblin = {
            name = "Гоблин",
            model = "GoblinModel",
            health = 50,
            damage = 15,
            speed = 8,
            attackRange = 3,
            attackCooldown = 2,
            lootTable = "enemy_loot.goblin",
            abilities = {},
            visualEffects = {
                color = Color3.fromRGB(0, 255, 0),
                size = Vector3.new(1, 2, 1)
            }
        },
        
        orc = {
            name = "Орк",
            model = "OrcModel",
            health = 80,
            damage = 25,
            speed = 6,
            attackRange = 4,
            attackCooldown = 2.5,
            lootTable = "enemy_loot.orc",
            abilities = {
                charge = {
                    name = "Рывок",
                    cooldown = 8,
                    range = 10,
                    damage = 35
                }
            },
            visualEffects = {
                color = Color3.fromRGB(255, 100, 0),
                size = Vector3.new(1.2, 2.5, 1.2)
            }
        },
        
        troll = {
            name = "Тролль",
            model = "TrollModel",
            health = 120,
            damage = 30,
            speed = 4,
            attackRange = 5,
            attackCooldown = 3,
            lootTable = "enemy_loot.troll",
            abilities = {
                regeneration = {
                    name = "Регенерация",
                    cooldown = 15,
                    healAmount = 20
                },
                rockThrow = {
                    name = "Бросок камня",
                    cooldown = 12,
                    range = 15,
                    damage = 40
                }
            },
            visualEffects = {
                color = Color3.fromRGB(100, 100, 100),
                size = Vector3.new(1.5, 3, 1.5)
            }
        },
        
        -- Элитные враги
        elite_goblin = {
            name = "Элитный гоблин",
            model = "EliteGoblinModel",
            health = 100,
            damage = 25,
            speed = 10,
            attackRange = 4,
            attackCooldown = 1.5,
            lootTable = "enemy_loot.elite_goblin",
            abilities = {
                stealth = {
                    name = "Скрытность",
                    cooldown = 10,
                    duration = 3,
                    speedBonus = 5
                },
                poisonDagger = {
                    name = "Отравленный кинжал",
                    cooldown = 6,
                    damage = 20,
                    poisonDamage = 5,
                    poisonDuration = 5
                }
            },
            visualEffects = {
                color = Color3.fromRGB(0, 200, 0),
                size = Vector3.new(1.1, 2.2, 1.1),
                glow = true
            }
        },
        
        elite_orc = {
            name = "Элитный орк",
            model = "EliteOrcModel",
            health = 150,
            damage = 35,
            speed = 7,
            attackRange = 5,
            attackCooldown = 2,
            lootTable = "enemy_loot.elite_orc",
            abilities = {
                berserkerRage = {
                    name = "Ярость берсерка",
                    cooldown = 20,
                    duration = 10,
                    damageBonus = 20,
                    speedBonus = 3
                },
                shieldBash = {
                    name = "Щитовой удар",
                    cooldown = 8,
                    damage = 45,
                    stunDuration = 2
                }
            },
            visualEffects = {
                color = Color3.fromRGB(255, 150, 0),
                size = Vector3.new(1.3, 2.7, 1.3),
                glow = true
            }
        },
        
        -- Боссы
        goblin_king = {
            name = "Король гоблинов",
            model = "GoblinKingModel",
            health = 500,
            damage = 50,
            speed = 5,
            attackRange = 6,
            attackCooldown = 2,
            lootTable = "enemy_loot.goblin_king",
            abilities = {
                royalCommand = {
                    name = "Королевский приказ",
                    cooldown = 15,
                    effect = "summon_minions",
                    minionCount = 3
                },
                crownLaser = {
                    name = "Лазер короны",
                    cooldown = 12,
                    range = 20,
                    damage = 80
                },
                treasureThrow = {
                    name = "Бросок сокровищ",
                    cooldown = 8,
                    range = 12,
                    damage = 60
                }
            },
            visualEffects = {
                color = Color3.fromRGB(255, 215, 0),
                size = Vector3.new(2, 4, 2),
                glow = true,
                particles = true
            }
        },
        
        dragon = {
            name = "Дракон",
            model = "DragonModel",
            health = 1000,
            damage = 80,
            speed = 3,
            attackRange = 8,
            attackCooldown = 3,
            lootTable = "enemy_loot.dragon",
            abilities = {
                fireBreath = {
                    name = "Огненное дыхание",
                    cooldown = 10,
                    range = 15,
                    damage = 100,
                    duration = 3
                },
                wingSlam = {
                    name = "Удар крылом",
                    cooldown = 15,
                    range = 10,
                    damage = 120,
                    knockback = true
                },
                dragonRoar = {
                    name = "Рев дракона",
                    cooldown = 20,
                    range = 25,
                    damage = 60,
                    fearEffect = true
                }
            },
            visualEffects = {
                color = Color3.fromRGB(255, 0, 0),
                size = Vector3.new(3, 6, 3),
                glow = true,
                particles = true,
                fireEffect = true
            }
        }
    }
end

function SpecificEnemyManager:CreateSpecificEnemy(enemyType, position)
    local enemyData = self.specificEnemies[enemyType]
    if not enemyData then
        warn("[SpecificEnemyManager] Enemy type not found:", enemyType)
        return nil
    end
    
    -- Создание физического объекта врага
    local enemy = Instance.new("Part")
    enemy.Name = enemyData.name
    enemy.Size = enemyData.visualEffects.size
    enemy.Position = position
    enemy.Anchored = true
    enemy.CanCollide = true
    enemy.Material = Enum.Material.Neon
    enemy.Color = enemyData.visualEffects.color
    enemy.Parent = workspace
    
    -- Создание свечения
    if enemyData.visualEffects.glow then
        local pointLight = Instance.new("PointLight")
        pointLight.Color = enemyData.visualEffects.color
        pointLight.Range = 8
        pointLight.Brightness = 2
        pointLight.Parent = enemy
    end
    
    -- Создание частиц
    if enemyData.visualEffects.particles then
        local particleEmitter = Instance.new("ParticleEmitter")
        particleEmitter.Color = ColorSequence.new(enemyData.visualEffects.color)
        particleEmitter.Size = NumberSequence.new(0.5, 0)
        particleEmitter.Speed = NumberRange.new(3, 8)
        particleEmitter.Rate = 15
        particleEmitter.Lifetime = NumberRange.new(2, 4)
        particleEmitter.Parent = enemy
    end
    
    -- Создание огненного эффекта для дракона
    if enemyData.visualEffects.fireEffect then
        local fire = Instance.new("Fire")
        fire.Heat = 10
        fire.Size = 5
        fire.Parent = enemy
    end
    
    -- Создание UI для врага
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Size = UDim2.new(0, 200, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.Parent = enemy
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.Position = UDim2.new(0, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = enemyData.name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextScaled = true
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.Parent = billboardGui
    
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(0.8, 0, 0.3, 0)
    healthBar.Position = UDim2.new(0.1, 0, 0.6, 0)
    healthBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = billboardGui
    
    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.Position = UDim2.new(0, 0, 0, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBar
    
    -- Установка атрибутов
    enemy:SetAttribute("EnemyType", enemyType)
    enemy:SetAttribute("Health", enemyData.health)
    enemy:SetAttribute("MaxHealth", enemyData.health)
    enemy:SetAttribute("Damage", enemyData.damage)
    enemy:SetAttribute("Speed", enemyData.speed)
    enemy:SetAttribute("AttackRange", enemyData.attackRange)
    enemy:SetAttribute("AttackCooldown", enemyData.attackCooldown)
    enemy:SetAttribute("LootTable", enemyData.lootTable)
    enemy:SetAttribute("IsSpecificEnemy", true)
    
    -- Сохранение ссылок на UI элементы
    enemy:SetAttribute("HealthBar", healthBar)
    enemy:SetAttribute("HealthFill", healthFill)
    
    -- Подключение событий
    enemy.Touched:Connect(function(hit)
        local character = hit.Parent
        local player = game.Players:GetPlayerFromCharacter(character)
        
        if player then
            self:HandleEnemyCombat(player, enemy, enemyData)
        end
    end)
    
    -- Запуск AI
    self:StartEnemyAI(enemy, enemyData)
    
    -- Добавление в активные враги
    self.activeEnemies[enemy] = {
        data = enemyData,
        lastAttack = 0,
        abilityCooldowns = {},
        target = nil
    }
    
    return enemy
end

function SpecificEnemyManager:HandleEnemyCombat(player, enemy, enemyData)
    local currentHealth = enemy:GetAttribute("Health")
    local damage = enemy:GetAttribute("Damage")
    
    -- Нанесение урона врагу
    currentHealth = currentHealth - 25 -- Урон от игрока
    enemy:SetAttribute("Health", currentHealth)
    
    -- Обновление полоски здоровья
    local healthFill = enemy:GetAttribute("HealthFill")
    if healthFill then
        local healthPercent = currentHealth / enemyData.health
        healthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
        
        -- Изменение цвета в зависимости от здоровья
        if healthPercent > 0.6 then
            healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        elseif healthPercent > 0.3 then
            healthFill.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
        else
            healthFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
    
    -- Нанесение урона игроку
    local character = player.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.Health = humanoid.Health - damage
    end
    
    -- Проверка смерти врага
    if currentHealth <= 0 then
        self:HandleEnemyDeath(player, enemy, enemyData)
    end
end

function SpecificEnemyManager:HandleEnemyDeath(player, enemy, enemyData)
    -- Генерация лута через AdvancedLootManager
    local loot = AdvancedLootManager:GenerateAdvancedLoot(enemyData.lootTable, enemy.Position, "common", player)
    
    -- Создание физического лута с эффектами
    AdvancedLootManager:CreatePhysicalLootWithEffects(loot, enemy.Position)
    
    -- Создание эффекта смерти
    self:CreateDeathEffect(enemy, enemyData)
    
    -- Уведомление игрока
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, "Побежден " .. enemyData.name .. "!", "success", 3)
    
    -- Удаление врага
    enemy:Destroy()
    
    -- Удаление из активных врагов
    self.activeEnemies[enemy] = nil
end

function SpecificEnemyManager:CreateDeathEffect(enemy, enemyData)
    -- Создание взрыва
    local explosion = Instance.new("Explosion")
    explosion.Position = enemy.Position
    explosion.BlastRadius = 3
    explosion.BlastPressure = 0 -- Без урона
    explosion.Parent = workspace
    
    -- Создание эффекта частиц
    local deathParticles = Instance.new("Part")
    deathParticles.Size = Vector3.new(0.1, 0.1, 0.1)
    deathParticles.Position = enemy.Position
    deathParticles.Anchored = true
    deathParticles.CanCollide = false
    deathParticles.Material = Enum.Material.Neon
    deathParticles.Color = enemyData.visualEffects.color
    deathParticles.Parent = workspace
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(enemyData.visualEffects.color)
    particleEmitter.Size = NumberSequence.new(1, 0)
    particleEmitter.Speed = NumberRange.new(5, 15)
    particleEmitter.Rate = 50
    particleEmitter.Lifetime = NumberRange.new(1, 3)
    particleEmitter.Parent = deathParticles
    
    -- Анимация исчезновения
    TweenService:Create(deathParticles, TweenInfo.new(2), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    }):Play()
    
    task.wait(2)
    deathParticles:Destroy()
end

function SpecificEnemyManager:StartEnemyAI(enemy, enemyData)
    task.spawn(function()
        while enemy and enemy.Parent do
            -- Поиск ближайшего игрока
            local nearestPlayer = self:FindNearestPlayer(enemy.Position)
            
            if nearestPlayer then
                local enemyInfo = self.activeEnemies[enemy]
                if enemyInfo then
                    enemyInfo.target = nearestPlayer
                    
                    -- Движение к игроку
                    self:MoveTowardsPlayer(enemy, nearestPlayer, enemyData)
                    
                    -- Проверка способностей
                    self:CheckAbilities(enemy, enemyData, nearestPlayer)
                    
                    -- Атака
                    self:AttackPlayer(enemy, nearestPlayer, enemyData)
                end
            end
            
            task.wait(0.1) -- Обновление каждые 0.1 секунды
        end
    end)
end

function SpecificEnemyManager:FindNearestPlayer(enemyPosition)
    local nearestPlayer = nil
    local nearestDistance = math.huge
    
    for _, player in pairs(game.Players:GetPlayers()) do
        local character = player.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            local distance = (humanoidRootPart.Position - enemyPosition).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end
    
    return nearestPlayer
end

function SpecificEnemyManager:MoveTowardsPlayer(enemy, player, enemyData)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart then
        local direction = (humanoidRootPart.Position - enemy.Position).Unit
        local distance = (humanoidRootPart.Position - enemy.Position).Magnitude
        
        -- Движение только если игрок не в зоне атаки
        if distance > enemyData.attackRange then
            local newPosition = enemy.Position + direction * enemyData.speed * 0.1
            enemy.Position = newPosition
        end
    end
end

function SpecificEnemyManager:CheckAbilities(enemy, enemyData, player)
    local enemyInfo = self.activeEnemies[enemy]
    if not enemyInfo then return end
    
    local currentTime = os.time()
    
    for abilityName, ability in pairs(enemyData.abilities) do
        local lastUse = enemyInfo.abilityCooldowns[abilityName] or 0
        
        if currentTime - lastUse >= ability.cooldown then
            if self:ShouldUseAbility(enemy, player, ability) then
                self:UseAbility(enemy, player, ability)
                enemyInfo.abilityCooldowns[abilityName] = currentTime
            end
        end
    end
end

function SpecificEnemyManager:ShouldUseAbility(enemy, player, ability)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart then
        local distance = (humanoidRootPart.Position - enemy.Position).Magnitude
        return distance <= (ability.range or 10)
    end
    
    return false
end

function SpecificEnemyManager:UseAbility(enemy, player, ability)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart then
        -- Создание визуального эффекта способности
        self:CreateAbilityEffect(enemy, humanoidRootPart.Position, ability)
        
        -- Применение эффекта способности
        if ability.name == "Рывок" then
            -- Рывок к игроку
            local direction = (humanoidRootPart.Position - enemy.Position).Unit
            local targetPosition = enemy.Position + direction * ability.range
            enemy.Position = targetPosition
            
        elseif ability.name == "Регенерация" then
            -- Восстановление здоровья
            local currentHealth = enemy:GetAttribute("Health")
            local maxHealth = enemy:GetAttribute("MaxHealth")
            local newHealth = math.min(currentHealth + ability.healAmount, maxHealth)
            enemy:SetAttribute("Health", newHealth)
            
        elseif ability.name == "Бросок камня" then
            -- Создание камня
            local rock = Instance.new("Part")
            rock.Size = Vector3.new(1, 1, 1)
            rock.Position = enemy.Position
            rock.Anchored = true
            rock.CanCollide = false
            rock.Material = Enum.Material.Rock
            rock.Parent = workspace
            
            -- Движение камня к игроку
            local direction = (humanoidRootPart.Position - enemy.Position).Unit
            TweenService:Create(rock, TweenInfo.new(1), {
                Position = humanoidRootPart.Position
            }):Play()
            
            -- Урон при попадании
            rock.Touched:Connect(function(hit)
                if hit.Parent == character then
                    local humanoid = character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.Health = humanoid.Health - ability.damage
                    end
                    rock:Destroy()
                end
            end)
            
            task.wait(1)
            rock:Destroy()
        end
    end
end

function SpecificEnemyManager:CreateAbilityEffect(enemy, targetPosition, ability)
    -- Создание эффекта способности
    local effect = Instance.new("Part")
    effect.Size = Vector3.new(0.1, 0.1, 0.1)
    effect.Position = enemy.Position
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.Neon
    effect.Color = Color3.fromRGB(255, 255, 0)
    effect.Parent = workspace
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
    particleEmitter.Size = NumberSequence.new(0.5, 0)
    particleEmitter.Speed = NumberRange.new(3, 8)
    particleEmitter.Rate = 20
    particleEmitter.Lifetime = NumberRange.new(1, 2)
    particleEmitter.Parent = effect
    
    -- Анимация исчезновения
    TweenService:Create(effect, TweenInfo.new(1), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    }):Play()
    
    task.wait(1)
    effect:Destroy()
end

function SpecificEnemyManager:AttackPlayer(enemy, player, enemyData)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if humanoidRootPart then
        local distance = (humanoidRootPart.Position - enemy.Position).Magnitude
        
        if distance <= enemyData.attackRange then
            local enemyInfo = self.activeEnemies[enemy]
            local currentTime = os.time()
            
            if currentTime - enemyInfo.lastAttack >= enemyData.attackCooldown then
                -- Нанесение урона
                local humanoid = character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.Health - enemyData.damage
                end
                
                enemyInfo.lastAttack = currentTime
                
                -- Создание эффекта атаки
                self:CreateAttackEffect(enemy, humanoidRootPart.Position)
            end
        end
    end
end

function SpecificEnemyManager:CreateAttackEffect(enemy, targetPosition)
    -- Создание эффекта атаки
    local effect = Instance.new("Part")
    effect.Size = Vector3.new(0.1, 0.1, 0.1)
    effect.Position = targetPosition
    effect.Anchored = true
    effect.CanCollide = false
    effect.Material = Enum.Material.Neon
    effect.Color = Color3.fromRGB(255, 0, 0)
    effect.Parent = workspace
    
    -- Анимация появления и исчезновения
    TweenService:Create(effect, TweenInfo.new(0.2), {
        Size = Vector3.new(2, 2, 2)
    }):Play()
    
    task.wait(0.2)
    
    TweenService:Create(effect, TweenInfo.new(0.3), {
        Size = Vector3.new(0, 0, 0),
        Transparency = 1
    }):Play()
    
    task.wait(0.3)
    effect:Destroy()
end

function SpecificEnemyManager:GetEnemyData(enemyType)
    return self.specificEnemies[enemyType]
end

function SpecificEnemyManager:GetAllEnemyTypes()
    local types = {}
    for enemyType, _ in pairs(self.specificEnemies) do
        table.insert(types, enemyType)
    end
    return types
end

return SpecificEnemyManager