# Nexus Siege - Быстрый старт

## 🚀 Запуск за 5 минут

### 1. Установка Rojo
```bash
# Windows (Chocolatey)
choco install rojo

# macOS (Homebrew)
brew install rojo

# Linux
# Скачайте с https://github.com/rojo-rbx/rojo/releases
```

### 2. Запуск сервера разработки
```bash
# Windows
start.bat

# Linux/macOS
chmod +x start.sh
./start.sh

# Или вручную
rojo serve
```

### 3. Подключение к Roblox Studio
1. Откройте Roblox Studio
2. Создайте новое место (Place)
3. Установите плагин Rojo:
   - View → Plugins
   - Найдите "Rojo" и установите
4. В плагине Rojo нажмите "Connect"
5. Введите: `localhost:34872`

### 4. Тестирование
1. Нажмите "Play" в Studio
2. Выберите класс в игре
3. Используйте клавиши 1-4 для способностей
4. Нажмите B для меню строительства

## 🎮 Управление

### Клавиши:
- **1-4** - Использование способностей
- **B** - Меню строительства
- **Escape** - Закрыть все меню
- **Мышь** - Выбор и размещение построек

### Классы:
- **Воин** - Танк, контроль толпы
- **Инженер** - Строитель, поддержка
- **Шахтер** - Добытчик ресурсов

## 🛠️ Разработка

### Структура файлов:
```
src/
├── ServerScriptService/Core/GameController.lua    # Главный контроллер
├── ServerScriptService/Systems/ClassSystem/Classes/Warrior.lua  # Класс Воина
├── ReplicatedStorage/Modules/Shared/GameConstants.lua  # Константы
├── StarterPlayer/StarterPlayerScripts/Client/ClientMain.lua  # Клиент
└── StarterGui/  # Интерфейс
```

### Основные файлы для редактирования:
- **GameConstants.lua** - Игровые константы, баланс
- **Warrior.lua** - Способности воина
- **ClientMain.lua** - Клиентский интерфейс
- **GameController.lua** - Игровая логика

### Добавление новой способности:
1. Откройте файл класса (например, `Warrior.lua`)
2. Добавьте способность в таблицу `abilities`
3. Реализуйте функцию способности
4. Обновите UI в `ClientMain.lua`

## 🐛 Отладка

### Логи сервера:
- Output в Roblox Studio
- Ищите `[GameController]`, `[Warrior]`

### Логи клиента:
- Developer Console (F9)
- Ищите `[ClientMain]`

### Частые проблемы:
1. **Rojo не подключается** → Проверьте `rojo serve`
2. **Скрипты не работают** → Проверьте синтаксис Lua
3. **UI не отображается** → Проверьте папки в Studio

## 📝 Следующие шаги

### Фаза 1 (Текущая):
- [x] Базовая структура
- [x] Класс Воина
- [x] Основной UI
- [ ] Система волн
- [ ] Система ресурсов

### Что делать дальше:
1. Реализуйте систему волн врагов
2. Добавьте систему ресурсов
3. Создайте остальные классы
4. Добавьте систему строительства

## 📞 Помощь

- **GitHub Issues** - Для багов и предложений
- **README.md** - Полная документация
- **Discord** - [Ссылка на сервер]

---

**Удачной разработки! 🎮**