{
  flake.modules.nixos.firefox = { pkgs, ... }: {
    environment.systemPackages = [ pkgs.firefox ];
  };
}
