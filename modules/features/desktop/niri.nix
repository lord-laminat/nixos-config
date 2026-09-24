{ inputs, ... }:
{
  flake.modules.nixos.niri = { config, pkgs, ... }: {
    imports = [ inputs.inir.nixosModules.inir ];
    programs.niri.enable = true;
    programs.inir = {
      enable = true;
      # The upstream launcher uses set -e; absent optional variables must succeed.
      package =
        (pkgs.callPackage (inputs.inir + "/nix/package.nix") { inherit pkgs; }).overrideAttrs
          (old: {
            patches = (old.patches or [ ]) ++ [ ../../../packages/inir/environment.patch ];
          });
      service.compositor = "niri";
      extraPackages = [
        config.programs.niri.package
        pkgs.swayidle
        pkgs.libsecret
        pkgs.matugen
      ];
    };
    security.polkit.enable = true;
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    environment.systemPackages = with pkgs; [
      brightnessctl
      xwayland-satellite
      lxqt.lxqt-policykit
    ];
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };

  flake.modules.homeManager.niri = { pkgs, ... }: {
    home.packages = [ pkgs.yazi ];
    xdg.configFile."niri/config.kdl".source = ../../../assets/niri/config.kdl;
    xdg.configFile."niri/config.d" = {
      source = ../../../assets/niri/config.d;
      recursive = true;
    };
  };
}
