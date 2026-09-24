# Работа с репозиторием

Команды выполняются в корне nixos-config. Новая конфигурация собрана, но пока не активирована.

## Инструменты и проверка

```sh
nix develop
# Новые исходники должны попасть в индекс, чтобы Git-flake видел их.
git add flake.nix flake.lock modules packages docs README.md .gitignore
nix fmt
nix build --no-link '.#checks.x86_64-linux.system' '.#checks.x86_64-linux.home'
```

Проверка home действительно собирает activationPackage отдельного Home Manager,
но не запускает его. Форматирование не подтверждает работоспособность конфигурации.

Дополнительная проверка:

```sh
nix flake check --no-build
nix build --no-link '.#nixosConfigurations.laptop.config.system.build.toplevel'
```

## Обновление

```sh
nix flake update
```

Затем проверить обе конфигурации. Обновление lock-файла само ничего не активирует.
stateVersion не повышать автоматически вместе с версиями пакетов.

## Будущее применение

Для применения проверенной конфигурации (эти команды ещё не выполнялись):

```sh
sudo nixos-rebuild switch --flake .#laptop
home-manager switch --flake '.#rychkin@laptop'
```

Если команда home-manager ещё не установлена, можно использовать собранный
результат из этого же lock-файла:

```sh
nix build --out-link result-home '.#homeConfigurations."rychkin@laptop".activationPackage'
./result-home/activate
```

Перед первой активацией разобрать конфликты с существующими файлами /home.
Совместное изменение функции NixOS и HM может потребовать обеих команд.

Откат поколения системы и возврат исходников/flake.lock в Git — разные действия.
Сохранять рабочие ревизии перед обновлением. Пользовательские данные не откатываются
с поколениями NixOS или HM и требуют отдельного резервного копирования.
