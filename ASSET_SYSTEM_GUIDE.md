# 🎨 Руководство по системе активов Nexus Siege

## 📋 Содержание
1. [Обзор системы](#обзор-системы)
2. [AssetManager - Управление активами](#assetmanager---управление-активами)
3. [CustomAssetLoader - Загрузка кастомных активов](#customassetloader---загрузка-кастомных-активов)
4. [ModelBuilder - Создание моделей](#modelbuilder---создание-моделей)
5. [TextureManager - Управление текстурами](#texturemanager---управление-текстурами)
6. [AssetEditor - Редактирование активов](#asseteditor---редактирование-активов)
7. [Примеры использования](#примеры-использования)
8. [Интеграция с игрой](#интеграция-с-игрой)

## 🎯 Обзор системы

Система активов Nexus Siege предоставляет полный набор инструментов для работы с:
- **Моделями** (враги, структуры, эффекты)
- **Текстурами** (материалы, цвета, паттерны)
- **Звуками** (эффекты, музыка)
- **Анимациями** (движение, трансформации)

### Архитектура системы:
```
Assets/
├── AssetManager.lua      # Основное управление активами
├── CustomAssetLoader.lua # Загрузка кастомных активов
├── ModelBuilder.lua      # Создание и редактирование моделей
├── TextureManager.lua    # Управление текстурами и материалами
└── AssetEditor.lua       # Интерактивный редактор
```

## 🎮 AssetManager - Управление активами

### Основные функции:

#### Создание моделей врагов
```lua
local enemy = AssetManager:CreateEnemy("Goblin", Vector3.new(0, 5, 0))
```

#### Создание структур
```lua
local tower = AssetManager:CreateStructure("ArcherTower", Vector3.new(10, 0, 10))
```

#### Создание эффектов
```lua
local explosion = AssetManager:CreateEffect("Explosion", Vector3.new(0, 0, 0))
```

#### Воспроизведение звуков
```lua
AssetManager:PlaySound("Attack", Vector3.new(0, 0, 0))
```

#### Применение текстур
```lua
AssetManager:ApplyTexture(part, "WoodTexture")
```

### Доступные типы активов:

#### Враги
- `Goblin` - Зеленый гоблин
- `Orc` - Красный орк
- `Troll` - Фиолетовый тролль
- `Dragon` - Оранжевый дракон
- `Skeleton` - Белый скелет
- `Demon` - Темно-красный демон

#### Структуры
- `WoodWall` - Деревянная стена
- `StoneWall` - Каменная стена
- `ReinforcedWall` - Укрепленная стена
- `ArcherTower` - Башня лучников
- `CatapultTower` - Башня катапульты
- `IceTower` - Ледяная башня
- `CrystalTower` - Кристальная башня

#### Эффекты
- `Explosion` - Взрыв
- `HealAura` - Аура исцеления
- `MagicBolt` - Магический снаряд
- `Shield` - Щит

## 🔄 CustomAssetLoader - Загрузка кастомных активов

### Настройка Asset ID:

```lua
-- В CustomAssetLoader.lua
self.assetIds = {
    enemies = {
        Goblin = 123456789, -- Замените на реальный ID
        Orc = 987654321,
        -- ...
    },
    structures = {
        WoodWall = 111222333,
        -- ...
    }
}
```

### Загрузка активов:

#### Загрузка всех активов
```lua
CustomAssetLoader:LoadAllAssets()
```

#### Загрузка по категории
```lua
CustomAssetLoader:LoadAssetsByCategory("enemies")
```

#### Асинхронная загрузка
```lua
CustomAssetLoader:LoadAssetsAsync()
```

#### Создание резервных моделей
```lua
CustomAssetLoader:CreateFallbackModels()
```

### Управление Asset ID:

```lua
-- Добавление нового Asset ID
CustomAssetLoader:AddAssetId("enemies", "NewEnemy", 999888777)

-- Удаление Asset ID
CustomAssetLoader:RemoveAssetId("enemies", "OldEnemy")

-- Сохранение конфигурации
local json = CustomAssetLoader:SaveAssetIdsToJson()

-- Загрузка конфигурации
CustomAssetLoader:LoadAssetIdsFromJson(jsonString)
```

## 🏗️ ModelBuilder - Создание моделей

### Создание моделей из шаблонов:

```lua
-- Создание врага из шаблона
local enemy = ModelBuilder:CreateModelFromTemplate("BasicEnemy", "enemies", Vector3.new(0, 5, 0))

-- Создание башни из шаблона
local tower = ModelBuilder:CreateModelFromTemplate("BasicTower", "structures", Vector3.new(10, 0, 10))
```

### Создание кастомных моделей:

```lua
local customModel = ModelBuilder:CreateCustomModel("MyModel", {
    body = {
        type = "Part",
        size = Vector3.new(2, 4, 1),
        color = Color3.fromRGB(255, 0, 0),
        material = Enum.Material.Plastic,
        position = Vector3.new(0, 2, 0)
    },
    head = {
        type = "Part",
        size = Vector3.new(1, 1, 1),
        color = Color3.fromRGB(255, 200, 200),
        material = Enum.Material.Plastic,
        position = Vector3.new(0, 4.5, 0)
    }
}, Vector3.new(0, 0, 0))
```

### Создание составных моделей:

```lua
local compositeModel = ModelBuilder:CreateCompositeModel("ComplexTower", {
    base = {
        template = "BasicTower",
        category = "structures",
        offset = Vector3.new(0, 0, 0)
    },
    flag = {
        template = "Flag",
        category = "decorations",
        offset = Vector3.new(0, 15, 0)
    }
}, Vector3.new(0, 0, 0))
```

### Редактирование моделей:

```lua
ModelBuilder:EditModel(model, {
    parts = {
        body = {
            size = Vector3.new(3, 5, 2),
            color = Color3.fromRGB(0, 255, 0)
        }
    },
    humanoid = {
        maxHealth = 200,
        health = 200
    }
})
```

### Доступные шаблоны:

#### Враги
- `BasicEnemy` - Базовый враг с телом и головой
- `FlyingEnemy` - Летающий враг с крыльями

#### Структуры
- `BasicTower` - Базовая башня (основание, башня, верхушка)
- `Wall` - Простая стена

#### Эффекты
- `Explosion` - Анимированный взрыв
- `MagicAura` - Пульсирующая магическая аура

## 🎨 TextureManager - Управление текстурами

### Применение текстур:

```lua
-- Применение текстуры к объекту
TextureManager:ApplyTexture(part, "Oak", "Wood")

-- Применение материала
TextureManager:ApplyMaterial(part, "Metal", "Basic")
```

### Создание кастомных текстур:

```lua
local customTexture = TextureManager:CreateCustomTexture("MyTexture", {
    textureId = "rbxassetid://123456789",
    color = Color3.fromRGB(255, 0, 0),
    transparency = 0.3
})
```

### Создание анимированных текстур:

```lua
local animatedTexture = TextureManager:CreateAnimatedTexture("PulsingTexture", {
    colorAnimation = {
        from = Color3.fromRGB(255, 0, 0),
        to = Color3.fromRGB(0, 0, 255)
    },
    duration = 2
})
```

### Создание градиентных текстур:

```lua
local gradientTexture = TextureManager:CreateGradientTexture("RainbowGradient", {
    Color3.fromRGB(255, 0, 0),
    Color3.fromRGB(0, 255, 0),
    Color3.fromRGB(0, 0, 255)
})
```

### Доступные текстуры:

#### Дерево
- `Oak` - Дуб
- `Pine` - Сосна
- `DarkWood` - Темное дерево

#### Камень
- `Granite` - Гранит
- `Marble` - Мрамор
- `Obsidian` - Обсидиан

#### Металл
- `Iron` - Железо
- `Gold` - Золото
- `Steel` - Сталь

#### Магия
- `Crystal` - Кристалл
- `Ice` - Лед
- `Fire` - Огонь

#### Природа
- `Grass` - Трава
- `Dirt` - Земля
- `Water` - Вода

## ✏️ AssetEditor - Редактирование активов

### Создание редактора моделей:

```lua
local editor = AssetEditor:CreateModelEditor()
```

### Создание модели с редактором:

```lua
local model, editor = AssetEditor:CreateModelWithEditor("BasicEnemy", "enemies", Vector3.new(0, 5, 0))
```

### Редактирование существующей модели:

```lua
local editor = AssetEditor:EditExistingModel(existingModel)
```

### Инструменты редактора:

```lua
-- Перемещение
editor.tools.move(part, Vector3.new(10, 5, 0))

-- Изменение размера
editor.tools.resize(part, Vector3.new(3, 6, 2))

-- Поворот
editor.tools.rotate(part, Vector3.new(0, 45, 0))

-- Изменение цвета
editor.tools.color(part, Color3.fromRGB(0, 255, 0))

-- Изменение материала
editor.tools.material(part, Enum.Material.Metal)
```

### Массовое редактирование:

```lua
AssetEditor:BatchEditObjects({part1, part2, part3}, function(part)
    part.Color = Color3.fromRGB(255, 0, 0)
    part.Material = Enum.Material.Neon
end)
```

### История изменений:

```lua
-- Отмена последнего действия
AssetEditor:Undo()

-- Получение статистики
local stats = AssetEditor:GetEditorStats()
print("История изменений:", stats.historySize)
```

### Экспорт и импорт:

```lua
-- Экспорт модели
local exportData = AssetEditor:ExportModel(model)

-- Импорт модели
local importedModel = AssetEditor:ImportModel(exportData, Vector3.new(0, 0, 0))
```

## 💡 Примеры использования

### Создание кастомного врага:

```lua
-- Создание модели
local enemyModel = ModelBuilder:CreateCustomModel("CustomGoblin", {
    body = {
        type = "Part",
        size = Vector3.new(2, 4, 1),
        color = Color3.fromRGB(0, 255, 0),
        material = Enum.Material.Plastic,
        position = Vector3.new(0, 2, 0)
    },
    head = {
        type = "Part",
        size = Vector3.new(1, 1, 1),
        color = Color3.fromRGB(255, 200, 200),
        material = Enum.Material.Plastic,
        position = Vector3.new(0, 4.5, 0)
    }
}, Vector3.new(0, 5, 0))

-- Применение текстур
TextureManager:ApplyTexture(enemyModel.body, "Oak", "Wood")
TextureManager:ApplyMaterial(enemyModel.head, "Neon", "Special")

-- Создание редактора для дальнейшего редактирования
local editor = AssetEditor:EditExistingModel(enemyModel)
```

### Создание анимированной башни:

```lua
-- Создание башни
local tower = ModelBuilder:CreateModelFromTemplate("BasicTower", "structures", Vector3.new(10, 0, 10))

-- Применение анимации
AssetEditor:ApplyPartAnimation(tower.top, {
    rotation = Vector3.new(0, 360, 0),
    duration = 5
})

-- Применение эффектов
local aura = AssetManager:CreateEffect("MagicAura", tower.PrimaryPart.Position)
aura.Parent = tower
```

### Создание градиентной стены:

```lua
-- Создание стены
local wall = ModelBuilder:CreateModelFromTemplate("Wall", "structures", Vector3.new(0, 0, 0))

-- Создание градиентной текстуры
local gradientTexture = TextureManager:CreateGradientTexture("WallGradient", {
    Color3.fromRGB(139, 69, 19),
    Color3.fromRGB(160, 82, 45)
})

-- Применение текстуры
TextureManager:ApplyTexture(wall.wall, gradientTexture.Name, "Custom")
```

## 🎮 Интеграция с игрой

### Инициализация в GameController:

```lua
-- В GameController:Initialize()
AssetManager:Initialize()
CustomAssetLoader:Initialize()
ModelBuilder:Initialize()
TextureManager:Initialize()
AssetEditor:Initialize()

-- Загрузка кастомных активов
CustomAssetLoader:LoadAssetsAsync()
CustomAssetLoader:CreateFallbackModels()
```

### Использование в EnemyManager:

```lua
-- Создание врага с кастомной моделью
local enemyModel = AssetManager:CreateEnemy(enemyType, spawnPoint)
if not enemyModel then
    -- Создание резервной модели
    enemyModel = ModelBuilder:CreateModelFromTemplate("BasicEnemy", "enemies", spawnPoint)
end
```

### Использование в BuildManager:

```lua
-- Создание структуры с кастомной моделью
local structureModel = AssetManager:CreateStructure(structureType, position)
if not structureModel then
    -- Создание резервной модели
    structureModel = ModelBuilder:CreateModelFromTemplate("BasicTower", "structures", position)
end
```

### Использование в CombatManager:

```lua
-- Создание эффектов атаки
local attackEffect = AssetManager:CreateEffect("Explosion", targetPosition)
AssetManager:PlaySound("Attack", targetPosition)
```

## 🔧 Настройка и кастомизация

### Добавление новых Asset ID:

1. Найдите нужные модели в Roblox Asset Library
2. Скопируйте Asset ID
3. Добавьте в `CustomAssetLoader.lua`:

```lua
self.assetIds.enemies.NewEnemy = 123456789
```

### Создание новых шаблонов:

1. Создайте модель в Roblox Studio
2. Экспортируйте через `AssetEditor:ExportModel()`
3. Добавьте в `ModelBuilder.templates`:

```lua
self.templates.enemies.NewEnemy = {
    parts = {
        -- данные частей
    },
    humanoid = true,
    weldConnections = {
        -- соединения
    }
}
```

### Создание новых текстур:

1. Добавьте в `TextureManager.textures`:

```lua
self.textures.Wood.NewWood = {
    color = Color3.fromRGB(100, 50, 0),
    material = Enum.Material.Wood,
    roughness = 0.8
}
```

## 📊 Производительность

### Оптимизация загрузки:

- Используйте `LoadAssetsAsync()` для асинхронной загрузки
- Создавайте резервные модели для критически важных активов
- Кэшируйте часто используемые модели

### Управление памятью:

- Очищайте неиспользуемые активы
- Используйте `AssetManager:ClearCache()`
- Ограничивайте размер истории изменений

### Мониторинг:

```lua
-- Получение статистики активов
local availableAssets = AssetManager:GetAvailableAssets()
local loadedAssets = CustomAssetLoader:GetLoadedAssetsList()
local editorStats = AssetEditor:GetEditorStats()
```

## 🎯 Заключение

Система активов Nexus Siege предоставляет мощные инструменты для создания и управления визуальными элементами игры. Используйте эти инструменты для создания уникальных и привлекательных моделей, текстур и эффектов, которые сделают вашу игру более интересной и визуально привлекательной.

### Основные преимущества:

- ✅ **Гибкость** - Создание кастомных моделей и текстур
- ✅ **Производительность** - Асинхронная загрузка и кэширование
- ✅ **Удобство** - Интерактивный редактор с историей изменений
- ✅ **Интеграция** - Полная совместимость с игровыми системами
- ✅ **Расширяемость** - Легкое добавление новых активов

Используйте эту систему для создания потрясающих визуальных эффектов и уникального игрового опыта! 🚀