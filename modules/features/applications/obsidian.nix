{
  flake.modules.homeManager.obsidian = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ obsidian ];
  };
}
