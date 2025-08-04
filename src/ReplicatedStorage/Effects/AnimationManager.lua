-- AnimationManager.lua
-- Полная система управления анимациями и визуальными эффектами

local AnimationManager = {}
AnimationManager.__index = AnimationManager

-- Импорт зависимостей
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Состояние
AnimationManager.animations = {}
AnimationManager.effects = {}
AnimationManager.activeAnimations = {}
AnimationManager.particleSystems = {}

function AnimationManager:Initialize()
    print("[AnimationManager] Initializing animation system...")
    
    -- Создание анимаций
    self:CreateAnimations()
    
    -- Создание эффектов
    self:CreateEffects()
    
    -- Создание систем частиц
    self:CreateParticleSystems()
    
    print("[AnimationManager] Animation system initialized!")
end

-- Создание анимаций
function AnimationManager:CreateAnimations()
    self.animations = {
        -- Анимации боя
        combat = {
            attack = {
                duration = 0.5,
                properties = {
                    Size = Vector3.new(1.2, 1.2, 1.2),
                    Transparency = 0.3
                }
            },
            block = {
                duration = 0.3,
                properties = {
                    Color = Color3.fromRGB(0, 255, 255),
                    Transparency = 0.5
                }
            },
            dodge = {
                duration = 0.4,
                properties = {
                    Transparency = 0.7,
                    Position = Vector3.new(0, 2, 0)
                }
            }
        },
        
        -- Анимации способностей
        abilities = {
            warrior_attack = {
                duration = 1.0,
                properties = {
                    Size = Vector3.new(2, 2, 2),
                    Color = Color3.fromRGB(255, 0, 0),
                    Transparency = 0.8
                }
            },
            engineer_build = {
                duration = 2.0,
                properties = {
                    Size = Vector3.new(1.5, 1.5, 1.5),
                    Color = Color3.fromRGB(0, 255, 0),
                    Transparency = 0.6
                }
            },
            heal = {
                duration = 1.5,
                properties = {
                    Size = Vector3.new(3, 3, 3),
                    Color = Color3.fromRGB(0, 255, 0),
                    Transparency = 0.7
                }
            }
        },
        
        -- Анимации UI
        ui = {
            button_hover = {
                duration = 0.2,
                properties = {
                    BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                }
            },
            button_click = {
                duration = 0.1,
                properties = {
                    Size = UDim2.new(0.95, 0, 0.95, 0)
                }
            },
            notification_appear = {
                duration = 0.5,
                properties = {
                    Position = UDim2.new(0.3, 0, 0.05, 0),
                    BackgroundTransparency = 0.2
                }
            }
        },
        
        -- Анимации врагов
        enemies = {
            spawn = {
                duration = 1.0,
                properties = {
                    Size = Vector3.new(1, 1, 1),
                    Transparency = 0
                }
            },
            death = {
                duration = 0.8,
                properties = {
                    Size = Vector3.new(0.5, 0.5, 0.5),
                    Transparency = 1
                }
            },
            damage = {
                duration = 0.3,
                properties = {
                    Color = Color3.fromRGB(255, 0, 0),
                    Transparency = 0.5
                }
            }
        }
    }
end

