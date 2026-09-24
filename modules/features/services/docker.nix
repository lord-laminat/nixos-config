{
  flake.modules.nixos.docker = { pkgs, ... }: {
    virtualisation.docker.enable = true;
    environment.systemPackages = [ pkgs.docker-compose ];
    users.users.rychkin.extraGroups = [ "docker" ];
  };
}
