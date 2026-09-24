{ config, pkgs, ... }:
{
  flake.modules.nixos.rychkin = {
    users.users.rychkin = {
      isNormalUser = true;
      home = "/home/rychkin";
      description = "Anton Rychkin";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };
  };
  flake.modules.homeManager.rychkin = {
    imports = [ config.flake.modules.homeManager.nix ];
    home.username = "rychkin";
    home.homeDirectory = "/home/rychkin";
    # Initial Home Manager compatibility baseline; not the package version.
    home.stateVersion = "26.05";
  };
}
