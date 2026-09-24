{
  flake.modules.nixos.nix = {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  flake.modules.homeManager.nix = {
    programs.home-manager.enable = true;
  };
}
