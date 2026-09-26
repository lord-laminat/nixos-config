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

  flake.modules.homeManager.noctalia = { config, lib, pkgs, ... }: {
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
          pure_black_dark = false;
          templates = {
            enable_builtin_templates = true;
            builtin_ids = lib.optional config.programs.ghostty.enable "ghostty";
            # Pin the community template and keep the generated file writable.
            user.vscode = {
              input_path = pkgs.fetchurl {
                url = "https://raw.githubusercontent.com/noctalia-dev/community-templates/538048e6c3fc97c87112e476d959886f4df17b19/vscode/vscode.json";
                hash = "sha256-uONmDgsCKZvb0+Qemz+jrk8u75F+hzpHj75pQ17lAWk=";
              };
              output_path = "${config.home.homeDirectory}/.vscode/extensions/noctalia.noctaliatheme-0.0.5/themes/NoctaliaTheme-color-theme.json";
              requires_path = "${config.home.homeDirectory}/.vscode/extensions/noctalia.noctaliatheme-0.0.5";
            };
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
