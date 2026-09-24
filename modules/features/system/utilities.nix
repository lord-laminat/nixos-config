{
  flake.modules.nixos.utilities = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vim
      wget
      zip
      unzip
    ];
  };
}