-- Создание эффектов
function AnimationManager:CreateEffects()
    self.effects = {
        -- Эффекты взрыва
        explosion = {
            duration = 2.0,
            particleCount = 50,
            particleSpeed = 20,
            particleLifetime = 2.0,
            colors = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0)},
            sizes = {Vector3.new(0.5, 0.5, 0.5), Vector3.new(0.1, 0.1, 0.1)}
        },
        
        -- Эффекты исцеления
        healing = {
            duration = 3.0,
            particleCount = 30,
            particleSpeed = 5,
            particleLifetime = 3.0,
            colors = {Color3.fromRGB(0, 255, 0), Color3.fromRGB(255, 255, 255)},
            sizes = {Vector3.new(0.3, 0.3, 0.3), Vector3.new(0.05, 0.05, 0.05)}
        },
        
        -- Эффекты магии
        magic = {
            duration = 4.0,
            particleCount = 40,
            particleSpeed = 8,
            particleLifetime = 4.0,
            colors = {Color3.fromRGB(138, 43, 226), Color3.fromRGB(255, 255, 255)},
            sizes = {Vector3.new(0.4, 0.4, 0.4), Vector3.new(0.08, 0.08, 0.08)}
        },
        
        -- Эффекты строительства
        building = {
            duration = 2.5,
            particleCount = 25,
            particleSpeed = 3,
            particleLifetime = 2.5,
            colors = {Color3.fromRGB(139, 69, 19), Color3.fromRGB(128, 128, 128)},
            sizes = {Vector3.new(0.2, 0.2, 0.2), Vector3.new(0.05, 0.05, 0.05)}
        }
    }
end

-- Создание систем частиц
function AnimationManager:CreateParticleSystems()
    self.particleSystems = {
        -- Система огня
        fire = {
            emitter = {
                Rate = 100,
                Lifetime = NumberRange.new(1, 2),
                Speed = NumberRange.new(5, 10),
                SpreadAngle = Vector2.new(30, 30),
                Color = ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 165, 0)),
                Size = NumberSequence.new(0.5, 0),
                Transparency = NumberSequence.new(0.5, 1)
            }
        },
        
        -- Система дыма
        smoke = {
            emitter = {
                Rate = 50,
                Lifetime = NumberRange.new(3, 5),
                Speed = NumberRange.new(2, 5),
                SpreadAngle = Vector2.new(45, 45),
                Color = ColorSequence.new(Color3.fromRGB(100, 100, 100)),
                Size = NumberSequence.new(1, 3),
                Transparency = NumberSequence.new(0.3, 1)
            }
        },
        
        -- Система искр
        sparks = {
            emitter = {
                Rate = 200,
                Lifetime = NumberRange.new(0.5, 1),
                Speed = NumberRange.new(15, 25),
                SpreadAngle = Vector2.new(360, 360),
                Color = ColorSequence.new(Color3.fromRGB(255, 255, 0)),
                Size = NumberSequence.new(0.1, 0),
                Transparency = NumberSequence.new(0.8, 1)
            }
        }
    }
end

-- Применение анимации к объекту
function AnimationManager:PlayAnimation(object, animationType, category, callback)
    if not object then return end
    
    local animation = self.animations[category] and self.animations[category][animationType]
    if not animation then
        warn("[AnimationManager] Animation not found:", category, animationType)
        return
    end
    
    local tweenInfo = TweenInfo.new(animation.duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, animation.properties)
    
    -- Сохранение оригинальных свойств
    local originalProperties = {}
    for property, _ in pairs(animation.properties) do
        if object[property] then
            originalProperties[property] = object[property]
        end
    end
    
    -- Восстановление свойств после анимации
    tween.Completed:Connect(function()
        for property, value in pairs(originalProperties) do
            if object and object[property] then
                object[property] = value
            end
        end
        
        if callback then
            callback()
        end
    end)
    
    tween:Play()
    
    -- Сохранение активной анимации
    table.insert(self.activeAnimations, {
        object = object,
        tween = tween,
        type = animationType,
        category = category
    })
    
    return tween
end

