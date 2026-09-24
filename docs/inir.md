# iNiR вместо Dank Material Shell

iNiR подключён официальным NixOS-модулем из `snowarch/iNiR`.
Ревизия зафиксирована в `flake.lock`; используются пакеты текущего Nixpkgs 26.05.
Поддержка NixOS у проекта экспериментальная:
https://github.com/snowarch/iNiR/wiki/NIXOS

Системный модуль `modules/features/desktop/niri.nix` устанавливает оболочку,
привязывает её пользовательскую службу к `niri.service` и включает PipeWire
и UPower. Отдельный Home Manager управляет конфигом Niri из `assets/niri/`.
Исходные настройки монитора, раскладки, внешнего вида и управления окнами сохранены.
Файлы `config.d` больше не генерируются DMS: изменять их нужно в репозитории.

Пакет содержит локальное исправление `packages/inir/environment.patch`:
скрипт запуска iNiR 2.31.0 с `set -e` завершался с кодом 1 при отсутствии
необязательной `ELECTRON_OZONE_PLATFORM_HINT` в конфиге Niri.
Исправление сохраняет успешный код возврата при отсутствии переменной.
Также сохраняется PATH Nix-пакета при импорте окружения сеанса: upstream
заменял его целиком, теряя упакованные зависимости. В PATH службы добавлены
`swayidle`, `libsecret` и `matugen`; включена служба профилей питания.

## Применение

```sh
cd /home/rychkin/Git/nixos-config
nix build --no-link .#checks.x86_64-linux.system .#checks.x86_64-linux.home
sudo nixos-rebuild switch --flake .#laptop
home-manager switch -b before-inir --flake '.#rychkin@laptop'
systemctl --user daemon-reload
systemctl --user start inir.service
```

Если Home Manager уже применён, повторять его активацию не требуется.
При следующем входе в Niri оболочка запускается автоматически.
Арховский `setup install` не нужен; обновление выполняется через
`nix flake update inir` и повторную сборку, а не через `inir update`.

## Основные сочетания

| Клавиши | Действие |
| --- | --- |
| Super+Space, Super+A | Запуск приложений |
| Super+I | Настройки iNiR |
| Super+V | Буфер обмена |
| Super+L | Блокировка |
| Super+X | Меню питания |
| Super+Y | Обои |
| Super+N | Уведомления |
| Super+Shift+N | Заметки |
| Super+M, Ctrl+Alt+Delete | Монитор ресурсов |
| Super+Return | Ghostty |

Клавиши громкости, яркости и воспроизведения обращаются к iNiR.

## Диагностика и резервная копия

```sh
systemctl --user status inir.service
journalctl --user -u inir.service -b --no-pager
inir logs --full
niri validate
```

Резервная копия предыдущей настройки и удалённых интеграций DMS:
`~/.local/state/dms-backup-20260922-222153/`.
Она содержит исходный каталог Niri, настройки, плагины и кеш DMS,
а также его интеграции с GTK, Kitty, Alacritty и Neovim.
Откат поколения NixOS не восстанавливает эти пользовательские файлы.

На 2026-09-22 Home Manager применён, действующий конфиг проверен `niri validate`.
Системная сборка завершена; её активация требует ввода пароля sudo в терминале.
