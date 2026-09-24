{
  flake.modules.homeManager.ayugram = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ ayugram-desktop ];
  };
}