-- Создание эффекта частиц
function AnimationManager:CreateParticleEffect(effectType, position, duration)
    local effect = self.effects[effectType]
    if not effect then
        warn("[AnimationManager] Effect not found:", effectType)
        return
    end
    
    local effectPart = Instance.new("Part")
    effectPart.Name = effectType .. "Effect"
    effectPart.Position = position
    effectPart.Size = Vector3.new(1, 1, 1)
    effectPart.Anchored = true
    effectPart.CanCollide = false
    effectPart.Transparency = 1
    effectPart.Parent = workspace
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Parent = effectPart
    
    -- Настройка эмиттера
    particleEmitter.Rate = effect.particleCount
    particleEmitter.Lifetime = NumberRange.new(effect.particleLifetime, effect.particleLifetime)
    particleEmitter.Speed = NumberRange.new(effect.particleSpeed, effect.particleSpeed)
    particleEmitter.SpreadAngle = Vector2.new(360, 360)
    
    -- Настройка цветов
    local colorSequence = ColorSequence.new(effect.colors)
    particleEmitter.Color = colorSequence
    
    -- Настройка размеров
    local sizeSequence = NumberSequence.new(effect.sizes[1].X, effect.sizes[2].X)
    particleEmitter.Size = sizeSequence
    
    -- Настройка прозрачности
    local transparencySequence = NumberSequence.new(0.5, 1)
    particleEmitter.Transparency = transparencySequence
    
    -- Автоматическое удаление
    task.wait(duration or effect.duration)
    particleEmitter.Enabled = false
    task.wait(effect.particleLifetime)
    effectPart:Destroy()
    
    return effectPart
end

-- Создание системы частиц
function AnimationManager:CreateParticleSystem(systemType, position, parent)
    local system = self.particleSystems[systemType]
    if not system then
        warn("[AnimationManager] Particle system not found:", systemType)
        return
    end
    
    local part = Instance.new("Part")
    part.Name = systemType .. "System"
    part.Position = position
    part.Size = Vector3.new(1, 1, 1)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Parent = parent or workspace
    
    local particleEmitter = Instance.new("ParticleEmitter")
    particleEmitter.Parent = part
    
    -- Применение настроек системы
    for property, value in pairs(system.emitter) do
        particleEmitter[property] = value
    end
    
    return part, particleEmitter
end

-- Создание анимации движения
function AnimationManager:CreateMovementAnimation(object, targetPosition, duration, easingStyle, easingDirection)
    if not object then return end
    
    local tweenInfo = TweenInfo.new(duration or 1, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, {Position = targetPosition})
    
    tween:Play()
    return tween
end

-- Создание анимации вращения
function AnimationManager:CreateRotationAnimation(object, targetRotation, duration, easingStyle, easingDirection)
    if not object then return end
    
    local tweenInfo = TweenInfo.new(duration or 1, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, {Orientation = targetRotation})
    
    tween:Play()
    return tween
end

-- Создание анимации масштабирования
function AnimationManager:CreateScaleAnimation(object, targetScale, duration, easingStyle, easingDirection)
    if not object then return end
    
    local tweenInfo = TweenInfo.new(duration or 1, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, {Size = targetScale})
    
    tween:Play()
    return tween
end

-- Создание пульсирующей анимации
function AnimationManager:CreatePulseAnimation(object, minScale, maxScale, duration, loopCount)
    if not object then return end
    
    local originalSize = object.Size
    local pulseUp = TweenService:Create(object, TweenInfo.new(duration/2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = originalSize * maxScale
    })
    
    local pulseDown = TweenService:Create(object, TweenInfo.new(duration/2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = originalSize * minScale
    })
    
    pulseUp.Completed:Connect(function()
        pulseDown:Play()
    end)
    
    pulseDown.Completed:Connect(function()
        if loopCount and loopCount > 1 then
            loopCount = loopCount - 1
            pulseUp:Play()
        elseif loopCount == -1 then
            pulseUp:Play()
        end
    end)
    
    pulseUp:Play()
    
    return pulseUp, pulseDown
end

-- Создание анимации появления
function AnimationManager:CreateFadeInAnimation(object, duration, easingStyle, easingDirection)
    if not object then return end
    
    local originalTransparency = object.Transparency
    object.Transparency = 1
    
    local tweenInfo = TweenInfo.new(duration or 0.5, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.Out)
    local tween = TweenService:Create(object, tweenInfo, {Transparency = originalTransparency})
    
    tween:Play()
    return tween
