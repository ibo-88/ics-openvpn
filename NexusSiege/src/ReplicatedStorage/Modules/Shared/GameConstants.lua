-- GameConstants.lua
-- Основные константы игры Nexus Siege

local GameConstants = {}

-- Игровые фазы
GameConstants.Phases = {
    WAITING = "Waiting",
    PREPARATION = "Preparation",
    DAY = "Day",
    TRANSITION_TO_NIGHT = "TransitionToNight",
    NIGHT = "Night",
    INTERMISSION = "Intermission",
    VICTORY = "Victory",
    DEFEAT = "Defeat"
}

-- Длительности фаз (в секундах)
GameConstants.PhaseDurations = {
    PREPARATION = 30,
    DAY = 600, -- 10 минут
    TRANSITION_TO_NIGHT = 30,
    NIGHT_BASE = 300, -- 5 минут базовая
    NIGHT_PER_WAVE = 30, -- +30 секунд за каждую волну
    INTERMISSION = 120, -- 2 минуты
    VICTORY = 60,
    DEFEAT = 30
}

-- Максимальное количество игроков
GameConstants.MAX_PLAYERS = 30
GameConstants.MIN_PLAYERS_TO_START = 1 -- Для тестирования, потом изменить на 5

-- Количество волн
GameConstants.TOTAL_WAVES = 10

-- Нексус
GameConstants.NEXUS = {
    MAX_HEALTH = 10000,
    POSITION = Vector3.new(0, 20, 0),
    SIZE = Vector3.new(40, 40, 40)
}

-- Ресурсы
GameConstants.Resources = {
    WOOD = {
        name = "Wood",
        maxStack = 999,
        gatherTime = 2,
        toolRequired = "Axe",
        dropAmount = {min = 3, max = 7}
    },
    STONE = {
        name = "Stone",
        maxStack = 999,
        gatherTime = 3,
        toolRequired = "Pickaxe",
        dropAmount = {min = 2, max = 5}
    },
    CRYSTAL = {
        name = "Crystal",
        maxStack = 99,
        gatherTime = 5,
        toolRequired = "CrystalPick",
        dropAmount = {min = 1, max = 3}
    }
}

-- Классы
GameConstants.Classes = {
    WARRIOR = "Warrior",
    ENGINEER = "Engineer",
    MINER = "Miner"
}

-- Характеристики классов
GameConstants.ClassStats = {
    [GameConstants.Classes.WARRIOR] = {
        health = 200,
        damage = 30,
        armor = 20,
        speed = 14,
        attackSpeed = 1.5
    },
    [GameConstants.Classes.ENGINEER] = {
        health = 150,
        damage = 20,
        armor = 10,
        speed = 16,
        attackSpeed = 1.2
    },
    [GameConstants.Classes.MINER] = {
        health = 175,
        damage = 25,
        armor = 15,
        speed = 18,
        attackSpeed = 1.3
    }
}

-- Стены
GameConstants.Walls = {
    WOOD = {
        name = "WoodWall",
        health = 500,
        cost = {Wood = 20},
        buildTime = 2,
        size = Vector3.new(10, 10, 2)
    },
    STONE = {
        name = "StoneWall",
        health = 1500,
        cost = {Stone = 30, Wood = 10},
        buildTime = 3,
        requirement = "WoodWall",
        size = Vector3.new(10, 12, 3)
    },
    REINFORCED = {
        name = "ReinforcedWall",
        health = 3000,
        cost = {Stone = 50, Crystal = 5},
        buildTime = 5,
        requirement = "StoneWall",
        damageReduction = 0.2,
        size = Vector3.new(10, 15, 4)
    }
}

-- Башни
GameConstants.Towers = {
    ARCHER = {
        name = "ArcherTower",
        levels = {
            [1] = {
                damage = 25,
                attackSpeed = 1.5,
                range = 20,
                cost = {Wood = 50, Stone = 20},
                buildTime = 3
            },
            [2] = {
                damage = 40,
                attackSpeed = 1.2,
                range = 25,
                cost = {Wood = 100, Stone = 50, Crystal = 2},
                buildTime = 4
            },
            [3] = {
                damage = 60,
                attackSpeed = 1.0,
                range = 30,
                cost = {Stone = 150, Crystal = 10},
                buildTime = 5,
                special = "MultiShot"
            }
        }
    },
    CATAPULT = {
        name = "CatapultTower",
        levels = {
            [1] = {
                damage = 40,
                attackSpeed = 0.8,
                range = 25,
                cost = {Wood = 80, Stone = 40},
                buildTime = 4,
                special = "AOE"
            }
        }
    },
    ICE = {
        name = "IceTower",
        levels = {
            [1] = {
                damage = 15,
                attackSpeed = 1.0,
                range = 18,
                cost = {Wood = 60, Crystal = 5},
                buildTime = 3,
                special = "Slow"
            }
        }
    },
    CRYSTAL = {
        name = "CrystalTower",
        levels = {
            [1] = {
                damage = 30,
                attackSpeed = 1.3,
                range = 22,
                cost = {Stone = 70, Crystal = 10},
                buildTime = 4,
                special = "Magic"
            }
        }
    }
}

