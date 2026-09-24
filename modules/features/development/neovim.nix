{
  flake.modules.homeManager.neovim = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ neovim ];
  };
}
