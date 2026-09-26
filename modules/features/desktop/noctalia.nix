{ inputs, ... }:
{
  flake.modules.nixos.noctalia = {
    imports = [ inputs.noctalia.nixosModules.default ];
    programs.noctalia = {
      enable = true;
      systemd.enable = true;
      systemd.target = "niri.service";
    };
  };

  flake.modules.homeManager.noctalia = { config, lib, ... }: {
    imports = [ inputs.noctalia.homeModules.default ];
    programs.noctalia = {
      enable = true;
      settings = {
        shell = {
          polkit_agent = true;
          launch_apps_as_systemd_services = true;
        };
        theme = {
          source = "wallpaper";
          templates = lib.mkIf config.programs.ghostty.enable {
            enable_builtin_templates = true;
            builtin_ids = [ "ghostty" ];
          };
        };
      };
    };
    # The built-in hook leaves this declarative config untouched when the
    # theme is already selected; only the generated theme file is writable.
    programs.ghostty.settings = lib.mkIf config.programs.ghostty.enable {
      theme = "noctalia";
    };
    xdg.configFile."niri/config.kdl".text = lib.mkAfter ''
      include "noctalia.kdl"
    '';
    xdg.configFile."niri/noctalia.kdl".source = ../../../assets/niri/noctalia.kdl;
  };
}
