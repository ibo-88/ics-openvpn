-- AdvancedLootManager.lua
-- Расширенная система лута с недостающими элементами

local AdvancedLootManager = {}
AdvancedLootManager.__index = AdvancedLootManager

-- Импорт зависимостей
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ProfileService = require(script.Parent.Parent.Parent.Data.ProfileService)
local EconomyManager = require(script.Parent.Parent.EconomySystem.EconomyManager)
local InventoryManager = require(script.Parent.Parent.InventorySystem.InventoryManager)
local ItemManager = require(script.Parent.Parent.ItemSystem.ItemManager)

-- Состояние
AdvancedLootManager.advancedLootTables = {}
AdvancedLootManager.lootPools = {}
AdvancedLootManager.lootEffects = {}
AdvancedLootManager.lootAnimations = {}

function AdvancedLootManager:Initialize()
    print("[AdvancedLootManager] Initializing advanced loot system...")
    
    self:InitializeAdvancedLootTables()
    self:InitializeLootPools()
    self:InitializeLootEffects()
    self:InitializeLootAnimations()
    
    print("[AdvancedLootManager] Advanced loot system initialized!")
end

function AdvancedLootManager:InitializeAdvancedLootTables()
    self.advancedLootTables = {
        -- Лут с разных типов врагов
        enemy_loot = {
            -- Обычные враги
            goblin = {
                guaranteed = {{itemId = "wood", minQuantity = 1, maxQuantity = 3}},
                possible = {
                    {itemId = "stone", minQuantity = 1, maxQuantity = 2, chance = 60},
                    {itemId = "gold", minQuantity = 2, maxQuantity = 8, chance = 40},
                    {itemId = "health_potion", minQuantity = 1, maxQuantity = 1, chance = 20}
                },
                rare = {
                    {itemId = "iron", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "goblin_ear", minQuantity = 1, maxQuantity = 2, chance = 10}
                }
            },
            
            orc = {
                guaranteed = {{itemId = "stone", minQuantity = 2, maxQuantity = 4}},
                possible = {
                    {itemId = "iron", minQuantity = 1, maxQuantity = 2, chance = 50},
                    {itemId = "gold", minQuantity = 5, maxQuantity = 15, chance = 60},
                    {itemId = "health_potion", minQuantity = 1, maxQuantity = 2, chance = 40}
                },
                rare = {
                    {itemId = "orc_tusk", minQuantity = 1, maxQuantity = 1, chance = 15},
                    {itemId = "strength_potion", minQuantity = 1, maxQuantity = 1, chance = 10}
                }
            },
            
            troll = {
                guaranteed = {{itemId = "stone", minQuantity = 3, maxQuantity = 6}},
                possible = {
                    {itemId = "iron", minQuantity = 2, maxQuantity = 4, chance = 70},
                    {itemId = "gold", minQuantity = 10, maxQuantity = 25, chance = 80},
                    {itemId = "health_potion", minQuantity = 2, maxQuantity = 3, chance = 60}
                },
                rare = {
                    {itemId = "troll_blood", minQuantity = 1, maxQuantity = 2, chance = 20},
                    {itemId = "regeneration_potion", minQuantity = 1, maxQuantity = 1, chance = 15}
                }
            },
            
            -- Элитные враги
            elite_goblin = {
                guaranteed = {
                    {itemId = "wood", minQuantity = 3, maxQuantity = 6},
                    {itemId = "stone", minQuantity = 2, maxQuantity = 4}
                },
                possible = {
                    {itemId = "iron", minQuantity = 1, maxQuantity = 3, chance = 60},
                    {itemId = "gold", minQuantity = 8, maxQuantity = 20, chance = 70},
                    {itemId = "health_potion", minQuantity = 2, maxQuantity = 3, chance = 50}
                },
                rare = {
                    {itemId = "goblin_chief_hat", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "stealth_potion", minQuantity = 1, maxQuantity = 1, chance = 10}
                }
            },
            
            elite_orc = {
                guaranteed = {
                    {itemId = "stone", minQuantity = 4, maxQuantity = 8},
                    {itemId = "iron", minQuantity = 2, maxQuantity = 4}
                },
                possible = {
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 2, chance = 40},
                    {itemId = "gold", minQuantity = 15, maxQuantity = 35, chance = 80},
                    {itemId = "strength_potion", minQuantity = 1, maxQuantity = 2, chance = 60}
                },
                rare = {
                    {itemId = "orc_warlord_armor", minQuantity = 1, maxQuantity = 1, chance = 3},
                    {itemId = "berserker_potion", minQuantity = 1, maxQuantity = 1, chance = 8}
                }
            },
            
            -- Боссы
            goblin_king = {
                guaranteed = {
                    {itemId = "wood", minQuantity = 10, maxQuantity = 20},
                    {itemId = "stone", minQuantity = 8, maxQuantity = 15},
                    {itemId = "iron", minQuantity = 5, maxQuantity = 10}
                },
                possible = {
                    {itemId = "crystal", minQuantity = 3, maxQuantity = 6, chance = 80},
                    {itemId = "gold", minQuantity = 50, maxQuantity = 100, chance = 100},
                    {itemId = "gems", minQuantity = 5, maxQuantity = 10, chance = 60}
                },
                rare = {
                    {itemId = "goblin_crown", minQuantity = 1, maxQuantity = 1, chance = 10},
                    {itemId = "king_potion", minQuantity = 1, maxQuantity = 2, chance = 20}
                },
                legendary = {
                    {itemId = "goblin_king_sword", minQuantity = 1, maxQuantity = 1, chance = 1},
                    {itemId = "goblin_king_armor", minQuantity = 1, maxQuantity = 1, chance = 1}
                }
            },
            
            dragon = {
                guaranteed = {
                    {itemId = "dragon_scale", minQuantity = 5, maxQuantity = 15},
                    {itemId = "gold", minQuantity = 200, maxQuantity = 500},
                    {itemId = "gems", minQuantity = 20, maxQuantity = 50}
                },
                possible = {
                    {itemId = "dragon_bone", minQuantity = 3, maxQuantity = 8, chance = 90},
                    {itemId = "dragon_heart", minQuantity = 1, maxQuantity = 2, chance = 50},
                    {itemId = "fire_potion", minQuantity = 2, maxQuantity = 5, chance = 80}
                },
                rare = {
                    {itemId = "dragon_wing", minQuantity = 1, maxQuantity = 2, chance = 30},
                    {itemId = "dragon_breath_potion", minQuantity = 1, maxQuantity = 1, chance = 25}
                },
                legendary = {
                    {itemId = "dragon_sword", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "dragon_armor", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "dragon_crown", minQuantity = 1, maxQuantity = 1, chance = 1}
                }
            }
        },
        
        -- Лут с ресурсных нод
        resource_loot = {
            -- Деревья
            oak_tree = {
                guaranteed = {{itemId = "oak_wood", minQuantity = 3, maxQuantity = 8}},
                possible = {
                    {itemId = "acorn", minQuantity = 1, maxQuantity = 3, chance = 40},
                    {itemId = "gold", minQuantity = 1, maxQuantity = 5, chance = 20}
                }
            },
            
            pine_tree = {
                guaranteed = {{itemId = "pine_wood", minQuantity = 2, maxQuantity = 6}},
                possible = {
                    {itemId = "pine_cone", minQuantity = 1, maxQuantity = 2, chance = 30},
                    {itemId = "gold", minQuantity = 1, maxQuantity = 3, chance = 15}
                }
            },
            
            -- Камни
            granite_rock = {
                guaranteed = {{itemId = "granite", minQuantity = 2, maxQuantity = 5}},
                possible = {
                    {itemId = "iron", minQuantity = 1, maxQuantity = 2, chance = 25},
                    {itemId = "gold", minQuantity = 2, maxQuantity = 6, chance = 20}
                }
            },
            
            crystal_formation = {
                guaranteed = {{itemId = "crystal", minQuantity = 1, maxQuantity = 3}},
                possible = {
                    {itemId = "gems", minQuantity = 1, maxQuantity = 2, chance = 15},
                    {itemId = "gold", minQuantity = 5, maxQuantity = 15, chance = 40}
                }
            },
            
            -- Редкие ресурсы
            gold_vein = {
                guaranteed = {{itemId = "gold_ore", minQuantity = 5, maxQuantity = 15}},
                possible = {
                    {itemId = "gems", minQuantity = 1, maxQuantity = 3, chance = 30},
                    {itemId = "gold", minQuantity = 10, maxQuantity = 25, chance = 60}
                }
            },
            
            gem_deposit = {
                guaranteed = {{itemId = "gems", minQuantity = 2, maxQuantity = 6}},
                possible = {
                    {itemId = "diamond", minQuantity = 1, maxQuantity = 1, chance = 10},
                    {itemId = "gold", minQuantity = 15, maxQuantity = 30, chance = 50}
                }
            }
        },
        
        -- Лут с сундуков
        chest_loot = {
            -- Обычные сундуки
            wooden_chest = {
                guaranteed = {{itemId = "gold", minQuantity = 5, maxQuantity = 15}},
                possible = {
                    {itemId = "health_potion", minQuantity = 1, maxQuantity = 2, chance = 60},
                    {itemId = "wood", minQuantity = 2, maxQuantity = 5, chance = 70},
                    {itemId = "stone", minQuantity = 1, maxQuantity = 3, chance = 50}
                }
            },
            
            iron_chest = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 15, maxQuantity = 35},
                    {itemId = "iron", minQuantity = 2, maxQuantity = 5}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 2, maxQuantity = 4, chance = 80},
                    {itemId = "mana_potion", minQuantity = 1, maxQuantity = 2, chance = 60},
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 2, chance = 40}
                },
                rare = {
                    {itemId = "sword", minQuantity = 1, maxQuantity = 1, chance = 20},
                    {itemId = "leather_armor", minQuantity = 1, maxQuantity = 1, chance = 15}
                }
            },
            
            -- Редкие сундуки
            crystal_chest = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 50, maxQuantity = 100},
                    {itemId = "gems", minQuantity = 3, maxQuantity = 8}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 3, maxQuantity = 6, chance = 90},
                    {itemId = "mana_potion", minQuantity = 2, maxQuantity = 4, chance = 80},
                    {itemId = "crystal", minQuantity = 2, maxQuantity = 5, chance = 70}
                },
                rare = {
                    {itemId = "bow", minQuantity = 1, maxQuantity = 1, chance = 40},
                    {itemId = "chain_armor", minQuantity = 1, maxQuantity = 1, chance = 35},
                    {itemId = "strength_potion", minQuantity = 1, maxQuantity = 2, chance = 50}
                }
            },
            
            -- Легендарные сундуки
            dragon_chest = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 200, maxQuantity = 400},
                    {itemId = "gems", minQuantity = 10, maxQuantity = 20},
                    {itemId = "dragon_scale", minQuantity = 2, maxQuantity = 5}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 5, maxQuantity = 10, chance = 100},
                    {itemId = "mana_potion", minQuantity = 3, maxQuantity = 6, chance = 90},
                    {itemId = "fire_potion", minQuantity = 2, maxQuantity = 4, chance = 70}
                },
                rare = {
                    {itemId = "dragon_sword", minQuantity = 1, maxQuantity = 1, chance = 15},
                    {itemId = "dragon_armor", minQuantity = 1, maxQuantity = 1, chance = 15},
                    {itemId = "dragon_breath_potion", minQuantity = 1, maxQuantity = 1, chance = 25}
                },
                legendary = {
                    {itemId = "dragon_crown", minQuantity = 1, maxQuantity = 1, chance = 2},
                    {itemId = "dragon_heart", minQuantity = 1, maxQuantity = 1, chance = 1}
                }
            }
        },
        
        -- Лут с волн
        wave_loot = {
            wave_5 = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 25, maxQuantity = 50},
                    {itemId = "gems", minQuantity = 1, maxQuantity = 3}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 2, maxQuantity = 4, chance = 100},
                    {itemId = "iron", minQuantity = 2, maxQuantity = 4, chance = 80},
                    {itemId = "crystal", minQuantity = 1, maxQuantity = 2, chance = 60}
                }
            },
            
            wave_10 = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 50, maxQuantity = 100},
                    {itemId = "gems", minQuantity = 3, maxQuantity = 6}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 3, maxQuantity = 6, chance = 100},
                    {itemId = "mana_potion", minQuantity = 2, maxQuantity = 4, chance = 100},
                    {itemId = "crystal", minQuantity = 2, maxQuantity = 5, chance = 80}
                },
                rare = {
                    {itemId = "sword", minQuantity = 1, maxQuantity = 1, chance = 30},
                    {itemId = "leather_armor", minQuantity = 1, maxQuantity = 1, chance = 25}
                }
            },
            
            wave_20 = {
                guaranteed = {
                    {itemId = "gold", minQuantity = 100, maxQuantity = 200},
                    {itemId = "gems", minQuantity = 5, maxQuantity = 10}
                },
                possible = {
                    {itemId = "health_potion", minQuantity = 5, maxQuantity = 10, chance = 100},
                    {itemId = "mana_potion", minQuantity = 3, maxQuantity = 6, chance = 100},
                    {itemId = "crystal", minQuantity = 4, maxQuantity = 8, chance = 100}
                },
                rare = {
                    {itemId = "bow", minQuantity = 1, maxQuantity = 1, chance = 50},
                    {itemId = "chain_armor", minQuantity = 1, maxQuantity = 1, chance = 40}
                },
                legendary = {
                    {itemId = "legendary_sword", minQuantity = 1, maxQuantity = 1, chance = 5},
                    {itemId = "legendary_armor", minQuantity = 1, maxQuantity = 1, chance = 5}
                }
            }
        }
    }
