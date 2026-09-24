# Архитектура: dendritic + flake-parts

Принято пользователем: flakes, отдельный Home Manager, локальная работа,
структура с нуля, разделение modules на flake, hosts, users и features.

## Ответственность каталогов

- flake.nix объявляет зависимости и явно импортирует верхнеуровневые модули.
- modules/flake создаёт outputs, инструменты и проверки репозитория.
- modules/hosts/<host> собирает системные функции и аппаратные настройки машины.
- modules/users/<user>/default.nix описывает пользователя и его общие настройки.
- modules/users/<user>/<host>.nix выбирает домашние функции на конкретной машине.
- modules/features группирует реализацию по теме: system, desktop, development,
  services, applications. В одном файле могут находиться системная и домашняя части.
- packages содержит рецепты пакетов, assets — файлы ресурсов. Они не импортируются
  как модули flake-parts и появляются только при добавлении содержимого.

Схема: верхний imports → объявления flake.modules → явный выбор в hosts/users
→ nixosConfigurations.laptop и homeConfigurations."rychkin@laptop".

Регистрация функции не означает её включение на всех машинах. Автоимпорт
не подключён. Системная и домашняя конфигурации имеют общий lock-файл,
но отдельные сборки, поколения и команды применения.

## Правила расширения

1. Создать файл функции в modules/features/<тема>.
2. Объявить нужные части через flake.modules.nixos и/или flake.modules.homeManager.
3. Добавить файл в imports корневого flake.nix.
4. Выбрать модули функции в соответствующих hosts/users.
5. Добавить новые файлы в Git, отформатировать и проверить затронутые сборки.

Внешний config относится к flake-parts. Во вложенных функциях использовать
различимые имена для config, если нужны одновременно несколько уровней.
Не передавать все inputs через specialArgs без необходимости: они доступны
через замыкание верхнеуровневого модуля.

Дробить файлы по смыслу. Дополнительные профили, собственные deferredModule-опции
и библиотеки вводить при появлении конкретной потребности.

## Источники

- [Dendritic](https://github.com/mightyiam/dendritic)
- [Flake-parts modules](https://flake.parts/options/flake-parts-modules.html)
- [Области аргументов](https://flake.parts/module-arguments.html)
- [Standalone Home Manager](https://nix-community.github.io/home-manager/nix-flakes/standalone.html)

Исходное сравнение альтернатив хранится в research.md и не является текущим решением.
