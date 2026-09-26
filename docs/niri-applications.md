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
