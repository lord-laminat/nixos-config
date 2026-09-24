# NixOS + standalone Home Manager

Локальная конфигурация dendritic + flake-parts с новой структурой.
Архитектура и структура каталогов согласованы пользователем.

```text
flake.nix                         зависимости и явный список модулей
flake.lock                        зафиксированные ревизии
modules/
  flake/
    configurations.nix            две независимые точки сборки
    checks.nix                    форматирование и проверки сборок NixOS/HM
    devshell.nix                  Git и nixfmt для работы с репозиторием
  hosts/laptop/
    default.nix                   выбор системных функций
    hardware.nix                  оборудование и файловые системы
  users/rychkin/
    default.nix                   учётная запись и общая пользовательская среда
    laptop.nix                    пользовательская композиция для ноутбука
  features/
    system/                      Nix, сеть, локаль, nix-ld, утилиты
    desktop/                     niri и Ghostty
    applications/                Firefox, Happ, Codex и приложения из Arch
    development/                 редакторы, SDK, компиляторы, AFL++
    services/                    Docker и VirtualBox
packages/                        собственные рецепты Happ и Codex
docs/
  architecture.md                 согласованная архитектура
  maintenance.md                  проверка, обновление и применение
  research.md                    исходное исследование альтернатив
```

assets/ly/result.dur хранит анимацию экрана входа.

iNiR и замена DMS: [установка, клавиши и диагностика](docs/inir.md).

Все .nix-файлы в modules — модули верхнего уровня flake-parts. Нужные вложенные
модули NixOS/HM выбираются явно. Home Manager не встроен в NixOS.

## Готовность

Настройки перенесены из действующей конфигурации /etc/nixos на 2026-09-21.
Сохранены её версии Nixpkgs и Happ, пакеты, оборудование, сеть и пользователь.
`laptop` — имя точки сборки, а настоящее имя хоста остаётся `nixos`.
Системная сборка, отдельная сборка HM и flake check прошли.

Прежние системные пакеты сохранены. Приложения из списка переноса Arch
добавлены преимущественно через отдельный Home Manager, системные службы
через NixOS. Настройки приложений в /home не взяты под управление HM.
Активация не выполнялась. Состав: [arch-applications.md](docs/arch-applications.md).
Для новой установки отдельно понадобится задать пароль/доступ пользователя:
существующий пароль текущей установки не хранится в репозитории.
Удалённого репозитория нет.

Историческая сверка до добавления приложений Arch: [parity.md](docs/parity.md).

Подробнее: [архитектура](docs/architecture.md), [обслуживание](docs/maintenance.md).