end

function AdvancedLootManager:InitializeLootPools()
    self.lootPools = {
        -- Пул лута для разных событий
        event_pools = {
            halloween = {
                guaranteed = {{itemId = "pumpkin", minQuantity = 1, maxQuantity = 3}},
                possible = {
                    {itemId = "ghost_essence", minQuantity = 1, maxQuantity = 2, chance = 60},
                    {itemId = "spooky_potion", minQuantity = 1, maxQuantity = 1, chance = 40}
                },
                rare = {
                    {itemId = "witch_hat", minQuantity = 1, maxQuantity = 1, chance = 10},
                    {itemId = "vampire_fang", minQuantity = 1, maxQuantity = 1, chance = 5}
                }
            },
            
            christmas = {
                guaranteed = {{itemId = "snowflake", minQuantity = 2, maxQuantity = 5}},
                possible = {
                    {itemId = "christmas_candy", minQuantity = 1, maxQuantity = 3, chance = 70},
                    {itemId = "hot_chocolate", minQuantity = 1, maxQuantity = 1, chance = 50}
                },
                rare = {
                    {itemId = "santa_hat", minQuantity = 1, maxQuantity = 1, chance = 15},
                    {itemId = "reindeer_antler", minQuantity = 1, maxQuantity = 1, chance = 8}
                }
            }
        },
        
        -- Пул лута для достижений
        achievement_pools = {
            first_kill = {
                guaranteed = {{itemId = "achievement_token", minQuantity = 1, maxQuantity = 1}},
                possible = {
                    {itemId = "gold", minQuantity = 10, maxQuantity = 25, chance = 100},
                    {itemId = "health_potion", minQuantity = 1, maxQuantity = 2, chance = 80}
                }
            },
            
            wave_master = {
                guaranteed = {
                    {itemId = "achievement_token", minQuantity = 1, maxQuantity = 1},
                    {itemId = "gems", minQuantity = 5, maxQuantity = 10}
                },
                possible = {
                    {itemId = "gold", minQuantity = 50, maxQuantity = 100, chance = 100},
                    {itemId = "legendary_core", minQuantity = 1, maxQuantity = 1, chance = 50}
                }
            }
        }
    }