-- Враги
GameConstants.Enemies = {
    GHOUL = {
        name = "Гнилец",
        health = 100,
        damage = 10,
        speed = 8,
        attackSpeed = 2,
        reward = 5,
        weakTo = "Physical"
    },
    RUNNER = {
        name = "Бегун",
        health = 50,
        damage = 5,
        speed = 20,
        attackSpeed = 1,
        reward = 7,
        ability = "Dodge"
    },
    BRUTE = {
        name = "Брут",
        health = 500,
        damage = 50,
        speed = 6,
        attackSpeed = 3,
        reward = 20,
        ability = "SiegeMode",
        weakTo = "Magic"
    },
    GHOST = {
        name = "Призрак",
        health = 200,
        damage = 20,
        speed = 12,
        attackSpeed = 1.5,
        reward = 15,
        ability = "Flying",
        weakTo = "Crystal"
    },
    BOMBER = {
        name = "Подрывник",
        health = 150,
        damage = 100,
        speed = 10,
        reward = 25,
        ability = "Explode",
        explosionRadius = 10
    },
    HEALER = {
        name = "Целитель",
        health = 300,
        damage = 5,
        speed = 8,
        reward = 30,
        ability = "HealAura",
        priority = "High"
    }
}

-- Точки спавна врагов
GameConstants.EnemySpawns = {
    NORTH = {
        position = Vector3.new(0, 0, -900),
        pathNodes = {
            Vector3.new(0, 0, -700),
            Vector3.new(-100, 0, -500),
            Vector3.new(0, 0, -300),
            Vector3.new(0, 0, -100)
        }
    },
    EAST = {
        position = Vector3.new(900, 0, 0),
        pathNodes = {
            Vector3.new(700, 0, 0),
            Vector3.new(500, 0, 100),
            Vector3.new(300, 0, 0),
            Vector3.new(100, 0, 0)
        }
    },
    SOUTH = {
        position = Vector3.new(0, 0, 900),
        pathNodes = {
            Vector3.new(0, 0, 700),
            Vector3.new(100, 0, 500),
            Vector3.new(0, 0, 300),
            Vector3.new(0, 0, 100)
        }
    },
    WEST = {
        position = Vector3.new(-900, 0, 0),
        pathNodes = {
            Vector3.new(-700, 0, 0),
            Vector3.new(-500, 0, -100),
            Vector3.new(-300, 0, 0),
            Vector3.new(-100, 0, 0)
        }
    }
}

-- Зоны ресурсов
GameConstants.ResourceZones = {
    FOREST = {
        center = Vector3.new(-500, 0, -500),
        radius = 200,
        resourceType = "Wood",
        respawnTime = 120
    },
    QUARRY = {
        center = Vector3.new(500, 0, -500),
        radius = 150,
        resourceType = "Stone",
        respawnTime = 180
    },
    CRYSTAL_CAVES = {
        center = Vector3.new(0, 0, 800),
        radius = 100,
        resourceType = "Crystal",
        respawnTime = 300
    }
}

-- Зоны строительства
GameConstants.BuildableAreas = {
    INNER = {
        radius = 150,
        maxWalls = 40,
        maxTowers = 20
    },
    MIDDLE = {
        radius = 300,
        maxWalls = 60,
        maxTowers = 30
    },
    OUTER = {
        radius = 450,
        maxWalls = 80,
        maxTowers = 40
    }
}

-- Анти-чит константы
GameConstants.AntiCheat = {
    MAX_SPEED = 25,
    MAX_JUMP_POWER = 50,
    MAX_ATTACK_RANGE = 50,
    TELEPORT_THRESHOLD = 100,
    ACTIONS_PER_SECOND = 10,
    MAX_RESOURCES_PER_GATHER = 10
}

-- Цвета UI
GameConstants.Colors = {
    DAY = {
        primary = Color3.fromRGB(135, 206, 235), -- небесно-голубой
        secondary = Color3.fromRGB(144, 238, 144), -- светло-зеленый
        accent = Color3.fromRGB(255, 215, 0) -- золотой
    },
    NIGHT = {
        primary = Color3.fromRGB(25, 25, 112), -- полуночно-синий
        secondary = Color3.fromRGB(139, 0, 139), -- темно-пурпурный
        accent = Color3.fromRGB(255, 165, 0) -- оранжевый
    }
}

return GameConstants