end

-- Создание анимации исчезновения
function AnimationManager:CreateFadeOutAnimation(object, duration, easingStyle, easingDirection, callback)
    if not object then return end
    
    local tweenInfo = TweenInfo.new(duration or 0.5, easingStyle or Enum.EasingStyle.Quad, easingDirection or Enum.EasingDirection.In)
    local tween = TweenService:Create(object, tweenInfo, {Transparency = 1})
    
    tween.Completed:Connect(function()
        if callback then
            callback()
        end
    end)
    
    tween:Play()
    return tween
end

-- Создание анимации тряски
function AnimationManager:CreateShakeAnimation(object, intensity, duration, frequency)
    if not object then return end
    
    local originalPosition = object.Position
    local shakeCount = math.floor(duration * frequency)
    local shakeInterval = duration / shakeCount
    
    for i = 1, shakeCount do
        task.wait(shakeInterval)
        if object and object.Parent then
            local offset = Vector3.new(
                (math.random() - 0.5) * intensity,
                (math.random() - 0.5) * intensity,
                (math.random() - 0.5) * intensity
            )
            object.Position = originalPosition + offset
        end
    end
    
    if object and object.Parent then
        object.Position = originalPosition
    end
end

-- Создание анимации волны
function AnimationManager:CreateWaveAnimation(objects, property, startValue, endValue, duration, delay)
    if not objects or #objects == 0 then return end
    
    for i, object in ipairs(objects) do
        if object then
            local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
            local tween = TweenService:Create(object, tweenInfo, {[property] = endValue})
            
            task.wait(delay or (duration / #objects))
            tween:Play()
        end
    end
end

-- Создание анимации цепочки
function AnimationManager:CreateChainAnimation(objects, animationType, category, delay)
    if not objects or #objects == 0 then return end
    
    for i, object in ipairs(objects) do
        if object then
            self:PlayAnimation(object, animationType, category)
            task.wait(delay or 0.1)
        end
    end
end

-- Остановка всех анимаций объекта
function AnimationManager:StopObjectAnimations(object)
    for i = #self.activeAnimations, 1, -1 do
        local animation = self.activeAnimations[i]
        if animation.object == object then
            animation.tween:Cancel()
            table.remove(self.activeAnimations, i)
        end
    end
end

-- Остановка всех анимаций
function AnimationManager:StopAllAnimations()
    for _, animation in pairs(self.activeAnimations) do
        animation.tween:Cancel()
    end
    self.activeAnimations = {}
end

-- Получение информации об анимации
function AnimationManager:GetAnimationInfo(category, animationType)
    local animation = self.animations[category] and self.animations[category][animationType]
    if not animation then return nil end
    
    return {
        duration = animation.duration,
        properties = animation.properties
    }
end

-- Получение списка всех анимаций
function AnimationManager:GetAllAnimations()
    local allAnimations = {}
    
    for category, animations in pairs(self.animations) do
        allAnimations[category] = {}
        for animationType, animation in pairs(animations) do
            table.insert(allAnimations[category], {
                type = animationType,
                duration = animation.duration,
                properties = animation.properties
            })
        end
    end
    
    return allAnimations
end

-- Получение активных анимаций
function AnimationManager:GetActiveAnimations()
    local active = {}
    
    for _, animation in pairs(self.activeAnimations) do
        table.insert(active, {
            object = animation.object,
            type = animation.type,
            category = animation.category
        })
    end
    
    return active
end

-- Очистка системы анимаций
function AnimationManager:Cleanup()
    -- Остановка всех анимаций
    self:StopAllAnimations()
    
    -- Очистка систем частиц
    for _, system in pairs(self.particleSystems) do
        if system and system.Parent then
            system:Destroy()
        end
    end
    
    self.animations = {}
    self.effects = {}
    self.activeAnimations = {}
    self.particleSystems = {}
end

return AnimationManager