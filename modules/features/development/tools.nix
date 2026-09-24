{
  flake.modules.homeManager.tools = { pkgs, lib, ... }: {
    home.packages = with pkgs; [
      git
      openssh
      gnupg
      gnutar
      zstd
    ];
  };
}