end

function AdvancedLootManager:InitializeLootEffects()
    self.lootEffects = {
        -- Визуальные эффекты для разных типов лута
        visual_effects = {
            common = {
                particleColor = Color3.fromRGB(255, 255, 255),
                glowColor = Color3.fromRGB(200, 200, 200),
                sparkleEffect = false
            },
            uncommon = {
                particleColor = Color3.fromRGB(0, 255, 0),
                glowColor = Color3.fromRGB(0, 200, 0),
                sparkleEffect = true
            },
            rare = {
                particleColor = Color3.fromRGB(0, 100, 255),
                glowColor = Color3.fromRGB(0, 80, 200),
                sparkleEffect = true
            },
            epic = {
                particleColor = Color3.fromRGB(255, 0, 255),
                glowColor = Color3.fromRGB(200, 0, 200),
                sparkleEffect = true
            },
            legendary = {
                particleColor = Color3.fromRGB(255, 165, 0),
                glowColor = Color3.fromRGB(255, 140, 0),
                sparkleEffect = true
            }
        },
        
        -- Звуковые эффекты
        sound_effects = {
            common = "rbxassetid://common_loot_sound",
            uncommon = "rbxassetid://uncommon_loot_sound",
            rare = "rbxassetid://rare_loot_sound",
            epic = "rbxassetid://epic_loot_sound",
            legendary = "rbxassetid://legendary_loot_sound"
        }
    }
