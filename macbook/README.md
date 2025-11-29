# macOS Configuration for Canary Layout

Конфигурация для использования Canary раскладки на MacBook.

## Компоненты

### 1. Canary Keyboard Layout (`canary.keylayout`)

Файл раскладки для macOS, созданный в Ukelele. Устанавливает базовый маппинг клавиш в стиле Canary.

**Установка:**

1. Скопировать `canary.keylayout` в одну из директорий:
   - `~/Library/Keyboard Layouts/` (только для текущего пользователя)
   - `/Library/Keyboard Layouts/` (для всех пользователей, требует sudo)

2. Перезагрузить систему или выйти/войти

3. System Settings → Keyboard → Input Sources → + → English → Canary

### 2. Karabiner-Elements NAV Layer + Sticky Modifiers (`karabiner-canary-mods.json`)

Complex modifications для Karabiner-Elements, реализующие NAV слой и one-shot (sticky) модификаторы в стиле Callum mods.

**Что делает:**

**NAV Layer (левый Command):**
- **Hold левый Cmd** → активирует NAV слой
- **Tap левый Cmd** → sticky Command (one-shot)
- В NAV слое (при удержании левого Cmd):
  - `A` → sticky Command (с таймаутом 2с)
  - `S` → sticky Option (с таймаутом 2с)
  - `D` → sticky Control (с таймаутом 2с)
  - `F` → sticky Shift (с таймаутом 2с)
  - `J/K/L/I` → стрелки влево/вниз/вправо/вверх
  - `O` → Backspace
  - `P` → Delete
  - `;` → Enter
  - `G` → Tab
  - `Q` → Escape

**Sticky Modifiers:**
- Все sticky модификаторы автоматически отключаются через **2 секунды** после активации
- Если не нажать другую клавишу за это время, модификатор сбросится
- Можно отменить sticky modifier досрочно, нажав его повторно

**Установка Karabiner-Elements:**

```bash
brew install --cask karabiner-elements
```

Если возникает ошибка с симлинками:
```bash
# Попробовать переустановку
brew reinstall --cask karabiner-elements

# Или удалить и установить заново
brew uninstall --cask karabiner-elements
brew install --cask karabiner-elements
```

**Установка конфигурации:**

1. Открыть Karabiner-Elements
2. Перейти в Complex Modifications → Add rule
3. Import more rules from the Internet (внизу)
4. Или импортировать файл вручную:

```bash
# Скопировать конфиг в директорию Karabiner
mkdir -p ~/.config/karabiner/assets/complex_modifications
cp karabiner-canary-mods.json ~/.config/karabiner/assets/complex_modifications/
```

5. В Karabiner-Elements: Complex Modifications → Add rule → Enable правила

**Отключение уведомлений о sticky modifiers:**

По умолчанию Karabiner показывает всплывающие уведомления при активации sticky модификаторов. Чтобы их отключить:

1. Открыть Karabiner-Elements
2. Settings (или Preferences) → Notifications
3. Снять галочку с **"Show notifications when sticky modifier state is changed"**

## Использование

После установки обоих компонентов:

1. **Переключить раскладку** на Canary (через меню в трее или Cmd+Space)

2. **NAV Layer (левый Command)**:
   - **Hold левый Cmd + C** → sticky Command (отпускаем обе, затем жмем клавишу)
   - **Hold левый Cmd + R** → sticky Option
   - **Hold левый Cmd + S** → sticky Control
   - **Hold левый Cmd + T** → sticky Shift
   - **Tap левый Cmd** (без других клавиш) → sticky Command

3. **Примеры использования NAV layer**:
   - Hold левый Cmd → Tap C → Release Cmd → Tap V = Cmd+V (вставить)
   - Hold левый Cmd → Tap S → Release Cmd → Tap C = Ctrl+C (в терминале)
   - Hold левый Cmd → Tap R → Release Cmd → Tap Tab = Alt+Tab (переключение окон)
   - Hold левый Cmd → Tap T → Release Cmd → Tap Right Arrow = Shift+→ (выделить)

4. **Остальные модификаторы (one-shot)**:
   - Tap правый Cmd → Tap C = копировать
   - Tap Shift → Tap Down Arrow = выделить вниз
   - Tap левый Opt → Tap Shift → Tap Left Arrow = выделить до начала слова

5. **Удержание модификатора** по-прежнему работает как обычно

## Примечания

- Karabiner-Elements требует разрешений в System Settings → Privacy & Security → Input Monitoring
- При первом запуске macOS попросит разрешить Input Monitoring для karabiner_grabber и karabiner_observer
- One-shot модификаторы можно комбинировать (Cmd+Shift, Cmd+Alt и т.д.)
- Если нужно отменить sticky modifier - нажми его еще раз

## Troubleshooting

**Каrabiner не работает:**
- Проверить разрешения в System Settings → Privacy & Security
- Перезапустить Karabiner-Elements

**Раскладка не появляется:**
- Убедиться, что файл скопирован в правильную директорию
- Перезагрузить систему
- Проверить, что в System Settings → Keyboard → Input Sources включено "Show Input menu in menu bar"

**Sticky modifiers не срабатывают:**
- Убедиться, что правила включены в Complex Modifications
- Проверить, что Karabiner-Elements активен (зеленая иконка в трее)
