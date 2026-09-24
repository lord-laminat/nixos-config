{ config, ... }:
let
  modules = config.flake.modules.nixos;
in
{
  flake.modules.nixos.laptop = {
    imports = with modules; [
      nix
      rychkin
      laptop-hardware
      networking
      bluetooth
      locale
      utilities
      niri
      terminal
      firefox
      happ
      codex
      ly
      docker
      virtualbox
    ];
    networking.hostName = "nixos";
    system.stateVersion = "26.05";
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    nixpkgs.config.allowUnfree = true;
  };
}
