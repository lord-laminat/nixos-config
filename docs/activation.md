# Применение 2026-09-21

Home Manager успешно активирован, код завершения 0.
Профиль: /nix/store/qb4xvsgy8mcjpp1df1n5nlcyflav0f2p-home-manager-generation.
Проверены наличие пользовательских программ и запуск Python 3.13.15.

Системная активация не выполнена: sudo -n сообщил, что нужен пароль.
Текущая система осталась:
/nix/store/abcz9k3l5ynhxjplr1vhm54mwfzi3qn2-nixos-system-nixos-26.05.20260918.cf9d2fb.

Подготовленная системная сборка:
/nix/store/y523nyyqlspxw4njdybs1mbz3ahxiym8-nixos-system-nixos-26.05.20260918.cf9d2fb.

Для завершения выполнить в пользовательском терминале:

```sh
sudo nixos-rebuild switch --flake /home/rychkin/nixos-migration/nixos-config#laptop
```

Home Manager сообщил о failed пользовательских службах activate-linux и
xdg-desktop-portal-gtk. Последующий systemctl --user show вернул inactive
и Result=success для обеих. Их работа в графическом сеансе не проверялась.