end

function AdvancedLootManager:InitializeLootAnimations()
    self.lootAnimations = {
        -- Анимации появления лута
        spawn_animations = {
            fade_in = function(lootObject)
                lootObject.Transparency = 1
                TweenService:Create(lootObject, TweenInfo.new(0.5), {
                    Transparency = 0
                }):Play()
            end,
            
            scale_up = function(lootObject)
                lootObject.Size = Vector3.new(0, 0, 0)
                TweenService:Create(lootObject, TweenInfo.new(0.3, Enum.EasingStyle.Bounce), {
                    Size = Vector3.new(1, 1, 1)
                }):Play()
            end,
            
            bounce = function(lootObject)
                local originalPosition = lootObject.Position
                lootObject.Position = originalPosition + Vector3.new(0, 5, 0)
                TweenService:Create(lootObject, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {
                    Position = originalPosition
                }):Play()
            end
        },
        
        -- Анимации сбора лута
        collect_animations = {
            fly_to_player = function(lootObject, player)
                local humanoidRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    TweenService:Create(lootObject, TweenInfo.new(0.5), {
                        Position = humanoidRootPart.Position
                    }):Play()
                end
            end,
            
            fade_out = function(lootObject)
                TweenService:Create(lootObject, TweenInfo.new(0.3), {
                    Transparency = 1
                }):Play()
            end,
            
            sparkle = function(lootObject)
                -- Создание эффекта искр при сборе
                local sparkle = Instance.new("Part")
                sparkle.Size = Vector3.new(0.1, 0.1, 0.1)
                sparkle.Position = lootObject.Position
                sparkle.Anchored = true
                sparkle.CanCollide = false
                sparkle.Material = Enum.Material.Neon
                sparkle.Color = Color3.fromRGB(255, 255, 0)
                sparkle.Parent = workspace
                
                TweenService:Create(sparkle, TweenInfo.new(1), {
                    Size = Vector3.new(0, 0, 0),
                    Transparency = 1
                }):Play()
                
                task.wait(1)
                sparkle:Destroy()
            end
        }
    }
