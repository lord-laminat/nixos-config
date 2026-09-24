# Приложения из согласованного списка переноса Arch

Источник состава: ../packages.md в комплекте миграции (вне этого репозитория).
Версии взяты из закреплённой NixOS 26.05, flake.lock не обновлялся.

| Приложение/функция | Где описано | Применение |
| --- | --- | --- |
| niri, Firefox, Ghostty | features/desktop, applications/firefox.nix | NixOS, уже были |
| ly и сохранённая анимация | features/desktop/ly.nix, assets/ly/result.dur | NixOS |
| Obsidian, AyuGram, LibreOffice | features/applications | Home Manager |
| VS Code, Neovim | features/development | Home Manager |
| .NET SDK 10, Python 3 | features/development/dotnet.nix, python.nix | Home Manager |
| Python 3.12 | features/development/python.nix | nix develop .#python312 |
| GCC, Clang, Make, CMake, Ninja, Meson, pkg-config, GDB, LLDB | features/development/c-cpp.nix | Home Manager |
| Git, OpenSSH-клиент, GnuPG, tar, zstd | features/development/tools.nix | Home Manager |
| Docker и Compose | features/services/docker.nix | NixOS |
| VirtualBox | features/services/virtualbox.nix | NixOS |
| AFL++ | features/development/aflplusplus.nix | Команда HM, запускает Docker-образ |

В таблице пути features указаны относительно modules/.

## Применение

Системные службы и пользовательские приложения активируются отдельно по
maintenance.md. Членство в docker и vboxusers вступит в силу после нового
входа. Для модулей VirtualBox и изменений параметров ядра нужна перезагрузка.
Ly начнёт обслуживать экран входа после активации; сохранять текущий рабочий
сеанс при первом тестировании. Ничего автоматически не активировалось.

Пакеты Obsidian/VS Code разрешены через allowUnfree в отдельном наборе pkgs
Home Manager. Это не включает перенос их профилей или настройку редакторов.
Старые настройки в /home остались; установка пакетов не очищает их.
Happ сохраняется.

GCC имеет приоритет для общих имён cc/c++; Clang остаётся доступен как clang.
Python 3.12 изолирован в devShell, чтобы не конфликтовать с основным python3.
Старые venv не считаются переносимыми, зависимости проектов пересоздаются.

## Ly

Анимация скопирована побайтно из ранее извлечённого result.dur.
Перенесены её режим, выравнивание и смещения. Команды входа, питания,
яркости и пути к сессиям предоставляет модуль NixOS; пути Arch не скопированы.
Параметры анимации описаны в
[конфигурации ly](https://github.com/fairyglade/ly/blob/master/res/config.ini).

## AFL++

После активации HM команда `aflplusplus` открывает официальный Docker-образ,
подключая текущий каталог в /src. Для первого запуска нужен доступ к Docker
и интернет для загрузки образа. Образ ещё не скачан: текущая работа добавляет
конфигурацию и команду запуска, без запуска контейнеров.

```sh
cd ~/Projects/my-target
aflplusplus
# Или выполнить команду внутри образа:
aflplusplus afl-fuzz -h
```

По умолчанию используется aflplusplus/aflplusplus:latest. Для воспроизводимости
можно передать AFLPLUSPLUS_IMAGE=aflplusplus/aflplusplus@sha256:... с выбранным
настоящим digest. Файлы, созданные контейнером, могут принадлежать root.

[Официальная инструкция AFL++](https://aflplus.plus/docs/install/).
Старые контейнеры, volumes и ВМ не импортируются.

## Проверено

- NixOS и Home Manager успешно собраны без активации.
- Проверка flake прошла; конфликт общих команд GCC/Clang устранён при сборке HM.
- Окружение python312 запущено: Python 3.12.14.
- SHA-256 анимации совпадает с сохранённым оригиналом.
- GUI-приложения, вход через ly, ВМ и контейнеры в рабочем сеансе не запускались.
