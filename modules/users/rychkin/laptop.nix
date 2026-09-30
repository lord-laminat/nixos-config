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
    home.file.".local/bin/to-win" = {
      executable = true;
      force = true;
      text = ''
        #!/bin/sh
        set -e
        sudo bootctl set-oneshot auto-windows
        systemctl reboot
      '';
    };
  };
}