end

-- Генерация расширенного лута
function AdvancedLootManager:GenerateAdvancedLoot(lootTableName, position, rarity, player)
    local lootTable = self.advancedLootTables[lootTableName]
    if not lootTable then
        warn("[AdvancedLootManager] Loot table not found:", lootTableName)
        return {}
    end
    
    local loot = {}
    rarity = rarity or "common"
    
    -- Применение бонусов игрока
    local playerData = ProfileService:GetPlayerData(player)
    local luckBonus = playerData.skills and playerData.skills.luck_boost or 0
    local goldBonus = playerData.skills and playerData.skills.gold_finder or 0
    
    -- Генерация гарантированного лута
    if lootTable.guaranteed then
        for _, item in pairs(lootTable.guaranteed) do
            local quantity = math.random(item.minQuantity, item.maxQuantity)
            
            -- Применение бонусов
            if item.itemId == "gold" then
                quantity = math.floor(quantity * (1 + goldBonus / 100))
            end
            
            table.insert(loot, {
                itemId = item.itemId,
                quantity = quantity,
                quality = "common",
                position = position
            })
        end
    end
    
    -- Генерация возможного лута
    if lootTable.possible then
        for _, item in pairs(lootTable.possible) do
            local chance = item.chance + luckBonus
            if math.random(1, 100) <= chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                
                -- Применение бонусов
                if item.itemId == "gold" then
                    quantity = math.floor(quantity * (1 + goldBonus / 100))
                end
                
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "uncommon",
                    position = position
                })
            end
        end
    end
    
    -- Генерация редкого лута
    if lootTable.rare then
        for _, item in pairs(lootTable.rare) do
            local chance = item.chance + luckBonus
            if math.random(1, 100) <= chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "rare",
                    position = position
                })
            end
        end
    end
    
    -- Генерация легендарного лута
    if lootTable.legendary then
        for _, item in pairs(lootTable.legendary) do
            local chance = item.chance + luckBonus
            if math.random(1, 100) <= chance then
                local quantity = math.random(item.minQuantity, item.maxQuantity)
                table.insert(loot, {
                    itemId = item.itemId,
                    quantity = quantity,
                    quality = "legendary",
                    position = position
                })
            end
        end
    end
    
    return loot
