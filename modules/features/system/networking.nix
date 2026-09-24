{
  flake.modules.nixos.networking = { pkgs, ... }: {
    networking.wireless.enable = true;
    services.resolved.enable = true;
    networking.networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
  };
}
