{
  flake.modules.homeManager.libreoffice = { pkgs, lib, ... }: {
    home.packages = with pkgs; [ libreoffice-fresh ];
  };
}
