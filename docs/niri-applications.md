# Niri и Noctalia

Ноутбук использует Noctalia v5: системный модуль `noctalia` устанавливает
оболочку и запускает пользовательскую службу вместе с `niri.service`.
Модуль `niri` подключается отдельно в NixOS и Home Manager и содержит
общие настройки композитора и клавиши окон и приложений. Модуль `noctalia`
добавляет настройки оболочки и `assets/niri/noctalia.kdl`. Общие службы
звука, питания и polkit вынесены в системный модуль `desktop-services`.
Настройки интерфейса можно менять через меню Noctalia.

- Super+A / Super+Space — приложения.
- Super+I — настройки.
- Super+L — блокировка.
- Super+X — меню выхода.
- Super+N — уведомления.
- Super+V — буфер обмена.
- Super+Y — обои.
- Super+M / Ctrl+Alt+Delete — системный монитор в центре управления.
- Клавиши громкости, микрофона, яркости и проигрывателя используют Noctalia IPC.

Привязка Super+Shift+N к блокноту iNiR отсутствует: для неё нужен отдельный
плагин или редактор. Остальные привязки окон и приложений сохранены.
`firefox`, `ghostty`, `AyuGram` и `yazi` устанавливаются существующими модулями.

Применение из корня репозитория (Home Manager здесь независим от NixOS):

```sh
sudo nixos-rebuild switch --flake path:.#laptop
home-manager switch --flake 'path:.#rychkin@laptop'
```

После применения обеих конфигураций выйдите из графической сессии и войдите
в Niri снова. Для диагностики:

```sh
systemctl --user status noctalia.service
journalctl --user -u noctalia.service -b
noctalia msg status
```

Чтобы вернуться к iNiR, замените `noctalia` на `inir` в импортах
`modules/hosts/laptop/default.nix` и `modules/users/rychkin/laptop.nix`,
затем примените обе конфигурации и перезайдите в сессию.

## Цвета терминала

Noctalia генерирует тему Ghostty `noctalia` из текущей палитры. Модуль
оболочки выбирает эту тему; iNiR отдельно выбирает `ii-auto`.
Starship использует ANSI-цвета терминала без старой `ii-palette.toml`.
Home Manager больше не создаёт `starship.toml`, поэтому включённый через
интерфейс Noctalia шаблон Starship также может генерировать свою палитру.

После применения Home Manager выполните `noctalia msg templates-apply`.
При необходимости перезагрузите конфигурацию Ghostty через Ctrl+Shift+,.
Настройки из интерфейса Noctalia имеют приоритет над декларативными:
в разделе Templates должен быть включён Ghostty, а для цветов из обоев
источником палитры должен быть Wallpaper.

## VS Code

При совместном подключении модулей `vscode` и `noctalia` Home Manager
устанавливает NoctaliaTheme 0.0.5 из закреплённого VSIX через CLI редактора.
Каталог расширения остаётся доступным для записи: Noctalia обновляет
`themes/NoctaliaTheme-color-theme.json` при изменении палитры.
Шаблон сообщества закреплён на конкретной ревизии в `noctalia.nix`;
включать community-шаблон VSCode в интерфейсе дополнительно не нужно.
Версия расширения и путь вывода шаблона должны обновляться вместе.

На новой машине один раз выберите **Preferences: Color Theme → NoctaliaTheme**.
Существующий `settings.json` и остальные расширения остаются под управлением
редактора. После применения Home Manager выполните:

```sh
noctalia msg config-reload
noctalia msg templates-apply
```

Если открытый редактор не обновил цвета, выполните **Developer: Reload Window**.