end

-- Создание физического лута с эффектами
function AdvancedLootManager:CreatePhysicalLootWithEffects(loot, position)
    for _, lootData in pairs(loot) do
        local lootPart = Instance.new("Part")
        lootPart.Size = Vector3.new(1, 1, 1)
        lootPart.Position = position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))
        lootPart.Anchored = true
        lootPart.CanCollide = false
        lootPart.Material = Enum.Material.Neon
        lootPart.Parent = workspace
        
        -- Применение визуальных эффектов
        local effects = self.lootEffects.visual_effects[lootData.quality]
        if effects then
            lootPart.Color = effects.particleColor
            
            -- Создание свечения
            local pointLight = Instance.new("PointLight")
            pointLight.Color = effects.glowColor
            pointLight.Range = 5
            pointLight.Brightness = 2
            pointLight.Parent = lootPart
            
            -- Создание частиц
            local particleEmitter = Instance.new("ParticleEmitter")
            particleEmitter.Color = ColorSequence.new(effects.particleColor)
            particleEmitter.Size = NumberSequence.new(0.1, 0)
            particleEmitter.Speed = NumberRange.new(2, 5)
            particleEmitter.Rate = 10
            particleEmitter.Lifetime = NumberRange.new(1, 2)
            particleEmitter.Parent = lootPart
            
            -- Эффект искр для редких предметов
            if effects.sparkleEffect then
                local sparkle = Instance.new("Sparkles")
                sparkle.SparkleColor = effects.particleColor
                sparkle.Parent = lootPart
            end
        end
        
        -- Создание UI для лута
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 100, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.Parent = lootPart
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = lootData.itemId .. " x" .. lootData.quantity
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = billboardGui
        
        -- Анимация появления
        self.lootAnimations.spawn_animations.fade_in(lootPart)
        self.lootAnimations.spawn_animations.scale_up(lootPart)
        self.lootAnimations.spawn_animations.bounce(lootPart)
        
        -- Сохранение данных лута
        lootPart:SetAttribute("LootData", lootData)
        lootPart:SetAttribute("Quality", lootData.quality)
        
        -- Подключение события сбора
        lootPart.Touched:Connect(function(hit)
            local character = hit.Parent
            local player = game.Players:GetPlayerFromCharacter(character)
            
            if player then
                self:CollectLootWithEffects(player, lootPart, lootData)
            end
        end)
        
        -- Автоматическое исчезновение через время
        task.spawn(function()
            task.wait(60) -- 60 секунд
            if lootPart and lootPart.Parent then
                self.lootAnimations.collect_animations.fade_out(lootPart)
                task.wait(0.3)
                lootPart:Destroy()
            end
        end)
    end
end

-- Сбор лута с эффектами
function AdvancedLootManager:CollectLootWithEffects(player, lootPart, lootData)
    if not lootPart or not lootPart.Parent then return end
    
    -- Анимация сбора
    self.lootAnimations.collect_animations.fly_to_player(lootPart, player)
    self.lootAnimations.collect_animations.sparkle(lootPart)
    
    task.wait(0.5)
    
    -- Добавление предмета игроку
    if lootData.itemId == "gold" then
        EconomyManager:AddCurrency(player, "gold", lootData.quantity, "Сбор лута")
    elseif lootData.itemId == "gems" then
        EconomyManager:AddCurrency(player, "gems", lootData.quantity, "Сбор лута")
    else
        InventoryManager:AddItem(player, lootData.itemId, lootData.quantity)
    end
    
    -- Уведомление игрока
    local qualityColors = {
        common = Color3.fromRGB(255, 255, 255),
        uncommon = Color3.fromRGB(0, 255, 0),
        rare = Color3.fromRGB(0, 100, 255),
        epic = Color3.fromRGB(255, 0, 255),
        legendary = Color3.fromRGB(255, 165, 0)
    }
    
    local color = qualityColors[lootData.quality] or Color3.fromRGB(255, 255, 255)
    local message = "Получен " .. lootData.itemId .. " x" .. lootData.quantity
    
    -- Отправка уведомления
    local showNotification = ReplicatedStorage.Remotes.UI.ShowNotification
    showNotification:FireClient(player, message, "success", 3)
    
    -- Удаление лута
    lootPart:Destroy()
end

return AdvancedLootManager