{ config, ... }: {
  flake.modules.homeManager.rychkin-laptop = {
    imports = with config.flake.modules.homeManager; [
      rychkin
      niri
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
