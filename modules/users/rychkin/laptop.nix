{ config, ... }: {
  flake.modules.homeManager.rychkin-laptop = {
    imports = with config.flake.modules.homeManager; [
      rychkin
      niri
      noctalia
      obsidian
      ayugram
      terminal
      libreoffice
      vscode
      neovim
      dotnet
      python
      c-cpp
      tools
      aflplusplus
    ];
  };
}
